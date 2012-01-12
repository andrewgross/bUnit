#!/bin/bash
# assertTest.sh

source ${BUNIT_HOME}/bin/assert.sh

test_assert_true() {

	assert_true 0
	assert_true a_string
	assert_true
	assert_true ""
	assert_true true

	# This will fail since the string has spaces
	# assert_true "a string"
    # assert_true 1

    # Bash has trouble comparing false -ne true
    # assert_true false

}

test_assert_false() {

	assert_false -1
	assert_false 2

	# These should fail
	# assert_false ""
    # assert_false 0
    # assert_false blag

    # Bash has trouble comparing false -ne true
    # assert_false false

}

test_assert_null() {

	unset my_var
	assert_null $my_var
	assert_null "$my_var"
	assert_null ""

	# These should fail
	# assert_null blag
    # assert_null false
    # assert_null true
}

test_assert_not_null() {

	local my_set_var="blah"
	assert_not_null $my_set_var
	assert_not_null string
	assert_not_null "string"
	assert_not_null `echo blah`
	# These should fail
	# assert_not_null ""
	# assert_not_null

}

test_assert_equal() {

    local var1=1
    local var2=1

    assert_equal 1 1
    assert_equal $var1 $var2
    assert_equal "1" 1
    assert_equal true true

    # These should fail
    # assert_equal "1 1" "1 1"
    # assert_equal 1 2
    # assert_equal 1 ""
    # assert_equal true false

}

test_assert_not_equal() {

    local var1=1
    local var2=2

    assert_not_equal 1 2
    assert_not_equal 1 ""
    assert_not_equal $var1 $var2
    assert_not_equal 1
    assert_not_equal "blah" "bleh"
    assert_not_equal true false

    # These should fail
    # assert_not_equal "1 1" "1 1"
    # assert_not_equal true true

}

test_assert_command_success() {

    assert_command_success echo
    assert_command_success true
    assert_command_success git status


    # These should fail
    # assert_command_success false

}