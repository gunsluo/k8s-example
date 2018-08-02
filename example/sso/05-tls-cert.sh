#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout dex.key -out dex.crt -subj "/CN=dex.sso/O=dex.sso"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout demo-login.key -out demo-login.crt -subj "/CN=demo-login.sso/O=demo-login.sso"

# kubectl create secret tls dex-secret --key dex.key --cert dex.crt
# kubectl create secret tls demo-login-secret --key demo-login.key --cert demo-login.crt

cat dex.key | base64
cat dex.crt | base64

cat demo-login.key | base64
cat demo-login.crt | base64
