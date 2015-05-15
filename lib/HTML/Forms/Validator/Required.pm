package HTML::Forms::Validator::Required;

use Moose;
use Types::Standard qw(-types);
use Carp;

with 'HTML::Forms::Role::Validator';

sub message  { '%s is a required value' }
sub is_valid { defined $_[1] && "$_[1]" ne '' }

__PACKAGE__->meta->make_immutable;
no Moose;
1;
