package HTML::Forms::Widget;

use Moose;
use MooseX::AttributeShortcuts;
use Types::Standard qw(-types);
use Try::Tiny;
use Carp;
use HTML::Forms::Util;

has name  => (is => 'ro', isa => Str, required => 1);
has id    => (is => 'ro', isa => Str, required => 1);
has value => (is => 'ro', isa => Defined, required => 0, default => '');

has attr => (
    is      => 'rw',
    isa     => HashRef[Str, Defined],
    default => sub {{}},
    traits  => ['Hash'],
    handles => {
        set_attr => 'set',
        get_attr => 'get',
    }
);

sub get_attributes {
    my $self = shift;
    return {
        %{$self->attr},
        id    => $self->id,
        name  => $self->name,
        value => $self->value,
    };
}

sub render {
    my $self = shift;
    return sprintf '<input %s />', $self->render_attributes;
}

sub render_attributes {
    my $self = shift;
    my $attr = $self->get_attributes;
    return join ' ', map { sprintf '%s="%s"', $_, e($attr->{$_}) } keys %$attr;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
