package Test::HTML::Forms::Input;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Input' }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub render_label :Test(2) {
    my $test = shift;
    my $input = $test->input;
    ok my $label = $input->render_label, 'render_label';
    tag_ok $label, 'label', {for => $test->id}, 'render_label: tag';
}

sub get_value_empty :Test(1) {
    my $test = shift;
    my $input = $test->input;
    is $input->get_value, '', 'get_value';
}

sub get_value_default :Test(1) {
    my $test = shift;
    my $input = $test->input(default => 'foo');
    is $input->get_value, 'foo', 'get_value';
}

sub get_value_set :Test(1) {
    my $test = shift;
    my $input = $test->input(default => 'foo');
    $input->value('bar');
    is $input->get_value, 'bar', 'get_value';
}

sub is_valid_no_data :Test(1) {
    my $test = shift;
    my $input = $test->input;
    throws_ok { $input->is_valid } qr/Missing form data/, 'no form data';
}

sub is_valid_good :Test(2) {
    require HTML::Forms::Validator::Required;
    my $test = shift;
    my $input = $test->input(value => 'foo');
    ok $input->add_validator(HTML::Forms::Validator::Required->new()), 'add validator';
    ok $input->is_valid, 'good data passes';
}

sub is_valid_bad :Test(3) {
    require HTML::Forms::Validator::Required;
    my $test = shift;
    my $input = $test->input(value => '');
    ok $input->add_validator(HTML::Forms::Validator::Required->new()), 'add validator';
    ok !$input->is_valid, 'bad data fails';
    is_deeply $input->errors, [sprintf('%s is a required value', $test->label)], 'get errors';
}

sub errors :Tests(4) {
    require HTML::Forms::Validator::Required;
    my $test = shift;
    my $input = $test->input(value => '');
    $input->add_validator(HTML::Forms::Validator::Required->new());
    $input->is_valid;

    ok my $html = $input->render_errors, 'render_errors';
    tag_ok $html, 'ul';
    tag_ok $html, 'li';
    text_ok $html, 'Test Input is a required value';
}

sub widget_args :Test(1) {
    my $test = shift;
    my $input = $test->input(value => '42');

    my $args = {
        id    => $test->id,
        name  => $test->name,
        value => '42',
        attr  => {},
    };

    is_deeply $input->widget_args, $args, 'widget_args structure';
}

1;
