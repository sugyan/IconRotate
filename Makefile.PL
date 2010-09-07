use inc::Module::Install;
name 'RotateIcon';
all_from 'lib/RotateIcon.pm';

requires 'Ark';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
