package Test::HTML::Forms::Widget;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Widget' }
sub name  { 'test_input' }
sub id    { 'test-input' }
sub value { 'test value' }
sub attr  { {foo => 'bar', baz => 'bat'} }

sub widget {
    my $test = shift;

    $test->class->new(
        name  => $test->name,
        id    => $test->id,
        value => $test->value,
        attr  => $test->attr,
    );
}

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub get_attributes :Tests(2) {
    my $test     = shift;
    my $widget   = $test->widget;
    my $expected = {%{$test->attr}, name => $test->name, id => $test->id, value => $test->value};

    ok my $attr = $widget->get_attributes, 'get_attributes: call';
    is_deeply $attr, $expected, 'get_attributes: content';
}

sub render :Tests(2) {
    my $test   = shift;
    my $widget = $test->widget;
    my $attr   = {%{$test->attr}, name  => $test->name, id    => $test->id, value => $test->value};

    ok my $html = $widget->render, 'render: call';
    tag_ok $html, 'input', $attr, 'render: tag structure';
}

1;
