<%@page import="com.google.apphosting.datastore.DatastoreV4.Filter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.googlecode.objectify.cmd.Query" %>

<%@ page import="fr.istic.tlctp1.Advertisement" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>

        <title>Tableau de publicités</title>

        <link rel="stylesheet" href="/stylesheets/main.css"">


        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.10/css/dataTables.bootstrap.min.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <script src="https://jqueryui.com/resources/demos/datepicker/datepicker-fr.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

    </head>

    <body>

    <div class = "page-header">

        <h1 align="center">
            Tableau de publicités
        </h1>

    </div>
        <div>
            <form method="GET">

             	<%
	             //récupération des valeurs
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
                        <div class="form-inline ">
                            <div class="input-group" style="position: initial;">
                                    <input type="text" style="position: initial;" class="form-control" placeholder="Search for..." id="search" name="searchTitle" value="${fn:escapeXml(searchTitle)}">
                          <span class="input-group-btn" >
                            	<input type="submit" value="Send" class="btn btn-secondary" style="position: initial;"/>
                          </span>
                                </div>
                        </div>

                        <div class="form-inline">
                            <label for="prixMin">Price between</label>
                            <input type="number" class="form-control" id="prixMin" name="prixMin" value="${fn:escapeXml(prixMin)}">

                            <label for="prixMax">and</label>
                            <input type="number" class="form-control" id="prixMax" name="prixMax" value="${fn:escapeXml(prixMax)}">
                        </div>

                    <div class="form-inline">
                        <div class="form-group">
                            <label for="dateMin">Date between</label>
                            <input type="text" class="form-control datepicker" id="dateMin" name="dateMin" value="${fn:escapeXml(dateMin)}">

                            <label for="dateMax">and</label>
                            <input type="text" class="form-control datepicker" id="dateMax" name="dateMax" value="${fn:escapeXml(dateMax)}">
                        </div>
                    </div>
        </div>



            </form>
            <a href="/advertisement.jsp">Add an advertisement !</a>
            <table id="myTable" class="table">
                <thead>
                <tr>
                    <th class="" >Date</th>
                    <th class="">Name</th>
                    <th class="">Price</th>
                </tr>
                </thead>
                <tbody >
                <tr>
            <%
                Query<Advertisement> query =  ObjectifyService.ofy().load().type(Advertisement.class);
                
                //filtre sur le titre
                if(searchTitle != null && !searchTitle.equals("")){
                	query = query.filter("title", searchTitle);
                }
                //filtre sur le prix
                if(prixMin != null && !prixMin.equals("") && prixMax != null && !prixMax.equals("")){
                	query = query.filter("price >=", Double.parseDouble(prixMin)).filter("price <=", Double.parseDouble(prixMax));
                }
                
                List<Advertisement> advertisements = query.limit(50).list();
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                //filtre sur la date
                if(dateMin != null && !dateMin.equals("") && dateMax != null && !dateMax.equals("")){
                	//impossible car on ne peut faire qu'une seule inégalité par propriété par requête  
                	//query = query.filter("date >", dateMin).filter("date <", dateMax);
                	
                	//on trie les pubs en fonction de la date
                	//création de deux calendars pour dateMin et dateMax
                	Calendar calendarMin = Calendar.getInstance();
                	calendarMin.setTime(formatter.parse(dateMin));
                	
                	//on met la date de fin à la dernière seconde de la journée
                	Calendar calendarMax = Calendar.getInstance();
                	calendarMax.setTime(formatter.parse(dateMax));
                	calendarMax.set(Calendar.HOUR_OF_DAY, 23);
                	calendarMax.set(Calendar.MINUTE, 59);
                	calendarMax.set(Calendar.SECOND, 59);
                	
                	Iterator<Advertisement> it = advertisements.iterator();
                	//parcours des publicités
                	while(it.hasNext()){
                		Advertisement current = it.next();
                		//on supprime les publicités si elle ne sont pas dans l'intervalle
                		if(!(current.date.after(calendarMin.getTime()) && current.date.before(calendarMax.getTime()))){
                			it.remove();
                		}
                	}
                }
                
                for(Advertisement advertisement :advertisements){
                    String msg = formatter.format(advertisement.date)+ " - "+advertisement.title +" "+advertisement.price;
                    pageContext.setAttribute("row", msg);
                    pageContext.setAttribute("myDate",formatter.format(advertisement.date));
                    pageContext.setAttribute("myTitle",advertisement.title);
                    pageContext.setAttribute("myPrice",advertisement.price);
                    pageContext.setAttribute("myId",advertisement.id);
                    %>
                <!--li class="list-group-item" ></li-->


                    <td >${fn:escapeXml(myDate)}</td>
                    <td >${fn:escapeXml(myTitle)}</td>
                    <td >${fn:escapeXml(myPrice)}</td>
                    <td>
                        <button type="button" class="btn btn-default" onclick="deleteAd(${fn:escapeXml(myId)})">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                        </button>
                    <td>

                </tr>
                    </tbody>

                    <%
                }
            %>
            </table>
        </div>


        <script type="text/javascript">
            $(function() {

                $.datepicker.setDefaults( $.datepicker.regional[ "fr" ] );
                $( ".datepicker" ).datepicker({
                    dateFormat: 'dd/mm/yy'
                });
            });


            function deleteAd(idlement) {
                $.ajax({
                    url: "delete" + '?' + $.param({"ide": idlement}),
                    type:"DELETE",
                    success: function(response){
                        location.reload();
                    }
                })

            }

        </script>

    </body>
</html>