use strict;
use warnings;
use Test::More;
use Test::HTML::Content;

my $class = 'HTML::Forms::Input::Choice';

use_ok($class);

my $choices = {
    ''    => '',
    'Foo' => 1,
    'Bar' => 2,
    'Baz' => 3,
    'Bat' => 4,
};

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
tag_ok $html, 'option', {value => ''}, 'option (blank)';
tag_ok $html, 'option', {value => '1'}, 'option 1';
tag_ok $html, 'option', {value => '2'}, 'option 2';
tag_ok $html, 'option', {value => '3', selected => 'selected'}, 'option 3 (selected)';
tag_ok $html, 'option', {value => '4'}, 'option 4';

$input->value(4);
ok $html = $input->render, 'call render w/ set value';
tag_ok $html, 'select', {name => $name, id => $id}, 'correct tag + attributes';
tag_ok $html, 'option', {value => '4', selected => 'selected'}, 'option 4 (selected)';

done_testing;
