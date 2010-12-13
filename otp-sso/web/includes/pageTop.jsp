<%--
    Document   : login
    Created on : 01/12/2010, 7:23:36 PM
    Author     : jake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<%@ page import="java.io.*,java.util.*" %>





<html>

    <head>

        <%

            Enumeration paramNames = request.getParameterNames();

            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                if (paramName.equals("lo")) {
                    String paramValue = request.getParameter(paramName);
                    if (paramValue.equals("true")) {
                    session.setAttribute("username", null);

                        %> <script type="text/javascript">
<!--
window.location = "../login.jsp"
//-->
</script> <%

                    }
                }


            }



%>




        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><% out.print(request.getParameter("title"));
            %></title>

        <link rel="stylesheet" href="../style/style.css" media="all" />

        <!--[if IE]>
        <style type="text/css">#header h1{ font-size:32px; } .column { width:200px;border:0;overflow:hidden; }</style>
        <![endif]-->


    </head>
    <body>

        <div id="container">



            <jsp:include page="header.jsp" />



            <jsp:include page="nav.jsp" />

            <div id="content">