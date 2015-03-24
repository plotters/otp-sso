NEWS
  * This now supports Google Apps SSO / SAML

The aim of this project is to create a web application that can auth users using Yubikeys, TOTP and/or Scratch codes. The system can be intergrated using PAM and/or Radius into existing systems. The system will not use multi password challanges, rather it will use a standard password prefixed or postfixed with the OTP - this is to enable compatability with existing systems.

This is a work in progess, and something I am working on in my spare time. It current implements a version of yubico's J server, TOTP's from the RFC, as well as 32 char scratch codes. I am currently using the system (through http auth pam and Radius) to authenticate windows and linux systems, wireless network users (eap-ttls-pap) <strike>and soon my google apps account though SAML.</strike>

I am licencing my code under LGPL, however this system uses code from a number of other licences (Apache, GPL, Creative Commons). These licence take precedence for the particular modules. I am no expert when it comes to licencing, so if I have missed a licence out of any part, or made a mistake let me know and I will fix it up.

I am also looking for other co-developers, so if your interested drop me an email or leave a message.

The code is in a semi working state (it is in use on my lab network), but should in no means be considered secure at this moment. This has been built using netbeans and implemented using glassfish.