package HTML::Forms::Input;

use Moo;
use MooX::HandlesVia;
use Types::Standard qw(-types);
use HTML::Escape qw(escape_html);
use Carp;

has label => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has form_element => (
    is       => 'ro',
    isa      => InstanceOf['HTML::Forms::FormElement'],
    required => 1,
    handles  => {
        id        => 'id',
        name      => 'name',
        set_value => 'value',
        value     => 'value',
        get_value => 'get_value',
        has_data  => 'has_value',
        render    => 'render',
    }
);

has validators => (
    is          => 'rw',
    isa         => ArrayRef[ConsumerOf['HTML::Forms::Role::Validator']],
    default     => sub {[]},
    required    => 0,
    handles_via => 'Array',
    handles     => {
        add_validator  => 'push',
        has_validators => 'count',
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

    croak sprintf('Missing form data for %s', $self->name)
        unless $self->has_data;

    return 1 unless $self->has_validators;

    my $value = $self->get_value;
    my $name  = $self->name;

    foreach my $validator (@{$self->validators}) {
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
    return sprintf '<label for="%s">%s</label>', escape_html($self->id), escape_html($self->label);
}

1;
