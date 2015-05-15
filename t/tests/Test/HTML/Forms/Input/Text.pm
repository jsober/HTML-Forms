package Test::HTML::Forms::Input::Text;
use base 'Test::HTML::Forms::BaseInputTest';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Input::Text' }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub type_attr :Tests(2) {
    my $test = shift;
    my $input = $test->input;
    ok my $html = $input->render, 'render';
    tag_ok $html, 'input', {type => 'text'}, 'attributes';
}

sub size_attr :Tests(2) {
    my $test = shift;
    my $input = $test->input(size => 25);
    ok my $html = $input->render, 'render';
    tag_ok $html, 'input', {type => 'text', size => 25}, 'attributes';
}

1;
