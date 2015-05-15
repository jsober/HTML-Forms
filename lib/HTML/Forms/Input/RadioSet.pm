package HTML::Forms::Input::RadioSet;

use Moose;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Input::Choice';

around get_attributes => sub {
    my $orig   = shift;
    my $self   = shift;
    my $result = $self->$orig(@_);
    delete $result->{name};
    return $result;
};

sub render_choice {
    my ($self, $id, $label, $value, $selected) = @_;
    my $sel = $selected ? ' checked' : '';
    return sprintf '<li><input type="radio" id="%s" name="%s" value="%s"%s> %s</li>', e($id), e($self->name), e($value), $sel, e($label);
}

sub render_choice_group {
    my ($self, $attributes, $choices) = @_;
    return sprintf "<ul %s>\n%s\n</ul>", $attributes, join("\n", @$choices);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
