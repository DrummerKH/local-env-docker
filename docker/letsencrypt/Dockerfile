FROM quay.io/letsencrypt/letsencrypt:latest

ENTRYPOINT sleep 6 && certbot certonly --standalone -d dev-new-secure.gdmfx.com --text --agree-tos --email it@gdmfx.com --server https://acme-v01.api.letsencrypt.org/directory --rsa-key-size 4096 --verbose --renew-by-default --standalone-supported-challenges http-01

