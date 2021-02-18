errmsg="\tFailed..."

echo "Testing Translation¬" && tuxi "Vais para cascais? em ingles" || echo $errmsg
echo "\nTesting Math¬" && tuxi "log(30)" && tuxi "(40/3)+4*6" || echo $errmsg
echo "\nTesting basic_top¬" && tuxi "christmas day" || echo $errmsg
echo "\nTesting Lyrics¬" && tuxi "the motans inainte sa ne fi nascut lyrics" || echo $errmsg
echo "\nTesting Featured¬" && tuxi "the meaning of life the universe and everything else" || echo $errmsg
echo "\nTesting Rich Answer¬" && tuxi "elevation of mt everest" || echo $errmsg
echo "\nTesting kno_rigth¬" && tuxi "lorem ipsum" || echo $errmsg
echo "\nTesting kno_top¬" && tuxi "the office cast" || echo $errmsg
echo "\nTesting weather¬" && tuxi "weather new york" || echo $errmsg
echo "\nTesting Error corrrection¬" && tuxi "Linux Tarvalds" || echo $errmsg
echo "\nTesting help message¬" && tuxi -h || echo $errmsg

