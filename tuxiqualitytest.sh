printf "\nTesting help message¬\n" && tuxi -h || printf "\tFailed...\n"
printf "\nTesting error corrrection¬\n" && tuxi "Linux Tarvalds" || printf "\tFailed...\n"
printf "\nTesting Math¬\n" && tuxi "log(30)" && tuxi "(40/3)+4*6" || printf "\tFailed...\n"
printf "\nTesting Knowledge Graph - top¬\n" && tuxi "the office cast" || printf "\tFailed...\n"
printf "\nTesting Rich Answer¬\n" && tuxi "elevation of mt everest" || printf "\tFailed...\n"
printf "\nTesting Featured Snippets¬\n" && tuxi "the meaning of life the universe and everything else" || printf "\tFailed...\n"
printf "\nTesting Lyrics¬\n" && tuxi "the motans inainte sa ne fi nascut lyrics" || printf "\tFailed...\n"
printf "\nTesting Weather¬\n" && tuxi "weather new york" || printf "\tFailed...\n"
printf "\nTesting Units¬\n" && tuxi "100 cm to m" || printf "\tFailed...\n"
printf "\nTesting Currency¬\n" && tuxi "100 GBP to USD" || printf "\tFailed...\n"
printf "\nTesting Translate¬\n" && tuxi "Vais para cascais? em ingles" || printf "\tFailed...\n"
printf "\nTesting Knowledge Graph - right¬\n" && tuxi "lorem ipsum" || printf "\tFailed...\n"



