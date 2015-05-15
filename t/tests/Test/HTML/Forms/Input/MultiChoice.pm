package Test::HTML::Forms::Input::MultiChoice;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Input::MultiChoice' }

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

sub render :Tests(13) {
    my $class = shift;
    my $id = $class->id;
    my $name = $class->name;

    my $input = $class->input(default => [3, 4]);

    ok my $html = $input->render, 'call render';
    tag_ok $html, 'select', {name => $name, id => $id}, 'correct tag + attributes';
    tag_ok $html, 'option', {id => "$id-0", value => '1'}, 'option 1';
    tag_ok $html, 'option', {id => "$id-1", value => '2'}, 'option 1';
    tag_ok $html, 'option', {id => "$id-2", value => '3'}, 'option 1';
    tag_ok $html, 'option', {id => "$id-3", value => '4'}, 'option 1';
    like $html, qr/<option id="$id-2" value="3" selected>/, 'option 3 selected';
    like $html, qr/<option id="$id-3" value="4" selected>/, 'option 4 selected';

    $input->value([1, 2]);
    ok $html = $input->render, 'call render w/ value';
    like $html, qr/<option id="$id-0" value="1" selected>/, 'option 1 selected';
    like $html, qr/<option id="$id-1" value="2" selected>/, 'option 2 selected';
    like $html, qr/<option id="$id-2" value="3">/, 'option 3 not selected';
    like $html, qr/<option id="$id-3" value="4">/, 'option 4 not selected';
}

1;
