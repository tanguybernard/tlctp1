
<%@page import="com.google.apphosting.datastore.DatastoreV4.Filter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.googlecode.objectify.cmd.Query" %>

<%@ page import="fr.istic.tlctp1.Advertisement" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <!--link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/-->

        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>





    </head>

    <body>
        <div>

            <form method="POST">
             <%
               String prixMin = request.getParameter("prixMin");
               String prixMax = request.getParameter("prixMax");
               String dateMin = request.getParameter("dateMin");
               String dateMax = request.getParameter("dateMax");
               String searchTitle = request.getParameter("searchTitle");
               pageContext.setAttribute("searchTitle", searchTitle);
               pageContext.setAttribute("prixMin", prixMin);
               pageContext.setAttribute("prixMax", prixMax);
               pageContext.setAttribute("dateMin", dateMin);
               pageContext.setAttribute("dateMax", dateMax);
             %>
                <input type="text" name="searchTitle" value="${fn:escapeXml(searchTitle)}"/> <input type="submit"/><br/>
                <span> Prix 
                	<span>
                		Entre 
                	</span>
                	<input type="number" id="prixMin" name="prixMin" value="${fn:escapeXml(prixMin)}"/>
                	<span>
                		et 
                	</span>
                	<input type="number" id="prixMax" name="prixMax" value="${fn:escapeXml(prixMax)}"/>
                </span><br/>
                 
                 <span> Date 
                	<span>
                		Entre 
                	</span>

                	<input type="text" id="datepicker" name="dateMin" value="${fn:escapeXml(dateMin)}"/>
                	<span>
                		et 
                	</span>
                	<input id="datepicker2" type="text" name="dateMax" value="${fn:escapeXml(dateMax)}"/>

                </span>
 
                
            </form>
            <a href="/advertisement.jsp">Ajout d'une publicité</a>
            <table id="example" class="table table-striped">
                <thead>
                <tr>
                    <th>Date</th>
                    <th>Name</th>
                    <th>Prix</th>
                </tr>
                </thead>
                <tbody class="searchable">
                <tr>
            <%
                Query<Advertisement> query =  ObjectifyService.ofy().load().type(Advertisement.class);
                
                //filtre sur le titre
                if(searchTitle != null && !searchTitle.equals("")){
                	query = query.filter("title", searchTitle);
                }
                //filtre sur le prix
                if(prixMin != null && !prixMin.equals("") && prixMax != null && !prixMax.equals("")){
                	query = query.filter("price >", Double.parseDouble(prixMin)).filter("price <", Double.parseDouble(prixMax));
                }
                
                List<Advertisement> advertisements = query.list();
                
                //filtre sur la date
                if(dateMin != null && !dateMin.equals("") && dateMax != null && !dateMax.equals("")){
                	//impossible car on ne peut faire qu'une seule inégalité par propriété par requête  
                	//query = query.filter("date >", dateMin).filter("date <", dateMax);
                	System.out.println(dateMin);
                }
                
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                for(Advertisement advertisement :advertisements){
                    String msg = formatter.format(advertisement.date)+ " - "+advertisement.title +" "+advertisement.price;
                    pageContext.setAttribute("row", msg);
                    pageContext.setAttribute("myDate",formatter.format(advertisement.date));
                    pageContext.setAttribute("myTitle",advertisement.title);
                    pageContext.setAttribute("myPrice",advertisement.price);
                    %>
                <!--li class="list-group-item" ></li-->


                    <td >${fn:escapeXml(myDate)}</td>
                    <td >${fn:escapeXml(myTitle)}</td>
                    <td >${fn:escapeXml(myPrice)}</td>

                    </tr>
                    </tbody>



                    <%
                }
            %>
            </table>
        </div>

        <script>
            $(function() {
                $( "#datepicker" ).datepicker();
            });
            $(function() {
                $( "#datepicker2" ).datepicker();
            });
        </script>

    </body>
</html>