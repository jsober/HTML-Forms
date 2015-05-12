use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'HTML::Forms',
    AUTHOR              => q{"Jeff Ober" <"jeffober@gmail.com">},
    VERSION_FROM        => 'lib/HTML/Forms.pm',
    ABSTRACT            => '',
        ($ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ('LICENSE'=> 'Perl License')
        : ()),
    PL_FILES            => {},
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'HTML-Forms-*' },

    PREREQ_PM => {
        'Moo'                 => '2.0',
        'MooX::HandlesVia'    => 0,
        'Types::Standard'     => 0,
        'Carp'                => 0,
        'HTML::Escape'        => 0,
    },
    BUILD_REQUIRES => {
        'Test::More'          => 0,
        'Test::HTML::Content' => '0.09',
    },
);
