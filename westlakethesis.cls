\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{westlakethesis}
\input{config/version}
\wlog{westlakethesis version: \westlakethesis}

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
    family=westlakethesis,
    prefix=
}
\DeclareStringOption{ClassNumber}
\DeclareStringOption[14626]{SchoolCode}
\DeclareStringOption{Security}
\DeclareStringOption{StudentName}
\DeclareStringOption{StudentNameEng}
\DeclareStringOption{StudentID}
\DeclareStringOption{AdvisorName}
\DeclareStringOption{AdvisorNameEng}
\DeclareStringOption{Grade}
\DeclareStringOption{Major}
\DeclareStringOption{MajorEng}
\DeclareStringOption{Department}
\DeclareStringOption{DepartmentEng}
\DeclareStringOption{Topic}
\DeclareStringOption{Title}
\DeclareStringOption{TitleEng}
\DeclareStringOption{SubmitDate}
\DeclareStringOption{SubmitDateEng}
\DeclareStringOption[undergraduate]{Degree}
\DeclareStringOption[general]{MajorFormat}
\DeclareStringOption[thesis]{Type}
\DeclareStringOption[proposal]{Period}
\DeclareStringOption[chinese]{Language}
\DeclareStringOption[doctor]{GradLevel}
\DeclareStringOption{ColaboratorName}
\DeclareStringOption[false]{BlindReview}
\DeclareStringOption[false]{PrintFilePath}
\DeclareStringOption[true]{TwoSide}
\DeclareBoolOption[true]{ListOfContents}
\DeclareBoolOption[true]{ListOfFigures}
\DeclareBoolOption[true]{ListOfTables}
\DeclareBoolOption[false]{ListOfAlgorithms}

\ProcessKeyvalOptions*

\wlog{Degree: {\Degree}}
\wlog{MajorFormat: {\MajorFormat}}
\wlog{Type: {\Type}}
\wlog{Period: {\Period}}
\wlog{BlindReview: {\BlindReview}}
\wlog{Language: {\Language}}
\wlog{GradLevel: {\GradLevel}}
\wlog{PrintFilePath: {\PrintFilePath}}

\PassOptionsToPackage{no-math}{fontspec}
\PassOptionsToPackage{AutoFakeBold}{xeCJK}

\usepackage{xifthen}

\ifthenelse{\equal{\TwoSide}{true}}
{
    \PassOptionsToClass{
        twoside,
        openright
    }{ctexrep}
}
{}

\makeatletter
\let\@classoptionslist\@empty
\makeatother

\LoadClass[
    zihao=-4,
    UTF8
]{ctexrep}

\input{config/packages}

\ifthenelse{\equal{\Degree}{undergraduate}}
{
    % undergraduate
    \ifthenelse{\equal{\Type}{thesis}}
    {
        \newcommand{\TitleTypeNameP}{西湖大学本科生毕业论文}
    }
    {
        \newcommand{\TitleTypeNameA}{西湖大学本科生毕业设计}
    }

    \ifthenelse{\equal{\Period}{proposal}}
    {
        \newcommand{\TitleTypeName}{\TitleTypeNameP~文献综述和开题报告}
    }
    {
        \newcommand{\TitleTypeName}{\TitleTypeNameP}
    }
}
{
    % graduate
    \ifthenelse{\equal{\GradLevel}{doctor}}
    {
        % doctor
        \ifthenelse{\equal{\Type}{thesis} \OR \equal{\Type}{design}}
        {
            % thesis or design
            \newcommand{\TitleTypeName}{西湖大学博士学位论文}
            \newcommand{\TitleTypeNameCover}{博士学位论文}
        }
        {}
    }
    {
        % master
        \ifthenelse{\equal{\Type}{thesis}}
        {
            % thesis
            \newcommand{\TitleTypeName}{西湖大学硕士学位论文}
            \newcommand{\TitleTypeNameCover}{硕士学位论文}
        }
        {
            % design
            \newcommand{\TitleTypeName}{西湖大学硕士专业学位论文}
            \newcommand{\TitleTypeNameCover}{硕士专业学位论文}
        }
    }
}

\input{config/path}
\input{config/commands}
\input{config/format/format}
