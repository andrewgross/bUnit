#!/bin/bash

print_output() {

    if [[ "${1}" == "success" ]]
    then
        echo  "[SUCCESS] for ${FUNCNAME[1]} in ${FUNCNAME[2]}" | tee -a ${BUNIT_HOME}/output/results.txt
    else
        echo  "[FAILURE] for ${FUNCNAME[1]} in ${FUNCNAME[2]}" | tee -a ${BUNIT_HOME}/output/results.txt
    fi

}

assert_equal() {
# Assert that two values are equal

    if [[ "${1}" == "${2}" ]]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

assert_not_equal() {
# Assert that two values are not equal

    if [[ "${1}" != "${2}" ]]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

assert_null() {
# Assert that a given value is empty

    if [ -z "${1}" ]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

assert_not_null() {
# Assert that a given value has a value

    if [ -n "${1}" ]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

assert_true() {
# Tests for truthiness.
# Any non-zero numberical value is false
# Unspaced Strings are true

    if [[ "${1}" -eq true ]]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

assert_false() {

    if [[ "${1}" -ne true ]]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

assert_command_success() {

    local command=${1}

    shift
    eval $command $*
    result=$?
    if [[ "${result}" -eq true ]]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

assert_command_failure() {

    local command=${1}

    shift
    eval $command $*
    result=$?
    if [[ "${result}" -ne true ]]
    then
        print_output success
        return 0
    else
        print_output fail
        return 1
    fi

}

