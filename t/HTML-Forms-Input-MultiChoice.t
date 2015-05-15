use strict;
use warnings;
use Test::More;
use Test::HTML::Content;

my $class = 'HTML::Forms::Input::MultiChoice';

use_ok($class);

my $choices = {
    'Foo' => 1,
    'Bar' => 2,
    'Baz' => 3,
    'Bat' => 4,
};

my $label   = 'Test Select';
my $id      = 'test-select';
my $name    = 'test_select';
my $default = [3, 4];

my $input = new_ok $class, [
    label   => $label,
    id      => $id,
    name    => $name,
    default => $default,
    choices => $choices,
];

ok my $html = $input->render, 'call render';
tag_ok $html, 'select', {name => $name, id => $id}, 'correct tag + attributes';
tag_ok $html, 'option', {value => '1'}, 'option 1';
tag_ok $html, 'option', {value => '2'}, 'option 2';
tag_ok $html, 'option', {value => '3'}, 'option 3';
tag_ok $html, 'option', {value => '4'}, 'option 4';
like $html, qr/<option value="4" selected>/, 'option 4 selected';
like $html, qr/<option value="3" selected>/, 'option 3 selected';

$input->value([1, 2]);
ok $html = $input->render, 'call render w/ value';
like $html, qr/<option value="1" selected>/, 'option 1 selected';
like $html, qr/<option value="2" selected>/, 'option 2 selected';

done_testing;