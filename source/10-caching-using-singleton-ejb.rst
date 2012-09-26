Caching using Singleton EJB and @Schedule to Pre-fetch Data
============================================================

The EJB 3.1 specification introduces ``@Singleton`` annotation that creates a single instance of an EJB per-application and per-JVM. By default, all methods are thread-safe and transactional. The specifications also simplifies how to schedule callback methods using calendar-based expressions. These methods can be invoked at a specified time, after a specified elapsed duration, or at recurring intervals.

.. note::

This section adds a singleton EJB that can be used to pre-fetch data from the database at recurring intervals.

1. Right-click on “org.glassfish.samples” package, select “New”, “Session Bean...”, type the name as “CacheSingletonBean”, and type as “Singleton” as shown.

And click on OK.

2. Add the following class-level annotation:

.. code-block:: java

    @javax.ejb.Startup

This will ensure that this singleton bean is loaded eagerly during the application startup.

3. Add the following code to the generated class:

.. code-block:: java

    @EJB CustomerSessionBean bean;
    List<Customer> customers;
    
    public List<Customer> getCustomers() {
        return customers;
    }
    
    @Schedule(hour="*", minute="*", second="*/30")
    public void preFetchCustomers() {
        System.out.println(new Date() + " Fetching customers");
        customers = bean.getCustomers();
    }

Fix the imports.

This code is using previously created ``CustomerSessionBean`` to get the list of customers. This method has a ``@Schedule`` annotation that takes cron-like syntax to specify the recurring interval at which the method needs to be invoked.
The GlassFish server log will show messages like:

.. code-block:: 

    INFO: Tue Nov 08 00:06:00 CET 2011 Fetching customers
    INFO: Tue Nov 08 00:06:30 CET 2011 Fetching customers
    INFO: Tue Nov 08 00:07:00 CET 2011 Fetching customers
    INFO: Tue Nov 08 00:07:30 CET 2011 Fetching customers
    INFO: Tue Nov 08 00:08:00 CET 2011 Fetching customers

The log messages show that customer cache is updated every 30 seconds, as defined by ``@Schedule``.

The application can now use this singleton bean, instead of CustomerSessionBean, to get the list of customers such as:

.. code-block:: java

    @EJB CacheSingletonBean bean;

    . . .

    bean.preFetchCustomers();

Note, ``bean.getCustomers()`` cannot be invoked as it may return null if the timer event has not occurred yet at least once. 

You may consider commenting ``@Schedule`` annotation to avoid flooding the server log with an output from the ``preFetchCustomers`` method.

