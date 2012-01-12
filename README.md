bunit.sh

A simple unit testing framework for bash.  The name is a bit misleading since it doesn't quite follow the xUnit style.

Setup (.profile/.bash_profile):
export BUNIT_HOME=/path/to/bUnit
export PATH=$PATH:${BUNIT_HOME}/bin

When running bUnit.sh it will look recursively for any files ending in Test.sh.  

These files will need to import the assert functions at the top. The test files should have functions that can be imported and run by bUnit.  
See the tests included with bUnit for examples and run them to make sure everything works!

