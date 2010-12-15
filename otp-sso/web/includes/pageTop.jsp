<%--
    Document   : login
    Created on : 01/12/2010, 7:23:36 PM
    Author     : jake
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<%@ page import="java.io.*,java.util.*" %>


<jsp:useBean id="totpAuth" class="auth.totp.totpauth" scope="request">
    <jsp:setProperty name="totpAuth" property="*"/>
</jsp:useBean>


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
                    session.setAttribute("uid", null);
                    session.setAttribute("admin", null);
                    session.setAttribute("yubi", null);
                    session.setAttribute("totp", null);
                    session.setAttribute("scratch", null);
                    session.setAttribute("wifi", null);

                        %>

                        <script type="text/javascript">
<!--
window.location = "../index.jsp"
//-->
</script>



        <%

                    }
                }

                if (paramName.equals("totprst")) {
                    String paramValue = request.getParameter(paramName);
                    if (paramValue.equals("true")) {



                       String uid = (String)session.getAttribute("uid");


                        totpAuth.newSecret(uid);




                        %>

                        <script type="text/javascript">
<!--
window.location = "../totp.jsp"
//-->
</script>



        <%

                    }
                }


            }



%>




        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% out.print(request.getParameter("header"));
            %>

        <link rel="stylesheet" href="../style/style.css" media="all" />

        <script type="text/javascript">
   function formfocus() {
      document.getElementById('focus').focus();
   }
   window.onload = formfocus;
</script>

        <!--[if IE]>
        <style type="text/css">#header h1{ font-size:32px; } .column { width:200px;border:0;overflow:hidden; }</style>
        <![endif]-->


    </head>
    <body>

        <div id="container">



            <jsp:include page="header.jsp" />



            <jsp:include page="nav.jsp" />

            <div id="content">