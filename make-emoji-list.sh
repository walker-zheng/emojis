#! /usr/bin/bash

echo "### gitmoji list" > README.md
curl https://gitmoji.carloscuesta.me/index.html|grep 'class="emoji-info"'|sed 's,class="emoji-info"><code>,\n,g'|grep -v 'github.com/carloscuesta/gitmoji'|sed 's,</p></div></div></article><article.*,,g'|sed 's,</code><p>,=,g'|awk -F= '{print " - "$1" `"$1"` "$2}' >> README.md
echo "### gogs emoji list" >> README.md
LINE="";COUNT=0;ls gogs/img/emoji/*|sed 's/gogs\/img\/emoji\/\(.*\)\.\(.*\)/:\1: `:\1:`/'|while read line;do (( COUNT+=1 )); (( ! (COUNT % 8) )) && { echo " - $LINE" ; LINE=""; } || { LINE="$LINE $line"; };done >> README.md
