% awthesis Class for Latex2e

%% This class file has been hacked together from huthesis.cls and
%% ubthesis.cls (16 March 2001) Alex Wilson

%\NeedsTeXFormat{LaTeX2e}
%\ProvidesClass{starthesis}[v1.0 AW Thesis Class]

% Which of these two is correct?
\DeclareOption{PhD}{\def\degreetitle{Doctor of Philosophy}}
\DeclareOption{MSc}{\def\degreetitle{Master of Science}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ExecuteOptions{PhD}

\ProcessOptions

\LoadClass[a4paper]{report}

%% We need >15mm  margins except on the binding edge, where it is >40mm
\oddsidemargin 14.6truemm \evensidemargin -5.4truemm
\marginparwidth 0truemm \marginparsep 0truemm
\topmargin 5truemm \headsep 0truemm \headheight 0truemm
\textheight 235truemm \textwidth 150truemm \footskip 15truemm


%% LETTER PAPER KLUDGE %%%%
%% We need >15mm  margins except on the binding edge, where it is >40mm
%\oddsidemargin 19.6truemm \evensidemargin -5.4truemm
%\marginparwidth 0truemm \marginparsep 0truemm
%\topmargin -12.0truemm \headsep 0truemm \headheight 0truemm
%\textheight 252truemm \textwidth 150truemm \footskip 8truemm

%% Disallow page breaks at hyphens (this will give some underfull vbox's,
%% so an alternative is to use \brokenpenalty=100 and manually search
%% for and fix such page breaks)
\brokenpenalty=10000

% For some environments we switch back to single-spacing, also
% provides \dsp in case you need double-spacing where single-spacing
% is otherwise used.
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}

% \def\dsp{\def\baselinestretch{1.35}\large\normalsize} % UC setting
% 1.8 is close enough to 2.0 to satisfy harvard university:
\def\dsp{\def\baselinestretch{1.8}\large\normalsize}
\def\hsp{\def\baselinestretch{1.35}\large\normalsize} % intermediate spacing


% \smallssp is used to produce tabular environments in the small font.
% This is required because single-spacing requires a change in font size.
% \scriptsizessp is a still smaller version of the same thing.

\def\smallssp{\def\baselinestretch{1.0}\large\small}
\def\scriptsizessp{\def\baselinestretch{1.0}\large\scriptsize}

%% Redefine the macro used for floats (including figures and tables)
%% so that single spacing is used.
%% (Note \def\figure{\@float{figure}set single spacing} doesn't work
%%  because figure has an optional argument)
%% Cai commented out lines 61 to 76 to show figures
%\def\@xfloat#1[#2]{\ifhmode \@bsphack\@floatpenalty -\@Mii\else
%   \@floatpenalty-\@Miii\fi\def\@captype{#1}\ifinner
%      \@parmoderr\@floatpenalty\z@
%    \else\@next\@currbox\@freelist{\@tempcnta\csname ftype@#1\endcsname
%       \multiply\@tempcnta\@xxxii\advance\@tempcnta\sixt@@n
%       \@tfor \@tempa :=#2\do
%                        {\if\@tempa h\advance\@tempcnta \@ne\fi
%                         \if\@tempa t\advance\@tempcnta \tw@\fi
%                         \if\@tempa b\advance\@tempcnta 4\relax\fi
%                         \if\@tempa p\advance\@tempcnta 8\relax\fi
%         }\global\count\@currbox\@tempcnta}\@fltovf\fi
%    \global\setbox\@currbox\vbox\bgroup
%    \def\baselinestretch{1}\@normalsize
%    \boxmaxdepth\z@
%    \hsize\columnwidth \@parboxrestore}

%% Redefine the macro used for footnotes to use single spacing
\long\def\@footnotetext#1{\insert\footins{\def\baselinestretch{1}\footnotesize
    \interlinepenalty\interfootnotelinepenalty 
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}



%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.  

% The year and month the completed thesis is submitted...
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} % \author, \title in report

% The full (unabbreviated) name of the degree
%\def\degree#1{\gdef\@degree{#1}}

% The name of your advisor (AHB 00/9/18)
\def\principaladviser#1{\gdef\@principaladviser{#1}}
\def\advis@r{Advisor}
\def\principaladvisor#1{\gdef\@principaladviser{#1}\gdef\advis@r{Advisor}}
\def\firstreader#1{\gdef\@firstreader{#1}}
\def\secondreader#1{\gdef\@secondreader{#1}}

% the department
\def\dept#1{\gdef\@dept{#1}}

