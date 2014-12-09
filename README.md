Writing Scientific Papers Using Markdown!
====================

Markdown is a markup language that is very handy and easy to use. I won't say much more about it, but I've written about it before [here](http://danieljhocking.wordpress.com/2013/09/25/knitting-beautiful-documents-in-rstudio/) and [here](http://danieljhocking.wordpress.com/2014/04/07/electronic-lab-notebook-take-1/). I've used it increasingly for writing blog posts, webpages, taking notes, with GitHub issue tracking, and with R code (R Markdown in RStudio is fantastic!). As a Mac OS user, I find Microsoft Office products to be annoying and temperamental. I read Karthik Ram's great post on how to [ditch MS Word](http://inundata.org/2012/12/04/how-to-ditch-word/) a while back and since I've been using Markdown for so much lately, it seemed like a good time to write my first scientific paper with it. I'm going to use this post, written in Markdown, to outline my process. This will help me repeat the process in the future if I like it and hopefully help others interested in trying it.

### Step 1: Create a Markdown Document
Obviously the first step is to create a Markdown document. You can do this with any text editor and just change the extension from `.txt` to `.md`. However, there are applications with handy Markdown features. I use [Mou](http://25.io/mou/) because it has a nice live-rendering of your markdown code so you can see what it looks like.

For this example and for future use, I've created a template for a manuscript that you can find here.

### Step 2: Add In-Text Citations
To add references, I use Mendeley and create a folder for any publications I cite (or might cite) in the manuscript. Then while writing you can add in-text citations with `[@Hocking2013]`, which can be found under Citation Key in Mendeley. Then I export this folder as a BibTeX file to the folder that the manuscript will live in. This will be used later to render the literature cited section.

### Step 3: Install or Update Pandoc
Pandoc is an amazing program to convert between different file types. In our case we can create HTML, Word, and PDF files from our Markdown document. You can find the installation instructions at [http://johnmacfarlane.net/pandoc/installing.html](http://johnmacfarlane.net/pandoc/installing.html). You will also need LaTeX installed if you want to output PDF documents. You can use [MacTex](https://tug.org/mactex/) or [BasicTeX](http://www.tug.org/mactex/morepackages.html) on a Mac or [MiKTeX](http://miktex.org/) on a Windows machine (Linux users, you know what to do).

I was getting an error

```
Error running filter pandoc-citeproc
Error 83
```

So I decided to install [Haskell](https://www.haskell.org/platform/) and run the following:

```
cabal update
cabal install pandoc pandoc-citeproc
```

Then this can just be run again in the Terminal app in the future to update pandoc.


### Step 4: Add a Style Sheet
When creating a PDF there is a 1.5 inch left margin by default (good for binding I guess). Generally, I want 1 inch margins all around so I open a text file and paste

```
\usepackage[vmargin=1in,hmargin=1in]{geometry}
```

Then save it as `format.sty` in the folder with the manuscript. If you want line numbers and other formatting you can add these lines

```
\usepackage{lineno}
\linenumbers
\usepackage{times}
```

### Step 5: Add a Journal Style File
One of the benefits of writing in simple text is that you don't have to worry about formatting while writing. But now to add formatting for a specific journal, go [here](https://github.com/citation-style-language/styles) to get a style `.csl` file that is an XML type document that defines the styles required for a journal. This includes in-text citation, literature cited, and heading styles. Copy the desired `.csl` file into the same folder as manuscript `.md` document.


### Step 6: Put it all Together
Now is when we use pandoc to combine the styles and bibliographic information with the manuscript. In the Terminal you can simply run

```
pandoc document.md -o document.pdf
```

to convert the document from markdown to PDF. However, this won't have any of the desired formatting. To include the formatting, you just add some flags and arguments as such:

```
pandoc document.md -o document.pdf --bibliography cite.bib --csl style.csl -H format.sty
```

To automate this code and potentially output PDF, Word, and HTML documents all at once you can easily create a `make` file. To do this open a text editor and paste something like:

```
all: document_ms.pdf document_ms.doc

document_ms.doc: document_ms.md document_refs.bib
	pandoc -H format.sty -V fontsize=12pt --bibliography document_refs.bib --csl=ecology.csl document_ms.md -o document_ms.doc

document_ms.pdf: document_ms.md document_refs.bib
	pandoc -H format.sty -V fontsize=12pt --bibliography document_refs.bib --csl=ecology.csl document_ms.md -o document_ms.pdf
```

Then save the file as `makefile` with no extension (i.e. `.txt`). Then when you `cd` to that folder in Terminal you just have to type `make` and the documents will automatically be created. At this point you should have `.md`, `.doc`, and `.pdf` files (and `.html` if you want). 

If you change anything in the markdown file or want to format for a different journal just add the new `.csl` file and make any other changes you want then run `make` again. Then submit the manuscript.

I am currently using `diff` in git or GitHub to replace track changes with co-authors early in the process when there are lots of changes but authors can also comment on Word or PDF versions as well. I'm also interested in potentially checking out [Authorea](https://www.authorea.com/) for collaborative writing in Markdown. It seems pretty slick.





