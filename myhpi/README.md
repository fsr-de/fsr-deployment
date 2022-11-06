# myHPI

This is a docker-compose setup for [myHPI](https://github.com/fsr-de/myHPI).

In order to run it, you need to copy the `.env.example `file to `.env` and insert appropriate values. Especially the secret key, the list of admins, the tenca and pretix credentials and the OIDC clients need to be replaced. After starting the service, it can be reached on port 80. SSL setup is not part of this deployment.