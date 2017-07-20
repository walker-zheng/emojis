#! /usr/bin/bash

ROWS=6
# 获取 gitmoji
echo "### gitmoji list" > README.md
(curl https://gitmoji.carloscuesta.me/index.html 2> /dev/null|grep 'class="emoji-info"'|sed 's,class="emoji-info"><code>,\n,g'|grep -v 'header-buttons'|sed 's,</p></div></div></article>.*,,g'|sed 's,</code><p>,=,g;s,/ ,,'|awk -F= '{print " - "$1" `"$1"` "$2}') >> README.md
# 下载 gitmoji
#   (mkdir -p gitmoji;awk -F: '{print $2}' README.md|grep -v '^$'|xargs -i grep '\<{}\>' github_api.txt|xargs.exe -n 2 -P 0 sh -c 'wget -c "$1" -O gitmoji/"$0".png') >& /dev/null
# 获取 github emoji api
(curl https://api.github.com/emojis 2> /dev/null|grep -vE '{|}'|sed 's,^ *,,'|awk -F\" '{print $2" "$4}') > github_api.txt
# 下载 github emoji
#   (mkdir -p github/unicode;(awk '{print $2}' github_api.txt|sed 's,.*icons/emoji/,,;s,?.*,,'|sort)|xargs -i -P 0 wget -c https://assets-cdn.github.com/images/icons/emoji/{}?v7 -O github/{}) >& /dev/null
# 对比 gogs & github
#   (comm <(cd gogs;ls|sed 's,\..*,,'|sort) <(awk '{print $1}' github_api.txt|sort)|sed 's,\t,=,g') > comm.tmp
echo "### github emoji list" >> README.md
echo >> README.md
echo ' | | | | | | | | ' >> README.md
echo '---|---|---|---|---|---|---|---|---|---|---' >> README.md
(LINE="";COUNT=0;cat github_api.txt|awk '{print ":"$1": `:"$1":` "}' |while read line;do (( COUNT+=1 )); (( ! (COUNT % ROWS) )) && { echo "$LINE | $line" ; LINE=""; } || { (( ! (COUNT % ROWS - (ROWS - 1)))) && LINE="$LINE $line" || LINE="$LINE $line |"; };done) >> README.md
