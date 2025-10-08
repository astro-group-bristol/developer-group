#!/bin/sh

# Uses ImageMagick.
# Pinched from http://varya.me/en/posts/image-diffs-with-git/.
#
# Getting this working with git:
#   git config --global core.attributesfile ~/.gitattributes
#   git config --global diff.image.command imgdiff
#   cat >>~/.gitattributes <<__EOF___
#      *.png diff=image
#      *.gif diff=image
#      __EOF__

# Here is one approach:
# compare $1 $2 png:- \
#   | montage -geometry +4+4 $1 $2 - png:- \ 
#   | display -title "$1"


# Here is another:
# convert '(' $1 -flatten -colorspace gray ')' \
#         '(' $2 -flatten -colorspace gray ')' \
#         '(' -clone 0-1 -compose darken -composite ')' \
#         -channel RGB -combine png:- \
#    | montage -geometry +4+4 -tile 2x2 $2 $1 - png:- \
#    | display -title "$1"


# Arguments are as GIT_EXTERNAL_DIFF, see git(1)
path=$1
pre=$2
post=$5

TMP=/tmp

compare $post $pre $TMP/t1.png

convert '(' $post -flatten -colorspace gray ')' \
        '(' $pre -flatten -colorspace gray ')' \
        '(' -clone 0-1 -compose darken -composite ')' \
        -channel RGB -combine \
        $TMP/t2.png \
|| convert -size 1x1 xc:white $TMP/t2.png

montage -geometry +4+4 -tile 2x2 $pre $post $TMP/t1.png $TMP/t2.png png:- \
      | display -title $path

rm -f $TMP/t1.png $TMP/t2.png


