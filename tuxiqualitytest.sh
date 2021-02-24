#!/bin/sh

rm -f testoutputs.txt

raw=false
red=$(tput setaf 1)
run=""
#defaults if raw != true

while getopts "r" o; do
    case "${o}" in
    r)  
        raw=true
        ;;
    *)
        exit 1
        ;;
    esac
done
#this took to long for me to figure out

if $raw; then
    red="" 
    run="-r"
fi



printf "${red}Test Output - If you don't know what you're doing here, hit h to figure out controls, or q if you aren't developing\n" >> testoutputs.txt
printf "${red}###################################################################################################################\n" >> testoutputs.txt
printf "${red}###################################################################################################################\n" >> testoutputs.txt
printf "${red}###################################################################################################################\n" >> testoutputs.txt

if ! $raw; then
    printf "Testing help message¬\n" && ./tuxi -h 1>>testoutputs.txt && printf "\tpassed.\n"|| printf "\tFailed...\n"
fi
#Help message cant be sent as raw, tuxi -r -h does not work

printf "Testing error corrrection¬\n" && ./tuxi $run "Linux Tarvalds" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing error corrrection¬\n" && ./tuxi $run "waht is the office" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing error corrrection¬\n" && ./tuxi $run "hwo much is btc wroth" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"



printf "Testing Math¬\n" && ./tuxi $run "log(30)" 1>>testoutputs.txt && ./tuxi $run "(40/3)+4*6" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Math¬\n" && ./tuxi $run "72^43/12(44+1)-3124" 1>>testoutputs.txt && ./tuxi $run "45/sqrt(4)*3" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Knowledge Graph - top¬\n" && ./tuxi $run "the office cast" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - top¬\n" && ./tuxi $run "legends of runeterra" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - top¬\n" && ./tuxi $run "reddit" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - top¬\n" && ./tuxi $run "twitter" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Rich Answer¬\n" && ./tuxi $run "elevation of mt everest" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Rich Answer¬\n" && ./tuxi $run "what is elevation of mt rainier" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Rich Answer¬\n" && ./tuxi $run "how big is the grand canyon" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Rich Answer¬\n" && ./tuxi $run "how long is the yellow river?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"



printf "Testing Featured Snippets¬\n" && ./tuxi $run "the meaning of life the universe and everything else" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Featured Snippets¬\n" && ./tuxi $run "shotgun doom eternal" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Featured Snippets¬\n" && ./tuxi $run "what is tenacity in league of legends" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Featured Snippets¬\n" && ./tuxi $run "rusty cage bio" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"



printf "Testing Lyrics¬\n" && ./tuxi $run "the motans inainte sa ne fi nascut lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && ./tuxi $run "lyrics of hello adele" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && ./tuxi $run "Toosie slide lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && ./tuxi $run "Sigues con el lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && ./tuxi $run "my truck breland lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && ./tuxi $run "maniac conan gray lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && ./tuxi $run "dealer RMR lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Units¬\n" && ./tuxi $run "100 cm to m" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Units¬\n" && ./tuxi $run "100 c to f" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Units¬\n" && ./tuxi $run "convert 100 c to f" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Units¬\n" && ./tuxi $run "what is 10 feet to meters" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Currency¬\n" && ./tuxi $run "100 GBP to USD" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Currency¬\n" && ./tuxi $run "what is 10000 GBP in USD" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Currency¬\n" && ./tuxi $run "how much is 1 btc in USD" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Translate¬\n" && ./tuxi $run "Vais para cascais? em ingles" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Translate¬\n" && ./tuxi $run "برمجة in english" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Translate¬\n" && ./tuxi $run "mañana in english?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Translate¬\n" && ./tuxi $run "what is mananeo in english" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
#it looks like you can only convert to english without error 


printf "Testing Weather¬\n" && ./tuxi $run "weather new york" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Weather¬\n" && ./tuxi $run "how hot is it in india?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Weather¬\n" && ./tuxi $run "how cold is it in alaska?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Weather¬\n" && ./tuxi $run "temp of mexico right now?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Weather¬\n" && ./tuxi $run "how cold is it in canada right now?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Knowledge Graph - right¬\n" && ./tuxi $run "lorem ipsum" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - right¬\n" && ./tuxi $run "the office" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - right¬\n" && ./tuxi $run "what is a firefighter" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - right¬\n" && ./tuxi $run "what is the american bill of rights" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"

########################################
#not yet implemented in dev2
########################################
# printf "Testing Define¬\n" && ./tuxi "define humor" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
# printf "Testing Debug¬\n" && ./tuxi -d "linus torvalds age" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
# printf "Testing Rich List" && ./tuxi "elephant height" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"

if ! $raw; then
    less -R testoutputs.txt
fi
#dont show the raw, just output it to the file
