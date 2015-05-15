use strict;
use warnings;
use Test::More;
use Test::HTML::Content;
use HTML::Forms::Validator::Required;

my $class = 'HTML::Forms::Input';
use_ok $class;

my $label = 'Test Input';
my $name  = 'foo';
my $id    = 'bar';

sub get_input {
    new_ok($class, [label => $label, id => $id, name => $name, @_]);
}

{
    my $value   = 'baz';
    my $default = 'bat';

    my $input_empty   = get_input();
    my $input_default = get_input(default => $default);
    my $input_value   = get_input(value => $value);
    my $input_attr    = get_input(attributes => {foo => 'bar', baz => 'bat'});

    note 'get_value';
    is $input_empty->get_value,   '',       'get_value: no default value';
    is $input_default->get_value, $default, 'get_value: default value';
    is $input_value->get_value,   $value,   'get_value: set value';

    note 'render';
    ok my $html_attr = $input_attr->render, 'render: attributes';
    tag_ok $html_attr, 'input', {id => $id, name => $name}, 'render: id and name present';
    tag_ok $html_attr, 'input', {foo => 'bar', baz => 'bat'}, 'render: attributes present';

    ok my $html_empty   = $input_empty->render,   'render: call with empty value';
    ok my $html_default = $input_default->render, 'render: call with default value';
    ok my $html_value   = $input_value->render,   'render: call with set value';

    tag_ok $html_empty,   'input', {value => ''},       'render: correct value with empty value';
    tag_ok $html_default, 'input', {value => $default}, 'render: correct value with default value';
    tag_ok $html_value,   'input', {value => $value},   'render: correct value with ealue';

    note 'render_label';
    ok my $label= $input_empty->render_label, 'render_label';
    tag_ok $label, 'label', {for => $id}, 'render_label: correct attributes';
    text_ok $label, 'Test Input', 'render_label: text';
}

note 'is_valid';
{
    my $input = get_input;
    eval { $input->is_valid };
    ok $@, 'is_valid: throw error without form data';
}

{
    my $input = get_input(value => 'foo');
    ok $input->is_valid, 'is_valid: no validators';
}

{
    my $input = get_input(value => 'foo');
    $input->add_validator(HTML::Forms::Validator::Required->new());
    ok $input->is_valid, 'is_valid: validators, good data';
}

{
    my $input = get_input(value => '');
    $input->add_validator(HTML::Forms::Validator::Required->new());
    ok !$input->is_valid, 'is_valid: validators, bad data';
    is_deeply $input->errors, ['Test Input is a required value'];
}

note 'render_errors';
{
    my $input = get_input(value => '');
    $input->add_validator(HTML::Forms::Validator::Required->new());
    $input->is_valid;
    my $html = $input->render_errors;

    tag_ok $html, 'ul';
    tag_ok $html, 'li';
    text_ok $html, 'Test Input is a required value';
}

done_testing;
