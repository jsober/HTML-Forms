package HTML::Forms::Input::CheckboxGroup;

use Moose;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Input::MultiChoice';

has +widget => (
    is      => 'ro',
    isa     => Str,
    default => sub { 'HTML::Forms::Widget::CheckboxGroup' },
);

__PACKAGE__->meta->make_immutable;
no Moose;
1;
