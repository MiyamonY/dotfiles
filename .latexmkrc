#!/usr/bin/env perl
$latex            = 'platex -synctex=1 -shell-escape -halt-on-error';
$latex_silent     = 'platex -synctex=1 -interaction=batchmode -halt-on-error';
$bibtex           = 'pbibtex -min-crossrefs=0';
$dvipdf           = 'dvipdfmx -d 5 %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 5;
$pdf_mode	  = 3; # generates pdf via dvipdfmx

# Prevent latexmk from removing PDF after typeset.
# This enables Skim to chase the update in PDF automatically.
$pvc_view_file_via_temporary = 0;

# Use Skim as a previewer
# $pdf_previewer    = "open -ga /Applications/Skim.app";
# # .latexmkrc starts
# $kanji    = "-kanji=$ENV{\"LATEXENC\"}" if defined $ENV{"LATEXENC"};
# $latex    = "platex -interaction=nonstopmode $kanji";
# $bibtex   = 'pbibtex $kanji';
# $dvipdf   = 'perl -e "exec(\'dvipdfmx\', \$ARGV[0])"';
# $pdf_mode = 3;
# $pdf_previewer = 'open -a skim';
# $clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';
# # .latexmkrc ends

# $pvc_view_file_via_temporary = 0;

# # Use Skim as a previewer
$pdf_previewer    = 'open -ga /Applications/Skim.app';
#$pdf_update_command = "open -ga Preview %S";

$out_dir = "./out";

$pdf_update_command = "git commit -am'update'";
