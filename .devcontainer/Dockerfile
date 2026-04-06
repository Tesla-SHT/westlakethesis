FROM texlive/texlive:latest-full
ARG TARGETOS TARGETARCH

ARG GITHUB_DOMAIN=gh-proxy.com/github.com

# starship
RUN --mount=type=cache,target=/tmp \
    curl -sSf https://starship.rs/install.sh | sh -s -- \
        -y --base-url https://${GITHUB_DOMAIN}/starship/starship/releases
RUN tee -a /etc/bash.bashrc <<"EOF"
eval "$(starship init bash)"
EOF

# gosu
RUN curl -Lo /usr/local/bin/gosu \
    https://${GITHUB_DOMAIN}/tianon/gosu/releases/download/1.17/gosu-${TARGETARCH} && \
    chmod +x /usr/local/bin/gosu

# latex-chinese-fonts
RUN --mount=type=cache,target=/tmp \
    curl -Lo /tmp/latex-chinese-fonts.zip \
        https://${GITHUB_DOMAIN}/Haixing-Hu/latex-chinese-fonts/archive/refs/heads/master.zip && \
    unzip /tmp/latex-chinese-fonts.zip -d /usr/share/fonts/latex-chinese-fonts

# create user
ARG USERNAME=westlaker
ARG GROUPNAME=westlaker
RUN groupadd ${GROUPNAME} || true && \
    useradd -g ${GROUPNAME} -m -s /bin/bash ${USERNAME} || true && \
    usermod -aG sudo "${USERNAME}" && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# add entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# default command
ENV WORKSPACE=/workspace
CMD ["/bin/bash"]
