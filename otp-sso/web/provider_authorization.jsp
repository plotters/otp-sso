<jsp:useBean id="idHandler" class="auth.login" scope="request">
    <jsp:setProperty name="idHandler" property="*"/>
</jsp:useBean>


<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value="<title>SSO OpenID</title>" />
</jsp:include>

<%@ page import="java.util.List, org.openid4java.message.AuthSuccess, org.openid4java.server.InMemoryServerAssociationStore, org.openid4java.message.DirectError,org.openid4java.message.Message,org.openid4java.message.ParameterList, org.openid4java.discovery.Identifier, org.openid4java.discovery.DiscoveryInformation, org.openid4java.message.ax.FetchRequest, org.openid4java.message.ax.FetchResponse, org.openid4java.message.ax.AxMessage,  org.openid4java.message.*, org.openid4java.OpenIDException, java.util.List, java.io.IOException, javax.servlet.http.HttpSession, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.openid4java.server.ServerManager, org.openid4java.consumer.InMemoryConsumerAssociationStore, org.openid4java.consumer.VerificationResult" %>

<%@ page import="java.io.*,java.util.*" %>
<%@page contentType="text/html" %>




<%

            ParameterList requestp = (ParameterList) session.getAttribute("parameterlist");
            String openidrealm = requestp.hasParameter("openid.realm") ? requestp.getParameterValue("openid.realm") : null;
            String openidreturnto = requestp.hasParameter("openid.return_to") ? requestp.getParameterValue("openid.return_to") : null;
            String openidclaimedid = requestp.hasParameter("openid.claimed_id") ? requestp.getParameterValue("openid.claimed_id") : null;
            String openididentity = requestp.hasParameter("openid.identity") ? requestp.getParameterValue("openid.identity") : null;


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

                        session.setAttribute("authenticatedAndApproved", Boolean.TRUE);
                        response.sendRedirect("provider.jsp?_action=complete");

                         String site=(String) (openidrealm == null ? openidreturnto : openidrealm);
%>

<strong>ClaimedID:</strong> <pre><%= openidclaimedid%></pre><br>
<strong>Identity:</strong> <pre><%= openididentity%> </pre><br>
<strong>Site:</strong> <pre> <%= site %></pre><br>

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
window.location = "../provider_authorization.jsp"
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

<div id="login"><form action="provider_authorization.jsp" method="POST">
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