% -------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "ppgia.cls",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, PUCPR, PPGIa, Thesis, Dissertation",
%     docstring       = "Class for a PPGIa/PUCPR thesis or dissertation.",
%     version         = "v1",
%	  author          = "Jean Paul Barddal"}
% --------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ppgia}[PPGIa Dissertation and Thesis Class]

% -- GENERAL SETUP --

% type
\LoadClass[12pt, a4paper, oneside]{book}

% page geometry
\RequirePackage[
  headheight=2cm,
  top=3.5cm,
  bottom=3.5cm,
  footskip=1.5cm,
  footnotesep=1cm,
%  twoside,
  a4paper
]{geometry}

% export in PDF/X, PDF/A, etc...
\RequirePackage{etoolbox}
\RequirePackage{colorprofiles}
\RequirePackage[a-2b,mathxmp]{pdfx}[\today]

% lorem ipsum generator
\RequirePackage{lipsum} 

% language, font and encodings
\RequirePackage{newpxtext,newpxmath}
\RequirePackage[T1]{fontenc}

%Referências no Formato ABNT:
\RequirePackage[alf,bibjustif,abnt-etal-list=0,abnt-and-type=&]{abntex2cite}

% -- USEFUL PACKAGES --

% spacings (\onehalfsize, \doublesize)
\RequirePackage{setspace}

% indent first line of paragraph
\RequirePackage{indentfirst}

% captions
\RequirePackage{caption}
\RequirePackage{subcaption}

% footnotes
\RequirePackage{footnote}
\RequirePackage[bottom]{footmisc}

% mathematics
\RequirePackage{amsmath}

% links
\RequirePackage{hyperref}
\RequirePackage{url}

% colors
\RequirePackage{color}

% graphics
\RequirePackage{graphicx}

% algorithms
\RequirePackage{algorithm}
%\RequirePackage{algorithmic}
\usepackage{algpseudocode}

% code snippets
\RequirePackage{listings}

% plots, drawings etc...
\RequirePackage{tikz}
\usetikzlibrary{shapes.geometric, arrows.meta}

% references
%\RequirePackage[autostyle]{csquotes}
%\RequirePackage[backend=biber]{biblatex}
%\addbibresource{references.bib}

% cria float do tipo quadro
% https://www.cnltx.de/2017/04/define-new-floating-environment/
\newcounter{quadro}% the counter
\renewcommand*\thequadro{\arabic{chapter}.\arabic{quadro}}% the default format for the counter
\newcommand*\fps@quadro{tbp}% default floating options
\newcommand*\ftype@quadro{4}% float type number, needs to be a power of 2;
                            % \ftype@figure=1, \ftype@table=2
\newcommand*\ext@quadro{los}% extension of file for the list of schemes
\newcommand*\fnum@quadro{\quadroname\nobreakspace\thequadro}% used in caption
\newcommand*\quadroname{Quadro}% the name
\newcommand*\listquadroname{Lista de Quadros}% the name of the list
\newenvironment{quadro}{\@float{quadro}}{\end@float}% the environment
\newenvironment{quadro*}{\@dblfloat{quadro}}{\end@dblfloat}% the starred
% version for twocolumn documents
\newcommand*\listofquadros{% the list of schemes
	\if@twocolumn \@restonecoltrue \onecolumn \else \@restonecolfalse \fi \chapter *{\listquadroname }\@mkboth {\MakeUppercase \listquadroname }{\MakeUppercase \listquadroname }\@starttoc {\ext@quadro}\if@restonecol \twocolumn \fi
}
\let\l@quadro\l@figure % layout of list is the same as for figures

% -- DEFINITIONS --

% idioma
\def\idioma#1{\gdef\@idioma{#1}}

% universidade
\def\universidade#1{\gdef\@universidade{#1}}

% programa
\def\programa#1{\gdef\@programa{#1}}

% programa
\def\cidade#1{\gdef\@cidade{#1}}