%defaults
\def\@title{}\def\@author{}\def\@dept{Physics}
\def\@principaladviser{}\def\@firstreader{}\def\@secondreader{}
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}

\ifnum\month=12
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \def\@copyrightyear{\number\the\year}
\fi
\newif\ifcopyright \newif\iffigurespage \newif\iftablespage \newif\ifsigpage
\copyrighttrue \figurespagetrue \tablespagetrue \sigpagefalse


% \alwayssingle and \endalwayssingle
%
% These macros define an environment for front matter that is always 
% single column even in a double-column document.

\def\alwayssingle{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
     \else \newpage \fi}

\def\endalwayssingle{\if@restonecol\twocolumn \else \newpage \fi}

% \maketitle outputs the complete titlepage.  It requires all the
% above macros except \campuscap.  It is probably not correct for 
% joint (e.g. UCSD/SDSU) degrees.


%% If you're doing an MSc, I'm sure you can guess which parts to change below.
\def\titlep{%
%	\pagenumbering{roman} % Jan 2000 GSAS Harvard req.
        \vfill
        \begin{center}
                \huge\bfseries\expandafter{\@title}
        \end{center}
        \vfill

        \begin{center}
            \vspace{-15mm}
            \includegraphics[scale=0.6]{Images/UoB_Graphic_RGB_24}
            \vspace{-30mm}
        \end{center}
        \vfill

        \begin{center}
		\LARGE
        \vspace{1em}
                \expandafter \@author\\
%                Department of \expandafter{\@dept}
        \end{center}

	\vfill


        \begin{center}
               \Large
               
		A dissertation submitted to the
		University of Bristol in accordance with the requirements
		 of the degree of \degreetitle \ in the Faculty of Science and Engineering. 
	 \end{center}
        \vfill

        
        \begin{center}
               \large
               \vspace{1em}
		\emph{School of Physics \\
			H.H. Wills Physics Laboratory \\
			Tyndall Avenue \\
			Bristol \\ BS8 1TL}
	 \end{center}
        \vfill

        \begin{center}
    		\large
            \vspace{1em}
                    \expandafter \textit{Supervised by \@principaladviser} \\
            \end{center}
    
        \vfill

        \begin{center}
                \Large\@submitdate
        \end{center}\vskip.5in

        \hskip12cm $\sim 50,000$ words
}
% COPYRIGHTPAGE
%
% This is a macro, not an environment, because it can be generated
% with the \title, \author, and \year macros.

\def\copyrightpage
{
  \clearpage
  \thispagestyle{empty}
  \rule[0pt]{0pt}{0pt} \\
  \vspace{8.0in}
  \rule[0pt]{0pt}{0pt} \\
  \large
  \centerline{\copyright\ {\@copyrightyear} by {\@author}}
  \centerline{\ }
  \centerline{All rights reserved.}
  \normalsize
}

% ABSTRACT
%
% The ABSTRACT environment allows for multi-page abstracts which,
% in accordance with Jan 2000 GSAS Harvard rules, are numbered iii, iv, etc.
% It requires definition
% of the \title, \author and \advisor macros.
% sspabstract does a better version when whole doc is \ssp mode.


\newenvironment{sabstract}
{
  \cleardoublepage
  \thispagestyle{plain}
%	\@mkboth{\abstractname}{\abstractname}
  \addcontentsline{toc}{section}{Abstract}
%	\vspace*{-.8in}
%	\noindent Thesis advisor \hfill Author \\
%	\noindent {\bf \@advisor} \hfill {\bf \@author} \\[.4in]
%	\begin{center}
%		{\large\bf {\@title}}
%	\end{center} \\[.4in]
%  {\centerline{\bf {\LARGE Abstract}}}
  \chapter*{Abstract}

}
{}
 
%\newenvironment{sspabstract}
%{
%  \cleardoublepage
%  \thispagestyle{empty}
%	\@mkboth{\abstractname}{\abstractname}
%  \addcontentsline{toc}{section}{Abstract}
%	\vspace*{-.7in}
%	\noindent Thesis advisor \hfill Author \\
%	\noindent {\bf \@advisor} \hfill {\bf \@author} \\[.5in]
%	\centerline{\large \bf {\@title}} \\[.5in]
%  {\centerline{\bf {\LARGE Abstract}}} \\[0.3in]
%}
%{}

% ACKNOWLEDGMENTS
%

\newenvironment{acknowledgments}
{
  \cleardoublepage
  \thispagestyle{plain}
%	\@mkboth{\acknowledgename}{\acknowledgename}
  \addcontentsline{toc}{section}{Acknowledgments}
  \chapter*{Acknowledgments}
}
{}

% DECLARATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{declaration}
{
  \cleardoublepage
  \thispagestyle{plain}
  \addcontentsline{toc}{section}{Declaration}
  \chapter*{Declaration}
}
{}

% Statement on the inclusion of published and collaborative work
%
% Added by MGL: Identical to dedication environment.

\newenvironment{statement_published_work}
{
  \cleardoublepage
  \thispagestyle{plain}
  \addcontentsline{toc}{section}{Statement on the Inclusion of Published and Collaborative work}
  \chapter*{Statement on the Inclusion of Published and Collaborative work}
}
{}

% CITATION ENVIRONMENT
%\newenvironment{citations}
%{
%  \cleardoublepage
%  \thispagestyle{empty}
%  \addcontentsline{toc}{section}{Citations}
%  \chapter*{Citations}
%}
%{}

% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}
{
  \cleardoublepage
  \thispagestyle{empty}
}
{}

% RESTART PAGE NUMBERING COMMAND
\newenvironment{startarabicpagination}
{
	\setcounter{page}{1}
	\pagenumbering{arabic}
	\pagestyle{plain}
}
{}

% CHANGE LIST SPACING

   \def\@listi{\leftmargin\leftmargini
               \parsep \z@
               \topsep 6\p@ \@plus2\p@ \@minus4\p@
               \itemsep\parsep}
   \let\@listI\@listi
   \@listi
   \def\@listii {\leftmargin\leftmarginii
                 \labelwidth\leftmarginii
                 \advance\labelwidth-\labelsep
                 \topsep    \z@
                 \parsep    \topsep
                 \itemsep   \parsep}
   \def\@listiii{\leftmargin\leftmarginiii
                 \labelwidth\leftmarginiii
                 \advance\labelwidth-\labelsep
                 \topsep    \z@
                 \parsep    \topsep
                 \itemsep   \parsep}
   \def\@listiv {\leftmargin\leftmarginiv
                 \labelwidth\leftmarginiv
                 \advance\labelwidth-\labelsep}
   \def\@listv  {\leftmargin\leftmarginv
                 \labelwidth\leftmarginv
                 \advance\labelwidth-\labelsep}
   \def\@listvi {\leftmargin\leftmarginvi
                 \labelwidth\leftmarginvi
                 \advance\labelwidth-\labelsep}
% make indentations changeable
\def\setitemindent#1{\settowidth{\labelwidth}{#1}%
        \leftmargini\labelwidth
        \advance\leftmargini\labelsep
   \def\@listi{\leftmargin\leftmargini
        \labelwidth\leftmargini\advance\labelwidth by -\labelsep
        \parsep=\parskip
        \topsep=\medskipamount
        \itemsep=\parskip \advance\itemsep by -\parsep}}
\def\setitemitemindent#1{\settowidth{\labelwidth}{#1}%
        \leftmarginii\labelwidth
        \advance\leftmarginii\labelsep
\def\@listii{\leftmargin\leftmarginii
        \labelwidth\leftmarginii\advance\labelwidth by -\labelsep
        \parsep=\parskip
        \topsep=\z@
        \itemsep=\parskip \advance\itemsep by -\parsep}}
