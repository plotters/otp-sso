<jsp:useBean id="idHandler" class="auth.login" scope="request">
    <jsp:setProperty name="idHandler" property="*"/>
</jsp:useBean>


<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value='<title>SSO - Google SAML</title>

               <script language="JavaScript">
               function submit_now(s,r) {
               document.acsForm.SAMLResponse.value=s;
               document.acsForm.RelayState.value=r;
               document.acsForm.submit();
               }
               </script>


               ' />
</jsp:include>


<%@ page import="java.io.*,java.util.*" %>
<%@page contentType="text/html" %>


<%@ page import="util.RequestUtil" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.net.URLEncoder" %>

<%  response.setContentType("text/html");%>



<%
            String samlRequest = request.getParameter("SAMLRequest");
            String domainName = "ris-net.net";
            String username = request.getParameter("username");


            //If SAML parameters still null, then authnRequest has not yet been
            //received by the Identity Provider, so user should not be logged in.
            if (samlRequest == null) {
%>

<div id="error">
    <img src="img/warning.gif"><br />
    Note: The user cannot be authenticated, and a SAML response cannot be
    sent, until a SAML request is received from the service provider.
</div>
<%      } else {

                String error = (String) request.getAttribute("error");
                if (error != null) {
%>
<p><%= error%><p>
    <%
                    }
                    String issueInstant = (String) request.getAttribute("issueInstant");
                    String providerName = (String) request.getAttribute("providerName");
                    String acsURL = (String) request.getAttribute("acsURL");
                    String relayState = (String) request.getAttribute("relayStateURL");
    %>
<form name="IdentityProviderForm" action="ProcessResponseServlet" method="post" id="loginpost">
    <input type="hidden" name="SAMLRequest" value="<%=samlRequest%>"/>
    <input type="hidden" name="RelayState" value="<%=RequestUtil.htmlEncode(relayState)%>"/>
    <input type="hidden" name="returnPage" value="googleSaml.jsp" />


    <input type="hidden" name="samlAction" value="Generate SAML Response">

    <div id="h2box"><h2>Google Apps Login</h2></div><br />

    <% Enumeration paramNames = session.getAttributeNames();

                    boolean authed = false;

                    while (paramNames.hasMoreElements()) {
                        String paramName = (String) paramNames.nextElement();
                        if (paramName.equals("uid")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (!paramValue.equals(null)) {

                                authed = true;
    %>


    <div id="error"><font align="left">Logging you into Google now...</font></div>
    <br />
    <%
                            }

                        }
                    }

                    if (authed) {%>
                    <div id="login">
                    <input type="hidden" name="authed" value="yes" />
                    <input type="hidden" name="username" value="<% out.print(session.getAttribute("username")); %>" />
                    <input type="hidden" name="password" value="yes" />


                    <%
                   } else {
                    %><input type="hidden" name="authed" value="no" />



    <div id="login">
        <br />
        Username: <input id="focus" type="text" name="username" />
        <br />
        <br />
        Password: <input type="password" name="password" />
        <br/>
        <br />

        <%
                   }

    %>

        <input type="submit" name="samlButton" value="Login">
    </div>
    <p><br>
</form>

    <script type="text/javascript">
function myfunc () {
var frm = document.getElementById("loginpost");
frm.submit();
}
window.onload = myfunc;
</script>

    
<%
                String samlResponse = (String) request.getAttribute("samlResponse");
                if (samlResponse != null) {
                    if (username != null) {
%>
<%-- This is a hidden form that POSTs the SAML response to the ACS.--%>
<form name="acsForm" action="<%=acsURL%>" method="post">
    <div style="display: none">
        <textarea rows=10 cols=80 name="SAMLResponse"><%=samlResponse%> </textarea>
        <textarea rows=10 cols=80 name="RelayState"><%=RequestUtil.htmlEncode(relayState)%></textarea>
    </div>
</form>
<%
                        session.setAttribute("username", username);
                        session.setAttribute("uid", idHandler.getUid(username));
                        session.setAttribute("admin", idHandler.getAdmin(username));
                        session.setAttribute("yubi", idHandler.getYubi(username));
                        session.setAttribute("totp", idHandler.getTotp(username));
                        session.setAttribute("scratch", idHandler.getScratch(username));
                        session.setAttribute("wifi", idHandler.getWifi(username));

                    } else {

%>
<p><span style="font-weight:bold;color:red">
        You must enter a valid username and password to log in.
    </span></p>
    <%                }
    %>
<span id="samlResponseDisplay" style="display:inline">
    <!--        <b> Generated and Signed SAML Response </b>
            <p><div class="codediv"><%=RequestUtil.htmlEncode(samlResponse)%></div>
             <center>
              <input type="button"
                     value="Submit SAML Response"
                     onclick="javascript:document.acsForm.submit()">
            </center>-->
    <script>javascript:document.acsForm.submit()</script>
</span>


<%
                }
            }
%>



<jsp:include page="includes/pageBtm.jsp" />