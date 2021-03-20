#!/usr/bin/env sh

# tuxi is a cli assistant created by Bugswriter
# to get answers for your questions instantly.
# tuxi is currently developed by many collaborators
# you can get more information on our repo :)

# https://github.com/Bugswriter/tuxi © GPL-3.0 License

###############################
#####      Constants      #####
###############################

# setting this overrides getting the system language variable
#   the -l commandline flag overrides everything
#   this can also be set in your shell environment with
#   TUXI_LANG=
[ -n "$TUXI_LANG" ] && LANGUAGE="$TUXI_LANG" || LANGUAGE=""

# if you find more than one answer is being printed (and you're not using -a)
#   increase this number by a little (you want it to be as low as possible)
#   this can also be set in your shell environment with
#   TUXI_DELAY=
[ -n "$TUXI_DELAY" ] && MICRO_DELAY="$TUXI_DELAY" || MICRO_DELAY=250

VERSION="dev 2.0"
MAIN_PID="$$"
[ ! "$XDG_CACHE_HOME" ] && XDG_CACHE_HOME="$HOME/.cache"

#########################################
#####      macOS compatibility      #####
#########################################

# credit to @Zhann in #149
#   to use it, you will need to have GNU core utils installed
case "$OSTYPE" in
darwin*)
    sed() {
        gsed "$@"
    }
    paste() {
        gpaste "$@"
    }
    ;;
esac

######################################
#####      Snippet priority      #####
######################################

# priority importance
#   this variable determines the order the tests are started, they are processed in parallel
#   even though these are started in order, by default, the first answer to resolve is the one printed
#   the order here might only make a very small difference

# priority order
#   the first word should be the name of the a_function() followed by a space
#   you can disable tests by commenting out the line(s)
priority="
tracklist       # Album track lists ( eg: noisia outer edges tracklist )
richcast        # Rich Rich Answers ( eg: social network cast )
define          # Define ( eg: define Aggrandize )
lists           # Simple lists ( eg Need for Speed Heat cars list )
kno_val         # Chem facts ( eg: density of silver, density of hydrogen, what is the triple point of oxygen )
pronounce       # Learn to pronounce ( eg: pronounce linux )
lyrics_int      # Lyrics ( eg: gecgecgec lyrics )
weather         # Weather ( eg: weather new york )
math            # Math ( eg: log_2(3) * pi^e )
unit            # Units Conversion ( eg: 1m into 1 cm )
currency        # Currency Conversion ( eg: 1 USD in rupee )
kno_top         # Knowledge Graph - top ( list ) ( eg: the office cast )
basic           # Basic Answers ( eg: christmas day )
feat            # Featured Snippets ( eg: who is garfield )
quotes          # Quotes ( eg: mahatma gandhi quotes )
trans           # Translate ( eg: Vais para cascais? em ingles )
sport_fixture   # Shows last or next fixture of a sports team ( eg. Chelsea next game )
lyrics_us       # Lyrics for US users, above does not work for US
kno_right       # Knowledge Graph - right ( eg: the office )
"

##############################
#####      Defaults      #####
##############################

# system language fallback
LANG=$(echo $LANG | sed 's/\..*//')

# options
raw=false
quiet=false
all=false
best_match=false
pick_search=false
debug=false
save_html=false
use_cache=false
pick_lang=false
no_pipe=false
plus_urls=false

# color codes
N="\033[0m"    # Reset
B="\033[1m"    # Bold
R="\033[1;31m" # Red
G="\033[1;32m" # Green
Y="\033[1;33m" # Yellow
M="\033[1;35m" # Magenta
C="\033[1;36m" # Cyan

##################################
#####      Help message      #####
##################################

help_text() {
    printf "%bUsage:%b tuxi %b[options]%b %bquery%b\n" "$G" "$N" "$Y" "$N" "$M" "$N"
    printf "%bOR:%b %bquery source%b | tuxi %b[options]%b\n" "$G" "$N" "$M" "$N" "$Y" "$N"
    printf "\n"
    printf "%bOptions:%b\n" "$G" "$N"
    printf "  -h                    Show this help message and exit.\n"
    printf "  -v                    Print tuxi version info and exit.\n"
    printf "\n"
    printf "  -r                    Raw search results.\n"
    printf "                        (no pretty output, no colors)\n"
    printf "\n"
    printf "  -q                    Only output search results.\n"
    printf "                        (silences \"Did you mean?\", greeting, usage)\n"
    printf "\n"
    printf "  -a                    Prints all valid answers.\n"
    printf "\n"
    printf "  -u                    Prints out the top handful of URLs for your search query\n"
    printf "                        (this is automatically printed out if tuxi can't find you an answer)\n"
    printf "\n"
    printf "  -b                    Tries to select the best answer based on keywords at the start and end of your query.\n"
    printf "                        (experimental - eg: define WORD, SONG lyrics, PERSON quotes, weather CITY, FILM cast)\n"
    printf "\n"
    printf "  -t                    Pick answers to test.\n"
    printf "                        (you can specify multiple answers using tuxi_NAME in your query)\n"
    printf "\n"
    printf "  -l                    use LANG_[lang] in your query to override the language used\n"
    printf "                        (eg: tuxi -l LANG_en_US my search query)\n"
    printf "\n"
    printf "%btuxi supports the following environment variables:%b\n" "$G" "$N"
    printf "  TUXI_LANG=[lang]      sets default search language (eg: TUXI_LANG='en_US')\n"
    printf "\n"
    printf "  TUXI_DELAY=[int]      if you find more than one answer is being printed (and you're not using -a)\n"
    printf "                        increase this number by a little (you want it to be as low as possible)\n"
    printf "                        default value is 250 (eg: TUXI_DELAY=270)\n"
    printf "\n"
    printf "%bdeveloper flags:%b\n" "$G" "$N"
    printf "  -d                    prints debug info along with results\n"
    printf "  -s                    saves HTML for this query to $XDG_CACHE_HOME/tuxi/[date]-[query].html\n"
    printf "\n"
    printf "  -c                    use most recent cached result and query\n"
    printf "                        this can be combined with -t flag to more quickly test for different answers\n"
    printf "\n"
    printf "  -p                    disable pipe support (it can break some scripts including our own test script)\n"
    printf "\n"
    printf "%bReport bugs at%b %bhttps://github.com/Bugswriter/tuxi/issues%b\n" "$G" "$N" "$C" "$N"
}

