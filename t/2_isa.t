
use strict;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 3, todo => [] }
BEGIN { $| = 1 }

# load your module...
use lib './';
use Handy::Dandy;

my($f) = Handy::Dandy->new();

# check to see if Handy::Dandy ISA [foo, etc.]
ok(UNIVERSAL::isa($f,'Handy::Dandy'));

# check to see if Handy::Dandy ISA [foo, etc.]
ok(UNIVERSAL::isa($f,'Exporter'));

# check to see if Handy::Dandy ISA [foo, etc.]
ok(UNIVERSAL::isa($f,'OOorNO'));

exit;
