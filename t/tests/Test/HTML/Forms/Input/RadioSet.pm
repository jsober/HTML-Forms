package Test::HTML::Forms::Input::RadioSet;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Input::RadioSet' }

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

1;
