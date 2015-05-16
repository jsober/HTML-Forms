package Test::HTML::Forms::Input::Text;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Input::Text' }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub widget_args :Tests(2) {
    my $test  = shift;
    my $size  = 42;
    my $input = $test->input(size => $size);
    my $args  = $input->widget_args;
    is $args->{size}, $size, 'widget_args: size="25"';
}

1;
