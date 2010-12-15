<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value="<title>SSO - TOTP</title>" />
</jsp:include>

<%@page contentType="text/html" %>
<%@ page import="java.io.*,java.util.*" %>

<%

            String uid = null;
            String access = null;

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

            }

            if (uid != null && access.equals("1")) {

%>




Welcome


<%                      } else {

%>

<div id="error"><img src="img/warning.gif"><br />You do not have permission to view this page.</div>
    <%            }

    %>

<jsp:include page="includes/pageBtm.jsp" />