% define tipo do Titulo (mestrado ou doutorado)
% define tb o tipo do titulo (Mestrado ou Doutorado)
% e tb o tipodocumentoextenso (Dissertação ou Tese)
% definindo campo de concentracao
\def\tipodocumento#1{
	% msc
	\ifthenelse{\equal{#1}{msc}}{
		\ifthenelse{\equal{\@idioma}{pt-br}}{
			\gdef\@tipotitulocompleto{Mestrado em Informática}
			\gdef\@tipotitulo{Mestre}
			\gdef\@tipodocumentoextenso{Dissertação}			
		}{ %en-us
			\gdef\@tipotitulocompleto{Masters in Informatics}
			\gdef\@tipotitulo{Master}
			\gdef\@tipodocumentoextenso{Dissertation}
		}
	}{ 
		% phd
		\ifthenelse{\equal{#1}{phd}}{ 
			\ifthenelse{\equal{\@idioma}{pt-br}}{
				\gdef\@tipotitulocompleto{Doutorado em Informática}
				\gdef\@tipotitulo{Doutor}
				\gdef\@tipodocumentoextenso{Tese}
			}{ %en-us
				\gdef\@tipotitulocompleto{Doctorate in Informatics}
				\gdef\@tipotitulo{Doctor}
				\gdef\@tipodocumentoextenso{Thesis}
			}
		}{ 
			% pdm
			\ifthenelse{\equal{#1}{pdm}}{
				\ifthenelse{\equal{\@idioma}{pt-br}}{
					\gdef\@tipotitulocompleto{Mestrado em Informática}
					\gdef\@tipotitulo{Mestre}
					\gdef\@tipodocumentoextenso{Projeto de Dissertação}	
				}{ %en-us
					\gdef\@tipotitulocompleto{Masters in Informatics}
					\gdef\@tipotitulo{Master}
					\gdef\@tipodocumentoextenso{Dissertation Project}
				}
			}{
				% pdd
				\ifthenelse{\equal{\@idioma}{pt-br}}{
					\gdef\@tipotitulocompleto{Doutorado em Informática}
					\gdef\@tipotitulo{Doutor}
					\gdef\@tipodocumentoextenso{Projeto de Tese}
				}{ %en-us
					\gdef\@tipotitulocompleto{Doctorate in Informatics}
					\gdef\@tipotitulo{Doctor}
					\gdef\@tipodocumentoextenso{Thesis Project}
				}
			}
		}
	}
%	\ifthenelse{\equal{#1}{msc}}{
%		\ifthenelse{\equal{\@idioma}{pt-br}}{
%			\gdef\@tipotitulocompleto{Mestrado em Informática}
%			\gdef\@tipotitulo{Mestre}
%			\gdef\@tipodocumentoextenso{Dissertação}			
%		}{ %en-us
%			\gdef\@tipotitulocompleto{Masters in Informatics}
%			\gdef\@tipotitulo{Master}
%			\gdef\@tipodocumentoextenso{Dissertation}
%		}
%	}{ %phd 
%		\ifthenelse{\equal{\@idioma}{pt-br}}{
%			\gdef\@tipotitulocompleto{Doutorado em Informática}
%			\gdef\@tipotitulo{Doutor}
%			\gdef\@tipodocumentoextenso{Tese}
%		}{ %en-us
%			\gdef\@tipotitulocompleto{Doctorate in Informatics}
%			\gdef\@tipotitulo{Doctor}
%			\gdef\@tipodocumentoextenso{Thesis}
%		}	
%	}	
	\ifthenelse{\equal{\@idioma}{pt-br}}{
		\gdef\@majorfield{Ciência da Computação}
		\gdef\ALG@name{Algoritmo}
	}{ %en-us
		\gdef\@majorfield{Computer Science}
		\gdef\ALG@name{Algorithm}
	}
	% definindo o nome para o sumário
	\ifthenelse{\equal{\@idioma}{pt-br}}{
		\renewcommand{\listquadroname}{Lista de Quadros}	
%		\newcommand{\listschemename}{Lista of Charts}	
	}{
		\renewcommand{\listquadroname}{Lista of Charts}		
%		\newcommand{\listschemename}{Lista de Quadros}	
	}			
	
	% definindo idioma do documento por conta dos headers
	\ifthenelse{\equal{\@idioma}{pt-br}}{
		\RequirePackage[brazil]{babel}
	}{
		\RequirePackage[english]{babel}	
	}	
}



%\def\msc{\gdef\@tipodocumento{Mestrado}}
%\def\phd{\gdef\@tipodocumento{Doutorado}}

% ano
\def\ano#1{\gdef\@ano{#1}}

% student ID
%\def\studentId#1{\gdef\@studentId{#1}}

% orientador
\def\orientador#1{\gdef\@orientador{#1}}

% co-advisor (if one)
\def\coorientador#1{\gdef\@coorientador{#1}}
\def\coorientadorUniversidade#1{\gdef\@coorientadorUniversidade{#1}}

\def\@coorientador{\@empty}

% PUCPR color
\definecolor{PUCPRColor}{RGB}{127, 26, 57}

% -- LINKS SETUP --

% set all links to black color
\hypersetup{
  colorlinks,
  citecolor=black,
  filecolor=black,
  linkcolor=black,
  urlcolor=black
}

% -- ITEMS AND ENUMARATIONS --

% reduce spacing for items and enumerations
\let\saveditemize=\itemize
\let\savedenditemize=\enditemize
\renewenvironment{itemize}
  {\begin{spacing}{0.5}\saveditemize}
  {\savedenditemize\end{spacing}}

\let\savedenumerate=\enumerate
\let\savedendenumerate=\endenumerate
\renewenvironment{enumerate}
  {\begin{spacing}{0.5}\savedenumerate}
  {\savedendenumerate\end{spacing}}

% italic for quotes
\let\savedquote\quote
\let\endsavedquote\endquote
\renewenvironment{quote}
    {\itshape\savedquote}
    {\endsavedquote}



% -- HEADERS AND FOOTERS --

% custom headers and footers
\RequirePackage{fancyhdr}

% custom title style
\RequirePackage{titlesec}

% remove headers and footers in blank pages
\RequirePackage{scrextend}

% box for titles
\RequirePackage{adjustbox}

% style for chapters
\titleformat{\chapter}[display]
{\Huge}%\filleft}
{
  \minsizebox{!}{70pt}{\colorbox{PUCPRColor}{\color{white}\thechapter}}
}
{1.2ex}
{}

% style for sections
\titleformat{\section}[hang]
{\Large}
{
  \colorbox{PUCPRColor}{\color{white} \thesection}
}
{1ex}
{\scshape}

% style for subsections
\titleformat{\subsection}[hang]
{\large}
{
  \colorbox{PUCPRColor}{\color{white} \thesubsection}
}
{1ex}
{\scshape}

% style for subsubsections
\titleformat{\subsubsection}[hang]
{\normalsize}
{}
{0ex}
{\bfseries\scshape}

% remove line headers
\renewcommand{\headrulewidth}{0ex}

% style for headers and footers
\newcommand{\setfancyhf} {
  \fancyhf{}
  \fancyhead[RO]{{\footnotesize\leftmark}}
  \fancyhead[LE]{{\footnotesize\rightmark}}
  \fancyfoot[RE, LO]{}
  \fancyfoot[C]{\thepage}
}


% -- Omissor de listagens não usadas
\usepackage[figure,table,quadro,algorithm,lstlisting]{totalcount}
\newcommand\conditionalLoFigures{%
  \iftotalfigures\listoffigures\addcontentsline{toc}{chapter}{\listfigurename}\fi}
\newcommand\conditionalLoTables{%
  \iftotaltables\listoftables\addcontentsline{toc}{chapter}{\listtablename}  \fi}
\newcommand\conditionalLoQuadros{%
  \iftotaltables\listofquadros\addcontentsline{toc}{chapter}{\listquadroname} \fi}
\newcommand\conditionalLoAlgoritmos{%
  \iftotaltables\listofalgorithms\addcontentsline{toc}{chapter}{\listalgorithmname}\fi}    
\newcommand\conditionalLoCodigos{%
  \iftotallstlistings\lstlistoflistings\addcontentsline{toc}{chapter}{\lstlistlistingname}\fi}
  



% -- FRONTMATTER --

\renewcommand{\frontmatter} {
    
  % set roman page numbering
  \pagenumbering{roman}

  % set page style
  \pagestyle{fancy}

  % create cover
  \maketitle
  
  % creates back cover
  \backcover

  % ficha de catalogacao
  \fichacatalografica
  
  % pagina de declaracao
  \paginadeclaracaoconclusao

  % reset fancy headers
  \setfancyhf

  % set head witdth
  \setlength{\headwidth}{\textwidth}

  % custom titles
  
  \ifthenelse{\equal{\@idioma}{pt-br}}{
  	  \renewcommand{\contentsname}{Sumário}
	  \renewcommand{\listfigurename}{Lista de Figuras}
	  \renewcommand{\listtablename}{Lista de Tabelas}
	  %\renewcommand{\listquadroname}{Lista de Quadros}
	  \renewcommand{\listalgorithmname}{Lista de Algoritmos}
	  \renewcommand{\lstlistingname}{Código} % Caption name of code snippets
	  \renewcommand{\lstlistlistingname}{Lista de Códigos-fonte}
	  \def\listacronymname{Lista de Acrônimos}
	  \renewcommand{\bibname}{Referências}
	  \def\acknowledgmentsname{Agradecimentos}
  }{ %en-us
	  \renewcommand{\contentsname}{Contents}
	  \renewcommand{\listfigurename}{List of Figures}
	  \renewcommand{\listtablename}{List of Tables}
	  %\renewcommand{\listquadroname}{List of Charts (?)}	  
	  \renewcommand{\listalgorithmname}{Lista of Algorithms}
	  \renewcommand{\lstlistingname}{Code} % Caption name of code snippets
	  \renewcommand{\lstlistlistingname}{List of Codes}
	  \def\listacronymname{List of Acronyms}
	  \renewcommand{\bibname}{References}
	  \def\acknowledgmentsname{Acknowledgements}
  }
  
  % insert dedication page
  \dedicationpage

  %insert citation page
  \citationpage

  % reseta contadores de página para iniciar daqui  
%  \pagestyle{plainheader}
  \setcounter{page}{1}  
  
  % insert abstract
  \abstractpage

  % insert acknowledgements
  \acknowledgments

	% initializes the counter
%  \setcounter{page}{1}
  % insert table of contents
  \tableofcontents  
  %\clearpage

  % insert list of figures
  \phantomsection
  %\listoffigures
  \conditionalLoFigures
    

  % insert list of tables
  \phantomsection
%  \setcounter{page}{13}
%  \listoftables
	\conditionalLoTables
%  \addcontentsline{toc}{chapter}{\listtablename}  
%  \clearpage

  % inserts list of charts
  \phantomsection
%  \setcounter{page}{17}
	\conditionalLoQuadros
%  \listofquadros
%   \addcontentsline{toc}{chapter}{\listquadroname} 
  \clearpage

  % insert list of algorithms
  \phantomsection
%  \setcounter{page}{15}
%  \listofalgorithms
	\conditionalLoAlgoritmos
%  \addcontentsline{toc}{chapter}{\listalgorithmname}

  \clearpage


  % insert list of code snippets
  \phantomsection
%  \setcounter{page}{19}
%  \lstlistoflistings
%  \addcontentsline{toc}{chapter}{\lstlistlistingname}
	\conditionalLoCodigos
  \clearpage

  % insert list of abbreviations/acronyms
%  \setcounter{page}{21}
  \acronyms
}



% -- TITLE/COVER --

% insert watermark
\RequirePackage{watermark}

\renewcommand{\maketitle} {
  %set custom geometry
  \newgeometry{
    top=1.5cm,
    bottom=2cm,
    inner=2cm,
    outer=2cm,
    headheight=3.5cm,
    includehead,
    includefoot,
  }

  % set head width
  \setlength{\headwidth}{\textwidth}

  % set watermark
  \thiswatermark{
    \centering
    \put(-400,-650) {
      \includegraphics[width=1.4\linewidth]{template/PUCPR_watermark}
    }
  }

  % set academic year in footer
  \cfoot{\normalsize\textsc{\@cidade \\ \@ano}}

  % set brands in header
%  \lhead{
%    \includegraphics[height=3cm]{template/ltunipd}
%  }
  \rhead{
    \includegraphics[height=4cm]{template/PUCPR_logo}
  }

  % content
  \begin{center}

    % parte superior
%    \null \vspace{\stretch{2}}
	\null\vspace{\stretch{-2}}
    \normalsize\textsc{
      \@universidade\\
      \@programa \\
      %\@tipotitulocompleto\\
    } 

    % title
    \vspace{\stretch{2}}
    \LARGE\textbf{\@title} \\
    \vspace{\stretch{2}}

    % authors, advisors etc...
    \doublespacing

	\begin{center}
		\large{\textbf{\@author}} 
		\vspace{\stretch{2}}
		
		\ifthenelse{\equal{\@idioma}{pt-br}}{\textsc{Orientador}}{\textsc{Supervisor}} \\
		\large{\textbf{\@orientador}} \\		
		% co-orientador (se houver)
		\ifthenelse{\equal{\@coorientador}{\@empty}}{
		~ % nao faz nada caso seja vazio
		}{
			% adiciona os dados do co-orientador
			\ifthenelse{\equal{\@idioma}{pt-br}}{\textsc{Co-orientador}}{\textsc{Co-Supervisor}} \\
	        \large{\textbf{\@coorientador}} \\
	        \small
	        \@coorientadorUniversidade \\
		}
%		\ifx\@coorientador\empty \else
%%        	~\\

%    	\fi
	\end{center}
    \vspace{\stretch{1}} \null
  \end{center}

  % restore defaults
  %\cleardoublepage
  \clearpage
  \restoregeometry
  \onehalfspacing
}

% -- FICHA CATALOGRAFICA
\newcommand{\pathfichacatalografica}[1]{
	\gdef\@pathfichacatalografica{#1}
}

\gdef\@pathfichacatalografica{NONE}

\newcommand{\fichacatalografica}[0]{
	\ifthenelse{\equal{\@pathfichacatalografica}{NONE}}{
		% nenhuma ficha definida
		\newpage
		\thispagestyle{empty}
		\phantomsection
		\cfoot{}
		\rhead{}
		\vfill
		\begin{center}
			Espaço dedicado para a ficha catalográfica. Não alterar.
		\end{center}
		\vfill
%		\clearpage
	}{		
%		\newpage
%		\thispagestyle{empty}
%		\phantomsection
		\cfoot{}
		\rhead{}
%		~\\
%		\clearpage
		\begin{figure}[hbt!]
			\vspace*{-2cm}
			\hspace*{-2cm}
	        \begin{center}
				\makebox[\linewidth]{
					\includegraphics[width=208mm]{\@pathfichacatalografica}   
				}
    	    \end{center}
		\end{figure}
%		\clearpage
	}
}


% -- DECLARACAO DE DEFESA
\newcommand{\pathdeclaracaoconclusao}[1]{
	\gdef\@pathdeclaracaoconclusao{#1}
}

\gdef\@pathdeclaracaoconclusao{NONE}

\newcommand\paginadeclaracaoconclusao[0]{
	\ifthenelse{\equal{\@pathdeclaracaoconclusao}{NONE}}{
		% Imprime aviso sobre declaracao
		\newpage
		\thispagestyle{empty}
		\phantomsection
		\cfoot{}
		\rhead{}
		~\\
%		\clearpage

%		\clearpage
%		\vfill
		\begin{center}
			Espaço dedicado para a declaração de conclusão emitida pelo programa. Não alterar.
		\end{center}
%		\vfill
		\clearpage
	}{
		% imprime a declaracao em pagina cheia
%		\newpage
		\thispagestyle{empty}
		\phantomsection
		\cfoot{}
		\rhead{}
		~\\
%		\clearpage
		\begin{figure}[hbt!]
			\vspace*{-2cm}
			\hspace*{-2cm}
	        \begin{center}
				\makebox[\linewidth]{
					\includegraphics[width=208mm]{\@pathdeclaracaoconclusao}   
				}
	        \end{center}
		\end{figure}		
		\clearpage
	}

}

%%%%%% INFORMATIONS %%%%%%

%\newcommand\informations[6]{%
%   \if@twoside
%     \clearpage
%   \else
%     \cleardoublepage
%   \fi
%
%%   \thispagestyle{empty}
%%   ~\\
%%   \vfill
%%   \vfill
%
%%   \begin{center}
%%      \begin{minipage}{140mm}
%%         \hsize=135mm
%%         \textwidth=\hsize
%%         \linewidth=\hsize
%%         \framebox[140mm]{%
%%            \vbox{%
%%           \noindent #1, #2\\\@title. \@address, \@date. \vskip2\baselineskip
%%           \@texttype\ - \@university . Programa de Pós-Graduação em Informática. \vskip2\baselineskip 1. #3 2. #4 3. #5 I.\@university. Escola Politécnica. Programa de Pós-Graduação em Informática II - t
%%            }
%%         }
%%      \end{minipage}
%%   \end{center}
%
%
%	% CATALOGACAO	
%	\begin{figure}[hbt!]
%		\vspace*{-2cm}
%		\hspace*{-2cm}
%        \begin{center}
%			\makebox[\linewidth]{
%				\includegraphics[width=208mm]{catalogacao}   
%			}
%        \end{center}
%	\end{figure}
%
%   \if@twoside
%   \else
%     \newpage
%     \thispagestyle{empty}
%     \ifx&#6&%
%        \mbox{}
%     \else
%        \begin{figure}[hbt!]
%		\vspace*{-2cm}
%		\hspace*{-2cm}
%        \begin{center}
%			\makebox[\linewidth]{
%				\includegraphics[width=208mm]{#6}   
%			}
%        \end{center}
%        \end{figure}
%     \fi
%     \clearpage
%     \newpage
%	 \thispagestyle{empty}
%     ~\\
%	 \vfill
%	 \vfill
%	 
%	 This thesis was prepared with \LaTeX. 
%	 The bibliography created using \BibTeX~and the abn\TeX2 style.
%	 Please respect the license required by the author and cite his works appropriately.
%	 \\
%    \begin{center}
%	 Jean Paul Barddal - 2019 \\ \doclicenseThis
%	 \end{center}
%   \fi
%   \newpage
%   \pagestyle{plainheader}
%   \setcounter{page}{1}
%}


% contracapa
\def\backcover{
  %set custom geometry
  \newgeometry{
    top=1.5cm,
    bottom=2cm,
    inner=2cm,
    outer=2cm,
    headheight=3.5cm,
    includehead,
    includefoot,
  }

  % set head width
  \setlength{\headwidth}{\textwidth}

  % set watermark
%  \thiswatermark{
%    \centering
%    \put(-400,-650) {
%      \includegraphics[width=1.4\linewidth]{template/PUCPR_watermark}
%    }
%  }

  % set academic year in footer
  \cfoot{\normalsize\textsc{\@cidade \\ \@ano}}

  % set brands in header
%  \lhead{
%    \includegraphics[height=3cm]{template/ltunipd}
%  }
%  \rhead{
%    \includegraphics[height=4cm]{template/PUCPR_logo}
%  }

  % content
  \begin{center}

    % parte superior
%    \null \vspace{\stretch{2}}
	\null\vspace{\stretch{-2}}
    \normalsize\textsc{
      \@universidade\\
      \@programa \\
      %\@tipotitulocompleto\\
    } 

    % title
    \vspace{\stretch{2}}
    \LARGE\textbf{\@title} \\
    \vspace{\stretch{2}}

    % authors, advisors etc...
    \doublespacing

	\begin{center}
		\large{\textbf{\@author}} 
		\vspace{\stretch{2}}
	\end{center}

	\begin{flushright}
		\begin{minipage}{80mm}
			\ifthenelse{\equal{\@idioma}{pt-br}}{
				\normalsize \@tipodocumentoextenso ~apresentada ao Programa de Pós-Graduação em Informática como requisito parcial para obtenção do título de \@tipotitulo ~em Informática.\\
				\textsc{\textbf{Campo de Concentração}}: \@majorfield\\				
				\textsc{\textbf{Orientador}: \@orientador} \\
				% co-orientador (se houver)
				\ifthenelse{\equal{\@coorientador}{\@empty}}{
					~ % nao faz nada caso seja vazio
				}{
					% adiciona os dados do co-orientador
					\textsc{\textbf{Co-orientador}: \@coorientador} \\
				}			
			}{ %en-us
				\normalsize \@tipodocumentoextenso ~presented to the \textit{Programa de Pós-Graduação em Informática} as a partial requirement for the degree of  \@tipotitulo ~in Informatics.\\
				\textsc{\textbf{Major Field}}: \@majorfield\\
				\textsc{\textbf{Supervisor}: \@orientador} \\
				% co-orientador (se houver)
				\ifthenelse{\equal{\@coorientador}{\@empty}}{
					~ % nao faz nada caso seja vazio
				}{
					% adiciona os dados do co-orientador
					\textsc{\textbf{Co-supervisor}: \@coorientador} \\
				}
			}
		\end{minipage}
	\end{flushright}
    \vspace{\stretch{1}} \null
  \end{center}

  % restore defaults
  %\cleardoublepage
%  \clearpage
  \restoregeometry
  \onehalfspacing
}



% -- DEDICATION --

\newcommand{\dedicationpage} {
  \newpage
  % set empty style for this page (no headers and footers)
  \thispagestyle{empty}

  \phantomsection
  
%  \null \vspace{\stretch{1}}
  \null \vfill

  \begin{flushright}
    \input{frontmatter/dedication}
  \end{flushright}

%  \vspace{\stretch{4}} \null
  
  % insert pages for alignment
  \clearpage
}

% -- CITATION PAGE --
\newcommand{\citationpage} {
  % set empty style for this page (no headers and footers)
  \thispagestyle{empty}

  \phantomsection
  
%  \null \vspace{\stretch{1}}
  \null \vfill

  \begin{flushright}
    \input{frontmatter/citation}
  \end{flushright}

%  \vspace{\stretch{4}} \null
  
  % insert pages for alignment
  \clearpage
}
  

% -- ACRONYMS/ABBREVIATIONS --

\RequirePackage{acronym}

% custom style for acronyms
\newcommand{\acronyms}{
  \phantomsection
  \addcontentsline{toc}{chapter}{\listacronymname}
  \chapter*{\listacronymname}
  \input{frontmatter/glossary}
  \clearpage
}


% -- ACKNOWLEDGMENTS --
\newcommand{\acknowledgments} {
  \phantomsection
  \chapter*{\acknowledgmentsname}
  \input{frontmatter/agradecimentos}
}


% -- ABSTRACT --
\newenvironment{abstract}{
  \null %\vfill
  \begin{center}
    \bfseries    
    Abstract
  \end{center}
}

\newenvironment{resumo}{
  \null %\vfill
  \begin{center}
    \bfseries    
    Resumo
  \end{center}  
}

% -- Citacao longa
\newenvironment{longcitation}[0]{
	\begin{flushright}	
	\footnotesize
	\itshape
}{	
	\end{flushright}
}

\def\palavraschave#1{~\\\noindent \textbf{Palavras-chave}:~{#1}}
\def\keywords#1{~\\\noindent \textbf{Key-words}:~{#1}}

\newcommand{\abstractpage} {
	% set empty style for this page (no headers and footers)
%	\thispagestyle{empty}
	\ifthenelse{\equal{\@idioma}{pt-br}}{
		% apresenta pt-br e dps en-us
		\input{frontmatter/resumo}		
		\clearpage
		\input{frontmatter/abstract}	
		\clearpage
	}{ % aqui faz o contrário
		\input{frontmatter/abstract}			
		\clearpage
		\input{frontmatter/resumo}		
		\clearpage
	}
}



% -- MAIN MATTER --

\renewcommand{\mainmatter} {
  \clearpage

  % reset page counter
  \setcounter{page}{1}

  % set arabic page numbering
  \pagenumbering{arabic}

  % reset chapter counter
  \setcounter{chapter}{0}
}



% -- BACKMATTER --

\renewcommand{\backmatter}{
  \clearpage
  \phantomsection

  % add references
  \addcontentsline{toc}{chapter}{\bibname}
%  \printbibliography
  \bibliographystyle{abntex2-alf}
  \bibliography{references.bib}
  
  \clearpage
  \phantomsection

%  % add acknowledgments
%  \addcontentsline{toc}{chapter}{\acknowledgmentsname}
%  \acknowledgments
}

% -- CODE SNIPPETS --

% Colors for code snippets highlights
\definecolor{commentsColor}{RGB}{36, 161, 156}
\definecolor{numColor}{RGB}{71, 96, 114}
\definecolor{stringColor}{RGB}{205, 63, 62}
\definecolor{kwColor}{RGB}{248, 6, 204}
\definecolor{bgCodeColor}{RGB}{255, 249, 249}

% Style of code snippets
\lstdefinestyle{codeSnippet} {
  backgroundcolor=\color{bgCodeColor},
  commentstyle=\color{commentsColor},
  keywordstyle=\color{kwColor},
  numberstyle=\tiny\color{numColor},
  stringstyle=\color{stringColor},
  basicstyle=\ttfamily\footnotesize,
  breakatwhitespace=false,         
  breaklines=true,                 
  captionpos=b,                    
  keepspaces=true,                 
  numbers=left,                    
  numbersep=5pt,                  
  showspaces=false,                
  showstringspaces=false,
  showtabs=false,                  
  tabsize=2
}

\lstset{style=codeSnippet}

  
