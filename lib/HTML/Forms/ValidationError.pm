package HTML::Forms::ValidationError;

use Moose;
use Types::Standard qw(-types);
use Carp;

has msg => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

sub BUILDARGS {
    my ($class, @args) = @_;

    if (@args == 1) {
        return { msg => $args[0] };
    } else {
        return { @args };
    }
}

sub error_for {
    my ($self, $name) = @_;

    if ($self->msg =~ /%s/) {
        return sprintf $self->msg, $name;
    }

    return '%s is not valid: %s', $name, $self->msg;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
