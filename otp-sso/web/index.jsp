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
                    session.setAttribute("uid", idHandler.getUid(username));

%> <script type="text/javascript">
    <!--
    window.location = "../index.jsp"
    //-->
</script> <%

                } else {

%><div id="error"><img src="img/warning.gif"><br />Incorrect username or password</div><br /><%

                                        username = null;
                                        password = null;
                                    }

                                }

                                if (loginBox) {%>
<div id="login"><form action="index.jsp" method="POST">
        <br />
        Username: <input type="text" name="username" />
        <br />
        <br />
        Password: <input type="password" name="password" />
        <br/>
        <br />
        <input type="submit" value="Login" />
    </form></div>

<% }


            username = null;
            password = null;


%>
<jsp:include page="includes/pageBtm.jsp" />