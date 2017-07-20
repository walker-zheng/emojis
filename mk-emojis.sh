#! /usr/bin/bash

ROWS=8
echo "### gitmoji list" > README.md
curl https://gitmoji.carloscuesta.me/index.html|grep 'class="emoji-info"'|sed 's,class="emoji-info"><code>,\n,g'|grep -v 'header-buttons'|sed 's,</p></div></div></article>.*,,g'|sed 's,</code><p>,=,g;s,/ ,,'|awk -F= '{print " - "$1" `"$1"` "$2}' >> README.md

# 对比 gogs & github
comm <(cd gogs/img/emoji/;ls|sed 's,\..*,,'|sort) <(curl https://api.github.com/emojis|grep -vE '{|}'|sed 's,^ *,,'|awk -F\" '{print $2}'|sort)|sed 's,\t,=,g' > comm.tmp
echo "### gogs emoji list" >> README.md
LINE="";COUNT=0;awk -F= '{print $1}' comm.tmp|grep -v '^$'|sed 's,\(.*\),![:\1:](gogs/img/emoji/\1.png) `:\1:` ,'|while read line;do (( COUNT+=1 )); (( ! (COUNT % ROWS) )) && { echo " - $LINE" ; LINE=""; } || { LINE="$LINE $line"; };done >> README.md
echo "### github emoji list" >> README.md
LINE="";COUNT=0;awk -F= '{print $2}' comm.tmp|grep -v '^$'|sed 's,\(.*\),<img src="https://assets-cdn.github.com/images/icons/emoji/unicode/\1.png?v7" width="24" height="24" alt=":\1:" /> `:\1:`,'|while read line;do (( COUNT+=1 )); (( ! (COUNT % ROWS) )) && { echo " - $LINE" ; LINE=""; } || { LINE="$LINE $line"; };done >> README.md
echo "### github & gogs emoji list" >> README.md
LINE="";COUNT=0;awk -F= '{print $3}' comm.tmp|grep -v '^$'|sed 's,\(.*\),<img src="https://assets-cdn.github.com/images/icons/emoji/unicode/\1.png?v7" width="24" height="24" alt=":\1:" /> `:\1:`,'|while read line;do (( COUNT+=1 )); (( ! (COUNT % ROWS) )) && { echo " - $LINE" ; LINE=""; } || { LINE="$LINE $line"; };done >> README.md
rm comm.tmp
