use ExtUtils::MakeMaker;

WriteMakefile(
	      'NAME'	=> 'WebService::weblogUpdates',
	      ($[ >= 5.005) ?
	      (AUTHOR   => 'Aaron Straup Cope (cpan@aaronland.net)',
	       ABSTRACT => 'methods supported by the Userland weblogUpdates framework') : (),
	      'VERSION_FROM' => 'lib/WebService/weblogUpdates.pm',
	      'PREREQ_PM'    => {
				 Carp          => 0,
				},
	      dist	        => {COMPRESS => 'gzip', SUFFIX => 'tar.gz'},
);
