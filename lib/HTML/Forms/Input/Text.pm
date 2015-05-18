package HTML::Forms::Input::Text;

use Moose;
use Types::Standard qw(-types);

extends 'HTML::Forms::Input';

has +widget_class => (
    is      => 'ro',
    isa     => Str,
    default => sub { 'HTML::Forms::Widget::Text' },
);

has size => (
    is        => 'ro',
    isa       => Maybe[Int],
    required  => 0,
    predicate => 'has_size',
);

around widget_args => sub {
    my $orig = shift;
    my $self = shift;
    my $args = $self->$orig(@_);
    $args->{size} = $self->size if $self->has_size;
    return $args;
};

__PACKAGE__->meta->make_immutable;
no Moose;
1;
