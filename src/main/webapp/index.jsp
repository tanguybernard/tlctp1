<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.*" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import="fr.istic.tlctp1.Advertisement" %>
<%@ page import="java.util.Date" %>
<html>
    <head>
      <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
    </head>

    <body>
        <div>
            <form method="GET">
                <input type="text" name="searchTitle"/> <input type="submit"/>
            </form>
            <a href="/advertisement.jsp">Ajout d'une publicité</a>
            <%
               String searchTitle = request.getParameter("searchTitle");

               // Get the Datastore Service
               DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
               Query q = new Query("Advertisement");
                if(searchTitle!= null){
                       Query.Filter filterTitle =
                               new Query.FilterPredicate("title",
                                       Query.FilterOperator.EQUAL ,
                                       searchTitle);
                        // Use class Query to assemble a query
                        q = q.setFilter(filterTitle);
                }


                PreparedQuery pq = datastore.prepare(q);
                for (Entity result : pq.asIterable()) {
                   Date date = (Date) result.getProperty("date");
                   String lastName = (String) result.getProperty("title");
                   Float price = (Float) result.getProperty("price");
                   %>
                          <span>${ date }+ " - " + ${title} + "  "+${price} %></span>

                    <%
                }



            %>
        </div>
    </body>
</html>