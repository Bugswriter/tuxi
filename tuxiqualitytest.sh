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
done #this took to long for me to figure out 
if $raw; then
    red="" 
    run="-r"
fi

#Clean up the code function
test_code () {
    # echo ${1}  "\"${2}\"" \n \n
    # printf "${1}¬\n" && ./tuxi ${run} \""${2}"\" 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"
    printf "${1}¬\n" && ./tuxi ${run} ${2} 1>>testoutputs.txt && printf "\tpassed.\n" || printf "\tFailed...\n"

}

printf "${red}Test Output - If you don't know what you're doing here, hit h to figure out controls, or q if you aren't developing\n" >> testoutputs.txt
printf "${red}###################################################################################################################\n" >> testoutputs.txt
printf "${red}###################################################################################################################\n" >> testoutputs.txt
printf "${red}###################################################################################################################\n" >> testoutputs.txt

if ! $raw; then
    printf "Testing help message¬\n" && ./tuxi -h 1>>testoutputs.txt && printf "\tpassed.\n"|| printf "\tFailed...\n"
fi

#FORMATTING:
# test_code name_of_function_being_tested test_case

#Help message cant be sent as raw, tuxi -r -h does not work
test_code "Testing error corrrectionn" "Linux Tarvalds"
test_code "Testing error corrrectionn" "waht is the office" 
test_code "Testing error corrrectionn" "hwo much is btc wroth" 



test_code "Testing Math" "log(30)" 
test_code "Testing Math" "72^43/12(44+1)-3124"
test_code "Testing Math" "45/sqrt(4)*3"


test_code "Testing Knowledge Graph - top" "the office cast" 
test_code "Testing Knowledge Graph - top" "hamilton cast" 
test_code "Testing Knowledge Graph - top" "legends of runeterra"
test_code "Testing Knowledge Graph - top" "reddit" 
test_code "Testing Knowledge Graph - top" "twitter" 


test_code "Testing Rich Answer" "elevation of mt everest" 
test_code "Testing Rich Answer" "what is elevation of mt rainier" 
test_code "Testing Rich Answer" "how big is the grand canyon" 
test_code "Testing Rich Answer" "how long is the yellow river?" 



test_code "Testing Featured Snippets" "the meaning of life the universe and everything else" 
test_code "Testing Featured Snippets" "shotgun doom eternal" 
test_code "Testing Featured Snippets" "what is tenacity in league of legends" 
test_code "Testing Featured Snippets" "rusty cage bio" 



test_code "Testing Lyrics" "the motans inainte sa ne fi nascut lyrics" 
test_code "Testing Lyrics" "lyrics of hello adele" 
test_code "Testing Lyrics" "Toosie slide lyrics" 
test_code "Testing Lyrics" "Sigues con el lyrics" 
test_code "Testing Lyrics" "my truck breland lyrics" 
test_code "Testing Lyrics" "maniac conan gray lyrics" 
test_code "Testing Lyrics" "dealer RMR lyrics" 


test_code "Testing Units" "100 cm to m" 
test_code "Testing Units" "100 c to f" 
test_code "Testing Units" "convert 100 c to f" 
test_code "Testing Units" "what is 10 feet to meters" 


test_code "Testing Currency" "100 GBP to USD" 
test_code "Testing Currency" "what is 10000 GBP in USD" 
test_code "Testing Currency" "how much is 1 btc in USD" 


test_code "Testing Translate" "Vais para cascais? em ingles" 
test_code "Testing Translate" "برمجة in english" 
test_code "Testing Translate" "mañana in english?" 
test_code "Testing Translate" "what is mananeo in english" 
#looks like you can only convert to english without error 


test_code "Testing Weather" "weather new york" 
test_code "Testing Weather" "how hot is it in india?" 
test_code "Testing Weather" "how cold is it in alaska?" 
test_code "Testing Weather" "temp of mexico right now?" 
test_code "Testing Weather" "how cold is it in canada right now?" 


test_code "Testing Knowledge Graph - right" "lorem ipsum" 
test_code "Testing Knowledge Graph - right" "the office" 
test_code "Testing Knowledge Graph - right" "what is a firefighter" 
test_code "Testing Knowledge Graph - right" "what is the american bill of rights" 


test_code "Testing How to Pronounce" "how to pronounce supercalifragilisticexpialidocious" 
test_code "Testing How to Pronounce" "pronunciation of worcestershire" 
test_code "Testing How to Pronounce" "pronounce almond" 
#THIS DOES NOT WORK FOR SOME WORDS ON MY END, i.e. gnocchi, charcuterie

#works for ipv4, someone else do ipv6
printf "Testing IP search¬\n" && ( echo "$(./tuxi ${run} "my ip address?")" | grep -Eq "^([0-9]{1,3}\.){3}[0-9]{1,3}$" ) && printf "\tpassed.\n" || printf "\tFailed...\n"

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