#############################
#####      Getopts      #####
#############################

# -r : raw output
# -v : version info
# -h : help
# -q : silences greeting and did you mean
# -a : print all answers
# -b : best match
# -t : specify answer type
# -l : specify language using LANG_[code] - eg LANG_en_US
# -d : print debug info
# -s : save google HTML response
# -c : use most recent cached results
# -p : disable pipe support (needed for test script)
# -u : also print out the top links
while getopts "rvhqabtldscpu" OPT; do
    case "$OPT" in
    r)
        raw=true
        ;;
    v)
        printf "tuxi %s\n" "$VERSION"
        exit 0
        ;;
    h)
        help_text
        exit 0
        ;;
    q)
        quiet=true
        ;;
    a)
        all=true
        ;;
    b)
        best_match=true
        ;;
    t)
        pick_search=true
        ;;
    d)
        debug=true
        ;;
    s)
        save_html=true
        ;;
    c)
        use_cache=true
        ;;
    l)
        pick_lang=true
        ;;
    p)
        no_pipe=true
        ;;
    u)
        plus_urls=true
        ;;
    *)
        help_text | head -n 1
        exit 1
        ;;
    esac
done

# shifts to query
shift $((OPTIND - 1))
$pick_search && $best_match && echo "sorry but -b and -t mutually exclusive" && exit 1

# TODO this may need reworking later to use read instead and only capture the first line
#   question | tuxi [-flags] --> answer :)
if ! $no_pipe; then
    [ -p /dev/stdin ] && query=$(cat)
fi

#######################################
#####      Output formatting      #####
#######################################

# search result output format (changes if raw=true)
output() {
    printf "%b---%b\n%s\n%b---%b\n" "$G" "$N" "$*" "$G" "$N"
}

# If raw=true: No colors, No pretty output
if $raw; then
    N=""
    B=""
    R=""
    G=""
    Y=""
    M=""
    C=""

    output() {
        printf "%s\n" "$*"
    }
fi

info_msg() {
    printf "%b>%b %s\n" "$G" "$N" "$*"
}

error_msg() {
    printf "%b%s%b\n" "$R" "$*" "$N"
}

######################################
#####      Dependency check      #####
######################################

# Checks if dependencies are installed.
check_deps() {
    while [ -n "$1" ]; do
        if [ ! "$(command -v $1)" ]; then
            error_msg "\"$1\" not found!"
            exit 2
        fi
        shift
    done
}

# Dependencies
#   pup : https://github.com/ericchiang/pup
#   recode : https://github.com/rrthomas/recode
#   jq : https://github.com/stedolan/jq
check_deps "pup" "recode" "jq"

########################################
#####      Query manipulation      #####
########################################

# Conditions to Query
#   If query is empty and -c is passed: use query from cached result
#   If query is empty (no -c): exit
#   If quiet=false: Prints greeting and usage
if [ -z "$1" ] && [ -z "$query" ]; then
    if ! $use_cache; then
        if ! $quiet; then
            printf "Hi, I'm Tuxi. Ask me anything!\n"
            help_text | head -n 1
        fi
        exit 0
    else
        query=$(ls -1t $XDG_CACHE_HOME/tuxi | head -n1 | sed -e 's/tuxi-*[0-9]*-//' -e 's/.html//' -e 's/_/ /g')
    fi
fi

# Else, all arguments are saved in $query
[ -z "$query" ] && query="$*"

# language select: the -l flag
#   language specified on the command line overwrites both
#   the variable set at the top of this script and the system language
if $pick_lang; then
    query="$(printf '%b\n' "$query" | sed 's/ /\\n/g')"
    LANGUAGE="$(printf '%b\n' "$query" | grep 'LANG_' | sed 's/LANG_//g')"
    query="$(printf '%b\n' "$query" | grep -v "LANG_" | sed 's/\\n/ /g')"
fi

