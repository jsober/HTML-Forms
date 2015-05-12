use strict;
use warnings;
use Test::More;

my $class = 'HTML::Forms::Validator::Required';

use_ok($class);

my $test = new_ok($class);

my $error = qr/%s is a required value/i;
like $test->get_error(undef), $error, 'undef generates expected error';
like $test->get_error(''),    $error, 'empty string generates expected error';

ok !defined $test->get_error('bar'), 'passing value returns undef';

done_testing;
