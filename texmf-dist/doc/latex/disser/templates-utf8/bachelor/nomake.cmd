@echo off

rem Makefile for documents and templates
rem Author: Stanislav Kruchinin <stanislav.kruchinin@gmail.com>

chcp 1251 > nul
set bibtex=biber
set bibtexflags= 
set latexnmk=call ..\..\include\latex.nmk.cmd

if "%1"=="" (
	%latexnmk%
) else (
	for %%f in (%*) do if "%%f"=="help" (
		call :%%f
	) else if "%%f"=="all" (
		%latexnmk% pdf
	) else if "%%f"=="allpdf" (
		%latexnmk% pdf
	) else if "%%f"=="alldvi" (
		%latexnmk% dvi
	) else (
		%latexnmk% %%f
	)
)

exit /b

:help
	echo   all          alias for pdf target
	echo   allpdf       alias for pdf target
	echo   alldvi       alias for dvi target
	%latexnmk% help
goto :eof

