#!/bin/bash

BASE_PATH=/oracle/Middleware/SSL

FQDN=$1
ORG=$2

CERT_PATH=$BASE_PATH/$FQDN

mkdir -p $CERT_PATH
cd $CERT_PATH

# Generate Keystore
keytool -genkey -keystore $CERT_PATH/$FQDN.jks -alias $FQDN -dname "CN=$FQDN, OU=IT, O=$ORG, L=MUM, ST=MH, C=IN"
-storetype JKS -storepass idfc1234 -keyalg RSA -sigalg SHA256withRSA -validity 365 -keysize 2048 -ext SAN="dns:$FQDN"

# Generate CSR
keytool -certreq -file $CERT_PATH/$FQDN.csr.txt -keystore $CERT_PATH/$FQDN.jks -alias $FQDN -ext SAN=dns:$FQDN -storepass idfc1234

# Convert JKS to PFX
keytool -importkeystore -srckeystore $CERT_PATH/$FQDN.jks -srcstoretype JKS -srcstorepass idfc1234 -destkeystore $CERT_PATH/$FQDN.pfx -deststoretype PKCS12 -deststorepass idfc1234

# Extract private key
openssl pkcs12 -in $CERT_PATH/$FQDN.pfx -nocerts -nodes -out $CERT_PATH/$FQDN.key.txt -passin pass:idfc1234

# Convert key format
openssl rsa -in $CERT_PATH/$FQDN.key.txt -out $CERT_PATH/${FQDN}_WP.key.txt

echo "All certificate files created under $CERT_PATH"

# RUN WITH ./create-csr.sh atmservice.idfcbank.com IDFCBANK