package Test::HTML::Forms::Input::Text;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;

sub class { 'HTML::Forms::Input::Text' }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub widget_args :Test {
    my $test  = shift;
    my $size  = 42;
    my $input = $test->input(size => $size);
    my $args  = $input->widget_args;
    is $args->{size}, $size, 'widget_args: size="25"';
}

1;
