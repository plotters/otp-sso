<%-- 
    Document   : nav
    Created on : 13/12/2010, 8:55:13 PM
    Author     : jake
--%>
<%@ page import="java.io.*,java.util.*" %>
<%@page contentType="text/html" %>

<div id="nav">

    <ul>
        <% Enumeration paramNames = session.getAttributeNames();

                    while (paramNames.hasMoreElements()) {
                        String paramName = (String) paramNames.nextElement();
                        if (paramName.equals("username")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (!paramValue.equals(null)) {
        %> <li><a href="login.jsp?lo=true">Logout</a></li> <%;
                                            }
                                        }
                                    }%>

    </ul>

</div>

