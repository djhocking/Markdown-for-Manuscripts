all: Markdown_for_Manuscripts_ms.pdf Markdown_for_Manuscripts_ms.doc Markdown_for_Manuscripts_ms.html

Markdown_for_Manuscripts_ms.doc: Markdown_for_Manuscripts_ms.md Markdown_for_Manuscripts_refs.bib Figures/
	pandoc -H format.sty -V fontsize=12pt --bibliography Markdown_for_Manuscripts_refs.bib --csl=ecology.csl Markdown_for_Manuscripts_ms.md -o Markdown_for_Manuscripts_ms.doc

Markdown_for_Manuscripts_ms.pdf: Markdown_for_Manuscripts_ms.md Markdown_for_Manuscripts_refs.bib Figures/
	pandoc -H format.sty -V fontsize=12pt --bibliography Markdown_for_Manuscripts_refs.bib --csl=ecology.csl Markdown_for_Manuscripts_ms.md -o Markdown_for_Manuscripts_ms.pdf
	
Markdown_for_Manuscripts_ms.html: Markdown_for_Manuscripts_ms.md Markdown_for_Manuscripts_refs.bib Figures/
	pandoc -H format.sty --bibliography Markdown_for_Manuscripts_refs.bib --csl=ecology.csl Markdown_for_Manuscripts_ms.md -o Markdown_for_Manuscripts_ms.html
