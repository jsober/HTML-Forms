package HTML::Forms::Widget::Text;

use Moose;
use MooseX::AttributeShortcuts;
use Types::Standard qw(-types);

extends 'HTML::Forms::Widget';

has size => (
    is        => 'ro',
    isa       => Maybe[Int],
    required  => 0,
    predicate => 'has_size',
);

around get_attributes => sub {
    my $orig = shift;
    my $self = shift;
    my $attr = $self->$orig(@_);
    $attr->{type} = 'text';
    $attr->{size} = $self->size if $self->has_size;
    return $attr;
};

__PACKAGE__->meta->make_immutable;
no Moose;
1;
