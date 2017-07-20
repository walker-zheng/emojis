#! /usr/bin/bash

echo "### gitmoji list" > README.md
curl https://gitmoji.carloscuesta.me/index.html|grep 'class="emoji-info"'|sed 's,class="emoji-info"><code>,\n,g'|grep -v 'header-buttons'|sed 's,</p></div></div></article>.*,,g'|sed 's,</code><p>,=,g;s,/ ,,'|awk -F= '{print " - "$1" `"$1"` "$2}' >> README.md
echo "### gogs emoji list" >> README.md
ROWS=8
LINE="";COUNT=0;ls gogs/img/emoji/*|sed 's/gogs\/img\/emoji\/\(.*\)\.\(.*\)/:\1: `:\1:`/'|while read line;do (( COUNT+=1 )); (( ! (COUNT % ROWS) )) && { echo " - $LINE" ; LINE=""; } || { LINE="$LINE $line"; };done >> README.md
echo "### github emoji list" >> README.md
LINE="";COUNT=0;curl https://api.github.com/emojis|grep -vE '{|}'|sed 's,^ *,,'|awk -F\" '{print "<img src=\""$4"\" width=\"24\" height=\"24\" alt=\":"$2":\" /> `:"$2":` "}'|while read line;do (( COUNT+=1 )); (( ! (COUNT % ROWS) )) && { echo " - $LINE" ; LINE=""; } || { LINE="$LINE $line"; };done >> README.md
