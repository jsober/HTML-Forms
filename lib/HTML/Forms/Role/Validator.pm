package HTML::Forms::Role::Validator;

use Moose::Role;
use Types::Standard qw(-types);
use HTML::Forms::ValidationError;

requires 'is_valid';
requires 'message';

sub test {
    my ($self, $value) = @_;

    die HTML::Forms::ValidationError->new(msg => $self->message)
        unless $self->is_valid($value);

    1;
}

1;
