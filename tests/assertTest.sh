# Tests.sh

source ${BUNIT_HOME}/bin/assert.sh

test_assert_true() {

	assert_true 0
	assert_true a_string
	assert_true
	assert_true ""
	# This will fail since the string has spaces
	# assert_true "a string"

}

test_assert_false() {

	assert_false -1
	assert_false 2
	# This will fail
	# assert_false ""

}

test_assert_null() {

	unset my_var
	assert_null $my_var
	assert_null "$my_var"
	assert_null ""

}

test_assert_not_null() {

	my_set_var="blah"
	assert_not_null $my_set_var
	assert_not_null string
	assert_not_null "string"
	assert_not_null `echo blah`

}

