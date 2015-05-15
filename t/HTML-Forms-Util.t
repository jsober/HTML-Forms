use strict;
use warnings;
use Test::More;

use HTML::Forms::Util;

is HTML::Forms::Util::e('< > & "'), '&lt; &gt; &amp; &quot;', 'e: smoke test';

done_testing;
