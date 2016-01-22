<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="fr.istic.tlctp1.Advertisement" %>
<%@ page import="fr.istic.tlctp1.Guestbook" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
    <script src="http://code.jquery.com/jquery-latest.min.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="js/addAdvertisement.js"></script>

</head>

<body>

<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
        pageContext.setAttribute("user", user);
%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
    <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
} else {
%>
<p>Hello!
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
    to include your name with greetings you post.</p>
<%
    }
%>


<form action="/add" method="post">
    <div class="input_fields_wrap">
        <button type='button' class="add_field_button">Add More Fields</button>
        <div><input type="text" name="title[]"></div>
        <div><input type="number" name="price[]" min="1"></div>
    </div>
    <div><input type="submit" value="Post Add"/></div>

</form>


</body>
>>>>>>> 71dea9ba0fed394d8d117f5b4aaaa526a8feccae
</html>