# Custom answers: the -t flag
#   clears the list of snippets to check (saving the original list to print out if a mistake is made)
#   then loops through the query looking for tuxi_ and updates the priority variable to use only those snippets
if $pick_search; then
    list_priority="$priority"
    snippet_check=$(printf '%b\n' "$list_priority" | cut -d ' ' -f1 | sed -e '/^\s*#.*$/d' -e '/^\s*$/d')
    matched=false
    priority=""
    query="$(printf '%b\n' "$query" | sed 's/ /\\n/g')"
    for pick_words in $(printf '%b\n' "$query" | grep 'tuxi_' | sed 's/tuxi_//g'); do
        for check_pick_words in $(printf '%b\n' "$snippet_check"); do
            if [ "$check_pick_words" = "$pick_words" ]; then
                [ -z "$priority" ] && priority="$(printf '%s\n' "$pick_words")" \
                    || priority="$(printf '%b\n%s\n' "$priority" "$pick_words")"
                matched=true
            fi
        done
        if ! $matched; then
            printf "Sorry but %s is not a valid search type\nPlease retry your search using one of the following: tuxi_\n" "$pick_words"
            printf "%b\n" "$list_priority"
            printf "\n"
            printf "If %s is on that list could you please file a bug report, thanks! (and sorry)\n" "$pick_words"
            exit 1
        fi
    done
    query="$(printf '%b\n' "$query" | grep -v "tuxi_" | sed 's/\\n/ /g')"
fi

# our patented (honest!) "smrt search" algorithm: the -b flag
# jokes aside, this is going to need some iterating on, I'll turn it into a tidy loop later
if $best_match; then
    j=8
    use_quotes=false
    use_lyrics=false
    use_weather=false
    use_cast=false
    use_weather=false
    use_define=false
    use_list=false
    use_pronounce=false
    use_tracklist=false

    query_check="$(printf '%b\n' "$query" | sed 's/ /\\n/g' | tr '[:upper:]' '[:lower:]')"
    first_word=$(printf '%b\n' "$query_check" | head -n1)
    last_word=$(printf '%b\n' "$query_check" | tail -n1)

    for keywords in printf '%s\n%s\n' "$first_word" "$last_word"; do
        case "$keywords" in
        quote | quotes) use_quotes=true ;;
        lyrics) use_lyrics=true ;;
        weather) use_weather=true ;;
        cast) use_cast=true ;;
        define | definition) use_define=true ;;
        list) use_list=true ;;
        pronounce | pronunciation) use_pronounce=true ;;
        tracklist | songs) use_tracklist=true ;;
        esac
    done

    $use_quotes && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep 'quotes')" || j=$(($j - 1))
    $use_lyrics && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep 'lyrics')" || j=$(($j - 1))
    $use_weather && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep 'weather')" || j=$(($j - 1))
    $use_cast && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep -e 'lists' -e 'kno_')" || j=$(($j - 1))
    $use_define && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep 'define')" || j=$(($j - 1))
    $use_pronounce && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep 'pronounce')" || j=$(($j - 1))
    $use_tracklist && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep 'tracklist')" || j=$(($j - 1))
    $use_list && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | grep -e 'lists' -e 'kno_')" || j=$(($j - 1))
    [ $j -eq 0 ] && priority="$(printf '%b\n' "$priority" | cut -d ' ' -f1 | sed -e '/^\s*#.*$/d' -e '/^[[:space:]]*$/d' | grep -v 'quotes' | grep -v 'lyrics' | grep -v 'weather')"
fi

######################################
#####      Answer functions      #####
######################################

# the following divs have been removed due to seemingly being redundant
# Im leaving them here just in case they're needed again in future
# div.ujudUb (seems to be another lyrics scrape)

# FUNCTION TEMPLATE

# NewAnswerName should be the word used in $priority

# a_NewAnswerName() { # Answer description (and example)
#     echo "$google_html" | pup ... [ SCRAPE METHOD HERE ] ...
# }

# NOTE: the order of these functions doesn't matter, priority is determined by the variable

