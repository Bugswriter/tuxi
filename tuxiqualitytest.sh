#!/bin/sh

# Color Codes
N="\033[0m"
Y="\033[1;33m"
R="\033[1;31m"

checkdep() { [ ! "$(command -v "$*" 2> /dev/null)" ] && err "\"$*\" not found!\n" && exit 1; }
checkdep "pup"; checkdep "recode"; checkdep "jq";

err () { printf "\n%bTuxTester%b:$ An Error has occured for the command > %s)\n" "$R" "$N" "$*" && sleep 3; }


  commands="$(printf 'tuxi -h
tuxi "Linux Tarvalds"
tuxi "the office cast"
tuxi "elevation of mt everest"
tuxi "the meaning of life and everything else"
tuxi "the motans inainte sa ne fi nascut lyrics"
tuxi "weather new york"
tuxi "100 cm to m"
tuxi "100 GBP to USD"
tuxi "vais para cascais? em ingles"
tuxi "lorem ipsum"')"
  
echo "$commands" | while read command ;
do
  printf "\n\n\n\n%bTuxTester%b:$ %s\n\n" "$Y" "$N" "$command"
  ./$command || err "$command"
done 

