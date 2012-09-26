Observer Pattern using CDI Events
==========================================

The CDI events follows the Observer pattern. Event producers raise events that are consumed by observers. The observers can optionally specify a combination of “selectors” using Qualifiers. The event object can carry state from producer to consumer. Also the observers can be notified immediately, or wait until the end of the current transaction.


.. note::
This section will explain how to produce/observe a CDI event. The TestServlet will produce an event if a new customer is added to the database. The CacheSingletonBean will observe the event and refresh the cache out of schedule.


1. Right-click on the project, select “New”, “Java Class...”, and give the name as “NewCustomerAdded”. Add the following code to this generated class:

.. code-block:: java

    private int id;
    
    public NewCustomerAdded(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

This id field is used to communicate the customer identifier that is added to the database. Alternatively, it can also pass the complete Customer object and then ``CacheSingletonBean`` can update the cache without querying the database.


2. Inject an event in the “TestServlet” as:

.. code-block:: java

    @Inject Event<NewCustomerAdded> newCustomerEvent;


Resolve the imports by choosing the class  ``javax.enterprise.event.Event`` as shown. Note, this is not the default value.


3. In the ``TestServlet.processRequest`` method, add the following code fragment:

.. code-block:: java

        newCustomerEvent.fire(new NewCustomerAdded(Integer.parseInt(id)));

at the end of the if block that adds a new customer to the database. The customer identifier is passed as the event state. The if block's updated fragment looks like:

.. code-block:: java

         out.println("<h2>Customer with '" + Integer.parseInt(id) + "' id added.</h2>");
         newCustomerEvent.fire(new NewCustomerAdded(Integer.parseInt(id)));
    }

The newly added code is highlighted in bold.


4. Add the following method in the ``CacheSingletonBean.java``:

.. code-block:: java

    public void onAdd(@Observes NewCustomerAdded event) {
        System.out.println("Processing the event: " + event.getId());
        preFetchCustomers();
    }

This method listens for the ``NewCustomerAdded`` event published from any producer, ``TestServlet`` in our case.


5. Accessing the URL “http://localhost:8080/JavaEE6SampleApp/TestServlet?add=6” in a browser, adds a new customer to the database, and displays the output as shown.

This confirms that the customer is added to the database.

The interesting part is shown in the GlassFish server log as:

.. code-block:: java

    INFO: Processing the event: 6

This shows that the event was produced by ``TestServlet`` and observed/consumed by CacheSingletonBean.
