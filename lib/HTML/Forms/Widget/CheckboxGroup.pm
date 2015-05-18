package HTML::Forms::Widget::CheckboxGroup;

use Moose;
use MooseX::AttributeShortcuts;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Widget::MultiSelect';

has choices => (
    is       => 'rw',
    isa      => ArrayRef[Tuple[Str, Defined]],
    required => 1,
);

around get_attributes => sub {
    my $orig   = shift;
    my $self   = shift;
    my $result = $self->$orig(@_);
    delete $result->{name};
    delete $result->{value};
    return $result;
};

sub render_choice {
    my ($self, $id, $label, $value, $selected) = @_;
    my $sel = $selected ? ' checked="checked"' : '';
    return sprintf '<li><input type="checkbox" id="%s" name="%s" value="%s"%s /> %s</li>', e($id), e($self->name), e($value), $sel, e($label);
}

sub render_choice_group {
    my ($self, $choices) = @_;
    my $attr = $self->render_attributes;
    return sprintf "<ul %s>\n%s\n</ul>", $attr, join("\n", @$choices);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
