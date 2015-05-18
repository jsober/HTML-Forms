package HTML::Forms::Input::RadioSet;

use Moose;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Input::Choice';

has +widget_class => (
    is      => 'ro',
    isa     => Str,
    default => sub { 'HTML::Forms::Widget::RadioSet' },
);

__PACKAGE__->meta->make_immutable;
no Moose;
1;
