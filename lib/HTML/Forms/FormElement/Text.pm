package HTML::Forms::FormElement::Text;

use Moo;
use Types::Standard qw(-types);

extends 'HTML::Forms::FormElement';

has size => (
    is       => 'ro',
    isa      => Maybe[Int],
    required => 0,
);

around get_attributes => sub {
    my $orig   = shift;
    my $self   = shift;
    my $result = $self->$orig(@_);

    return {
        %$result,
        type => 'text',
        ($self->size ? (size => $self->size) : ()),
    };
};

1;
