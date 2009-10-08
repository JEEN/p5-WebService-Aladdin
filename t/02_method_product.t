use strict;
use warnings;
use Test::Base tests => 2;

use WebService::Aladdin;

my $aladdin = WebService::Aladdin->new();
ok $aladdin;

my $data = $aladdin->product('9238043167');
ok $data;
