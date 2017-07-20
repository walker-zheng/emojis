#! /usr/bin/bash

echo "### gogs emoji list" >README.md
LINE="";COUNT=0;ls gogs/img/emoji/*|sed 's/gogs\/img\/emoji\/\(.*\)\.\(.*\)/:\1: = :\1: =/'|while read line;do (( COUNT+=1 )); (( ! (COUNT % 8) )) && { echo " - $LINE" ; LINE=""; } || { LINE="$LINE $line"; };done >> README.md
