<%@ page import="java.util.*" %>
<jsp:useBean id="idHandler" class="auth.login" scope="request">
<jsp:setProperty name="idHandler" property="*"/>
</jsp:useBean>


<!--String arg1=request.getParameter("username");
String arg2=request.getParameter("password");-->
<!--   if (idHandler.authenticate(arg1,arg2)) {-->



<%

String userID = null;
  String password = null;

      // Assume not valid until proven otherwise

      boolean valid = false;

      // Get the Authorization header, if one was supplied

      String authHeader = request.getHeader("Authorization");
      if (authHeader != null) {
         java.util.StringTokenizer st = new java.util.StringTokenizer(authHeader);
         if (st.hasMoreTokens()) {
            String basic = st.nextToken();

            // We only handle HTTP Basic authentication

            if (basic.equalsIgnoreCase("Basic")) {
               String credentials = st.nextToken();

               // This example uses sun.misc.* classes.
               // You will need to provide your own
               // if you are not comfortable with that.

               sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
               String userPass =
                  new String(decoder.decodeBuffer(credentials));
//               String encoding = new sun.misc.BASE64Encoder().encode (userPassword.getBytes());


               // The decoded string is in the form
               // "userID:password".

               int p = userPass.indexOf(":");
               if (p != -1) {
                  userID = userPass.substring(0, p);
                  password = userPass.substring(p+1);

                  // Validate user ID and password
                  // and set valid true true if valid.
                  // In this example, we simply check
                  // that neither field is blank


                  if (idHandler.authenticate(userID.trim(),password.trim()))
                 {
                     valid = true;
                  }
               }
            }
         }
      }

      // If the user was not validated, fail with a
      // 401 status code (UNAUTHORIZED) and
      // pass back a WWW-Authenticate header for
      // this servlet.
      //
      // Note that this is the normal situation the
      // first time you access the page.  The client
      // web browser will prompt for userID and password
      // and cache them so that it doesn't have to
      // prompt you again.

      if (!valid) {
         String s = "Basic realm=\"RIS-NET SSO\"";
         response.setHeader("WWW-Authenticate", s);
         response.setStatus(401);
      }

      %>

      <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIS-NET SSO - Basic Auth</title>
    </head>
    <body>
    </body>
</html>
