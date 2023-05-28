# RabbitMQ apt Mirror Docker Image

This `Dockerfile` serves as a base for images that can serve as [Team RabbitMQ's apt repository](https://rabbitmq.com/install-debian.html).

## What is Provided

The image pre-configures:

 * The packages necessary to run an apt repository mirror
 * A list of apt mirrors
 * An Nginx server definition

## What is Required from Deriving Images

Some things must be provided at build time:

 * `--build-arg TARGET_HOSTNAME=ppa.eng.megacorp.com` to specify a hostname. It will be used in the Nginx server definition
   as well as the certificate and private key filenames

Others should be provided by a deriving image:

 * A TLS (x.509, HTTPS) certificate pair at `/etc/ssl/certs/${TARGET_HOSTNAME}.pem` and `/etc/ssl/private/${TARGET_HOSTNAME}.key`
 * A `crontab` or any other automation that runs `apt-mirror` to perform package sync

## Deploying

This is just a Docker image. It can be deployed however you like.
