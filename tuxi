#!/bin/sh

if [ $# -le 0 ]; then
  echo "Hi, I am Tuxi.. Ask me something"
  echo "Usage: tuxi <your question>"
  exit
fi

query="$*"

user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:53.0) Gecko/20100101 Firefox/53.0"

webpage=$(curl -s -G --compressed "https://www.google.com/search?hl=en_US" --user-agent "$user_agent" --data-urlencode "q=$query")

res0=$(echo "$webpage" | pup 'a.gL9Hy > b text{}' | sed ':a;N;$!ba;s/\n/ /g'| recode html..utf8 )
[ -n "$res0" ] && echo "> u mean $res0?"

list=$(echo "$webpage" | pup 'div.dAassd json{}'  | jq -r '.[] | .children | .[] | .text' | sed ':a;N;$!ba;s/\n/ /g' | sed 's/null/\n/g' | awk '{$1=$1;print "* " $0}' | sed '/^* $/d'| recode html..utf8)
[ -n "$list" ] && echo "$list" && exit

res1=$(echo "$webpage" | pup 'div.zCubwf text{}' | tr -d '\n' | recode html..utf8)
[ -n "$res1" ] && echo "$res1" && exit

res2=$(echo "$webpage" | pup 'div.XcVN5d text{}' | recode html..utf8)
[ -n "$res2" ] && echo "$res2" && exit

res3=$(echo "$webpage" | pup 'span.hgKElc text{}' | tr -d '\n' | recode html..utf8 | xargs -d ' ' -n10)
[ -n "$res3" ] && echo "$res3" && exit


tmp=$(echo "$webpage" | pup 'div.kno-rdesc')
[ -z "$tmp" ] && echo "No Result" || (echo "$tmp" | pup 'span' | sed -n '2p' | awk '{$1=$1;print}' | recode html..utf8 | xargs -d ' ' -n10)
