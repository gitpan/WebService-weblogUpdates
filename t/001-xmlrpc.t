use strict;
use Test::More;

#

eval "require Frontier::Client";

if ($@) {
   plan tests => 1;

   warn 
     "You do not have the Frontier::RPC package installed\n".
     "You will not be able to ping the weblogUpdates service using the XMLRPC protocol.\n";

   ok(1);
   exit;
}

#

plan tests => 6;

use constant PACKAGE  => "WebService::weblogUpdates";

use constant PINGNAME => "Perlblog";
use constant PINGURL  => "http://www.nospum.net/perlblog";

use constant RSSPINGNAME => "What does Aaron think about RSS";
use constant RSSPINGURL  => "http://aaronland.info/weblog/category/rss/rss";

use_ok("WebService::weblogUpdates");

my $weblogs = WebService::weblogUpdates->new(transport=>"XMLRPC",debug=>0);
isa_ok($weblogs,PACKAGE);

ok($weblogs->ping({name=>PINGNAME,url=>PINGURL}),"ping!");

my $msg = $weblogs->ping_message();
ok($msg,$msg);

ok($weblogs->ping({name=>RSSPINGNAME,url=>RSSPINGURL,changesurl=>RSSPINGURL,category=>"rss"}),
   "pinged for RSS feed:".RSSPINGURL);

my $msg = $weblogs->ping_message();
ok($msg,$msg);
