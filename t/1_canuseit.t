
use strict;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 1, todo => [] }

# load your module...
use lib './';
use Handy::Dandy;

# check object constructor
ok(ref(Handy::Dandy->new()),'Handy::Dandy');

exit;