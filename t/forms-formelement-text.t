use strict;
use warnings;
use Test::More;
use Test::HTML::Content;

my $class = 'HTML::Forms::FormElement::Text';

use_ok($class);

# Set some variables to use for testing
my $name          = 'foo';
my $id            = 'bar';
my $default_value = 'baz';

# Create input
my $input = new_ok($class, [name => $name, id => $id, default_value => $default_value]);
ok my $html = $input->render, 'call render';
tag_ok $html, 'input', {value => $default_value, type => 'text'}, 'correct attributes';

$input = new_ok($class, [name => $name, id => $id, default_value => $default_value, size => 25], 'sized');
ok $html = $input->render, 'sized: call render';
tag_ok $html, 'input', {value => $default_value, type => 'text', size => 25}, 'sized: correct attributes';

done_testing;
