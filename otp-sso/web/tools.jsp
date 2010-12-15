<jsp:include page="includes/pageTop.jsp" >
    <jsp:param name="header" value="<title>SSO - Tools</title>" />
</jsp:include>

<%@page contentType="text/html" %>


<div id="h2box"><h2>Tools</h2></div><br />

<div id="txtbox"><h2>Wifi Tool</h2><p>
In order to correctly use the wifi service with OTP's, you will need this tool.</p>
    <p>
<a href="../tools/wifi.exe" class="button">Download</a></p><br />
</div>
<br />
<div id="txtbox"><h2>Google Authenticator</h2><p>
In order to use TOTP, you will need Google Authenticator. You can get it for Android:</p> <p><img src="img/andoridGa.png"></p>
    <p>
<a href="http://code.google.com/p/google-authenticator/" class="button">Read More</a></p><br />
    <p>
Or for iPhone:</p>
    <p>
<a href="http://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8#" class="button">Read More</a></p><br />
</div>

<jsp:include page="includes/pageBtm.jsp" />