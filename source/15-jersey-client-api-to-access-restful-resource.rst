Jersey Client API to Access the RESTful Resource
========================================================

Jersey is the Reference Implementation of JAX-RS. The Jersey Client API is an easy-to-use and high-level Java API that can help you write clients for any HTTP-based RESTful Web service.


.. note::
This section will create a client that will access the RESTful resource published at the /customers/{id} path.


1. Right-click on the project, select “New”, “Java Class...”, give the class name as “RESTfulClient”, take all other defaults, and click on “Finish”.


2. Add the following code to the generated class:

.. code-block:: java

    public static void main(String[] args) {
        String BASE_URL = "http://localhost:8080/JavaEE6SampleApp/restful/customers/";
        Client client = Client.create();
        WebResource resource = client.resource(BASE_URL + "1");
        resource.addFilter(new LoggingFilter());
        resource.get(String.class);
        
        resource.accept(MediaType.APPLICATION_JSON).get(String.class);
    }

Notice the following points:

 * This code creates a new Jersey client runtime instance. This is an expensive object and so must be saved if no other configuration is required to access the resources.
 * A new ``WebResource`` is created per RESTful resource that is capable of building requests to send to the resource and processing responses returned from the resource. Each ``WebResource`` follows a builder pattern to specify the required MIME type in the response, application/json in this case.
 * A ``LoggingFilter`` is added to the resource to print the request and response messages.
 * The code then requests a default and JSON representation of the resource in two separate calls.

Fix the imports by taking all the defaults.


3. Right-click on the file and select “Run File” to see the following output:


.. code-block:: 

    run:
    Nov 8, 2011 10:15:43 PM com.sun.jersey.api.client.filter.LoggingFilter log
    INFO: 1 * Client out-bound request
    1 > GET http://localhost:8080/JavaEE6SampleApp/restful/customers/1
    
    Nov 8, 2011 10:15:43 PM com.sun.jersey.api.client.filter.LoggingFilter log
    INFO: 1 * Client in-bound response
    1 < 200
    1 < Date: Tue, 08 Nov 2011 21:15:43 GMT
    1 < Content-Length: 601
    1 < Content-Type: application/xml
    1 < X-Powered-By: Servlet/3.0 JSP/2.2 (GlassFish Server Open Source Edition 3.1.1 Java/Apple Inc./1.6)
    1 < Server: GlassFish Server Open Source Edition 3.1.1
    1 <
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><customer><address><addressline1>111 E. Las Olivas Blvd</addressline1><addressline2>Suite 51</addressline2><city>Fort Lauderdale</city><state>FL</state><zip><areaLength>547.967</areaLength><areaWidth>468.858</areaWidth><radius>755.778</radius><zipCode>95117</zipCode></zip></address><creditLimit>100000</creditLimit><customerId>1</customerId><discountCode><discountCode>78</discountCode><rate>0.00</rate></discountCode><email>jumboeagle@example.com</email><fax>305-555-0189</fax><name>Jumbo Eagle Corp</name><phone>305-555-0188</phone></customer>
    
    Nov 8, 2011 10:15:43 PM com.sun.jersey.api.client.filter.LoggingFilter log
    INFO: 2 * Client out-bound request
    2 > GET http://localhost:8080/JavaEE6SampleApp/restful/customers/1
    2 > Accept: application/json

    Nov 8, 2011 10:15:43 PM com.sun.jersey.api.client.filter.LoggingFilter log
    INFO: 2 * Client in-bound response
    2 < 200
    2 < Transfer-Encoding: chunked
    2 < Date: Tue, 08 Nov 2011 21:15:43 GMT
    2 < Content-Type: application/json
    2 < X-Powered-By: Servlet/3.0 JSP/2.2 (GlassFish Server Open Source Edition 3.1.1 Java/Apple Inc./1.6)
    2 < Server: GlassFish Server Open Source Edition 3.1.1
    2 <
    {"address":{"addressline1":"111 E. Las Olivas Blvd","addressline2":"Suite 51","city":"Fort Lauderdale","state":"FL","zip":{"areaLength":"547.967","areaWidth":"468.858","radius":"755.778","zipCode":"95117"}},"creditLimit":"100000","customerId":"1","discountCode":{"discountCode":"78","rate":"0.00"},"email":"jumboeagle@example.com","fax":"305-555-0189","name":"Jumbo Eagle Corp","phone":"305-555-0188"}

    BUILD SUCCESSFUL (total time: 1 second)

The output shows request and response messages to/from the resource. The first pair of messages is pre-fixed with “1”  and shows the default XML response coming back. The second pair of messages is pre-fixed with “2” and shows the “Accept” header going from client to endpoint for content-negotiation with server. The server understands the expected format and returns a JSON response.

