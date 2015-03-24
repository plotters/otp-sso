# SQL Details #

Details of the sql server are specified in the authDbSecrets.java file in the auth package. This will need to be recompiled for any modifications.

## Basic Details ##

The software uses a single MySQL database. This includes all information for freeradius as well otp-sso.
The SQL file can be located in the svn repo, un the trunk/otp-sso/src directory called auth.sql.

## Tables ##

These tables are used for the otp-sso package:

  * authScratch - contains scratch codes
  * authTotp - contains the TOTP secret and prefix
  * authUsers - List of users and what verification means they can use
  * authYubi - contains details of the yubikey auth, namly the token ID.

These tables are used by the yubi j server, refer to their documentation for more details.

  * clients - client details (only require one client - staticly created at this stage)
  * perms - permission of the client (staticly set at this stage)
  * yubikeys - Yubikey secrets encoded.

These tables are used for the freeradius server, refer to there documentation for more details.

  * radacct
  * radcheck
  * radgroupcheck
  * radgroupreply
  * radpostauth
  * radreply
  * radusergroup