# Define (eg: define Aggrandize) //original snippet credit @igaurab
a_define() {
    case "$LANGUAGE" in
    en_*) dfn_use_new=true ;;
    *) dfn_use_new=false ;;
    esac
    if $dfn_use_new; then
        define="$(echo "$google_html" | pup 'div.VpH2eb.dZd3De.vmod text{}' | sed '/^[[:space:]]*$/d' | recode html..ISO-8859-1)"
        if [ -n "$define" ]; then
            printf 'pronounced: %b%s%b\n\n' "$C" "$(printf '%s\n' "$define" | grep -m1 -A1 -w '/' | tail -n1)" "$N"
            dfn_top=true
            dfn_end_top=false
            dfn_start=false
            dfn_append=false
            dfn_marker=false
            dfn_sim_op=false
            dfn_skip=false
            printf '%s\n' "$define" | while IFS= read -r dfn_foo; do
                if $dfn_top; then
                    if $dfn_end_top; then
                        case "$dfn_foo" in
                        *"noun: " | *"verb: " | *"adjective: " | *"adverb: " | *"pronoun: " | *"preposition: " | *"conjunction: " | *"determiner: " | *"exclamation: ")
                            printf '%s ' "$dfn_foo"
                            dfn_append=true
                            ;;
                        *"noun:" | *"verb:" | *"adjective:" | *"adverb:" | *"pronoun:" | *"preposition:" | *"conjunction:" | *"determiner:" | *"exclamation:")
                            printf '%s ' "$dfn_foo"
                            dfn_append=true
                            ;;
                        *) printf '%b%s%b\n\t%b%s%b\n' "$Y" "$dfn_backup" "$N" "$B" "$dfn_foo" "$N" ;;
                        esac
                        dfn_top=false
                    else
                        case "$dfn_foo" in
                        noun | verb | adjective | adverb | pronoun | preposition | conjunction | determiner | exclamation)
                            dfn_backup="$dfn_foo"
                            dfn_end_top=true
                            ;;
                        *) continue ;;
                        esac
                    fi
                elif $dfn_append; then
                    printf '%b%s%b\n' "$C" "$dfn_foo" "$N"
                    dfn_append=false
                elif [ $dfn_foo -eq $dfn_foo ] 2>/dev/null; then
                    printf '\n'
                    $dfn_sim_op && dfn_sim_op=false
                elif [ "$dfn_foo" = '/' ]; then
                    $dfn_skip && dfn_skip=false || dfn_skip=true
                elif $dfn_skip; then
                    continue
                elif [ "$dfn_foo" = '. ' ]; then
                    $dfn_sim_op && dfn_sim_op=false
                elif [ "$dfn_foo" = '.' ]; then
                    printf '\n'
                    $dfn_sim_op && dfn_sim_op=false
                elif $dfn_marker; then
                    [ "$dfn_foo" = 'Similar:' ] && dfn_hl="$G" || dfn_hl="$R"
                    printf '%b%s%b\n' "$dfn_hl" "$dfn_foo" "$N"
                    dfn_marker=false
                    dfn_sim_op=true
                elif $dfn_start; then
                    case "$dfn_foo" in
                    informal) printf '(informal) ' ;;
                    British) printf '(British) ' ;;
                    rare) printf '(rare) ' ;;
                    *)
                        printf '%s ' "$dfn_foo"
                        dfn_append=true
                        dfn_start=false
                        ;;
                    esac
                else
                    case "$dfn_foo" in
                    "; "*)
                        printf '%s ' "$dfn_foo"
                        dfn_append=true
                        ;;
                    *"noun: " | *"verb: " | *"adjective: " | *"adverb: " | *"pronoun: " | *"preposition: " | *"conjunction: " | *"determiner: " | *"exclamation: ")
                        printf '\n%s ' "$dfn_foo"
                        $dfn_sim_op && dfn_sim_op=false
                        dfn_append=true
                        ;;
                    " h ")
                        dfn_marker=true
                        ;;
                    noun | verb | adjective | adverb | pronoun | preposition | conjunction | determiner | exclamation)
                        printf '\n'
                        $dfn_sim_op && dfn_sim_op=false
                        dfn_start=true
                        ;;
                    *)
                        $dfn_sim_op && printf '\t%s\n' "$dfn_foo" \
                            || printf '\t%b%s%b\n' "$B" "$dfn_foo" "$N"
                        ;;
                    esac
                fi
            done
        fi
    else
        echo "$google_html" | pup 'div.DgZBFd, div.vdBwhd, div[data-dobid="dfn"] text{}' | sed -e 's/^/* /' -e '1 s/^* //' | recode html..ISO-8859-1
    fi
}

# this div is google's top line answer, works for simple dates, values etc
# eg: density of silver, what is the triple point of oxygen, elevation of mount everest, christmas day
# "what is the " seems to be required for some things //credit @sudocanttype
a_kno_val() {
    echo "$google_html" | pup 'div.Z0LcW.XcVN5d text{}' | tr '\n' ' '
}

# Math ( eg: log_2(3) * pi^e ) //credit @BeyondMagic
a_math() {
    echo "$google_html" | pup 'span.qv3Wpe text{}' | tr -d '\n ' | recode html..ISO-8859-1
}

# Knowledge Graph - top (list) ( eg: the office cast ) //credit @Bugswriter
a_kno_top() {
    echo "$google_html" | pup 'div.dAassd json{}' | jq -r '.[] | .children | .[] | .text' | sed ':a;N;$!ba;s/\n/ /g;s/null/\n/g' | sed '1s/.*/* &/;2,$s/.*/*&/;$d' | recode html..ISO-8859-1
}

# Quotes ( eg: mahatma gandhi quotes ) //credit @PoseidonCoder
a_quotes() {
    echo "$google_html" | pup 'div.Qynugf text{}' | recode html..ISO-8859-1
}

# Basic Answers ( eg: summer solstice || easter ) // @Bugswriter
# this displays similar info to kno_val but uses a different div in the google results
a_basic() {
    echo "$google_html" | pup 'div.zCubwf text{}' | tr -d '\n' | recode html..ISO-8859-1
}

# Rich Rich Answers ( eg: social network cast ) //credit @BeyondMagic
a_richcast() {
    echo "$google_html" | pup 'a.ct5Ked json{}' | jq -r '.[] | .title' | sed 's/^/* /' | recode html..ISO-8859-1
}

# Simple lists (eg: how to exit vim || how to update windows) //original snippet credit @BeyondMagic
a_lists() {
    lists="$(echo "$google_html" | pup 'div.co8aDb.XcVN5d, li.TrT0Xe' | sed 's/^[[:blank:]]*//g' | recode html..ISO-8859-1)"
    if [ -n "$lists" ]; then
        lists_num=0
        printf '%s\n' "$lists" | while IFS= read -r lists_foo; do
            case "$lists_foo" in
            "<div "*) continue ;;
            "</div>") printf '\n' ;;
            "<b>") printf '%b' "$B" ;;
            "</b>") printf '%b' "$N" ;;
            "<li "*)
                lists_num=$(($lists_num + 1))
                printf '%s%b)%b\t' "$lists_num" "$Y" "$N"
                ;;
            "</li>") printf '\n' ;;
            *) printf '%s ' "$lists_foo" ;;
            esac
        done
    fi
}

