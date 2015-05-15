use strict;
use warnings;
use Test::More;
use Try::Tiny;

my $class = 'HTML::Forms::Validator::Required';

use_ok($class);
my $test = new_ok($class);

ok   !$test->is_valid(undef), 'undef fails';
ok   !$test->is_valid(''),    'empty string fails';
ok   $test->is_valid('foo'),  'string passes';
like $test->message, qr/%s/,  'error message contains string format code';

done_testing;
