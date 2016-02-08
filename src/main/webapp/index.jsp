
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.googlecode.objectify.cmd.Query" %>

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
                	<input type="number" name="prixMin" value="${fn:escapeXml(prixMin)}"/>
                	<span>
                		et 
                	</span>
                	<input type="number" name="prixMax" value="${fn:escapeXml(prixMax)}"/>
                </span><br/>
                 <span> Date 
                	<span>
                		Entre 
                	</span>
                	<input type="date" name="dateMin" value="${fn:escapeXml(dateMin)}"/>
                	<span>
                		et 
                	</span>
                	<input type="date" name="dateMax" value="${fn:escapeXml(dateMax)}"/>
                </span>
 
                
            </form>
            <a href="/advertisement.jsp">Ajout d'une publicité</a>
            <ul>
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
                //filtre sur la date
                if(dateMin != null && !dateMin.equals("") && dateMax != null && !dateMax.equals("")){
                	query = query.filter("date >", dateMin).filter("date <", dateMax);
                }
                
                List<Advertisement> advertisements = query.list();
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