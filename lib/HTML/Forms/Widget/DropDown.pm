package HTML::Forms::Widget::DropDown;

use Moose;
use MooseX::AttributeShortcuts;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Widget';

has choices => (
    is       => 'rw',
    isa      => ArrayRef[Tuple[Str, Defined]],
    required => 1,
);

around get_attributes => sub {
    my $orig = shift;
    my $self = shift;
    my $attr = $self->$orig(@_);
    delete $attr->{value};
    return $attr;
};

sub render_choice {
    my ($self, $id, $label, $value, $selected) = @_;
    my $sel = $selected ? ' selected="selected"' : '';
    return sprintf '<option id="%s" value="%s"%s>%s</option>', e($id), e($value), $sel, e($label);
}

sub render_choice_group {
    my ($self, $choices) = @_;
    my $attr = $self->render_attributes;
    return sprintf "<select %s>\n%s\n</select>", $attr, join("\n", @$choices);
}

sub render {
    my $self = shift;
    my $selected = $self->value;
    my @choices;

    my $idx = 0;
    foreach my $tuple (@{$self->choices}) {
        my ($label, $value) = @$tuple;
        my $id = sprintf '%s-%d', $self->id, $idx;
        my $choice = $self->render_choice($id, $label, $value, ($selected eq $value));
        push @choices, $choice;
        ++$idx;
    }

    return $self->render_choice_group(\@choices);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
