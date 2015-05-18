package HTML::Forms::Input::Choice;

use Moose;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Input';

has +widget_class => (
    is      => 'ro',
    isa     => Str,
    default => sub { 'HTML::Forms::Widget::DropDown' },
);

has choices => (
    is       => 'rw',
    isa      => ArrayRef[Tuple[Str, Defined]],
    required => 1,
);

around widget_args => sub {
    my $orig = shift;
    my $self = shift;
    my $args = $self->$orig(@_);
    $args->{choices} = $self->choices;
    return $args;
};

__PACKAGE__->meta->make_immutable;
no Moose;
1;
