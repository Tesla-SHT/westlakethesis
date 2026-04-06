<!-- The project is still in development-->

本项目仍在开发中，欢迎提交 issue 和 pull request 参与完善！目前模板已支持西湖大学本科生毕业论文的开题报告和正文部分，但仍有一些细节和功能需要调整和补充！

---

# 西湖大学本科生毕业论文 LaTeX 模板

本项目为**西湖大学本科生毕业论文（设计）**的 LaTeX 模板，支持：

- **开题报告**（文献综述 + 开题报告 + 外文翻译）
- **毕业论文**（正文 + 附录 + 致谢）

---

## 目录结构

```
westlakethesis.tex          ← 主文件，在此填写个人信息并选择编译模式
westlakethesis.cls          ← 文档类（一般不需要修改）
body/
  ref.bib                   ← 参考文献库（在此添加所有引用）
  undergraduate/
    final/
      1-introduction.tex    ← 毕业论文：绪论
      2-body.tex            ← 毕业论文：正文各章
      3-appendix.tex        ← 毕业论文：附录
      4-cv.tex              ← 毕业论文：作者简历
      abstract.tex          ← 毕业论文：摘要
      acknowledgement.tex   ← 毕业论文：致谢
    proposal/
      review/
        review.tex          ← 开题报告：文献综述
      proposal/
        background.tex      ← 开题报告：研究背景
        content.tex         ← 开题报告：研究内容与技术路线
        plan.tex            ← 开题报告：进度安排与预期目标
      translation/
        translation.tex     ← 开题报告：外文翻译
      original/
        original.tex        ← 开题报告：外文原文（PDF嵌入）
figure/                     ← 图片目录（将图片放在此处引用）
attachment/                 ← 学校官方表格（任务书、评阅表等）
```

---

## 快速开始

### 第一步：填写个人信息

打开 `westlakethesis.tex`，修改 `\documentclass[...]` 中的字段：

```latex
StudentName  = 你的姓名,
StudentID    = 你的学号,
AdvisorName  = 导师姓名~职称,   % 例如：李四~副教授
Grade        = 20XX,            % 入学年份
Major        = 你的专业,
Department   = 你的学院,
Title        = 论文中文题目,
TitleEng     = {Your Thesis Title in English},
SubmitDate   = 二〇二六年六月,  % 封面日期
```

### 第二步：选择编译模式

在同一位置修改 `Period` 字段：

| `Period` 值 | 生成内容 |
|---|---|
| `proposal` | 开题报告（文献综述 + 开题报告 + 外文翻译） |
| `final` | 毕业论文正文 |
| `paper` | 仅正文，不含开题部分 |

其他常用选项：

| 字段 | 选项 | 说明 |
|---|---|---|
| `Type` | `thesis` / `design` | 论文类 / 设计类 |
| `BlindReview` | `false` / `true` | 正常版 / 盲审版（隐藏姓名学号） |
| `TwoSide` | `true` / `false` | 双面打印 / 单面（电子提交） |

### 第三步：编写内容

**开题报告** — 编辑以下文件：

```
body/undergraduate/proposal/review/review.tex       文献综述正文
body/undergraduate/proposal/proposal/background.tex 研究背景
body/undergraduate/proposal/proposal/content.tex    研究内容与技术路线
body/undergraduate/proposal/proposal/plan.tex       进度安排与预期目标
body/undergraduate/proposal/translation/translation.tex  外文译文
body/undergraduate/proposal/original/original.tex   外文原文（PDF插入）
```

**毕业论文** — 编辑以下文件：

```
body/undergraduate/final/abstract.tex        摘要（中英文）
body/undergraduate/final/1-introduction.tex  第一章：绪论
body/undergraduate/final/2-body.tex          正文各章（可按需增减章节文件并在 content.tex 中引入）
body/undergraduate/final/3-appendix.tex      附录
body/undergraduate/final/4-cv.tex            作者简历
body/undergraduate/final/acknowledgement.tex 致谢
```

如需拆分正文为多个文件，在 `body/undergraduate/final/content.tex` 中用 `\inputbody{final/your-chapter}` 引入。

### 第四步：添加参考文献

在 `body/ref.bib` 中添加 BibTeX 格式的文献条目，在正文中用 `\cite{key}` 引用：

```bibtex
@article{your-key,
    author  = {Author Name},
    title   = {Paper Title},
    journal = {Journal Name},
    year    = {2024},
}
```

### 第五步：放置图片

将图片文件放在 `figure/` 目录下，在正文中引用时只需写文件名：

```latex
\includegraphics[width=0.8\linewidth]{your-image.png}
```

### 第六步：编译

在项目根目录运行：

```bash
latexmk
```

输出 PDF 位于 `out/westlakethesis.pdf`。

> **注意**：必须使用 `latexmk` 命令编译（而非直接运行 xelatex），否则参考文献可能无法正确显示。

---

## 多行标题

若论文题目较长需要换行，在 `westlakethesis.tex` 中取消注释相应的命令：

```latex
% 两行标题
\titletwolines{题目第一行}{题目第二行}

% 两行英文标题
\titleengtwolines{English Title Line One}{English Title Line Two}
```

---

## 编译环境

### 本地编译

1. 安装 [TeX Live](https://tug.org/texlive/)（建议 2021 或更新版本），需包含 XeTeX 引擎
2. 克隆或下载本仓库
3. 在根目录运行 `latexmk`

### Overleaf

1. 下载本仓库 zip 文件，上传至 Overleaf 新建项目
2. 在 Overleaf 菜单中：
   - Compiler → **XeLaTeX**
   - TeX Live version → **2021** 或更新
3. 删除根目录的 `.latexmkrc` 文件（Overleaf 不使用此文件，需手动删除）
4. 字体有版权，需手动上传字体文件到 `fonts/` 目录（详见 `script/ci/` 中的字体说明）

### Dev Container

本仓库提供 `.devcontainer` 配置，支持在 VS Code Dev Containers 或 GitHub Codespaces 中直接使用，已预装 TeX Live 和 LaTeX Workshop 插件。容器内用户名为 `westlaker`。

---

## 字数统计

先用 `latexmk` 编译一遍，再在项目根目录运行以下脚本统计正文字数：

```bash
# Linux / macOS / Git Bash
bash script/utils/word_count.sh
```

```powershell
# Windows PowerShell
.\script\utils\word_count.ps1
```

该脚本调用 TeX Live 自带的 `texcount` 工具，无需额外安装。

---

## 官方表格

学校官方的毕业论文相关表格（任务书、评阅表、答辩表等）位于 `attachment/` 目录，请自行查阅填写。

---

## 致谢

本模板基于 [zjuthesis](https://github.com/TheNetAdmin/zjuthesis)（作者：Zixuan Wang）开发，在此表示感谢。

## 许可证

MIT License

学校标志与学校文件的版权归西湖大学所有
