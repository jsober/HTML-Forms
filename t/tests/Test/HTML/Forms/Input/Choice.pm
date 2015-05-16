package Test::HTML::Forms::Input::Choice;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Input::Choice' }

sub choices {
    [
        [''    => 0],
        ['Foo' => 1],
        ['Bar' => 2],
        ['Baz' => 3],
        ['Bat' => 4],
    ]
}

sub input {
    my $class = shift;
    $class->SUPER::input(@_, choices => $class->choices);
}

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub widget_args :Tests {
    my $test  = shift;
    my $input = $test->input;
    my $args  = $input->widget_args;
    ok exists $args->{choices}, 'widget_args: choices key exists';
    is_deeply $args->{choices}, $test->choices, 'widget_args: choices correct';
}

1;
