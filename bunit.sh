#!/bin/bash

aliases() {
    # Alter behavior of outbound calls so that we do not affect system state during testing

    alias ssh='echo ssh'
    alias rsync='echo rsync'

}

dealias() {
    # Revert our behavior changes

    unalias ssh
    unalias rsync

}

import() {
    # Import any functions passed in for testing

    local imports=${1}

    . ${imports}

}

assert() {

    export bunit_assertion=${1}

}

record_result() {

    local outcome=${1}
    local result=${2}

    echo "${outcome} ${current_bunit_test} [ASSERTION] ${bunit_assertion} [RESULT] ${result}" | tee -a ${bunit_output_file}

}

check_result() {

    while read result
    do
        if [[ "${result}" == "${bunit_assertion}" ]]
        then
            record_result $(echo "[SUCCESS] ${result}")
        else
            record_result $(echo "[FAIL] ${result}")
        fi
    done

}

test() {

    # Execute our test function with all parameters
    export current_bunit_test="$*"
    $* 2>&1 | check_result

}

setup(){

    import ${1}
    aliases

}

teardown() {

    dealias
    unset assertion

}

parse_output_file() {

    local success_count=$(cat ${bunit_output_file} | grep -c "\[SUCCESS\]")
    local fail_count=$(cat ${bunit_output_file} | grep -c "\[FAIL\]")
    local total_tests=$(cat ${bunit_output_file} | wc -l | sed -e 's/^[ \t]*//')

    echo "Total Tests:      ${total_tests}" | tee -a ${bunit_output_file}
    echo "Successful Tests: ${success_count}" | tee -a ${bunit_output_file}
    echo "Failed Tests:     ${fail_count}" | tee -a ${bunit_output_file}

}

# Main Program

export bunit_input_file=${1}
export bunit_output_file=results-${bunit_input_file}
imports=${2}

# Remove any old test output
[ -e results-${bunit_input_file} ] && rm ${bunit_output_file}

cat ${bunit_input_file} |
(
while read line
do

# Ignore Comments and blank lines
echo "${line}" |egrep -v "^(#|$)" >/dev/null || continue

# Fail on unset variable
set -u
# Fail on error
set -e

# Set up our environment
setup ${imports}

if [[ -n "$(echo ${line} | grep ASSERT)" ]]
then
    # Set assertion, trim line designator and spaces
    assert "$(echo ${line} | tr -d '\[ASSERT\]' | sed -e 's/^[ \t]*//')"
elif [[ -n "$(echo ${line} | grep TEST)" ]]
then
    # Test it!
    test "$(echo ${line} | tr -d '\[TEST\]' | sed -e 's/^[ \t]*//')"
    # Cleanup on exit
    teardown
else
    echo "[ERROR] Badly formatted line: ${line}"
fi

done
)

parse_output_file


