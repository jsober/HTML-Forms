use strict;
use warnings;
use Test::More;
use Test::HTML::Content;
use HTML::Forms::FormElement::Text;
use HTML::Forms::Validator::Required;

my $class = 'HTML::Forms::Input';
use_ok $class;

sub get_input {
    new_ok($class, [
        label => 'Test Input',
        form_element => HTML::Forms::FormElement->new(
            id   => 'field_id',
            name => 'field_name',
            size => 25,
        ),
    ]);
}

{
    my $input = get_input;
    eval { $input->is_valid };
    ok $@, 'is_valid: throw error without form data';
}

{
    my $input = get_input;
    $input->set_value('foo');
    $input->is_valid;
    ok $@, 'is_valid: no validators';
}

{
    my $input = get_input;
    $input->add_validator(HTML::Forms::Validator::Required->new());
    $input->set_value('foo');
    ok $input->is_valid, 'is_valid: validators, good data';
}

{
    my $input = get_input;
    $input->add_validator(HTML::Forms::Validator::Required->new());
    $input->set_value('');
    ok !$input->is_valid, 'is_valid: validators, bad data';
    is_deeply $input->errors, ['field_name is a required value'];
}

{
    my $input = get_input;
    ok my $html = $input->render_label, 'render_label';
    tag_ok $html, 'label', {for => 'field_id'}, 'render_label: attributes, tag';
    text_ok $html, 'Test Input', 'render_label: text';
}

done_testing;
