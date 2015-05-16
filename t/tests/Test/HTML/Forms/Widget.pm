package Test::HTML::Forms::Widget;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Input' }
sub name  { 'test_input' }
sub id    { 'test-input' }
sub value { 'test value' }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

1;