# Featured Snippets ( eg: who is garfield ) //credit @Bugswriter
a_feat() {
    echo "$google_html" | pup 'span.hgKElc text{}' | tr -d '\n' | recode html..ISO-8859-1 | tr ' ' '\0' | xargs -0 -n10
}

# Lyrics ( eg: gecgecgec lyrics ) //credit @d-shaun
a_lyrics_int() {
    echo "$google_html" | pup 'div.bbVIQb text{}' | recode html..ISO-8859-1
}

# Lyrics for US users, above does not work for US //credit @sudocanttype
a_lyrics_us() {
    echo "$google_html" | pup 'span[jsname="YS01Ge"] text{}' | recode html..ISO-8859-1
}

# Weather ( eg: weather new york) //credit @jhagas + @Genghius + @BeyondMagic
a_weather() {
    weather=$(echo "$google_html" | pup 'div.UQt4rd json{}' | jq -r '.. | .text?, .alt?' | sed '/null/d' | sed '$!N; /^\(.*\)\n\1$/!P; D')
    if [ -n "$weather" ]; then
        if [ $(echo "$weather" | sed -n 2p) -gt $(echo "$weather" | sed -n 3p) ]; then
            weather=$(printf '%b\n' "$weather" | sed -e 2','3'!b' -e ''2'h;'2'!H;'3'!d;x;s/^\([[:print:]'"$(printf '\001\002\003\004\005\006\007\010\011\013\014\015\016\017\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037\177')"']*\)\(.*\n\)\(.*\)/\3\2\1/')
        fi
        printf '%b\n' "$weather" | sed '4,5d;2s/.*/&ºC/;2,${N;s/\n/\t/;};3s/.*/&ºF/;$s/\t/\t\t/' | recode html..ISO-8859-1
    fi
}

# Units Conversion ( eg: 1m into 1 cm ) //credit @karthink
a_unit() {
    echo "$google_html" | pup '#NotFQb json{}' | jq -r '.[] | .children | .[0] | .value' | recode html..ISO-8859-1
}

# Currency Conversion ( eg: 1 USD in rupee ) //credit @karthink
a_currency() {
    echo "$google_html" | pup '.SwHCTb text{}' | sed 's/\n//g;s/\ /\0/g' | recode html..ISO-8859-1
}

# Translate ( eg: Vais para cascais? em ingles ) //credit @Genghius
a_trans() {
    echo "$google_html" | pup 'pre.XcVN5d json{}' | jq -r '[.[] | .children | .[] | select(.class!="BCGytf")][1] | .text' | sed 's/null//g' | recode html..ISO-8859-1
}

# Knowledge Graph - right ( eg: the office ) //credit @Bugswriter
a_kno_right() {
    echo "$google_html" | pup 'div.kno-rdesc span' | sed -n '2p' | awk '{$1=$1;print}' | recode html..ISO-8859-1 | tr ' ' '\0' | xargs -0 -n10
}

