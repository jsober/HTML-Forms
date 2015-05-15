use strict;
use warnings;
use Test::More;
use Test::HTML::Content;

my $class = 'HTML::Forms::Input::Choice';

use_ok($class);

my $choices = [
    [''    => 0],
    ['Foo' => 1],
    ['Bar' => 2],
    ['Baz' => 3],
    ['Bat' => 4],
];

my $label   = 'Test Dropdown';
my $id      = 'test-dropdown';
my $name    = 'test_dropdown';
my $default = 3;

my $input = new_ok $class, [
    label   => $label,
    id      => $id,
    name    => $name,
    default => $default,
    choices => $choices,
];

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

done_testing;
