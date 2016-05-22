\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{legislation}[2016/05/15 UMBC SGA Legislation Template]

\LoadClass{article}

\RequirePackage{mdframed}
\RequirePackage{enumitem}
\RequirePackage[pagewise]{lineno}
\RequirePackage{xifthen}

\newcommand{\@legislationType}{senate}
\DeclareOption{financeBoard}{
	\renewcommand{\@legislationType}{finance}
}
\DeclareOption{joint}{
	\renewcommand{\@legislationType}{joint}
}

\newcommand{\@authorname}{}
\newcommand{\@legislationNumber}{}
\newcommand{\@legislativeSession}{}
\newcommand{\@sponsor}{}
\newcommand{\@introduced}{}
\renewcommand{\author}[1]{\renewcommand{\@authorname}{#1}}
\newcommand{\legislationNumber}[1]{\renewcommand{\@legislationNumber}{#1}}
\newcommand{\legislativeSession}[1]{\renewcommand{\@legislativeSession}{#1}}
\newcommand{\sponsor}[1]{\renewcommand{\@sponsor}{#1}}
\newcommand{\introduced}[1]{\renewcommand{\@introduced}{#1}}
\newcommand{\senatorsActed}[5]{
	\newcommand{\@senatorsFor}{#1}
	\newcommand{\@senatorsOpposing}{#2}
	\newcommand{\@senatorsAbstaining}{#3}
	\newcommand{\@senatorsNotPresent}{#4}
	\newcommand{\@senatorsActed}{#5}
}
\newcommand{\representativesActed}[5]{
	\newcommand{\@representativesFor}{#1}
	\newcommand{\@representativesOpposing}{#2}
	\newcommand{\@representativesAbstaining}{#3}
	\newcommand{\@representativesNotPresent}{#4}
	\newcommand{\@representativesActed}{#5}
}

\newcommand{\@firstWhereas}{}

\ProcessOptions\relax

\newcommand{\legislationHeader}{
	\begin{mdframed}[leftmargin=-10pt,rightmargin=+10pt]
	\centering{\section*{
		\ifthenelse{\equal{\@legislationType}{joint}}{
			UMBC SGA Joint Legislation
		}{
			\ifthenelse{\equal{\@legislationType}{senate}}{
				UMBC SGA Senate Legislation
			}{
				UMBC SGA Finance Board Legislation
			}}
	}}
	\par
		\ifthenelse{\equal{\@legislationType}{joint}}{
			JL\@legislationNumber-\@legislativeSession
		}{
			\ifthenelse{\equal{\@legislationType}{senate}}{
				SL\@legislationNumber-\@legislativeSession
			}{
				FBL\@legislationNumber-\@legislativeSession
			}}
	\begin{description}[style=sameline]
		\item [Author] \@authorname
		\item [Sponsor] \@sponsor
		\item [Introduced] \@introduced
	\end{description}
	\end{mdframed}
	\centering{\section*{\@title}}
}
\newcommand{\legislation}[1]{
	\legislationHeader
	\raggedright\begin{linenumbers}
	\begin{description}[style=sameline,leftmargin=\parindent]
#1
	\end{description}
	\end{linenumbers}
	\legislationFooter
}
\newcommand{\whereas}[1]{
	\ifthenelse{
		\equal{\@firstWhereas}{}
	}{
		\renewcommand{\@firstWhereas}{no}
		\item [Whereas] #1
	}{\item [And whereas] #1}
}
\newcommand{\resolved}[1]{
	\renewcommand{\@firstWhereas}{}
	\item [Let it be resolved] #1
}
\newcommand{\legislationFooter}{
	\ifthenelse
	{\isundefined{\@senatorsActed} \AND \isundefined{\@representativesActed}}{}{
	\begin{mdframed}[leftmargin=-10pt,rightmargin=+10pt]
	\begin{description}[style=sameline]
		\ifthenelse{\equal{\@legislationType}{senate} \OR \equal{\@legislationType}{joint}}{
			\item [Senators For] \@senatorsFor
			\item [Senators Opposing] \@senatorsOpposing
			\item [Senators Abstaining] \@senatorsAbstaining
			\item [Senators Not Present] \@senatorsNotPresent
			\item [Date of \ifthenelse{\@senatorsFor > \@senatorsOpposing}{Passage}{Failure}] \@senatorsActed
		}{}
		\ifthenelse{\equal{\@legislationType}{joint}}{
			\end{description}
			\hrulefill
				\begin{description}[style=sameline]
		}{}
		\ifthenelse{\equal{\@legislationType}{finance} \OR \equal{\@legislationType}{joint}}{
			\item [Representatives For] \@representativesFor
			\item [Representatives Opposing] \@representativesOpposing
			\item [Representatives Abstaining] \@representativesAbstaining
			\item [Representatives Not Present] \@representativesNotPresent
			\item [Date of \ifthenelse{\@representativesFor > \@representativesOpposing}{Passage}{Failure}] \@representativesActed
		}{}
	\end{description}
	\end{mdframed}
The above piece of legislation has been presented to the Student Goverment Association of the University of Maryland, Baltimore County and has received the votes indicated above.
	\ifthenelse{\equal{\@legislationType}{senate} \OR \equal{\@legislationType}{joint}}{
	\SignatureAndDate{Speaker of the SGA Senate}
	}{}
	\ifthenelse{\equal{\@legislationType}{finance} \OR \equal{\@legislationType}{joint}}{
	\SignatureAndDate{Chair of the SGA Finance Board}
	}{}
	\ifthenelse{\equal{\@legislationType}{senate} \OR \equal{\@legislationType}{finance} \AND \isundefined{\@supressPresidentialApproval}}{
	\parI hereby \iftheneelse{\isundefined{\@presidentialApproval}}{approve/veto}{\@presidentialApproval} the above piece of legislation.
	\SignatureAndDate{President of the SGA}
	}{}
}}

% Modified from the work of Peter Grill (https://tex.stackexchange.com/questions/48152/dynamic-signature-date-line)
\newcommand*{\SignatureAndDate}[1]{%
	\vspace{.2in}
	\par\noindent\makebox[3.0in]{\hrulefill} \hfill\makebox[1.5in]{\hrulefill}%
		\par\noindent\makebox[3.0in][l]{#1}      \hfill\makebox[1.5in][l]{Date}%
}%
\endinput
