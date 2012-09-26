Inject Beans using CDI Qualifiers
=========================================================

The Contexts and Dependency Injection is a new specification in the Java EE 6 platform. The CDI specification provides a type-safe approach to dependency injection. The specification promotes “strong typing” and “loose coupling”. A bean only specifies the type and semantics of other beans it depends upon, only using the Java type system with no String-based identifiers. The bean requesting injection may not be aware of the lifecycle, concrete implementation, threading model, or other clients requesting injection. The CDI runtime finds the right bean in the right scope and context and then injects it in the requestor. This loose coupling makes code easier to maintain.

The CDI specification defines “Qualifiers” as a means to uniquely identify one of the multiple implementations of a bean to be injected. The specification defines certain pre-defined qualifiers (``@Default``, ``@Any``, ``@Named``, ``@New``) and allows new qualifiers to be defined easily.


.. note::
This section shows how one or many implementations of a bean can be injected using CDI Qualifiers.


1. Right-click on the project, select “New”, “Other...”, “Java”, “Java Interface...”, give the name as “Greeter” and choose the package name as “org.glassfish.samples”. Click on “Finish”.


2. Add the following method to this interface:

.. code-block:: java

    public String greet(Customer customer);

This interface will be used to greet the customer.

Resolve the imports.

3. Add an implementation of the customer by adding a new class with the name “NormalGreeter”. Change the generated class to look like:

.. code-block:: java

    public class NormalGreeter implements Greeter {
    
        @Override
    public String greet(Customer customer) {
        return "Hello " + customer.getName() + "!";
    }
}

This class implements the Greeter interface and provide a concrete implementation of the method.


4. In TestServlet.java, inject a Greeter as:

.. code-block:: java

    @Inject Greeter greeter;

Note, this is injecting the interface, not the implementation.

Resolve the imports.

5. Add the following code in the ``processRequest`` method:

.. code-block:: java

    String greet = request.getParameter("greet");
    if (greet != null) {
            Customer customer = bean.getCustomers().get(Integer.parseInt(greet));
            out.println(greeter.greet(customer) + "<br><br>");
    }

For convenience, this code was added right before the list of customers is printed.

This code reads a parameter “greet” from the URL, uses its value to extract the customer from the database, and invokes the injected ``Greeter`` interface on it. Behind the scene, the CDI runtime looks for an implementation of this interface, finds NormalGreeter, and injects it.

The default scope of the bean is @Dependent and is injected directly. For non-default scopes, a proxy to the bean is injected. The actual bean instance is injected at the runtime after the scope and context is determined correctly. 


6. Access the page “http://localhost:8080/JavaEE6SampleApp/TestServlet?greet=0” in a browser to see the output as shown. Note, the value of the parameter is not the customer identifier, its the order of customer in the list returned by the database.

The output from the recently added statement is highlighted with a red circle.

Lets add an alternative implementation of Greeter that greets customers based upon their credit limit.


7. Right-click on the project, select “New”, “Java Class...”, give the name as “PromotionalGreeter”. Change the implementation to:

.. code-block:: java

    public class PromotionalGreeter extends NormalGreeter {
    
        @Override
        public String greet(Customer customer) {
    	    String greeting = super.greet(customer);
            
            if (customer.getCreditLimit() >= 100000)
                return "You are super, thank you very much! " + greeting;
       
            if (customer.getCreditLimit() >= 50000)
                return "Thank you very much! " + greeting;
        
            if (customer.getCreditLimit() >= 25000)
                return "Thank you! " + greeting;
        
            return greeting;
        }
    }

This method returns a different greeting method based upon the credit limit. Notice, this class is extending ``NormalGreeter`` class and so now the Greeter interface has two implementations in the application.

Resolve the imports. As soon as you save this file, the NetBeans IDE tries to deploy the project but fails with the following error:

Error occurred during deployment: Exception while loading the app : WELD-001409 Ambiguous dependencies for type [Greeter] with qualifiers [@Default] at injection point [[field] @Inject org.glassfish.samples.TestServlet.greeter]. Possible dependencies [[Managed Bean [class org.glassfish.samples.PromotionalGreeter] with qualifiers [@Any @Default], Managed Bean [class org.glassfish.samples.NormalGreeter] with qualifiers [@Any @Default]]].

The error message clearly explains that the Greeter interface has two implementations, both with the default set of qualifiers. The CDI runtime finds both the implementations equally capable for injection and gives an error message explaining the “ambiguous dependencies”.

Lets resolve this by adding a qualifier on one of the implementations.


8.  Add ``@Promotion`` as a class-level annotation on ``PromotionalGreeter.java``. Click on the yellow bulb and take the suggestion to create the Qualifier.

This generates the boilerplate code required for the ``@Promotion`` qualifier as:

.. code-block:: java

    @Qualifier
    @Retention(RUNTIME)
    @Target({METHOD, FIELD, PARAMETER, TYPE})
    public @interface Promotion {
    }

As you can see, the CDI qualifier is a Java annotation, that itself is annotated with the ``@javax.inject.Qualifier`` meta-annotation.

The project gets successfully deployed after this file is saved. This happens correctly now because one of the implementations of the Greeter interface (``PromotionalGreeter``) is more qualified than the other (``NormalGreeter``) and so the default implementation (``NormalGreeter``) can be injected without any ambiguities.

Refreshing the page “http://localhost:8080/JavaEE6SampleApp/TestServlet?greet=1” shows the same the output as earlier.


9. Change the injection of Greeter to:

.. code-block:: java

    @Inject @Promotion Greeter greeter;

Save the file, refreshing the page “http://localhost:8080/JavaEE6SampleApp/TestServlet?greet=0” displays the output as shown.

The updated greeting message shows that the PromotionalGreeter is injected instead of the default one (``NormalGreeter``). The updated greeting is highlighted with a red circle.

Accessing “http://localhost:8080/JavaEE6SampleApp/TestServlet?greet=6” shows a different greeting message, based upon the credit limit of the customer, as shown.

The CDI qualifiers ensures that there is no direct dependency on any (possibly many) implementations of the interface. 
