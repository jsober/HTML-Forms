package HTML::Forms::Input;

use Moo;
use MooX::HandlesVia;
use Types::Standard qw(-types);
use HTML::Escape qw(escape_html);
use Carp;

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

has attributes => (
    is        => 'rw',
    isa       => HashRef,
    default   => sub {{}},
    required  => 0,
);

has default => (
    is        => 'ro',
    required  => 0,
    predicate => 1,
);

has value => (
    is        => 'rw',
    required  => 0,
    predicate => 1,
);

has label => (
    is       => 'ro',
    isa      => Str,
    required => 1,
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
        unless $self->has_value;

    return 1 unless $self->has_validators;

    my $value = $self->get_value;
    my $label = $self->label;

    foreach my $validator (@{$self->validators}) {
        if (defined (my $error = $validator->get_error($value))) {
            push @{$self->{errors}}, sprintf($error, $label);
        }
    }

    return @{$self->{errors}} ? 0 : 1;
}

sub empty_value {
    return '';
}

sub get_value {
    my $self = shift;
    return $self->value if $self->has_value;
    return $self->default if $self->has_default;
    return $self->empty_value;
}

sub get_attributes {
    my $self = shift;
    my $attr = $self->attributes;
    return { %$attr, id => $self->id, name => $self->name, value => $self->get_value };
}

sub render {
    my $self = shift;
    return sprintf '<input %s />', $self->render_attributes;
}

sub render_attributes {
    my $self = shift;
    my $attr = $self->get_attributes;
    return join ' ', map { sprintf '%s="%s"', $_, escape_html($attr->{$_}) } keys %$attr;
}

sub render_label {
    my $self = shift;
    return sprintf '<label for="%s">%s</label>', escape_html($self->id), escape_html($self->label);
}

sub render_errors {
    my $self  = shift;
    my $items = join "\n", map { sprintf('<li>%s</li>', escape_html($_)) } @{$self->errors};
    return sprintf "<ul>\n%s\n</ul>", $items;
}

1;
