OIDC_HOST='host.docker.internal'
openssl req -x509\
  -out    kc_temp.crt \
  -keyout kc_temp.key \
  -newkey rsa:2048 -nodes -sha256                     \
  -subj '/CN='${OIDC_HOST} -extensions EXT -config <( \
   printf "[dn]\nCN=${OIDC_HOST}\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:${OIDC_HOST}\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
mv ./kc_temp.crt ./docker/build-context/ssl/kc_temp.crt
mv ./kc_temp.key ./docker/build-context/ssl/kc_temp.key
