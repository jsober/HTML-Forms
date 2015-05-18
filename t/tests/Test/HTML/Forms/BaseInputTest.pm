package Test::HTML::Forms::BaseInputTest;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class  { die 'must be defined in subclass' }
sub label  { 'Test Input' }
sub name   { 'test_input' }
sub id     { 'test-input' }

sub input {
    my $test = shift;

    $test->class->new(
        label  => $test->label,
        id     => $test->id,
        name   => $test->name,
        @_,
    );
}

1;
