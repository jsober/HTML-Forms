package HTML::Forms::Role::Validator;

use Moo::Role;
use Types::Standard qw(-types);

requires 'get_error';

1;
