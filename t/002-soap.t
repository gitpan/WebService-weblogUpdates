use strict;
use Test::More;

#

eval "require SOAP::Lite";

if ($@) {
   plan tests => 1;

   warn 
     "You do not have the SOAP::Lite package installed\n".
     "You will not be able to ping the weblogUpdates service using the SOAP protocol.\n";

   ok(1);
   exit;
}

#

plan tests => 7;

use constant PACKAGE  => "WebService::weblogUpdates";
use constant PINGNAME => "Perlblog";
use constant PINGURL  => "http://www.nospum.net/perlblog";
use constant RSSPINGNAME => "What does Aaron think about RSS";
use constant RSSPINGURL  => "http://aaronland.info/weblog/category/rss/rss";

ok($SOAP::Lite::VERSION >= 0.55,"SOAP::Lite::VERSION >= 0.55");

use_ok("WebService::weblogUpdates");

my $weblogs = WebService::weblogUpdates->new(transport=>"SOAP",debug=>0);
isa_ok($weblogs,PACKAGE,PACKAGE);

ok($weblogs->ping({name=>PINGNAME,url=>PINGURL}),"pinged for:".PINGURL);

my $msg = $weblogs->ping_message();
ok($msg,$msg);

ok($weblogs->ping({name=>RSSPINGNAME,url=>RSSPINGURL,changesurl=>RSSPINGURL,category=>"rss"}),
   "pinged for RSS feed:".RSSPINGURL);

my $msg = $weblogs->ping_message();
ok($msg,$msg);
