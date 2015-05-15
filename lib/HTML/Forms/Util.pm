package HTML::Forms::Util;

use strict;
use warnings;
use HTML::Escape qw(escape_html);

use parent 'Exporter';
our @EXPORT = qw(
    e
);

sub e { goto \&escape_html }

1;
