use strict;
use warnings;
use Test::More;
use Test::HTML::Content;

my $class = 'HTML::Forms::Input::Text';

use_ok($class);

# Set some variables to use for testing
my $label   = 'Foo';
my $name    = 'foo';
my $id      = 'bar';
my $default = 'baz';

# Create input
my $input = new_ok($class, [label => $label, name => $name, id => $id, default => $default]);
ok my $html = $input->render, 'call render';
tag_ok $html, 'input', {value => $default, type => 'text'}, 'correct attributes';

$input = new_ok($class, [label => $label, name => $name, id => $id, default => $default, size => 25], 'sized');
ok $html = $input->render, 'sized: call render';
tag_ok $html, 'input', {value => $default, type => 'text', size => 25}, 'sized: correct attributes';

done_testing;