# Shows last or next fixture of a sports team ( eg. Chelsea next game ) //original snippet credit @ismayilkarimli
a_sport_fixture() {
    sport_fixture="$(echo "$google_html" | pup 'span[jscontroller="f9W5M"] text{}' | recode html..ISO-8859-1)"
    if [ -n "$sport_fixture" ]; then
        case "$sport_fixture" in
        "Premier League" | "EFL "* | "FA "* | "MLS" | "Canadian Premier League" | "USL "* | "UEFA "* | "Ligue "* | "Coupe de France" | "Trophée des Champions" | *"Bundesliga" | "DFB-Pokal" | "Serie "* | "Coppa Italia" | "Supercoppa Italiana" | "Eredivisie" | "Eerste Divisie" | "Tweede Divisie" | "KNVB "* | "Johan Cruijff"* | "Scottish Premiership" | "Scottish Championship" | "Scottish Cup" | "Scottish League Cup" | "La Liga" | "Segunda División" | "Tercera División" | "Copa del Rey" | "Supercopa de España" | "Copa Federación" | "Allsvenskan" | "Superettan" | "Svenska Cupen" | "Swiss Super League" | "Swiss Challenge League" | "Schweizer Cup" | "Uhrencup")
            sf_use_new=true
            ;;
        *) sf_use_new=false ;;
        esac
        if $sf_use_new; then
            sport_fixture="$(echo "$google_html" | pup 'div.imso_mh__tm-scr text{}' | recode html..ISO-8859-1)"
            sfi=1 # <-- this is used as both a loop counter and name for our new variables

            printf '%b\n' "$sport_fixture" | { # <-- the braces are needed because while/read is executed in a subshell...
                # this means that as soon as the loop has finished it will exit the new process and "forget" everything
                # if we encapsulate the whole loop and processing code in the braces, we get to use the data

                while IFS= read -r sfx; do # read the contents of $sport_fixture line by line...
                    # ...saving the text from each line in the variable $sfx and *do*ing the following:

                    eval sf${sfi}=\"\${sfx}\" # use eval to declare a new variable using two different variables...
                    # we use sf and then the line number for that text string for the name of the variable (eg: $sf1)
                    # and the value of the new variable is going to be the current value of $sfx
                    # when using eval this way the value side of the declaration has to be properly escaped

                    sfi=$(($sfi + 1)) # i++ - increment the loop counter and more importantly the next variable name

                    [ $sfi -eq 10 ] && break # we don't need any of the information after the ninth line...
                    # so we can just use break to exit the loop when the counter hits ten

                done # <-- normally after this point everything processed above would be gone...
                # but because we are still within the braces we get to do some checks on the data we have

                # check if match is in progress
                if [ "$sf3" != ' · ' ]; then
                    # match is underway
                    if [ "$sf2" = "'" ]; then
                        # match is underway, score is a draw
                        if [ $sf5 -eq $sf7 ]; then
                            printf '%s\n%b%s\t%s\n%s\t%s%b\n%s %b%s%s%b\n' \
                                "$sf3" "$B" "$sf5" "$sf4" "$sf7" "$sf8" "$N" "$sf6" "$G" "$sf1" "$sf2" "$N"
                        # match is underway, team one is winning
                        elif [ $sf5 -gt $sf7 ]; then
                            printf '%s\n%b%s\t%s\n%b%b%s\t%s%b\n%s %b%s%s%b\n' \
                                "$sf3" "$C" "$sf5" "$sf4" "$N" "$B" "$sf7" "$sf8" "$N" "$sf6" "$G" "$sf1" "$sf2" "$N"
                        # match is underway, team two is winning
                        else
                            printf '%s\n%b%s\t%s\n%b%s\t%s%b\n%s %b%s%s%b\n' \
                                "$sf3" "$B" "$sf5" "$sf4" "$C" "$sf7" "$sf8" "$N" "$sf6" "$G" "$sf1" "$sf2" "$N"
                        fi
                    # half time
                    else
                        # match is even
                        if [ $sf4 -eq $sf6 ]; then
                            printf '%s\n%b%s\t%s\n%s\t%s\n%b%s %b%s%b\n' \
                                "$sf2" "$B" "$sf4" "$sf3" "$sf6" "$sf7" "$N" "$sf5" "$R" "$sf1" "$N"
                        # team one winning
                        elif [ $sf4 -gt $sf6 ]; then
                            printf '%s\n%b%s\t%s\n%b%b%s\t%s\n%b%s %b%s%b\n' \
                                "$sf2" "$C" "$sf4" "$sf3" "$N" "$B" "$sf6" "$sf7" "$N" "$sf5" "$R" "$sf1" "$N"
                        # team two winning
                        else
                            printf '%s\n%b%s\t%s\n%b%s\t%s\n%b%s %b%s%b\n' \
                                "$sf2" "$B" "$sf4" "$sf3" "$C" "$sf6" "$sf7" "$N" "$sf5" "$R" "$sf1" "$N"
                        fi
                    fi
                # check if the match has happened or is upcomming
                elif [ -n "$sf9" ]; then
                    # match has finished
                    if [ $sf6 -eq $sf8 ]; then
                        # scores are even
                        printf '%s%s%s\n%b%s\t%s\n%s\t%s%b\n%s %s\n' \
                            "$sf4" "$sf3" "$sf2" "$B" "$sf6" "$sf5" "$sf8" "$sf9" "$N" "$sf7" "$sf1"
                    elif [ $sf6 -gt $sf8 ]; then
                        # team one has won
                        printf '%s%s%s\n%b%s\t%s%b%b\n%s\t%s%b\n%s %s\n' \
                            "$sf4" "$sf3" "$sf2" "$C" "$sf6" "$sf5" "$N" "$B" "$sf8" "$sf9" "$N" "$sf7" "$sf1"
                    else
                        # team two has won
                        printf '%s%s%s\n%b%s\t%s\n%b%s\t%s%b\n%s %s\n' \
                            "$sf4" "$sf3" "$sf2" "$B" "$sf6" "$sf5" "$C" "$sf8" "$sf9" "$N" "$sf7" "$sf1"
                    fi
                else
                    # match is upcomming
                    printf '%b%b%b\n%b%b%b %b %b%b%b\n' \
                        "$sf3" "$sf2" "$sf1" "$B" "$sf4" "$N" "$sf5" "$B" "$sf6" "$N"
                fi
            } # <-- and here is where the subshell ends and the rest of the snippet code falls through to exit
        fi
    else
        echo "$google_html" | pup 'span.imso_mh__lr-dt-ds, span[jscontroller="f9W5M"], div.liveresults-sports-immersive__team-name-width span, div.imso_mh__l-tm-sc, div.imso_mh__r-tm-sc text{}' | recode html..ISO-8859-1
    fi
}

