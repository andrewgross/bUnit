#!/bin/bash
# If the eval is confusing
# http://www.linuxjournal.com/content/return-values-bash-functions

find_test_files() {
# Look  recursively for any files that have tests


    local  __resultvar=$1

    local files=$(find . -name *Test.sh)

    eval $__resultvar="'${files}'"

}

import_tests() {
# Import the test functions from all test files in to the current shell

    find_test_files test_files

    for test_file in ${test_files}
    do
        . ${test_file}
    done

}

get_test_functions() {
# Get a list of all of the imported test functions

    local  __resultvar=$1

    local functions=$(declare -F | grep "declare -f test_" | sed -e s/^declare\ -f// |sed -e 's/^[ ]*//')

    eval $__resultvar="'${functions}'"


}

run_tests() {
# Run all of the imported test functions

    import_tests

    get_test_functions tests

    for test in ${tests}
    do
        ${test}
    done

}

run_tests






