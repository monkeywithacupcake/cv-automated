# CV-Automated

This repo is an updated version of the setup described by Scott Granneman in [his blog post on using Pandoc for CV](https://www.chainsawonatireswing.com/2013/05/28/how-i-create-manage-my-cv-using-markdown-pandoc/)

Generated Lorem Ipsum from [Lipsum](https://lipsum.com)

## How it Works
The main file, `cv.sh` will take the markdown files and produce interim HTML files in `/tmp` and final .pdf files for the cover letter and CV in the main directory.  

## Setup
The files will work out of the box, but it will create a cover letter and resume of nonsense for Jane Awesome.

 1. Consider your needs. Create additional .md files in `/Builds` to suit your needs.
    + If you are creating a `.cv` you will want to have publications, and you may want to break up journal articles and presentations.
    + If you have multiple skill bases, like statistics and teaching, you may want to break up experience into separate sections, so you can move one or the other up in the order on your final cv output. (see below)
 2. Once you have all of the files that you need, make sure that each of them has your text. You can find `Jane Awesome` sprinkled as a name all over. That is you - change the name.
 3. Adjust `cv.sh` to meet your needs. At a minimum, you will want to change the 'myName' variable because it will be in the filenames of your output. If you created any new `.md` files or you want to change the order, adjust the order in the section starting with `Join the HTML files into one HTML CV`. It looks like this now:
    ```
    pandoc -H $cvBuildDir/style.css --section-divs -f markdown -t html5 \
    -o "$cvTmpDir/$cvName.html" \
    -A $cvTmpDir/description.html \
    -A $cvTmpDir/experience.html \
    -A $cvTmpDir/education.html \
    -A $cvTmpDir/skills.html \
    -A $cvTmpDir/articles.html \
    $cvBuildDir/cv.md
    ```
 4. Save everything and run `./cv.sh` from terminal. Adjust as needed and rerun.

## Likely Issues

+ Issue: I get a permission denied error when I run `./cv.sh` in terminal | *RESOLUTION*: you may need to give executable rights to the file. Make sure you are comfortable with the contents of the file and then:

  ```
  cd CV-Automated
  sudo chmod 755 ./cv.sh
  ```
+ Issue: My output is not styled nicely | *RESOLUTION*: modify `style.css` and `cv.tex` to your heart's content. You can even have separate style and tex files for the CV and Cover letter if you want. Be sure to modify `cv.sh` to match.

## Requirements
This program assumes that you are running Mac OS X and are familiar with bash and markdown.

If not already installed, you need to install pandoc and LaTeX. I recommend installing with these instructions:

 + [Pandoc](https://pandoc.org/installing.html)
 + [BasicTEX](https://www.tug.org/mactex/morepackages.html)
