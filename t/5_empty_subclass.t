
use strict;
use Test;

# use a BEGIN block so we print our plan before module is loaded
BEGIN { use Handy::Dandy }
BEGIN { plan tests => scalar(@Handy::Dandy::EXPORT_OK), todo => [] }
BEGIN { $| = 1 }

# load your module...
use lib './';

# automated empty subclass test

# subclass Handy::Dandy in package _Foo
package _Foo;
use strict;
use warnings;
use Handy::Dandy qw( :all );
$Foo::VERSION = 0.00_0;
@_Foo::ISA = qw( Handy::Dandy );
1;

# switch back to main package
package main;

# see if _Foo can do everything that Handy::Dandy can do
map {

   ok ref(UNIVERSAL::can('_Foo', $_)) eq 'CODE'

} @Handy::Dandy::EXPORT_OK;


exit;
