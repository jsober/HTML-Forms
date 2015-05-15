package HTML::Forms::Form;

use Moose;
use MooseX::AttributeShortcuts;
use Types::Standard qw(-types);
use Carp;

has has_form_data => (
    is       => 'rw',
    isa      => Bool,
    default  => sub {0},
    init_arg => undef,
);

has is_validated => (
    is       => 'rw',
    isa      => Bool,
    default  => sub {0},
    init_arg => undef,
);

has input => (
    is        => 'rw',
    isa       => Map[Str, ConsumerOf['HTML::Forms::Input']],
    default   => sub {{}},
);

has is_valid => (
    is        => 'lazy',
    isa       => Bool,
    init_arg  => undef,
    predicate => 'is_validated',
);

sub _build_is_valid {
    my $self = shift;

    croak 'No form data has been added'
        unless $self->has_form_data;

    my $is_valid = 1;

    foreach my $name ($self->input_names) {
        unless ($self->input->{$name}->is_valid) {
            $is_valid = 0;
        }
    }

    return $is_valid;
}

sub add_input {
    my ($self, $input) = @_;
    $self->input->{$input->name} = $input;
}

sub input_names {
    my $self = shift;
    return keys %{$self->input};
}

sub set_data {
    my ($self, $data) = @_;
    my @names = $self->input_names;

    foreach my $name (@names) {
        croak "Missing key for input $name"
            unless exists $data->{$name};
    }

    foreach my $name (@names) {
        my $value = $data->{$name};
        $self->input->set_value($value);
    }

    $self->has_form_data(1);
}

sub errors {
    my ($self, $name) = @_;
    return $self->input->{$name}->errors if $name;
    return { map { $_ => $self->input->{$_}->errors } $self->input_names };
}

1;
