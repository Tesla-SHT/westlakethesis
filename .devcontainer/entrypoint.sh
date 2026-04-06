#!/bin/bash
set -e

WORKSPACE=${WORKSPACE:-/workspace}

echo "[*] Current workspace is $WORKSPACE."

USERNAME=westlaker
GROUPNAME=westlaker
CURRENT_UID=$(id -u "$USERNAME" 2>/dev/null)
CURRENT_GID=$(id -g "$USERNAME" 2>/dev/null)

# Check if WORKSPACE or any parent directory is mounted
current_dir="$WORKSPACE"
is_mounted=false
while [ "$current_dir" != "/" ]; do
    if mountpoint -q "$current_dir"; then
        echo "[*] $current_dir is a mount point."
        is_mounted=true
        break
    fi
    current_dir=$(dirname "$current_dir")
done

# After the loop, check the is_mounted flag
if [ "$is_mounted" = true ]; then
    HOST_UID=$(stat -c "%u" $WORKSPACE)
    HOST_GID=$(stat -c "%g" $WORKSPACE)

    if [ "$CURRENT_UID:$CURRENT_GID" != "$HOST_UID:$HOST_GID" ]; then
        echo "[*] Current UID:GID ($CURRENT_UID:$CURRENT_GID) does not match host UID:GID ($HOST_UID:$HOST_GID) of $WORKSPACE."

        echo "[*] Changing user $USERNAME:$GROUPNAME to $HOST_UID:$HOST_GID and chowning \"/home/${USERNAME}/\"..."
        usermod -u "$HOST_UID" "$USERNAME"
        groupmod -g "$HOST_GID" "$GROUPNAME"
        chown -R "${USERNAME}:${GROUPNAME}" "/home/${USERNAME}"

        echo "[*] ID Changed. Continuing as $USERNAME ($HOST_UID:$HOST_GID)."
    else
        echo "[*] User ID and group ID matched. Continuing as $USERNAME ($HOST_UID:$HOST_GID)."
    fi
else
    echo "[!] $WORKSPACE is not mounted. Continuing as $USERNAME ($CURRENT_UID:$CURRENT_GID)."
fi

if [ -d "$WORKSPACE" ]; then
    cd "$WORKSPACE"
else
    mkdir -p $WORKSPACE
    chown -R $USERNAME:$GROUPNAME $WORKSPACE
    cd $WORKSPACE
fi

exec gosu "$USERNAME" "$@"
