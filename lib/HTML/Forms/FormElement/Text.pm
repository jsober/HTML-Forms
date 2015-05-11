package HTML::Forms::FormElement;

use Moo;
use Types::Standard qw(-types);

extends 'HTML::Forms::FormElement';

has size => (
    is       => 'ro',
    isa      => Maybe[Int],
    required => 0,
);

around get_attributes => sub {
    my ($self, $orig, @args) = @_;
    my $result = $self->$orig->(@args);

    return {
        %$result,
        type => 'text',
        ($self->size ? (size => $self->size) : ()),
    };
};

1;
