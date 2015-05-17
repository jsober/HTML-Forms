package Test::HTML::Forms::Widget::DropDown;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class   { 'HTML::Forms::Widget::DropDown' }
sub name    { 'test_input' }
sub id      { 'test-input' }
sub value   { 2 }
sub choices { [[foo => 1], [bar => 2], [baz => 3]] }

sub widget {
    my $test = shift;
    return $test->class->new(
        name    => $test->name,
        id      => $test->id,
        value   => $test->value,
        choices => $test->choices,
    );
}

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub render :Tests(5) {
    my $test   = shift;
    my $widget = $test->widget;
    my $id     = $test->id;

    ok my $html = $widget->render, 'render: call';
    tag_ok $html, 'select', {name => $test->name, id => $test->id}, 'render: select tag';
    tag_ok $html, 'option', {id => "$id-0", value => '1'}, 'render: option 1';
    tag_ok $html, 'option', {id => "$id-1", value => '2', selected => 'selected'}, 'render: option 2';
    tag_ok $html, 'option', {id => "$id-2", value => '3'}, 'render: option 3';
}

1;
