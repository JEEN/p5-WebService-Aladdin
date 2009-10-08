use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'WebService::Aladdin',
    'AUTHOR'    => 'JEEN <jeen@perl.kr>',
    'VERSION_FROM' => 'lib/WebService/Aladdin.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::Base => 0,
	version    => 0,
	Class::Accessor::Fast => 0,
	LWP::UserAgent => 0,
	URI            => 0,
	Carp           => 0,
	XML::FeedPP    => 0
    },
);
