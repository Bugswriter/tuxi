#!/bin/sh

rm -f testoutputs.txt

printf "Testing help message¬\n" && tuxi -h 1>>testoutputs.txt && printf "\tpassed.\n"|| printf "\tFailed...\n"


printf "Testing error corrrection¬\n" && tuxi "Linux Tarvalds" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing error corrrection¬\n" && tuxi "waht is the office" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing error corrrection¬\n" && tuxi "hwo much is btc wroth" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"



printf "Testing Math¬\n" && tuxi "log(30)" 1>>testoutputs.txt && tuxi "(40/3)+4*6" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Math¬\n" && tuxi "72^43/12(44+1)-3124" 1>>testoutputs.txt && tuxi "45/sqrt(4)*3" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Knowledge Graph - top¬\n" && tuxi "the office cast" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - top¬\n" && tuxi "legends of runeterra" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - top¬\n" && tuxi "reddit" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - top¬\n" && tuxi "twitter" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Rich Answer¬\n" && tuxi "elevation of mt everest" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Rich Answer¬\n" && tuxi "what is elevation of mt rainier" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Rich Answer¬\n" && tuxi "how big is the grand canyon" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Rich Answer¬\n" && tuxi "how long is the yellow river?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"



printf "Testing Featured Snippets¬\n" && tuxi "the meaning of life the universe and everything else" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Featured Snippets¬\n" && tuxi "shotgun doom eternal" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Featured Snippets¬\n" && tuxi "what is tenacity in league of legends" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Featured Snippets¬\n" && tuxi "rusty cage bio" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"



printf "Testing Lyrics¬\n" && tuxi "the motans inainte sa ne fi nascut lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && tuxi "lyrics of hello adele" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && tuxi "Toosie slide lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && tuxi "Sigues con el lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && tuxi "my truck breland lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && tuxi "maniac conan gray lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && tuxi "dealer RMR lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Units¬\n" && tuxi "100 cm to m" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Units¬\n" && tuxi "100 c to f" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Units¬\n" && tuxi "convert 100 c to f" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Units¬\n" && tuxi "what is 10 feet to meters" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Currency¬\n" && tuxi "100 GBP to USD" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Currency¬\n" && tuxi "what is 10000 GBP in USD" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Currency¬\n" && tuxi "how much is 1 btc in USD" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"


printf "Testing Translate¬\n" && tuxi "Vais para cascais? em ingles" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Translate¬\n" && tuxi "برمجة in english" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Translate¬\n" && tuxi "mañana in english?" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Translate¬\n" && tuxi "what is mananeo in english" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
#it looks like you can only convert to english without error 


printf "Testing Knowledge Graph - right¬\n" && tuxi "lorem ipsum" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
########################################
#not yet implemented in dev2
########################################
# printf "Testing Weather¬\n" && tuxi "weather new york" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
# printf "Testing Define¬\n" && tuxi "define humor" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
# printf "Testing Debug¬\n" && tuxi -d "linus torvalds age" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
# printf "Testing Rich List" && tuxi "elephant height" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
