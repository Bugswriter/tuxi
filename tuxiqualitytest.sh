#!/bin/sh

# Please do not try to make this script any more fancy or extensible, just leave it as is.

printf "Testing help message¬\n" && tuxi -h 1>>testoutputs.txt && printf "\tpassed.\n"|| printf "\tFailed...\n"
printf "Testing error corrrection¬\n" && tuxi "Linux Tarvalds" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Math¬\n" && tuxi "log(30)" 1>>testoutputs.txt && tuxi "(40/3)+4*6" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - top¬\n" && tuxi "the office cast" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Rich Answer¬\n" && tuxi "elevation of mt everest" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Featured Snippets¬\n" && tuxi "the meaning of life the universe and everything else" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Lyrics¬\n" && tuxi "the motans inainte sa ne fi nascut lyrics" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Weather¬\n" && tuxi "weather new york" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Units¬\n" && tuxi "100 cm to m" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Currency¬\n" && tuxi "100 GBP to USD" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Translate¬\n" && tuxi "Vais para cascais? em ingles" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Knowledge Graph - right¬\n" && tuxi "lorem ipsum" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Define¬\n" && tuxi "define humor" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
printf "Testing Debug¬\n" && tuxi -d "linus torvalds age" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
