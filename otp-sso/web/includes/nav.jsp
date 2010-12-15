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
                                                if (paramName.equals("admin")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (paramValue.equals("1")) {
        %> <li><a href="admin.jsp">Admin</a></li> <%;
                                            }
                                        }

                                    }


         paramNames = session.getAttributeNames();

                    while (paramNames.hasMoreElements()) {
                        String paramName = (String) paramNames.nextElement();

                        if (paramName.equals("yubi")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (paramValue.equals("1")) {
        %> <li><a href="yubi.jsp">Yubikey</a></li> <%;
                                            }
                                        }
                        if (paramName.equals("totp")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (paramValue.equals("1")) {
        %> <li><a href="totp.jsp">TOTP</a></li> <%;
                                            }
                                        }
                        if (paramName.equals("scratch")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (paramValue.equals("1")) {
        %> <li><a href="scratch.jsp">Scratch</a></li> <%;
                                            }
                                        }
                       if (paramName.equals("wifi")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (paramValue.equals("1")) {
        %> <li><a href="wifi.jsp">Wifi</a></li> <%;
                                            }
                                        }

                                    }


paramNames = session.getAttributeNames();

                    while (paramNames.hasMoreElements()) {
                        String paramName = (String) paramNames.nextElement();
                        if (paramName.equals("uid")) {
                            String paramValue = (String) session.getAttribute(paramName);

                            if (!paramValue.equals(null)) {
        %> <li><a href="index.jsp?lo=true">Logout</a></li> <%;
                                            }
                                        }

                                    }


        %>

    </ul>

</div>

