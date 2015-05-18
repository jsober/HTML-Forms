package HTML::Forms::Input;

use Moose;
use MooseX::AttributeShortcuts;
use Types::Standard qw(-types);
use Try::Tiny;
use Carp;
use Class::Load qw(try_load_class);
use HTML::Forms::Util;

has widget_class => (is => 'ro', isa => Str, default => sub {'HTML::Forms::Widget::Text'});

has name => (is => 'ro', isa => Str, required  => 1);

has id => (is => 'ro', isa => Str, required  => 1);

has attributes => (is => 'rw', isa => HashRef, default => sub {{}}, required  => 0);

has default => (is => 'ro', required  => 0, predicate => 1);

has value => (is => 'rw', required  => 0, predicate => 1);

has label => (is => 'ro', isa => Str, required => 1);

has empty_value => (is => 'ro', isa => Str, default => sub { '' });

has validators => (
    is       => 'rw',
    isa      => ArrayRef[ConsumerOf['HTML::Forms::Role::Validator']],
    default  => sub {[]},
    required => 0,
    traits   => ['Array'],
    handles  => {
        add_validator  => 'push',
        has_validators => 'count',
    }
);

has errors => (
    is       => 'rw',
    isa      => ArrayRef[Str],
    default  => sub {[]},
    init_arg => undef,
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
        try {
            $validator->test($value);
        }
        catch {
            if (ref $_ && $_->isa('HTML::Forms::ValidationError')) {
                push @{$self->{errors}}, $_->error_for($label);
            }
            else {
                croak $_;
            }
        };
    }

    return @{$self->{errors}} ? 0 : 1;
}

has widget => (
    is      => 'lazy',
    isa     => InstanceOf['HTML::Forms::Widget'],
    handles => ['render'],
);

sub _build_widget {
    my $self  = shift;
    my $class = $self->widget_class;

    my ($loaded, $error) = try_load_class($class);

    croak "Unable to load widget $class: $error"
        if $error;

    my $args = $self->widget_args;
    return $class->new(%$args);
}

sub get_value {
    my $self = shift;
    return $self->value if $self->has_value;
    return $self->default if $self->has_default;
    return $self->empty_value;
}

sub widget_args {
    my $self = shift;
    return {
        attr  => $self->attributes,
        id    => $self->id,
        name  => $self->name,
        value => $self->get_value,
    }
}

sub render_label {
    my $self = shift;
    return sprintf '<label for="%s">%s</label>', e($self->id), e($self->label);
}

sub render_errors {
    my $self  = shift;
    my $items = join "\n", map { sprintf('<li>%s</li>', e($_)) } @{$self->errors};
    return sprintf "<ul>\n%s\n</ul>", $items;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
