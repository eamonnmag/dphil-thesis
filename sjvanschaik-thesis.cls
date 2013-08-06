% This is sjvanschaik-thesis v0.1
%
% Based on: 
%  - ociamthesis v2.2 by Keith A. Gillow <gillow@maths.ox.ac.uk>
%  - oxthesis v1.0 by Pavel Avgustinov <pavel@semmle.com>
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sjvanschaik-thesis}[2010/10/01 v1.0 Sebastiaan J. van Schaik thesis class]
%-------------------------- initial code -----------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.
\global\let\@ThesisDraftMode\@empty
\global\let\@ThesisStrictMode\@empty
\global\let\@ThesisAuthor\@empty
\global\let\@ThesisCollege\@empty
\global\let\@ThesisTitle\@empty
\global\let\@ThesisTerm\@empty
\global\let\@ThesisYear\@empty
\global\let\@PageReserving\@empty
\global\let\@ThesisKeywords\@empty

% A flag indicating draft mode (produces a date and allows notes)
\newcommand{\ThesisDraft}{\def\@ThesisDraftMode{y}}

% General meta-information about the thesis
\newcommand{\ThesisAuthor}[1]{\def\@ThesisAuthor{#1}\hypersetup{pdfauthor={#1}}}
\newcommand{\ThesisCollege}[1]{\def\@ThesisCollege{#1}}
\newcommand{\ThesisTitle}[1]{\def\@ThesisTitle{#1}\hypersetup{pdftitle={#1}}}
\newcommand{\ThesisTerm}[1]{\def\@ThesisTerm{#1}}
\newcommand{\ThesisYear}[1]{\def\@ThesisYear{#1}}
\newcommand{\ThesisKeywords}[1]{\def\@ThesisKeywords{#1}\hypersetup{pdfkeywords={#1}}}

% SETTING SPACING
\DeclareOption{singlespacing}{
\def\@SpacingMode{\singlespacing}
}
\DeclareOption{onehalfspacing}{
\def\@SpacingMode{\onehalfspacing}
}
\DeclareOption{doublespacing}{
\def\@SpacingMode{\doublespacing}
}
\global\def\@SpacingMode{\onehalfspacing}

\DeclareOption{reservepages}{\def\@PageReserving{y}}

% Don't warn on notes to self; print timestamp; other draft tweaks
\DeclareOption{draft}{\ThesisDraft}
\DeclareOption{draftthesis}{\ThesisDraft}

% Give errors rather than warnings on note to self in non-draft mode
\DeclareOption{strict}{\def\@ThesisStrictMode{y}}



\ProcessOptions\relax
\LoadClass[a4paper]{book}
% As an alternative to the above could use next line for twosided output
%\LoadClass[a4paper,twoside,openright]{report}

\RequirePackage{graphicx,tikz,pgfplots,pgfplotstable,xspace,amsmath,amssymb,upgreek,varioref,suffix,etoolbox,environ,forloop,setspace,manfnt,amsthm,cite,fancyhdr,stmaryrd,prettyref,ifthen,fix-cm,blindtext}

\RequirePackage[pagebackref=true,bookmarks=true]{hyperref}

% Default font
\RequirePackage[sc]{mathpazo}
\linespread{1.05}         % Palatino needs more leading (space between lines)
\RequirePackage[T1]{fontenc}

%\RequirePackage[final]{listings}

% Define text area of page and margin offsets
%
\setlength{\topmargin}{0.0in}
\setlength{\oddsidemargin}{0.33in}
\setlength{\evensidemargin}{-0.08in}
\setlength{\textheight}{9.0in}
\setlength{\textwidth}{6.0in}

% Algorithm (algorithm2e) stuff
\RequirePackage[ruled,vlined]{algorithm2e}
% \SetAlCapSkip{0.5em}
% \SetAlCapNameSty{textbf}
\SetAlCapHSkip{0cm}
\SetAlgoSkip{}
\setlength{\algomargin}{0em}
\SetKwComment{Comment}{$\rhd$~}{}
\SetKwBlock{Begin}{}{}
\SetFuncSty{textsc}
\SetCommentSty{scriptsize}
\SetDataSty{textsc}
\SetKw{AlgAnd}{and}
\SetKw{AlgOr}{or}
\SetKw{AlgContinue}{continue}


\newcommand{\WarnIfNotDraft}[1]{%
\ifx \@ThesisDraftMode \@empty%
% We are not in draft mode
\ifx \@ThesisStrictMode \@empty%
\ClassWarning{oxthesis}{#1}
\else \ClassError{oxthesis}{#1}\fi%
\else\fi}

% NOTES
% The NOTETOSELF command should be used for all notes of things to do etc.
% This allows searching for NOTETOSELF to guarantee that none are left in
% the final version

% TODO: Give an option to produce an index of notes to self.
% Difficulty: don't interfere with any existing index.

\newcommand{\NOTETOSELF}[1]{%
\WarnIfNotDraft{The NOTETOSELF command should only be used in draft mode}%
\marginpar{\raggedright [#1]}}

% The NOTETOSELFLONG should be used for longer notes that can't comfortably
% fit in a margin

\newcommand{\NOTETOSELFLONG}[1]{%
\WarnIfNotDraft{The NOTETOSELFLONG command should only be used in draft mode}%
\par\bigskip
\hfill\textdbend \ \
\begin{tabular}{|c}
\ \parbox{0.85\textwidth}{{\color{red}#1}}
\end{tabular}\NOTETOSELF{\textbf{NOTE}}
\par\bigskip
}

% The NOTETOSELFINLINE command should be used for notes in floating boxes,
% like marginpars, footnotes and figures -- otherwise you end up with a
% cryptic LaTeX error about 'Float(s) lost'
\newcommand{\NOTETOSELFINLINE}[1]{%
\WarnIfNotDraft{The NOTETOSELF command should only be used in draft mode}%
\textbf{[[\emph{NOTE:} #1]]}}



\newcommand{\todo}[1]{{\color{red}\textsc{todo}: #1}}
\newcommand{\etal}{\emph{et al.}\xspace}
\newcommand{\ie}{\emph{i.e.}\xspace}
\newcommand{\eg}{\emph{e.g.}\xspace}
\newcommand{\Eg}{\emph{E.g.}\xspace}
\newcommand{\BigO}[1]{$\mathcal{O}\left(#1\right)$}

\newtheorem{example}{Example}
\newtheorem{remark}{Remark}
\newtheorem{proposition}{Proposition}

\newcommand{\nop}[1]{}
\newcommand{\emphtext}[1]{\text{\emph{#1}}}
\newcommand{\dan}[1]{{\color{red}\textsc{Dan}: #1}}
\newcommand{\bas}[1]{{\color{blue}\textsc{Bas}: #1}}
\newcommand{\ramon}[1]{{\color{red}\textsc{Ramon}: #1}}
\newcommand{\doubt}[1]{{\color{red}\uwave{#1}}}
\newcommand{\mathfalse}{\text{\emph{false}}}
\newcommand{\mathtrue}{\text{\emph{true}}}
\newcommand{\false}{\emph{false}\xspace}
\newcommand{\true}{\emph{true}\xspace}
\newcommand{\algfalse}{\text{false}\xspace}
\newcommand{\algtrue}{\text{true}\xspace}
\newcommand{\argmax}{\operatornamewithlimits{argmax}}
\newcommand{\argmin}{\operatornamewithlimits{argmin}}
\newcommand{\parheader}[1]{\noindent\textbf{#1}}




% This macro define an environment for front matter that is always 
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi}%
       {\if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}

       
% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.

\newenvironment{dedication}
{\begin{alwayssingle}
  \thispagestyle{empty}
  \begin{center}
  \vspace*{1.5cm}
  {\LARGE }
  \end{center}
  \vspace{0.5cm}
  \begin{verse}\begin{center}}
{\end{center}\end{verse}\end{alwayssingle}}


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

\newenvironment{acknowledgements}
{\begin{alwayssingle} \thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Acknowledgements}
\end{center}
\vspace{0.5cm}
\begin{quote}}
{\end{quote}\end{alwayssingle}}

% The acknowledgementslong environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgement itself 
% does not appears in a quote environment so you can get more in.

\newenvironment{acknowledgementslong}
{\begin{alwayssingle} \thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Acknowledgements}
\end{center}
\vspace{0.5cm}}
{\end{alwayssingle}}

% The originalitylong environment puts a large, bold, centered 
% "Statement of originality" label at the top of the page. The statement 
% of originality itself does not appears in a quote environment so you can 
% get more in.
\newenvironment{originalitylong}
{\begin{alwayssingle} \thispagestyle{empty}
\begin{center}
\vspace*{1.5cm}
{\Large \bfseries Statement of Originality}
\end{center}
\vspace{0.5cm}}
{\end{alwayssingle}}


%ABSTRACT
%
%The abstract environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself appears in a quote environment,
%i.e. tabbed in at both sides, and on its own page.
\newenvironment{abstract} {\begin{alwayssingle} \thispagestyle{empty}
  \begin{center}
  \vspace*{1.5cm}
  {\Large \bfseries  Abstract}
  \end{center}
  \vspace{0.5cm}
   \begin{quote}}
{\end{quote}\end{alwayssingle}}

%The abstractlong environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself does not appears in a quote
%environment so you can get more in.
\newenvironment{abstractlong} {\begin{alwayssingle} \thispagestyle{empty}
  \begin{center}
  \vspace*{1.5cm}
  {\Large \bfseries  Abstract}
  \end{center}
  \vspace{0.5cm}}
{\end{alwayssingle}}

%The abstractseparate environment is for running of a page with the abstract
%on including title and author etc as required to be handed in separately
\newenvironment{abstractseparate} {\begin{alwayssingle} \thispagestyle{empty}
  \vspace*{-1in}
 \begin{center}
    { \Large {\bfseries {\@title}} \par}
    {{\large \vspace*{1ex} \@author} \par}
{\large \vspace*{1ex}
    {{\@college} \par}
    {University of Oxford \par}
\vspace*{1ex}
    {{\it \submittedtext} \par}
    {\it {\@degree} \par}
\vspace*{2ex}
    {\@degreedate}}
  \end{center}}
{\end{alwayssingle}}

%ROMANPAGES
%
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).

\newenvironment{romanpages}
{\cleardoublepage\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\cleardoublepage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}

\newcommand{\crest}{\includegraphics[width=32mm]{images/oxford-crest_blue-on-white.pdf}}

% Title page etc
\title{%
\ifx \@ThesisTitle \@empty
\ClassError{thesis}{Title not set, use \ThesisTitle to set}
{The \ThesisTitle{...} command must be used to set the thesis title}
\else\fi
{\fontsize{25}{50}\selectfont \@ThesisTitle}}

\author{%
\ifx \@ThesisAuthor \@empty
\ClassError{thesis}{Author not set, use \ThesisAuthor to set}
{The \ThesisAuthor{...} command must be used to set the thesis title}
\else\fi
\ifx \@ThesisCollege \@empty
\ClassError{thesis}{College not set, use \ThesisCollege to set}
{The \ThesisCollege{...} command must be used to
set the thesis author's college}
\else\fi
\@ThesisAuthor\\
\it{\@ThesisCollege
}\\[35pt]}

\date{
\ifx \@ThesisDraftMode \@empty
% We are not in draft mode
\ifx \@ThesisTerm \@empty
\ClassError{thesis}{Term not set, use \ThesisTerm to set}
{If the \ThesisDraft command is not used, \ThesisTerm{...} must be used to set the submission term}
\else\fi
\ifx \@ThesisYear \@empty
\ClassError{thesis}{Year not set, use \ThesisYear to set}
{If the \ThesisDraft command is not used, \ThesisYear{...} must be used to set the submission year}
\else\fi
\@ThesisTerm{} Term \@ThesisYear\\[60pt]
{\itshape Submitted in partial fulfilment of the requirements for \\
\itshape the degree of Doctor of Philosophy
                                                        \\[25pt]}
\crest
\\[20pt]
Department of Computer Science\\
University of Oxford
\else
\fbox{DRAFT --- \today}\\[110pt]
\crest
\\[20pt]
Oxford University Computing Laboratory\\
Programming Tools Group
\fi
}


% THE ABSTRACT PAGE

\global\let\@ThesisAbstract\@empty

\newcommand{\ThesisAbstract}[1]{\def\@ThesisAbstract{#1}}

\newcommand{\Abstract}{%
\ifx \@ThesisAbstract \@empty
\WarnIfNotDraft{No abstract given}%
\else\fi%
\thispagestyle{empty}
\doublespacing
\begin{center}
{\LARGE{\@ThesisTitle}}
\end{center}
\singlespacing
\begin{center}
\@ThesisAuthor\\
{\it \@ThesisCollege}
\\[20pt]
D.Phil. Thesis\\
\ifx \@ThesisDraftMode \@empty
% Not in draft mode
\@ThesisTerm{} Term \@ThesisYear
\else
% Draft mode
{\bf DRAFT} --- \today
\fi
\end{center}
\vspace{60pt}
\begin{center}
{\Large{\bf Abstract}}
\end{center}
\vspace{10pt}
\@SpacingMode
{\@ThesisAbstract}\par
\newpage
}



% Various preamble-specific options
\numberwithin{section}{chapter}
\theoremstyle{plain}    
%\newtheorem{thm}{Theorem}[chapter]
\numberwithin{figure}{chapter} %% Comment out for sequentially-numbered
\numberwithin{table}{chapter}  %% Comment out for sequentially-numbered

%-----------------------------------------------------------------------
%  Reduce widow/orphan problems, mainly from a posting from Donald
%  Arsenau on comp.text.tex, 24 Sep 1995.
%  Updated to follow comments from Michael Downes on comp.text.tex,
%  31 Aug 1998.
%-----------------------------------------------------------------------
\doublehyphendemerits=10000     % No consecutive line hyphens.
\brokenpenalty=4991             % Reduce broken words across columns/pages.
\widowpenalty=9999              % Almost no widows at bottom of page.
\clubpenalty=9996               % Almost no orphans at top of page.
\interfootnotelinepenalty=9999  % Almost never break footnotes.
\predisplaypenalty=10000        % Default value
\postdisplaypenalty=1549        % Few breaks between display and widows
\displaywidowpenalty=1602       % At least as high as \postdisplaypenalty

%-----------------------------------------------------------------------
% Change float placement parameters to reduce problems.  Based on
% values posted by Donald Arsenau on comp.text.tex at various times.
% See in particular 17th Nov 1997.
%-----------------------------------------------------------------------
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.7}
\renewcommand{\textfraction}{.15}
\renewcommand{\floatpagefraction}{.66}
\renewcommand{\dbltopfraction}{.66}
\renewcommand{\dblfloatpagefraction}{.66}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}

%-----------------------------------------------------------------------
% Re-define \cleardoublepage as recommended by Piet van Oostrum in the
% documentation for fancyhdr.sty page 15.  This is to avoid blank pages
% having headers or footers.
%-----------------------------------------------------------------------
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else
   \thispagestyle{empty}
   \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

   
   
%-----------------------------------------------------------------------
% Number figures, tables and equations by chapter.  Re-define footnotes
% and minipage footnotes to be single spaced.  Make new macros needed
% for thesis definitions.
%-----------------------------------------------------------------------
\renewcommand{\thefigure}{\thechapter.\@arabic\c@figure}
\renewcommand{\thetable}{\thechapter.\@arabic\c@table}
\renewcommand{\theequation}{\thechapter.\@arabic\c@equation}

% Re-define \@footnotetext and \@mpfootnotetext to use single spacing
% rather than the space-and-a-half that is the default elsewhere.

\renewcommand{\@footnotetext}[1]{\insert\footins{%
    \linespread{1}\normalfont\footnotesize%
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}

\renewcommand{\@mpfootnotetext}[1]{%
  \global\setbox\@mpfootins\vbox{%
    \unvbox \@mpfootins
    \linespread{1}\normalfont\footnotesize%
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
       \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
   \color@endgroup}}

%\renewcommand{\bibname}{References}


\pagestyle{fancy}

\fancyhead{}
\renewcommand{\headrulewidth}{.1pt}
%\fancyhead[LO,RE]{\footnotesize\sffamily\leftmark}
%\fancyhead[LE,RO]{\footnotesize\sffamily\itshape\rightmark}
\fancyhead[LE]{\footnotesize\sffamily\leftmark}
\fancyhead[RO]{\footnotesize\sffamily\itshape\rightmark}
\fancyfoot[c]{\thepage}

\fancypagestyle{plain}{%
\fancyhead{} %get rid of the headers on plain pages
\renewcommand{\headrulewidth}{0pt}% and the line
}


\ifx \@ThesisDraftMode \@empty%
\else%
\lfoot{\textbf{DRAFT} --- \emph{DO NOT REDISTRIBUTE}}%
\cfoot{\thepage}%
\rfoot{\emph{\today}}%
\fi

% set up \prettyrefs with non-breaking spaces and conditional page
% refs for figures, tables, listings
\newrefformat{eq}{\textup{(\ref{#1})}}
\newrefformat{lem}{Lemma~\ref{#1}}
\newrefformat{thm}{Theorem~\ref{#1}}
\newrefformat{cha}{Chapter~\ref{#1}}
\newrefformat{sec}{Section~\ref{#1}}

% above are close to default. These are new or modified.
\newrefformat{sub}{Section~\ref{#1}}
% By default, display 'on page X' if the float hasn't occurred
% yet (on this or a previous page).
\newrefformat{fig}{Figure~\ref{#1}\ifthenelse{\thepage<\pageref{#1}}{ on page~\pageref{#1}}{}}
\newrefformat{tab}{Table~\ref{#1}\ifthenelse{\thepage<\pageref{#1}}{ on page~\pageref{#1}}{}}
\newrefformat{lst}{Listing~\ref{#1}\ifthenelse{\thepage<\pageref{#1}}{ on page~\pageref{#1}}{}}



%\newcounter{clearpagesct}
%\newcommand{\clearpages}[1]{\forloop{clearpagesct}{0}{\value{clearpagesct} < #1}{~\clearpage}}

\newcommand{\reservepages}[1]{\ifx\@PageReserving\@empty\relax\else\WarnIfNotDraft{using reservepages is only allowed in draft mode}\clearpage\addtocounter{page}{#1}\addtocounter{page}{-1}\fi}