package HTML::Forms::Role::Input;

use Moo;
use MooX::HandlesVia;
use Types::Standard qw(-types);
use Carp;

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
        value     => 'value',
        get_value => 'get_value',
        has_data  => 'has_value',
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
    is          => 'rw',
    isa         => ArrayRef[Str],
    default     => sub {[]},
    init_arg    => undef,
);

before errors => sub {
    my $self = shift;
    $self->is_valid;
};

has is_valid => (
    is        => 'lazy',
    isa       => Bool,
    init_arg  => undef,
    predicate => 'is_validated',
);

sub _build_is_valid {
    my $self = shift;

    croak sprintf('Missing for data for %s', $self->name)
        unless $self->has_data;

    my $value = $self->get_value;
    my $name  = $self->name;

    foreach my $validator ($self->validators) {
        if (defined (my $error = $validator->get_error($value))) {
            push @{$self->{errors}}, sprintf($error, $name);
        }
    }

    return @{$self->{errors}} ? 0 : 1;
}

sub render {
    my $self = shift;
    return $self->form_element->render;
}

sub render_label {
    my $self = shift;
    return sprintf '<label for="%s">%s</label>', html_escape($self->id), html_escape($self->label);
}

1;
