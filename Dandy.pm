package Handy::Dandy;
use strict;
use vars qw( $VERSION   @ISA   @EXPORT_OK   %EXPORT_TAGS   $ATL   $AUTOLOAD );
use Exporter;
use OOorNO qw( :all );
$VERSION     = 1.30_6; # 12/23/02, 1:17 am
@ISA         = qw( Exporter   OOorNO );
@EXPORT_OK   =
   (
      @OOorNO::EXPORT_OK, qw
      (
         convert_size   html_encode   html_escape   isfloat
         isin   isint   isnum   touch   trim   use_once   utf8
      )
   );
%EXPORT_TAGS =
   (
      'all'       => [ @EXPORT_OK ],
      'OOorNO'    => [ @OOorNO::EXPORT_OK ],
   );

# --------------------------------------------------------
# Handy::Dandy::use_once
# --------------------------------------------------------
sub use_once { }


# --------------------------------------------------------
# Handy::Dandy::isnum
# --------------------------------------------------------
sub isnum { isint(@_) || isfloat(@_) }


# --------------------------------------------------------
# Handy::Dandy::isint
# --------------------------------------------------------
sub isint {

   my($check)  = myargs(@_);

   return undef unless defined($check);

   # it's too complicated to figure out whether or not a given
   # string is an integer when it contains the '_' character.
   # I'm not going to write in support for it.  calls that pass
   # the "_" character to this method within a string will get
   # a value of undef passed back
   $check !~ tr/0123456789/0123456789/cd ? $check : undef
}


# --------------------------------------------------------
# Handy::Dandy::isfloat
# --------------------------------------------------------
sub isfloat {

   my($check)  = myargs(@_);

   return undef unless defined($check);

   return undef if $check !~ /\./;
   return undef if substr($check,-1,1) eq '.';
   return undef if $check =~ tr/././d > 1;
   return undef if $check =~ tr/._0123456789/._0123456789/cd >= 1;

   (length($check)) ?  ($1||'') . $check : undef
}


# --------------------------------------------------------
# Handy::Dandy::html_escape()
# --------------------------------------------------------
sub html_escape {

   my(@chars) = split(//,(${\myargs(@_)}||return(undef)));

   my($c) = ''; my($i) = 0;

   # need to escape ascii 33-47, 58-64, 91-96, 123+
   for ($i = 0; $i < @chars; ++$i) {

      $c = ord($chars[$i]);

      if
         (
            ($c > 32 and $c < 48)
               ||
            ($c > 57 and $c < 65)
               ||
            ($c > 90 and $c < 97)
               ||
            ($c > 123)
         )
      { $chars[$i] = qq[\046\043] . $c . qq[\073] }
   }

   return(join('',@chars))
}


# --------------------------------------------------------
# Handy::Dandy::AUTOLOAD()
# --------------------------------------------------------
sub AUTOLOAD {

   my($sub) = $AUTOLOAD; $sub =~ s/^.*\:\://o;

   if (ref($ATL) ne 'HASH') { $ATL = eval($ATL); }

   if (ref(eval(qq[\$sub])) eq 'CODE') { goto &$sub; }

   unless ($ATL->{ $sub }) {

      die(qq[BAD AUTOLOAD. Can't do $sub().  Don't know what it is.]);
   }

   eval($ATL->{ $sub }); CORE::delete($ATL->{ $sub });

   goto &$sub
}


# --------------------------------------------------------
# Handy::Dandy::DESTROY()
# --------------------------------------------------------
sub DESTROY {}


BEGIN { $ATL = <<'___AUTOLOADED___'; }
   {

'isin' => <<'__SUB__',
# --------------------------------------------------------
# Handy::Dandy::isin
# --------------------------------------------------------
sub isin {

   @_ = myargs(@_);
   my($cmp)  = shift(@_) || return(undef);
   my(%hash) = ();

   @hash{ @_ } = @_;

   exists $hash{ $cmp }
}
__SUB__

'convert_size' => <<'__SUB__',
# --------------------------------------------------------
# Handy::Dandy::convert_size()
# --------------------------------------------------------
sub convert_size {

   # syntax: $dandy->convert_size($int, q[bytes to megabytes])

   my($amt, $cmd) = myargs(@_);

   return(undef) unless isnum($amt);

   my(@specs)     = split(/ /,$cmd);
   my($from)      = $specs[0];
   my($to)        = $specs[-1];

   my($b) = 1;
   my($k) = 1000;
   my($m) = 1000000;

   # FROM conversions
   if ($from =~ /^ki/io) {

      $amt *= $k;
   }
   elsif ($from =~ /^meg/io) {

      $amt *= $m;
   }
   elsif ($from =~ /^by/io) {

      $amt *= $b;
   }

   # TO conversions
   if ($to =~ /^ki/io) {

      $amt /= $k;
   }
   elsif ($to =~ /^meg/io) {

      $amt /= $m;
   }
   elsif ($to =~ /^by/io) {

      $amt /= $b;
   }

   return($amt);
}
   }
__SUB__

'utf8' => <<'__SUB__',
# --------------------------------------------------------
# Handy::Dandy::utf8()
# --------------------------------------------------------
sub utf8 {

   my($toencode)  = join('',@{[&myargs,'']});
   my($no_encode) = q[a-zA-Z 0-9_\\-@.=];

   $toencode =~ s/([^&;$no_encode])/sprintf('%%%02X',ord($1))/ego;
   $toencode =~ tr/ /+/;

   return($toencode);
}
__SUB__

'html_encode' => <<'__SUB__',
# --------------------------------------------------------
# Handy::Dandy::html_encode()
# --------------------------------------------------------
sub html_encode {

   my(@chars)  = split(//,join('',@{[&myargs,'']}));

   foreach (@chars) {

      $_ = '&#' . ord($_) .';';
   }

   return(join('',@chars));
}

__SUB__
   }
___AUTOLOADED___

# --------------------------------------------------------
# end Handy::Dandy Class, return true on import
# --------------------------------------------------------
1;

=pod

=head1 NAME

Handy::Dandy - Miscellaneous simple, reusable code routines.

=head1 VERSION

1.30_6

=head1 @ISA

   Exporter
   OOorNO
   Handy::Dandy::TimeTools

=head1 @EXPORT

None by default.

=head1 @EXPORT_OK

All available methods.

=head1 %EXPORT_TAGS

   :all (exports all of @EXPORT_OK)

=head1 Methods

   convert_size()
   html_encode()
   html_escape()
   isfloat()
   isin()
   isint()
   isnum()
   use_once()
   utf8()

=head2 AUTOLOAD-ed methods

   convert_size()
   html_encode()
   isin()
   utf8()

=head1 PREREQUISITES

OOorNO.pm
Handy::Dandy::TimeTools

=head1 AUTHOR

Tommy Butler <cpan@atrixnet.com>

=head1 COPYRIGHT

Copyright(c) 2001-2003, Tommy Butler.  All rights reserved.

=head1 LICENSE

This library is free software, you may redistribute
and/or modify it under the same terms as Perl itself.

=cut

