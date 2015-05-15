package HTML::Forms::Input::MultiChoice;

use Moo;
use Types::Standard qw(-types);
use HTML::Forms::Util;

extends 'HTML::Forms::Input';

has choices => (
    is  => 'rw',
    isa => Map[Defined, Defined],
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

sub render {
    my $self = shift;

    my $value = $self->get_value;
    my %selected;
    @selected{@$value} = (1) x scalar(@$value);

    my @options;

    foreach my $label (keys %{$self->choices}) {
        my $val = $self->choices->{$label};
        my $sel = $selected{$val} ? ' selected="selected"' : '';
        my $opt = sprintf '<option value="%s"%s>%s</option>', e($val), $sel, e($label);
        push @options, $opt;
    }

    my $options = join "\n", @options;
    return sprintf "<select %s>\n%s\n</select>", $self->render_attributes, $options;
}

1;
