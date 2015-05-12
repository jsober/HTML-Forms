package HTML::Forms::Validator::Required;

use Moo;
use Types::Standard qw(-types);
use Carp;

with 'HTML::Forms::Role::Validator';

sub get_error {
    my ($self, $value) = @_;

    return '%s is a required value'
        unless defined $value
            && "$value" ne '';

    return;
}

1;
