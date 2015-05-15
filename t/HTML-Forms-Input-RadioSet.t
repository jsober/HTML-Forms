use strict;
use warnings;
use Test::More;
use Test::HTML::Content;

my $class = 'HTML::Forms::Input::RadioSet';

use_ok($class);

my $choices = [
    [''    => 0],
    ['Foo' => 1],
    ['Bar' => 2],
    ['Baz' => 3],
    ['Bat' => 4],
];

my $label   = 'Test';
my $id      = 'test';
my $name    = 'test';
my $default = 3;

my $input = new_ok $class, [
    label   => $label,
    id      => $id,
    name    => $name,
    default => $default,
    choices => $choices,
];

ok my $html = $input->render, 'call render';
tag_ok $html, 'ul', {id => $id}, 'correct tag + attributes';
tag_ok $html, 'input', {type => 'radio', id => "$id-0", value => '0'}, 'option 0';
tag_ok $html, 'input', {type => 'radio', id => "$id-1", value => '1'}, 'option 1';
tag_ok $html, 'input', {type => 'radio', id => "$id-2", value => '2'}, 'option 2';
tag_ok $html, 'input', {type => 'radio', id => "$id-3", value => '3'}, 'option 3';
tag_ok $html, 'input', {type => 'radio', id => "$id-4", value => '4'}, 'option 4';
like $html, qr/<input type="radio" id="$id-3" name="test" value="3" checked>/, 'correct value checked';

$input->value(4);
ok $html = $input->render, 'call render w/ set value';
tag_ok $html, 'ul', {id => $id}, 'correct tag + attributes';
like $html, qr/<input type="radio" id="$id-3" name="test" value="3">/, 'correct value checked';
like $html, qr/<input type="radio" id="$id-4" name="test" value="4" checked>/, 'correct value checked';

done_testing;
