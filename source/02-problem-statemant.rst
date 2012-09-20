Problem Statement
====================================================

This hands-on lab builds a typical 3-tier Java EE 6 Web application that retrieves customer information from a database and displays it in a Web page. The application also allows new customers to be added to the database as well. The string-based and type-safe queries are used to query and add rows to the database. Each row in the database table is published as a RESTful resource and is then accessed programmatically. Typical design patterns required by a Web application like validation, caching, observer, partial page rendering, and cross-cutting concerns like logging are explained and implemented using different Java EE 6 technologies.

This application uses a sample database that comes pre-configured in both NetBeans "All" and "Java EE" downloaded bundled versions.


.. warning:: 
    **Disclaimer**: This is a sample application and the code may not be following the best practices to prevent SQL injection, cross-side scripting attacks, escaping parameters, and other similar features expected of a robust enterprise application. This is intentional such as to stay focused on explaining the technology. Each of this topic can take its own hands-on lab and there is enough material available on the Internet. Its highly recommended to make sure that the code copied from this sample application is updated to meet those requirements.
