
use strict;
use Test;

# use a BEGIN block so we print our plan before MyModule is loaded
BEGIN { plan tests => 12, todo => [] }
BEGIN { $| = 1 }

# load your module...
use lib './';
use Handy::Dandy qw( :all );

convert_size;
html_encode;
html_escape;
isfloat;
isin;
isint;
isnum;
use_once;
utf8;

my($f) = Handy::Dandy->new();

# check to see if non-autoloaded Handy::Dandy methods are can-able ;O)
map { ok(ref(UNIVERSAL::can($f,$_)),'CODE') } qw
   (
      convert_size
      html_encode
      html_escape
      isfloat
      isin
      isint
      isnum
      use_once
      utf8

      VERSION
      DESTROY
      AUTOLOAD
   );

exit;
