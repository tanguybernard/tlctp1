<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import="fr.istic.tlctp1.Advertisement" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <!--link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>


    </head>

    <body>
        <div>
            <div class="input-group">
                <form class="navbar-form" role="search" method="get">
                    <div class="input-group col-md-12">
                        <input type="text" class="form-control" placeholder="Search" name="searchTitle" id="srch-term">
                        <div class="input-group-btn">
                            <button class="btn btn-primary" type="submit">
                                <span class="glyphicon glyphicon-search"></span></button>
                        </div>
                    </div>
                </form>
            </div>

            <a href="/advertisement.jsp">Ajout d'une publicité</a>
            <ul class="list-group">
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
                    pageContext.setAttribute("myDate",formatter.format(advertisement.date));
                    %>
                <!--li class="list-group-item" ></li-->
                    <li class="list-group-item" >${fn:escapeXml(row)}</li>
                    <%
                }
            %>
            </ul>
        </div>
    </body>
</html>