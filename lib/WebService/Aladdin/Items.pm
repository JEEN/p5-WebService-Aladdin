package WebService::Aladdin::Items;

use strict;
use warnings;
use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw/items status link startIndex itemsPerPage totalResults/);

1;
