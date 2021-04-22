#!/usr/bin/env sh
#
# This is a run-test script for tuxi.
# Run this after overall changes or new snippets to test
# if there's conflict with other queries or the code is
# working fine.
#
# https://github.com/Bugswriter/tuxi © GPL-3.0 License

#-----------------------------------------------
# Constants
#-----------------------------------------------

# A default language for all queries, this prevents from 
#   tuxi not giving some results for a few languages since Google's results
#   is different for those languages. (#179)
export TUXI_LANG=en_US

# Files and Dirs
#   Path for all files that this test will give and use
origin_path=$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)
querie_file='testqueries.txt'
output_file='testoutputs.txt'
totals_file='totals.txt'

# Default cycle
    red=$(tput setaf 1)
  cycle=1
max_run=3

# Verify if we have our file to get our queries to test
#   You can add more or less in the file
if ! [ -f $origin_path/$querie_file ]; then
    printf "Y'all got anymore of those testqueries(.txt)?"
    exit 1
fi

#-----------------------------------------------
# Clean cached files to continue through next run
#-----------------------------------------------

rm -f "$origin_path/$output_file" \
      "$origin_path/$totals_file" 2>/dev/null

#-----------------------------------------------
# Default Options
#-----------------------------------------------

unset run
use_tee=false; raw=false

while getopts "rtdb" o; do
    case "${o}" in
    r)
        raw=true
        ;;
    t)
        use_tee=true
        ;;
    d)
        # only do run 1 - the default tuxi output
        max_run=2 
        ;;
    b)
        # only do run 2 - the "smart search" -b flag
        cycle=2
        ;;
    *)
        exit 1
        ;;
    esac
done

# This took to long for me to figure out
$raw && unset red

#-----------------------------------------------
# Start
#-----------------------------------------------

# Echo a warning for developers/users
echo "${red} #--------------------------------------------------------------\n" \
     "${red}# Test Output - If you don't know what you're doing here,\n" \
     "${red}# hit h to figure out controls, or q if you aren't developing.\n" \
     "${red}#--------------------------------------------------------------\n" \
     "${red}\n" >> "$origin_path/$output_file"

# Help message cant be sent as raw, tuxi -r -h does not work
if ! $raw; then
  printf "Testing help message¬\n" \
         && $origin_path/../tuxi -h 1 >> "$origin_path/$output_file" \
         && printf "\tPassed.\n" \
         || printf "\tFailed...\n"
fi

#-----------------------------------------------
# Process
#-----------------------------------------------

until [ $cycle -eq $max_run ]; do

    # Cycle with options
    case $cycle in
      # default search with debug info and pipe disabled
      1) run='-d -p' ;;
      # same as above but also with smart search
      2) run='-d -p -b' ;; 
      *) exit 1 ;;
    esac

    # Decide run's type
    $raw && run="-r ${run}"

    # Start message if everything's fine
    printf "\n--> Starting run: %s | flags in use: %s\n\n" "$cycle" "$run" | \
           tee -a "$origin_path/$output_file"

    good=true

    sed -e '/^\s*#.*$/d' -e '/^[[:space:]]*$/d' $origin_path/$querie_file | while read -r x; do

        unset reason

              target=$(printf '%s' "$x" | cut -d ' ' -f1)
        multi_target=$(printf '%b\n' $(printf '%b\n' "$target" | sed 's/\//\\n/g'))
                   q=$(printf '%b\n' "$multi_target" | wc -l)

        [ $q -gt 1 ] || unset multi_target

        query=$(printf '%s' "$x" | sed 's/^ *[^ ][^ ]*  *//')
        printf "target(s): %b | query: %b\n" "$target" "$query" | \
            tee -a "$origin_path/$output_file"

          result=$($origin_path/../tuxi $run "$query")
        nr_check=$(printf '%b\n' "$result" | grep 'No Result!')

        if [ -n "$nr_check" ]; then

            echo 'FAILED' >> "$origin_path/$totals_file"
            good=false
            reason='No results.'

        # Testing tuxi's correction scrap
        elif [ "$target" = 'did_you_mean' ]; then
            dym_check=$(printf '%b\n' "$result" | head -n1 | grep 'did you mean "')

            [ -n "$dym_check" ] && {
                echo 'PASSED' >> "$origin_path/$totals_file"
                good=true
            } || {
                echo 'FAILED' >> "$origin_path/$totals_file"
                good=false
                reason='No correction.'
            }

        else
            answer=$(printf '%b\n' "$result" | grep 'Answer selected: ')

            [ $(printf '%b\n' "$answer" | wc -l) -gt 1 ] && {
                echo 'FAILED' >>"$origin_path/$totals_file"
                good=false
                reason='Multiple answers printed.'

            } || {
                answer=$(printf '%b\n' "$answer" | awk '{print $NF}')

                [ "$answer" = 'lyrics_int' ] \
                    || [ "$answer" = 'lyrics_us' ] \
                    && answer='lyrics'

                if [ -n "$multi_target" ]; then

                    for z in $(printf '%b\n' "$multi_target"); do

                        [ "$answer" = "$z" ] && {
                            echo "PASSED" >> "$origin_path/$totals_file"
                            good=true
                            break
                        } || {
                            good=false
                        }

                    done

                    if ! $good; then
                        echo 'FAILED' >> "$origin_path/$totals_file"
                        good=false
                        reason="Wrong answer."
                    fi

                elif [ "$answer" = "$target" ]; then
                    echo "PASSED" >> "$origin_path/$totals_file"
                    good=true

                else
                    echo "FAILED" >> "$origin_path/$totals_file"
                    good=false
                    reason="Wrong answer."
                fi
            }
        fi

        # Option to ...
        if $use_tee; then
            printf '%b\n' "$result" | tee -a "$origin_path/$output_file" \
        else
            printf '%b\n' "$result" 1 >> "$origin_path/$output_file"
        fi

        # Option to ...
        if $good; then
            printf '|--> passed \n\n' | tee -a "$origin_path/$output_file"
        else
            printf '|-->> FAILED! | Reason: %b\n\n' "$reason" | \
                        tee -a "$origin_path/$output_file"
        fi

    done

    # Count how many failed and passed
    passed=$(grep -c PASSED "$origin_path/$totals_file")
    failed=$(grep -c FAILED "$origin_path/$totals_file")

    # Print results
    printf '\n-->> END RUN %s | Results: PASSED %s FAILED %s\n' $cycle $passed $failed | \
        tee -a "$origin_path/$output_file"
    cycle=$(($cycle + 1))

    # Remove cached file
    rm -f "$origin_path/$totals_file"
done

# Don' show the raw, just output it to the file
if ! $raw; then
    less -R "$origin_path/$output_file"
fi
