Initially the setup is at http://guard.server.example.com:3000 , after the setup the port wont work so remove it from the compose file.


For support to DOH to adguard follow below steps:

edit /opt/adguardhome/conf/AdGuardHome.yaml, make sure these values are same

trusted_proxies:
  - 172.16.0.0/12

tls:
  enabled: true
  allow_unencrypted_doh: true
