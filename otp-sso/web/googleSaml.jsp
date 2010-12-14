<jsp:useBean id="idHandler" class="auth.login" scope="request">
    <jsp:setProperty name="idHandler" property="*"/>
</jsp:useBean>


<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value='<title>Google SSO SAML</title>

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

<%  response.setContentType("text/html"); %>



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
<p><font color="red"><b><%= error%></b></font><p>
    <%
            }
            String issueInstant = (String) request.getAttribute("issueInstant");
            String providerName = (String) request.getAttribute("providerName");
            String acsURL = (String) request.getAttribute("acsURL");
            String relayState = (String) request.getAttribute("relayStateURL");
    %>
<form name="IdentityProviderForm" action="ProcessResponseServlet" method="post">
    <input type="hidden" name="SAMLRequest" value="<%=samlRequest%>"/>
    <input type="hidden" name="RelayState" value="<%=RequestUtil.htmlEncode(relayState)%>"/>
    <input type="hidden" name="returnPage" value="googleSaml.jsp">
    <input type="hidden" name="samlAction" value="Generate SAML Response">

    <div id="h2box"><h2>Google Apps Login</h2></div><br />

    <div id="login">
         <br />
        Username: <input id="focus" type="text" name="username" />
        <br />
        <br />
        Password: <input type="password" name="password" />
        <br/>
        <br />
        <input type="submit" name="samlButton" value="Login">
    </div>
    <p><br>
</form>
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