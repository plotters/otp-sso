# TODO and Features #

## Current Features ##

  * Authenticates using locally stored Yubikey AES secrets
  * Authenticates using securly generated Scratch Codes
  * Authenticates using TOTP codes generated from RFC and using Google Authenticator
  * Provides a http basic auth interface
  * Can be integrated with FreeRadius using PAM

  * A SAML interface for Google Apps authentication


## Currently Working On ##

  * A web interface to reset and control features
  * Optional prefix's for yubikey auth

## Partly Implemented ##

  * FreeRadius integration - DB's have been merged, and config files provided for static passwords with fall though the pam, but need to find a nicer way of handling it.

## Future / Considered / Need help with ##

  * LDAP Integration... this is something that would be cool to include, but I am happy with just radius at the moment.