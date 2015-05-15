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

sub render :Tests(12) {
    my $class = shift;
    my $id = $class->id;
    my $name = $class->name;

    my $input = $class->input(default => 3);

    ok my $html = $input->render, 'call render';
    tag_ok $html, 'select', {name => $name, id => $id}, 'correct tag + attributes';
    tag_ok $html, 'option', {id => "$id-0", value => '0'}, 'option 0';
    tag_ok $html, 'option', {id => "$id-1", value => '1'}, 'option 1';
    tag_ok $html, 'option', {id => "$id-2", value => '2'}, 'option 2';
    tag_ok $html, 'option', {id => "$id-3", value => '3'}, 'option 3';
    tag_ok $html, 'option', {id => "$id-4", value => '4'}, 'option 4';
    like $html, qr/<option id="$id-3" value="3" selected>/, 'option 3 selected';

    $input->value(4);
    ok $html = $input->render, 'call render w/ set value';
    tag_ok $html, 'select', {name => $name, id => $id}, 'correct tag + attributes';
    like $html, qr/<option id="$id-4" value="4" selected>/, 'correct value selected';
    like $html, qr/<option id="$id-3" value="3">/, 'correct value selected';
}

1;
