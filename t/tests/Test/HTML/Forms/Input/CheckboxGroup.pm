package Test::HTML::Forms::Input::CheckboxGroup;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;

sub class { 'HTML::Forms::Input::CheckboxGroup' }

sub choices {
    [
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
