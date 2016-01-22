<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import="fr.istic.tlctp1.Advertisement" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
            <ul>
            <%
               String searchTitle = request.getParameter("searchTitle");
                List<Advertisement> advertisements = null;
                if(searchTitle == null){
                    advertisements = ObjectifyService.ofy().load().type(Advertisement.class).list();
                }else{
                    advertisements = ObjectifyService.ofy().load().type(Advertisement.class).filter("title", searchTitle).list();
                }
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                for(Advertisement advertisement :advertisements){
                    String msg = formatter.format(advertisement.date)+ " - "+advertisement.title +" "+advertisement.price;
                    pageContext.setAttribute("row", msg);
                    %>
                    <li>${fn:escapeXml(row)}</li>
                    <%
                }
            %>
            </ul>
        </div>
    </body>
</html>