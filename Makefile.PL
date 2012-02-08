use inc::Module::Install;
name 'WebService-Aladdin';
all_from 'lib/WebService/Aladdin.pm';
requires 'Test::Base' => 0;
requires 'version'    => 0;
requires 'Class::Accessor::Fast' => 0;
requires 'LWP::UserAgent' => 0;
requires 'URI' => 0;
requires 'Carp' => 0;
requires 'XML::FeedPP' => 0;

tests 't/*.t';
test_requires 'Test::More';
resources repository => 'git://github.com/JEEN/p5-WebService-Aladdin.git';
auto_include;
WriteAll;

