\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custom}[2023/10/01 v1.0 Custom LaTeX Class]
% Load a base class to define standard font sizes

% Define options for report and slide
\newif\if@isreport
\newif\if@isslide
\DeclareOption{report}{\@isreporttrue}
\DeclareOption{slide}{\@isslidetrue}
\ExecuteOptions{report}
\ProcessOptions\relax

\if@isreport

%%%%%%%%%% report package %%%%%%%%%%
\LoadClass{article} % Added to define standard font sizes
% Load common packages
\RequirePackage[utf8]{inputenc}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{geometry}
\RequirePackage{ctex} % Added for Chinese text support
\RequirePackage{fancyhdr} % Added for header and footer customization
\RequirePackage{enumitem} % Added for customizable list environments
\RequirePackage{amsmath} % Added for math equation support
\RequirePackage{amssymb} % Added for mathematical symbols
\RequirePackage{titling} % Added for \droptitle support
% Load additional packages from 2025-01-13.tex
\RequirePackage{subcaption}
\RequirePackage{multicol}
\RequirePackage{listings}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{tikz}
\RequirePackage{titlesec} % Added: Load titlesec package for \titleformat

% Settings specific to report
\geometry{margin=0.5in, paperheight=11in, paperwidth=8.5in} % Set paper size

% Custom header and footer
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\thetitle}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\fi

\if@isslide
% Settings specific to slide
\RequirePackage{beamer}
\mode<presentation>
\usetheme{Madrid}
\fi

\endinput