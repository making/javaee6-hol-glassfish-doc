Þ          4      L       `   !   a   «     W  /  4     Ø  ¼                    Inject Beans using CDI Qualifiers The Contexts and Dependency Injection is a new specification in the Java EE 6 platform. The CDI specification provides a type-safe approach to dependency injection. The specification promotes âstrong typingâ and âloose couplingâ. A bean only specifies the type and semantics of other beans it depends upon, only using the Java type system with no String-based identifiers. The bean requesting injection may not be aware of the lifecycle, concrete implementation, threading model, or other clients requesting injection. The CDI runtime finds the right bean in the right scope and context and then injects it in the requestor. This loose coupling makes code easier to maintain. Project-Id-Version: Java EE 6 Hands-on Lab 1.0
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
 CDIä¿®é£¾å­ãå©ç¨ãã¦Beanãã¤ã³ã¸ã§ã¯ã Contexts and Dependency Injects(CDI)ã¯Java EE 6ã§è¿½å ãããæ°ããä»æ§ã§ããCDIã¯ä¾å­æ§ã®æ³¨å¥ã«å¯¾ãã¦ã¿ã¤ãã»ã¼ããªã¢ãã­ã¼ããæä¾ãã¦ãã¾ãããã®ä»æ§ã§ã¯âå¼·åãªåâã¨âççµåâãæ¨é²ãã¦ãã¾ããbeanã¯åã¨ä¾å­ããbeanã®ã»ãã³ãã£ã¯ã¹ã®ã¿ãå®ç¾©ãã¾ããJavaã®åã·ã¹ãã ã®ã¿ãä½¿ç¨ããæå­åãã¼ã¹ã®è­å¥å­ã¯ããã¾ãããæ³¨å¥ãã¦ã»ããbeanã¯ 