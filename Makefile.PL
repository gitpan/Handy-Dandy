use ExtUtils::MakeMaker;
require 5.6.0;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile
   (
   'ABSTRACT'     => 'Miscellaneous simple, reusable code routines',
   'AUTHOR'       => 'Tommy Butler <cpan@atrixnet.com>',
   'INSTALLDIRS'  => 'perl',
   'NAME'         => 'Handy::Dandy',
   'VERSION_FROM' => 'Dandy.pm',
   'linkext'      => { LINKTYPE => '' }, # no link needed
   'PREREQ_PM'    =>
      {
         'OOorNO' => 0.00_2,
      },
   'dist'         =>
      {
         'COMPRESS'  => 'gzip -9f',
         'SUFFIX'    => 'gz',
         'ZIP'       => '/usr/bin/zip',
         'ZIPFLAGS'  => '-rl',
      }
   );

__END__
   * NAME
   * SYNOPSIS
   * DESCRIPTION
   * INSTALLATION
   * EXPORT
   * EXPORT_OK
   * GLOBAL VARIABLES
   * PUBLIC METHODS
   * PRIVATE METHODS
   * EXAMPLES
   * BUGS
   * AUTHOR
   * COPYRIGHT
   * SEE ALSO
