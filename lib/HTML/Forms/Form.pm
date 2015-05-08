package HTML::Forms::Form;

#-------------------------------------------------------------------------------
# TODO:
#   * Inputs available by name
#   * Flag when data set
#-------------------------------------------------------------------------------

use Moo;
use MooX::HandlesVia;
use Types::Standard qw(-types);
use Carp;

has inputs => (
    is          => 'rw',
    isa         => ArrayRef[ConsumerOf['HTML::Forms::Input']],
    default     => sub {[]},
    init_arg    => undef,
    handles_via => 'Array',
    handles     => {
        add_input => 'push',
    }
);

has errors => (
    is       => 'rw',
    isa      => Map[Str, ArrayRef[Str]],
    default  => sub {[]},
    init_arg => undef,
);

sub set_data {
    my ($self, $data) = @_;

    foreach my $name (keys %$data) {

    }
}

sub validate {
    my $self = shift;
}

1;