# Learn to pronounce ( eg: pronounce linux ) //credit @sdushantha
a_pronounce() {
    echo "$google_html" | pup 'div.fQ02Rb.eDzgme span.seLqNc text{}' | paste -s -d ' ' | sed 's/\s/∙/g'
}
# Album track lists ( eg: noisia outer edges tracklist )
a_tracklist() {
    tracklist="$(echo "$google_html" | pup 'div.mR2gOd json{}')"
    if [ -n "$tracklist" ]; then
        tracklist_songs="$(printf '%s\n' "$tracklist" | jq -r '.[0].children[0].children[].children[0].children[].children[0].children[0].children[1].children[1].children[0].children[0].text' \
            | sed '/^null$/d' | recode html..ISO-8859-1)"
        [ -z "$tracklist_songs" ] && tracklist_songs="$(printf '%s\n' "$tracklist" \
            | jq -r '.[0].children[0].children[].children[0].children[].children[0].children[0].children[1].children[0].children[0].children[0].text' \
            | sed '/^null$/d' | recode html..ISO-8859-1)"
        [ -z "$tracklist_songs" ] && exit
        tracklist_links="$(printf '%s\n' "$tracklist" | jq -r '.[1].children[0].children[0].children[].href' | sed '/^null$/d')"
        printf '%s\n' "$tracklist_links" | grep -q 'youtube.com' || unset tracklist_links
        [ -n "$tracklist_links" ] && tracklist_use_links=true || tracklist_use_links=false
        tracklist_title="$(echo "$google_html" | pup 'div.SPZz6b text{}' | recode html..ISO-8859-1)"
        [ -n "$tracklist_title" ] && printf '%b%s%b (%s)\n' "$C" \
            "$(printf '%s\n' "$tracklist_title" | head -n1)" "$N" \
            "$(printf '%s\n' "$tracklist_title" | tail -n1)"
        tracklist_i=1
        printf '%s\n' "$tracklist_songs" | while IFS= read -r tracklist_foo; do
            printf '%s%b)%b\t%b%s%b\n' "$tracklist_i" "$Y" "$N" "$B" "$tracklist_foo" "$N"
            tracklist_i=$(($tracklist_i + 1))
        done
        if $tracklist_use_links; then
            $raw || printf '%b---%b\n' "$G" "$N"
            printf '%bassociated video links:%b\n' "$R" "$N"
            printf '%s\n' "$tracklist_links"
        fi
    fi
}

###############################
#####      Functions      #####
###############################

# these are used by the processing loop to determine how and when to print info and exit
#   USR1
found_answer_signal() {
    answers_found=$(($answers_found + 1))
}
trap found_answer_signal USR1

#   USR2
output_printed_signal() {
    printed=$(($printed + 1))
}
trap output_printed_signal USR2

# waiting signals to continue
#   without this the main script assumes that fork doesn't have an answer ready
#   because it checks the printed variable too fast and sends the signal to print
#   to another fork and that's how you get multiple answers being printed out
#   so be careful with this
short_delay() {
    [ ! $1 ] && runs=1 || runs=$1
    foo=0
    until [ $foo -eq $runs ]; do
        l=0
        until [ $l -eq $MICRO_DELAY ]; do
            [ true ]
            l=$(($l + 1))
        done
        foo=$(($foo + 1))
    done
}

# calculates execution time and number of answers processed
debug_info() {
    timer_stop=$(date +'%s %N')
    timer_start_secs=$(echo $timer_start | cut -d ' ' -f1)
    timer_stop_secs=$(echo $timer_stop | cut -d ' ' -f1)
    timer_start_nano=$(echo $timer_start | cut -d ' ' -f2)
    timer_start_nano=$(expr $timer_start_nano + 0)
    timer_stop_nano=$(echo $timer_stop | cut -d ' ' -f2)
    timer_stop_nano=$(expr $timer_stop_nano + 0)
    timer_secs_math=$(($timer_stop_secs - $timer_start_secs))
    if [ $timer_secs_math -lt 1 ]; then
        timer_duration=$(($timer_stop_nano - $timer_start_nano))
        timer_duration=$(($timer_duration / 1000))
        if [ $timer_duration -gt 1999 ]; then
            timer_duration=$(($timer_duration / 1000))
            timer_unit='ms'
        else
            timer_unit='μs'
        fi
    elif [ $timer_secs_math -eq 1 ]; then
        timer_duration=$((1000000000 - $timer_start_nano))
        timer_duration=$(($timer_duration + $timer_stop_nano))
        timer_duration=$(($timer_duration / 1000))
        if [ $timer_duration -gt 1999 ]; then
            timer_duration=$(($timer_duration / 1000))
            timer_unit='ms'
        else
            timer_unit='μs'
        fi
    else
        timer_duration="$timer_secs_math"
        timer_unit='s'
    fi
    info_msg "$answers_found answer(s) found - post curl processing time ~$timer_duration $timer_unit"
}

# enabled with the -s flag
dump_html() {
    [ -d "$XDG_CACHE_HOME"/tuxi ] || mkdir -p "$XDG_CACHE_HOME/tuxi"
    file_name="$(date +%s%N)-$(printf %s "$query" | sed 's/ /_/g').html"
    html_location="$XDG_CACHE_HOME/tuxi/$file_name"
    printf "%s" "$google_html" >$html_location
    info_msg "HTML for \"$query\" -> $html_location"
}

# this calls the various snippet functions and checks for valid answers
test_answers() {
    print_answer_signal() {
        if [ -n "$z" ]; then
            kill -USR2 "$MAIN_PID"
            $debug && info_msg "Answer selected: $the_chosen_one"
            output "$z"
            kill "$sleep_pid"
        fi
    }
    trap print_answer_signal USR1
    z="$(a_${1})"
    if [ -n "$z" ]; then
        the_chosen_one="$1"
        if ! $all; then
            kill -USR1 "$MAIN_PID"
            sleep 1 &
            sleep_pid="$!"
            wait
        else
            kill -USR1 "$MAIN_PID"
            $debug && output "$(printf '%b\n\n%b\n' "$(info_msg "Answer selected: $the_chosen_one")" "$z")" || output "$z"
        fi
    fi
}

