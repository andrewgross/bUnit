bunit.sh

A simple unit testing framework for bash.  The name is a bit misleading since it doesn't quite follow the xUnit style.

Usage:
./bunit.sh tests.txt my_extra_functions

tests.txt should have a listing of tests that can be called, with appropriate arguments and assertions in a format like the example file in this repository.

my_extra_functions should be a location I can source to put any necessary functions into the environment.

The output is printed to STDOUT and a file in the same location as your input file with "results-" prepended

Ex: ./bunit.sh ~/Projects/My_Project/tests/tests.txt ~/Projects/My_Project/functions/my_functions.sh

