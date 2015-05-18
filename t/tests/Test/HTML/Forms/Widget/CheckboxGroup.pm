package Test::HTML::Forms::Widget::CheckboxGroup;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class   { 'HTML::Forms::Widget::CheckboxGroup' }
sub name    { 'test_input' }
sub id      { 'test-input' }
sub value   { [2, 3] }
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

sub render :Tests(11) {
    my $test   = shift;
    my $widget = $test->widget;
    my $id     = $test->id;

    ok my $html = $widget->render, 'render: call';
    tag_ok $html, 'ul', {id => $test->id}, 'render: ul wrapper tag';

    tag_ok $html, 'li', {}, 'render: li 1';
    tag_ok $html, 'input', {type => 'checkbox', name => $test->name, id => "$id-0"}, 'render: checkbox 1';
    text_ok $html, 'foo';

    tag_ok $html, 'li', {}, 'render: li 2';
    tag_ok $html, 'input', {type => 'checkbox', name => $test->name, id => "$id-1", checked => 'checked'}, 'render: checkbox 2';
    text_ok $html, 'bar';

    tag_ok $html, 'li', {}, 'render: li 3';
    tag_ok $html, 'input', {type => 'checkbox', name => $test->name, id => "$id-2", checked => 'checked'}, 'render: checkbox 3';
    text_ok $html, 'baz';
}

1;
