use strict;
use warnings;
use Test::More;
use Test::HTML::Content;

my $class = 'HTML::Forms::FormElement';

use_ok($class);

# Set some variables to use for testing
my $name          = 'foo';
my $id            = 'bar';
my $default_value = 'baz';
my $value         = 'bat';

# Create inputs
my $input_default = new_ok($class, [name => $name, id => $id, default_value => $default_value]);
my $input_empty   = new_ok($class, [name => $name, id => $id]);
my $input_value   = new_ok($class, [name => $name, id => $id, default_value => $default_value]);
$input_value->value($value);

note 'get_value';
is $input_empty->get_value,   '',             'get_value: no default value';
is $input_default->get_value, $default_value, 'get_value: default value';
is $input_value->get_value,   $value,         'get_value: set value';

note 'render';
ok my $html_empty   = $input_empty->render,   'render: call with empty value';
ok my $html_default = $input_default->render, 'render: call with default value';
ok my $html_value   = $input_value->render,   'render: call with set value';

tag_ok $html_empty,   'input', {value => ''},             'render: correct value with empty value';
tag_ok $html_default, 'input', {value => $default_value}, 'render: correct value with default value';
tag_ok $html_value,   'input', {value => $value},         'render: correct value with ealue';

done_testing;
