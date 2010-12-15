<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value="<title>SSO - Scratch Codes</title>" />
</jsp:include>

<%@page contentType="text/html" %>
<%@ page import="java.io.*,java.util.*" %>

<jsp:useBean id="scratchAuth" class="auth.scratch.scratchauth" scope="request">
    <jsp:setProperty name="scratchAuth" property="*"/>
</jsp:useBean>
<jsp:useBean id="scratchGen" class="auth.scratch.genScratch" scope="request">
    <jsp:setProperty name="scratchGen" property="*"/>
</jsp:useBean>
<%

            String uid = null;
            String access = null;

            String[] codesList = null;

            Enumeration paramNames = session.getAttributeNames();

            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                if (paramName.equals("uid")) {
                    String paramValue = (String) session.getAttribute(paramName);

                    if (!paramValue.equals(null)) {
                        uid = paramValue;
                    }

                }

                if (paramName.equals("scratch")) {
                    String paramValue = (String) session.getAttribute(paramName);

                    if (paramValue.equals("1")) {
                        access = paramValue;
                    }

                }

            }

            if (uid != null && access.equals("1")) {

                String stillValid = scratchAuth.validCodes(uid);

                boolean genDone = false;

                if (request.getParameter("codes") != null && request.getParameter("codes") != "") {

                    codesList = new String[Integer.parseInt(request.getParameter("codes"))];

                    codesList = scratchGen.generate(Integer.parseInt(request.getParameter("codes")));

                    scratchGen.insertScratch(codesList, Integer.parseInt(uid));

                    genDone = true;

                }

%>



<div id="h2box"><h2>Scratch Codes</h2></div><br />

<% if(!genDone)

    {%>
<div id="txtbox"><h2>Current State</h2>
    <center>Currently valid Scratch codes remaining: <b><% out.print(stillValid);%></b></center>
</div><br />
<% } else { %>

<div id="txtbox"><h2>New Codes</h2>
    <center><b><font color="red">These are your new codes. Copy them securly.</font></b></center><br />
<center>
    
    <% for (int i = 0; i < codesList.length; i++) {
            System.out.print("<code>" + codesList[i] + "</code><br/>");
            out.println("<code>");
            out.println(codesList[i]);
            out.println("</code><br/>");
        } %>
    
    </center>
        <p>
        <a href="scratch.jsp" class="button">Done</a></p><br />
</div><br />

<% }  %>

<div id="txtbox"><h2>Reset Scratch Codes</h2>
    <p>To regenerate your Scratch Codes enter the number to generate and click generate<br/> </p><p><b><font color="red">WARNING: This will invalidate all currently active codes.</font></b></p>
    <form action="scratch.jsp" method="POST">
        <br />
        Number of Codes: <input id="focus" type="text" name="codes" maxlength="2" size="2" />
        <br />
        <br />
        <input type="submit" value="Generate" />
    </form>
</div>

<%                      } else {

%>

<div id="error"><img src="img/warning.gif"><br />You do not have permission to view this page.</div>
    <%            }

    %>

<jsp:include page="includes/pageBtm.jsp" />