package HTML::Forms::Input::MultiChoice;

use Moose;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Input';

has choices => (
    is       => 'rw',
    isa      => ArrayRef[Tuple[Str, Defined]],
    required => 1,
);

around get_attributes => sub {
    my $orig   = shift;
    my $self   = shift;
    my $result = $self->$orig(@_);
    delete $result->{value};
    $result->{multiple} = 'multiple';
    return $result;
};

sub empty_value {
    return [];
}

sub render_choice {
    my ($self, $id, $label, $value, $selected) = @_;
    my $sel = $selected ? ' selected' : '';
    return sprintf '<option id="%s" value="%s"%s>%s</option>', e($id), e($value), $sel, e($label);
}

sub render_choice_group {
    my ($self, $attributes, $choices) = @_;
    return sprintf "<select %s>\n%s\n</select>", $attributes, join("\n", @$choices);
}

sub render {
    my $self = shift;

    my $value = $self->get_value;
    my %selected;
    @selected{@$value} = (1) x scalar(@$value);

    my @choices;

    my $idx = 0;
    foreach my $tuple (@{$self->choices}) {
        my ($label, $value) = @$tuple;
        my $id = sprintf '%s-%d', $self->id, $idx;
        my $choice = $self->render_choice($id, $label, $value, ($selected{$value}));
        push @choices, $choice;
        ++$idx;
    }

    return $self->render_choice_group($self->render_attributes, \@choices);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
