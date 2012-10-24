Þ          |      Ü          $   !  P   F  û     Ê     P   ^  {  ¯    +  b   7  '     D   Â       W  £  3   û	  p   /
     
  è   ¬  l     Á      Ä     K  9   Ù  E     Õ   Y           	                       
                         Active Redeploy to Preserve Sessions Edit ``Customer.java``, change the implementation of the ``toString`` method to: Fix the imports by taking the defaults. This code stores a session attribute identifying the number of times a page has been accessed. Refresh the page âhttp://localhost:8080/JavaEE6SampleApp/TestServletâ in the browser to see the output as shown. GlassFish provides support for preserving session state across redeployments. This feature is called as *Active Redeploy* and works for HTTP sessions, stateful EJBs, and persistently created EJB timers. In ``TestServlet.java``, add the following code before the database access code: Notice, that even though the output from the toString is correctly updated, indicating the app was redeployed successfully, the session access count was incremented by one. This shows that the session attributes were preserved across the redeployment. This boosts developer's productivity because HTTP session, which is where typically application's login information might be stored, is not invalidated if your application is redeployed. This is an optional feature and can be disabled by viewing the properties of the GlassFish server in the âServicesâ tab of NetBeans and unselecting âPreserve Sessions Across Redeploymentâ. Notice, â[ â are replaced with â (â. Save the file. The NetBeans IDE auto-deploys a Java EE 6 project with every file save. This can be configured in âProject Propertiesâ, âRunâ, and by selecting/unselecting the checkbox âDeploy on Saveâ as shown. The output from the Servlet may look slightly different based upon where you copy/pasted the code. The updated output looks like as shown. The âTimestampâ and âAccess countâ is displayed on the page. This section will show how Active Redeploy for HTTP sessions, together with NetBeans auto-deploy, boosts productivity for Java EE 6 application developers. Project-Id-Version: Java EE 6 Hands-on Lab 1.0
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2012-09-26 20:42
PO-Revision-Date: 2012-09-26 20:37+0900
Last-Translator: Toshiaki Maki <>
Language-Team: Japanese
Language: ja
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=1; plural=0;
 æ¢å­ã®ã»ãã·ã§ã³ã«åçã«åããã­ã¤ ``Customer.java`` ãç·¨éãã¦ ``toString`` ã¡ã½ããã®å®è£ãæ¬¡ã®ããã«å¤æ´ãã¦ãã ãã:  ã¤ã³ãã¼ããFIXãã¦ãã ããããã®ã³ã¼ãã§ã¯ãã®ãã¼ã¸ã¸ã®ã¢ã¯ã»ã¹åæ°ãã»ãã·ã§ã³ã«ä¿æãã¦ãã¾ããâhttp://localhost:8080/JavaEE6SampleApp/TestServletâ ãåèª­ã¿è¾¼ã¿ããã¨æ¬¡ã®ããã«è¡¨ç¤ºããã¾ãã GlassFishã¯åããã­ã¤å¾ãã»ãã·ã§ã³ã®ç¶æãä¿æããæ©è½ããµãã¼ããã¾ãããã®æ©è½ã¯ *Active Redeploy* ã¨å¼ã°ããHTTPã»ãã·ã§ã³, ã¹ãã¼ããã«EJB,  EJBã¿ã¤ãã¼ã§æå¹ã§ãã ``TestServlet.java``, ã§ãã¼ã¿ãã¼ã¹ã¢ã¯ã»ã¹ã®åã«æ¬¡ã®ã³ã¼ããè¿½è¨ãã¦ãã ãã : toStringã®çµæãæ­£ããæ´æ°ãããæ­£å¸¸ã«åããã­ã¤ããã¦ããã«ãé¢ããããã»ãã·ã§ã³ä¸ã®ã¢ã¯ã»ã¹åæ°ãã¤ã³ã¯ãªã¡ã³ãããã¦ãããã¨ã«çç®ãã¦ãã ãããããªãã¡ã»ãã·ã§ã³ãåããã­ã¤å¾ãä¿å­ããã¦ãã¾ããããã«HTTPã»ãã·ã§ã³(å¸åçã«ã­ã°ã¤ã³æå ±ãä¿å­ããã¦ããé å)ãåããã­ã¤ãã¦ãç ´æ£ãããªããããéçºèã®çç£æ§ãé«ãã¾ããããã¯ãªãã·ã§ã³ã®æ©è½ã§ãããNetBeansã®GlassFishãµã¼ãã¼ã®ãã­ããã£ãè¦ã¦ãâServicesâ ã¿ãã®âPreserve Sessions Across Redeploymentâ ãé¸æãå¤ããã¨ã§ç¡å¹åã§ãã¾ãã â[ â ã â (â ã«ç½®æããã¦ãããã¨ã«çç®ãã¦ãã ããã ãã¡ã¤ã«ãä¿å­ãã¦ãã ãããNetBeansã¯åãã¡ã¤ã«ãä¿å­ãããåº¦ã«èªåçã«Java EE 6ãã­ã¸ã§ã¯ããããã­ã¤ãã¾ãããã®æ©è½ã¯æ¬¡ã®ããã« âProject Propertiesâ, âRunâ ã® âDeploy on Saveâ ããã§ãã¯ããã»ããªãã§è¨­å®å¯è½ã§ãã ãµã¼ãã¬ããã®åºåçµæãã³ãã¼ã¢ã³ããã¼ã¹ã¨ããã³ã¼ãã®ãã®ã¨å°ãéã£ã¦è¦ããããããã¾ããã æ´æ°å¾ã®åºåçµæã¯æ¬¡ã®ããã«ãªãã¾ãã âTimestampâ ã¨ âAccess countâ ãè¡¨ç¤ºããã¦ãã¾ãã ãã®ã»ã¯ã·ã§ã³ã§ã¯HTTPã»ãã·ã§ã³ã«å¯¾ããActive Redeployã NetBeansã¨é£æºãã¦ãã©ãã®ããã« JavaEE6ã¢ããªã±ã¼ã·ã§ã³éçºèã®çç£æ§ãåä¸ãããããç¤ºãã¾ãã 