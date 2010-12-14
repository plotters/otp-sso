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
                        
                        %> 
                        
<div id="h2box"><h2>Welcome <% out.print(session.getAttribute("username")); %></h2></div><br />

<div id="txtbox"><h2>News</h2><p>
This tool is still very much in beta... still getting it running and adding features.</p>
    <p>
</div>
<br />
<div id="txtbox"><h2>Common Tasks</h2>
   <br /><p>
<a href="http://start.ris-net.net" class="button">Start RIS-NET</a>
   <a href="http://www.ris-net.net" class="button">RIS-NET Home</a>
<a href="http://start.here" class="button">Start.Here</a>
<a href="http://wiki.local" class="button">Wiki.Local</a>
   </p><br />
</div>

                        <%


                    }
                }
            }


            if (username != null && password != null) {

                if (idHandler.authenticate(username, password)) {
                    out.print("Password good");

                    loginBox = false;

                    session.setAttribute("username", username);
                    session.setAttribute("uid", idHandler.getUid(username));
                    session.setAttribute("admin", idHandler.getAdmin(username));
                    session.setAttribute("yubi", idHandler.getYubi(username));
                    session.setAttribute("totp", idHandler.getTotp(username));
                    session.setAttribute("scratch", idHandler.getScratch(username));
                    session.setAttribute("wifi", idHandler.getWifi(username));


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

<div id="h2box"><h2>RIS-NET Login</h2></div><br />

<div id="login"><form action="index.jsp" method="POST">
        <br />
        Username: <input id="focus" type="text" name="username" />
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