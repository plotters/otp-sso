<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value="<title>SSO - TOTP</title>" />
</jsp:include>

<%@page contentType="text/html" %>
<%@ page import="java.io.*,java.util.*" %>

<jsp:useBean id="totpAuth" class="auth.totp.totpauth" scope="request">
    <jsp:setProperty name="totpAuth" property="*"/>
</jsp:useBean>

<%

            String uid = null;
            String access = null;
            String username = null;

            Enumeration paramNames = session.getAttributeNames();

            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                if (paramName.equals("uid")) {
                    String paramValue = (String) session.getAttribute(paramName);

                    if (!paramValue.equals(null)) {
                        uid = paramValue;
                    }

                }

                if (paramName.equals("totp")) {
                    String paramValue = (String) session.getAttribute(paramName);

                    if (paramValue.equals("1")) {
                        access = paramValue;
                    }

                }

                if (paramName.equals("username")) {
                    String paramValue = (String) session.getAttribute(paramName);

                    if (!paramValue.equals(null)) {
                        username = paramValue;
                    }

                }


            }

            if (uid != null && access.equals("1")) {

                boolean prefixError = false;
                boolean prefixChange = false;

                if (request.getParameter("pass1") != null && request.getParameter("pass2") != null) {
                    if (request.getParameter("pass1") != "" && request.getParameter("pass2") != "") {
                        if (request.getParameter("pass1").equals(request.getParameter("pass2"))) {
                            if (request.getParameter("pass1").length()<3)
                                {
                                prefixError = true;
                                }
                            else
                                {
                                prefixChange = true;
                            totpAuth.newPrefix(uid, request.getParameter("pass1"));
                                }
                            

                        }else{prefixError = true;}

                    }
                }



%>


<div id="h2box"><h2>TOTP Settings</h2></div><br />

<div id="txtbox"><h2>Current QR Code / TOTP Secret</h2>
    <p>Your current secret is: <b><% out.print(totpAuth.getSecret(uid));%></b></p>
    <p><center><img src="http://chart.apis.google.com/chart?cht=qr&chs=230x230&chl=otpauth%3A%2F%2Ftotp%2F<% out.print(username);%>%40auth.ris-net.net%3Fsecret%3D<% out.print(totpAuth.getSecret(uid));%>"></center></p>
</div><br />

<% if(prefixError){ %>

<div id="error"><img src="img/warning.gif"><br />Prefix's are not the same or to short.</div><br />
<% } %>

<% if(prefixChange){ %>

<div id="txtbox"><center><img src="img/warning.gif"><br /><b>Prefix has been changed</b></center></div><br />
<% } %>

<div id="txtbox"><h2>Reset Prefix Password</h2>
    <p>To reset your TOTP Prefix please enter it bellow. Ensure that this is at least 3 chars long.</p>
    <form action="totp.jsp" method="POST">
        <br />
        Prefix: <input id="focus" type="password" name="pass1" />
        <br />
        <br />
        Again: <input type="password" name="pass2" />
        <br/>
        <br />
        <input type="submit" value="Change" />
    </form>
</div><br />

<div id="txtbox"><h2>Reset TOTP Secret</h2>
    <p>To regenerate your TOTP Secret click the generate link.<br/> </p><p><b><font color="red">WARNING: You will need to reset all your authenticator devices with this new code</font></b></p>
    <p>
        <a href="totp.jsp?totprst=true" class="button">Generate</a></p><br />
</div>


<%                      } else {

%>

<div id="error"><img src="img/warning.gif"><br />You do not have permission to view this page.</div>
    <%            }

    %>

<jsp:include page="includes/pageBtm.jsp" />