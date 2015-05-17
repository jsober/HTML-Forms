package Test::HTML::Forms::Widget::Text;
use base 'Test::Class';

use Test::Most;
use Test::HTML::Content;

sub class { 'HTML::Forms::Widget::Text' }
sub name  { 'test_input' }
sub id    { 'test-input' }
sub value { 'test value' }
sub size  { 42 }

sub compile :Tests(startup => 1) {
    my $test = shift;
    use_ok $test->class;
}

sub widget {
    my $test = shift;

    $test->class->new(
        name  => $test->name,
        id    => $test->id,
        value => $test->value,
        size  => $test->size,
    );
}

sub get_attributes :Test(2) {
    my $test     = shift;
    my $widget   = $test->widget;
    my $expected = {type => 'text', size => $test->size, name => $test->name, id => $test->id, value => $test->value};

    ok my $attr = $widget->get_attributes, 'get_attributes: call';
    is_deeply $attr, $expected, 'get_attributes: content';
}

1;
