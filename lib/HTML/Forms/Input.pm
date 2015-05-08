package HTML::Forms::Role::Input;

use Moo;
use MooX::HandlesVia;
use Types::Standard qw(-types);

has label => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has form_element => (
    is       => 'ro',
    isa      => ConsumerOf['HTML::Forms::Role::FormElement'],
    required => 1,
    handles  => {
        id        => 'id',
        name      => 'name',
        set_value => 'value',
        get_value => 'value',
    }
);

has validators => (
    is          => 'rw',
    isa         => ArrayRef[ConsumerOf['HTML::Forms::Role::Validator']],
    default     => sub {[]},
    required    => 0,
    handles_via => 'Array',
    handles     => {
        add_validator => 'push',
    }
);

has errors => (
    is       => 'rw',
    isa      => Map[Str, Str],
    default  => sub {{}},
    init_arg => undef,
);

has value => (
    is        => 'rw',
    required  => 0,
    predicate => 1,
);

sub get_errors {
    my ($self, $value) = @_;

    foreach my $validator ($self->validators) {
        my $error = $validator->get_error($value);

        if (defined $error) {
            push @{$self->{errors}}, $error;
        }
    }

    return @errors;
}

sub serialize {
    my $self = shift;
    $self->form_element->value($self->value) if $self->has_value;
    return $self->form_element->serialize;
}

sub serialize_label {
    my $self = shift;
    return sprintf '<label for="%s">%s</label>', html_escape($self->id), html_escape($self->label);
}

1;
