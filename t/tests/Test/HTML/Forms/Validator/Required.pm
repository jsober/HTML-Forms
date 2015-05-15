package Test::HTML::Forms::Validator::Required;
use base 'Test::Class';

use Test::Most;

sub class { 'HTML::Forms::Validator::Required' }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub is_valid :Tests(4) {
    my $test = shift;
    my $validator = $test->class->new();

    ok   !$validator->is_valid(undef), 'undef fails';
    ok   !$validator->is_valid(''),    'empty string fails';
    ok   $validator->is_valid('foo'),  'string passes';
    like $validator->message, qr/%s/,  'error message contains string format code';
}

1;
