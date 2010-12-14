<%-- 
    Document   : nav
    Created on : 13/12/2010, 8:55:13 PM
    Author     : jake
--%>
<%@ page import="java.io.*,java.util.*" %>
<%@page contentType="text/html" %>

<div id="nav">

    <ul>
         <li><a href="index.jsp">Home</a></li>
         <li><a href="https://www.google.com/a/ris-net.net/ServiceLogin?continue=http://partnerpage.google.com/ris-net.net&followup=http://partnerpage.google.com/ris-net.net&service=ig&passive=true&cd=US&hl=en&nui=1&ltmpl=default">Google SSO</a></li>
       <li><a href="tools.jsp">Tools</a></li>

         <% Enumeration paramNames = session.getAttributeNames();

                    while (paramNames.hasMoreElements()) {
                        String paramName = (String) paramNames.nextElement();
                        if (paramName.equals("uid")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (!paramValue.equals(null)) {
        %> <li><a href="index.jsp?lo=true">Logout</a></li> <%;
                                            }
                                        }
                                    }%>

    </ul>

</div>