% labels of description
\def\descriptionlabel#1{\hspace\labelsep #1\hfil}
% adjusted environment "description"
% if an optional parameter (at the first two levels of lists)
% is present, its width is considered to be the widest mark
% throughout the current list.
\def\description{\@ifnextchar[{\@describe}{\list{}{\labelwidth\z@
          \itemindent-\leftmargin \let\makelabel\descriptionlabel}}}
\let\enddescription\endlist
%
\def\describelabel#1{#1\hfil}
\def\@describe[#1]{\relax\ifnum\@listdepth=0
\setitemindent{##1}\else\ifnum\@listdepth=1
\setitemitemindent{##1}\fi\fi
\list{--}{\let\makelabel\describelabel}}
%
\setlength\leftmargini  {\parindent}
\leftmargin  \leftmargini
\setlength\leftmarginii {\parindent}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {.5em}
\setlength\leftmarginvi {.5em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}

%%% DPC 15/9/93 Make the bibliography generate an entry in the table
%%% of contents.  

\def\thebibliography#1{\chapter*{\bibname\@mkboth
  {\uppercase{\bibname}}{\uppercase{\bibname}}}%
  \addcontentsline{toc}{chapter}{\bibname}%
  \list
  {\@biblabel{\arabic{enumiv}}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \def\theenumiv{\arabic{enumiv}}}%
    \def\newblock{\hskip .11em plus.33em minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=\@m}

\def\endthebibliography{%
  \def\@noitemerr{\@warning{Empty `thebibliography' environment}}%
  \endlist}


%%% Useful definitions \def\sun{\hbox{$\odot$}}
\def\la{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr<\cr\sim\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
<\cr\sim\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
<\cr\sim\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
<\cr\sim\cr}}}}}
\def\ga{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr>\cr\sim\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
>\cr\sim\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
>\cr\sim\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
>\cr\sim\cr}}}}}

\newcommand{\sun}{\hbox{$\odot$}}
\newcommand{\msun}{\hbox{M$_{\odot}$}}
\newcommand{\lsun}{\hbox{L$_{\odot}$}}
\newcommand{\co}{\hbox{$^{12}\mathrm{CO}$}}
\newcommand{\kms}{\hbox{km\,s$^{-1}$}}
\newcommand{\wco}{\hbox{W$\mathrm{_{CO}}$}}
\newcommand{\tco}{\hbox{$^{13}\mathrm{CO}$}}
\newcommand{\ndash}{\hbox{\nobreakdash\textendash}}

\def\degr{\hbox{$^\circ$}}
\def\arcmin{\hbox{$^\prime$}}
\def\arcsec{\hbox{$^{\prime\prime}$}}
\def\utw{\smash{\rlap{\lower5pt\hbox{$\sim$}}}}
\def\udtw{\smash{\rlap{\lower6pt\hbox{$\approx$}}}}
\def\fd{\hbox{$.\!\!^{\rm d}$}}
\def\fh{\hbox{$.\!\!^{\rm h}$}}
\def\fm{\hbox{$.\!\!^{\rm m}$}}
\def\fs{\hbox{$.\!\!^{\rm s}$}}
\def\fdg{\hbox{$.\!\!^\circ$}}
\def\farcm{\hbox{$.\mkern-4mu^\prime$}}
\def\farcs{\hbox{$.\!\!^{\prime\prime}$}}
\def\fp{\hbox{$.\!\!^{\scriptscriptstyle\rm p}$}}
\def\cor{\mathrel{\mathchoice {\hbox{$\widehat=$}}{\hbox{$\widehat=$}}
{\hbox{$\scriptstyle\hat=$}}
{\hbox{$\scriptscriptstyle\hat=$}}}}
\def\sol{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr\sim\cr<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr\sim\cr
<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr\sim\cr
<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
\sim\cr<\cr}}}}}
\def\sog{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr\sim\cr>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr\sim\cr
>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
\sim\cr>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
\sim\cr>\cr}}}}}
\def\lse{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr<\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
<\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
<\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
<\cr\simeq\cr}}}}}
\def\gse{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr>\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
>\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
>\cr\simeq\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
>\cr\simeq\cr}}}}}
\def\grole{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr>\cr\noalign{\vskip-1.5pt}<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
>\cr\noalign{\vskip-1.5pt}<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
>\cr\noalign{\vskip-1pt}<\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
>\cr\noalign{\vskip-0.5pt}<\cr}}}}}
\def\leogr{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr<\cr\noalign{\vskip-1.5pt}>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
<\cr\noalign{\vskip-1.5pt}>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
<\cr\noalign{\vskip-1pt}>\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
<\cr\noalign{\vskip-0.5pt}>\cr}}}}}
\def\loa{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr<\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
<\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
<\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
<\cr\approx\cr}}}}}
\def\goa{\mathrel{\mathchoice {\vcenter{\offinterlineskip\halign{\hfil
$\displaystyle##$\hfil\cr>\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\textstyle##$\hfil\cr
>\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptstyle##$\hfil\cr
>\cr\approx\cr}}}
{\vcenter{\offinterlineskip\halign{\hfil$\scriptscriptstyle##$\hfil\cr
>\cr\approx\cr}}}}}
\def\diameter{{\ifmmode\mathchoice
{\ooalign{\hfil\hbox{$\displaystyle/$}\hfil\crcr
{\hbox{$\displaystyle\mathchar"20D$}}}}
{\ooalign{\hfil\hbox{$\textstyle/$}\hfil\crcr
{\hbox{$\textstyle\mathchar"20D$}}}}
{\ooalign{\hfil\hbox{$\scriptstyle/$}\hfil\crcr
{\hbox{$\scriptstyle\mathchar"20D$}}}}
{\ooalign{\hfil\hbox{$\scriptscriptstyle/$}\hfil\crcr
{\hbox{$\scriptscriptstyle\mathchar"20D$}}}}
\else{\ooalign{\hfil/\hfil\crcr\mathhexbox20D}}%
\fi}}
