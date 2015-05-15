package Test::HTML::Forms::Form;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Form' }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

1;
