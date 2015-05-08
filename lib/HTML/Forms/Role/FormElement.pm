package HTML::Forms::FormElement;

use Moo::Role;
use Types::Standard qw(-types);
use HTML::Escape qw(escape_html);

requires 'no_value';
requires 'get_attibutes';

has name => (
    is        => 'ro',
    isa       => Str,
    required  => 1,
);

has id => (
    is        => 'ro',
    isa       => Str,
    required  => 1,
);

has default_value => (
    is        => 'ro',
    required  => 0,
    predicate => 1,
);

has value => (
    is        => 'rw',
    required  => 0,
    predicate => 1,
);

has attributes => (
    is        => 'rw',
    isa       => HashRef,
    default   => sub {{}},
    required  => 0,
);

sub get_value {
    my $self = shift;
    return $self->value if $self->has_value;
    return $self->default_value if $self->has_default_value;
    return $self->no_value;
}

sub serialize {
    my $self = shift;
    return sprintf '<input %s />', $self->_serialize_attributes;
}

sub _serialize_attributes {
    my $self = shift;
    my %attr = (%{$self->get_attributes}, $self->attributes);
    return join ' ', map { sprintf '%s="%s"', $_, escape_html($attr{$_}) } keys %$attr;
}

1;