# this finds and prints out the top links for your query
top_links() {
    url_list="$(echo "$google_html" | pup 'div.tF2Cxc json{}' \
        | jq -r '.[].children[0].children[0].children[1].text, .[].children[0].children[0].children[1].children[0].text, .[].children[0].children[0].href' \
        | sed '/^null$/d' | recode html..ISO-8859-1)"
    if [ -n "$url_list" ]; then
        if [ -n "$1" ]; then
            info_msg "Sorry about that! Perhaps one of these links may be of use?"
            $raw || printf '%b---%b\n' "$G" "$N"
        fi
        links_num=$(($(printf '%s\n' "$url_list" | wc -l) / 2))
        links_i=1
        printf '%s\n' "$url_list" | {
            while IFS= read -r links_foo; do
                eval links_bar_${links_i}=\"\${links_foo}\"
                links_i=$(($links_i + 1))
            done
            links_i=1
            until [ $links_i -gt $links_num ]; do
                links_j=$(($links_i + $links_num))
                printf '%b%s%b\n%s\n' "$C" "$(eval echo \"\$links_bar_${links_i}\")" \
                    "$N" "$(eval echo \"\$links_bar_${links_j}\")"
                links_i=$(($links_i + 1))
            done
        }
        $raw || printf '%b---%b\n' "$G" "$N"
    fi
}

######################################
#####      Getting the HTML      #####
######################################

# fetch response from Google via cURL (-G: get, -s: silent) unless -c flag is passed
# in which case we use the most recent cached html from $XDG_CACHE_HOME/tuxi
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:53.0) Gecko/20100101 Firefox/53.0"
google_url="https://www.google.com/search?hl="${LANGUAGE:="${LANG:=en_US}"}""
$use_cache && google_html="$(cat $XDG_CACHE_HOME/tuxi/$(ls -1t $XDG_CACHE_HOME/tuxi | head -n1))"
if [ -z "$google_html" ]; then
    $use_cache && printf 'no cached pages found!\n' && exit 1
    google_html=$(curl -Gs --compressed "$google_url" --user-agent "$user_agent" --data-urlencode "q=$query")
fi
[ -z "$google_html" ] && error_msg "No valid response from google!" && exit 1

# if -s flag is passed save search results for debugging
$save_html && dump_html

# start timer for debug_info after receiving results from google
$debug && timer_start=$(date +'%s %N')

################################
#####      Processing      #####
################################

# launches all the snippet functions and saves the pids for later
pids=""
answers_found=0
printed=0
if ! $pick_search || ! $best_match; then
    priority=$(printf '%b\n' "$priority" | cut -d ' ' -f1 | sed -e '/^\s*#.*$/d' -e '/^[[:space:]]*$/d')
fi
# loops through $priority forking all the tests in order
for tests in $(printf '%b\n' "$priority"); do
    test_answers "$tests" 2>/dev/null &
    [ -z "$pids" ] && pids="$!" || pids="${pids}\n${!}"
done

# did you mean is processed here to make controling the order things get printed easier
# forking the tests makes things faster (hopefully) but makes passing information around harder
if ! $quiet; then
    # silenced if quiet=true
    did_you_mean="$(echo "$google_html" | pup 'a.gL9Hy text{}')"
    if [ -n "$did_you_mean" ]; then
        err_hl="$(echo "$google_html" | pup 'a.gL9Hy > b text{}')"
        did_you_mean="$(printf '%b\n' "$did_you_mean" | sed ':a;N;$!ba;s/\n//g' | recode html..ISO-8859-1)"
        for errors in $(printf '%b\n' "$err_hl"); do
            replacement="${C}${errors}${N}${B}"
            replacement=$(printf '%s\n' "$replacement" | sed -e 's/[\/&]/\\&/g')
            did_you_mean=$(printf '%b\n' "$did_you_mean" | sed "s/${errors}/${replacement}/g")
        done
        info_msg "$(printf 'did you mean "%b%b%b" ?\n' "$B" "$did_you_mean" "$N")"
    fi
fi

# loops to spin wheels until an answer has been found
# if all the launched processes exit without an answer being found
# script exits with a "No Result!" message
while [ $answers_found -eq 0 ]; do
    for waiting1 in $(printf '%b\n' "$pids"); do
        kill -0 "$waiting1" 1>/dev/null 2>&1
        [ $? -eq 0 ] && break
        for waiting2 in $(printf '%b\n' "$pids"); do
            kill -0 "$waiting2" 1>/dev/null 2>&1
            [ $? -eq 0 ] && break 2
        done
        error_msg "No Result!"
        $quiet || top_links 1
        $debug && debug_info
        exit 1
    done
done

# now we have our first answer, it's time to print it
# this loops through the child pid list in priority order sending the USR1 kill signal
# if one has an answer ready that is what gets printed out
if ! $all; then
    for lucky_winner in $(printf '%b\n' "$pids"); do
        [ $printed -gt 0 ] && break
        kill -0 "$lucky_winner" 1>/dev/null 2>&1
        if [ $? -eq 0 ]; then
            kill -USR1 "$lucky_winner" 1>/dev/null 2>&1
            short_delay
        fi
    done
fi

# once an answer has been printed and the -a flag isn't active
# kills all remaining child processes
# if -a flag is active then it waits until every answer has been printed first
if ! $all; then
    for kids in $(printf '%b\n' "$pids"); do
        kill -0 "$kids" 1>/dev/null 2>&1
        [ $? -eq 0 ] && kill "$kids" 1>/dev/null 2>&1
    done
fi
$all && wait

# another small delay as wait sometimes doesn't seem to wait quite long enough
# for the last answer to be printed before exiting.
short_delay 2
$plus_urls && top_links
$debug && debug_info
exit 0
