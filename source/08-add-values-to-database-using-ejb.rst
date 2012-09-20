Add Values to the Database using EJB, use Bean Validation Constraints
===========================================================================

Bean Validation is a new specification added to the Java EE 6 platform. This specification
defines an extensible validation constraints mechanism, with a pre-defined set of constraints,
that can be specified on field, method, type, or annotations. It also defines a validation facility
for the Java application developer.

The constraints can be specified on a JPA entity and the validation facility ensure these are
met during the pre-persist, pre-update, and pre-remove lifecycle events. These constraints
can also be used on “backing beans” for forms displayed by JSF. This ensures that the data
entered in the form meets the validation criteria.

.. note::
This section will explain how EJB can be used to add values to the database and Bean
Validation constraints can be used to automatically validate the data.

1. Add a new method to the EJB as:

.. code-block:: java

    public void addCustomer(Integer customerId, 
            String name, 
            Address address, 
            String phone, 
            String fax, 
            String email, 
            Integer creditLimit, 
            DiscountCode discountCode) {
        Customer c = new Customer(customerId);
        c.setName(name);
        c.setAddress(address);
        c.setPhone(phone);
        c.setFax(fax);
        c.setCreditLimit(creditLimit);
        c.setDiscountCode(discountCode);
        em.persist(c);
    }

This method takes a few parameters and adds a new customer to the database by calling the
``persist`` method on the ``EntityManager``.

Resolve the imports by taking default value for ``DiscountCode`` class but make sure
``Address`` class is imported from ``org.glassfish.samples.Address`` instead of the default
value.

2. Add the following code to ``TestServlet``'s ``processRequest`` method:

.. code-block:: java

     String id = request.getParameter("add");
     if (id != null) {
         Address address = new Address();
         address.setAddressline1("4220, Network Circle");
         address.setCity("Santa Clara");
         address.setState("CA");
         MicroMarket zip = new MicroMarket();
         zip.setZipCode("95051");
         address.setZip(zip);
         bean.addCustomer(Integer.parseInt(id),
                 "FLL Enterprises", 
                 address, 
                 "1234", 
                 "5678", 
                 "foo@bar.com", 
                 1000, 
                 new DiscountCode('H'));
         out.println("<h2>Customer with '" + Integer.parseInt(id) + "' id　added.</h2>");
    }

This code fragment looks for the “add” parameter specified as part of the URL and then
invokes the EJB's method to add a new customer to the database. The customer identifier is
obtained as a value of the parameter and all other values are defaulted.

Once again, fix the imports by taking default values for ``DiscountCode`` and ``MicroMarket``
but make sure ``Address`` is imported from ``org.glassfish.samples.Address``.

3. Access “http://localhost:8080/JavaEE6SampleApp/TestServlet?add=4” in the browser and
this will add a new customer (with id “4” in this case) to the database and displays the page
as shown.

Notice the newly added customer is now shown in the list. The output may differ based upon
where the code was added in the ``processRequest`` method. 

.. note::
The customer identifier is specified as part of the URL so its important to pick a number
that does not already exist in the database.

4. One of the bean validation constraints mentioned in ``Customer.java`` is for the phone
number (identified by the field ``phone``) to be a maximum of 12 characters. Lets update the
constraint such that it requires at least 7 characters to be specified as well. This can be done
by changing the existing constraint from:

.. code-block:: java

    @Size(max = 12)

to

.. code-block:: java

    @Size(min = 7, max = 12)

Save the file and the project automatically gets re-deployed.

5. Access the URL  “http://localhost:8080/JavaEE6SampleApp/TestServlet?add=5” in a
browser and this tries to add a new customer to the database and shows the output as
shown.

The output shows the “Access count” incremented by 1 but the list of customers is not shown.
Instead the GlassFish output log shows the following message:

.. code-block::

    Caused by: javax.validation.ConstraintViolationException: Bean Validation
    constraint(s) violated while executing Automatic Bean Validation on callback
    event:'prePersist'. Please refer to embedded ConstraintViolations for details.

This error message comes because the phone number is specified as a 4-digit number in the
Servlet and so does not meet the validation criteria. This can be fixed by changing the phone
number to specify 7 digits.

6. Edit ``TestServlet.java``, change the phone number from “1234” to “1234567”, and save
the file. And access the URL “http://localhost:8080/JavaEE6SampleApp/TestServlet?add=5”
again to see the output as shown.

The customer is now successfully added.
