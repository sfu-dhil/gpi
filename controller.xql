xquery version "3.1";

(:~ The controller library contains URL routing functions.
 :
 : @see http://www.exist-db.org/exist/apps/doc/urlrewrite.xml
 :)
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace request="http://exist-db.org/xquery/request";

declare default element namespace 'http://exist.sourceforge.net/NS/exist';

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

if ($exist:path eq '') then
  <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
    <redirect url="{request:get-uri()}/"/>
  </dispatch>

else if ($exist:path eq "/") then
    (: forward root path to index.xql :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
      <redirect url="index.html"/>
    </dispatch>
  
else if (ends-with($exist:resource, ".html")) then
  (: the html page is run through view.xql to expand templates :)
  <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
    <view>
      <forward url="{$exist:controller}/modules/view.xql"/>
    </view>
  </dispatch>
  
else
  <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
    <cache-control cache="yes"/>
  </dispatch>
