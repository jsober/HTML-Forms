package Test::HTML::Forms::Widget::RadioSet;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class   { 'HTML::Forms::Widget::RadioSet' }
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

sub render :Tests(11) {
    my $test   = shift;
    my $widget = $test->widget;
    my $id     = $test->id;

    ok my $html = $widget->render, 'render: call';
    tag_ok $html, 'ul', {id => $test->id}, 'render: ul wrapper tag';

    tag_ok $html, 'li', {}, 'render: li 1';
    tag_ok $html, 'input', {type => 'radio', name => $test->name, id => "$id-0"}, 'render: radio 1';
    text_ok $html, 'foo';

    tag_ok $html, 'li', {}, 'render: li 2';
    tag_ok $html, 'input', {type => 'radio', name => $test->name, id => "$id-1"}, 'render: radio 2';
    text_ok $html, 'bar';

    tag_ok $html, 'li', {}, 'render: li 3';
    tag_ok $html, 'input', {type => 'radio', name => $test->name, id => "$id-2"}, 'render: radio 3';
    text_ok $html, 'baz';
}

1;
