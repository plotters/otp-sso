<jsp:useBean id="idHandler" class="auth.login" scope="request">
    <jsp:setProperty name="idHandler" property="*"/>
</jsp:useBean>


<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value="<title>SSO Login Page</title>" />
</jsp:include>


<%@ page import="java.io.*,java.util.*" %>
<%@page contentType="text/html" %>


<%

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            boolean loginBox = true;

            Enumeration paramNames = session.getAttributeNames();

            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                if (paramName.equals("username")) {
                    String paramValue = (String) session.getAttribute(paramName);

                    if (!paramValue.equals(null)) {
                        loginBox = false;
                        out.print("Hello " + session.getAttribute("username"));
                    }
                }
            }


            if (username != null && password != null) {

                if (idHandler.authenticate(username, password)) {
                    out.print("Password good");

                    loginBox = false;

                    session.setAttribute("username", username);

%> <script type="text/javascript">
    <!--
    window.location = "../login.jsp"
    //-->
</script> <%

                } else {

                    out.print("<p> Incorret Username or Password </p><br />");

                    username = null;
                    password = null;
                }

            }

            if (loginBox) {%>
<center><form action="login.jsp" method="POST">
        Username: <input type="text" name="username" />
        <br />
        <br />
        Password: <input type="password" name="password" />
        <br/>
        <br />
        <input type="submit" value="Submit" />
    </form></center>

<% }


            username = null;
            password = null;


%>
<jsp:include page="includes/pageBtm.jsp" />