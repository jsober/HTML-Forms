package HTML::Forms::FormElement;

use Moo;
use Types::Standard qw(-types);

with 'HTML::Forms::Role::FormElement';

has size => (
    is       => 'ro',
    isa      => Maybe[Int],
    required => 0,
);

sub no_value {
    return '';
}

sub get_attributes {
    my $self = shift;
    return {
        type  => 'text',
        id    => $self->id,
        name  => $self->name,
        value => $self->get_value,
        ($self->size ? (size => $self->size) : ()),
    };
}

1;
