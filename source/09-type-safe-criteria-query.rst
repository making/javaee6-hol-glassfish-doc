Type-safe Critieria Query using JPA2 Metamodel
================================================================================================

The JPA2 specification defines Metamodel classes to capture the meta-model of the
persistent state and relationships of the managed classes of a persistence unit. The canonical
metamodel classes can be generated statically using an annotation processor following the
rules defined by the specification.

This abstract persistence schema is used to author the type-safe queries using Critieria API,
rather than use of the string-based approach of the Java Persistence Query Language
(JPQL).

.. note::
This section creates type-safe query using JPA2 Criteria API.

1. Right-click on the project and select “Clean and Build” to generate metamodel classes for the JPA entities. The project explorer looks like as shown.

The JPA2 specification defines a canonical metamodel. NetBeans uses “EclipseLink
Canonical Metamodel Generator” to generate these metamodel classes when the project is
built. This is pre-configured in “Project Properties”, “Libraries”, “Processor” as shown.

Here is how the generated ``Address_.java`` class looks like:

.. code-block:: java

    package org.glassfish.samples.entities;
    import javax.annotation.Generated;
    import javax.persistence.metamodel.SingularAttribute;
    import javax.persistence.metamodel.StaticMetamodel;
    import org.glassfish.samples.entities.MicroMarket;
    @Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2011-11-07T16:13:45")
    @StaticMetamodel(Address.class)
    public class Address_ { 
        public static volatile SingularAttribute<Address, String> addressline2;
        public static volatile SingularAttribute<Address, MicroMarket> zip;
        public static volatile SingularAttribute<Address, String> addressline1;
        public static volatile SingularAttribute<Address, String> state;
        public static volatile SingularAttribute<Address, String> city;
    }

This class provides the type and cardinality of each field in the Address entity.

2. Add the following code to ``CustomerSessionBean.java``:

.. code-block:: java

    public List<Customer> getCustomers2() {
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery criteria = builder.createQuery(Customer.class);
        // FROM clause
        Root root = criteria.from(Customer.class);
        // SELECT clause
        criteria.select(root);
        // No WHERE clause
        // FIRE query
        TypedQuery query = em.createQuery(criteria);
        // PRINT result
        return query.getResultList();
    }

This method returns the list of all customers from the database, just like ``getCustomers``
method earlier, but uses type-safe Criteria API to query the database. 

The generated metamodel will be used later.

.. note::
Note that all the information is specified without any string-based identifiers.

Fix the imports by taking all the defaults.

3. In “TestServlet.java”, replace the code:

.. code-block:: java

    List<Customer> result = bean.getCustomers();

with

.. code-block:: java

    List<Customer> result = bean.getCustomers2();

Notice the new EJB function is now invoked.

Fix the imports.

4. Refresh the page “http://localhost:8080/JavaEE6SampleApp/TestServlet” in browser to see an output like:

This confirms that there is no change in the output, as expected.
