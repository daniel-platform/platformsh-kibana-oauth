# Kibana with Oauth

## Setup

After deploying your project you'll need to SSH in and create a configuration file under `config/oauth2_proxy.cfg`

```
client_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
client_secret = "XXXXXXXX"
email_domains = [
     "domain.tld"
]
```

Fill in the values as needed.

## Kown Issues

If child processes die, they won't be restarted.  You'll need to do a redeploy.
