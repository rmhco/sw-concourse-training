#!/usr/bin/env bash
set -x
#For the purpose of this tutorial, there are credentials being commited here.
#This is on purpose and will be covered in the security tutorial.
#The director is expected to be secured and only locally available for this lab session
#But this does not demonostrate a best practice

export CA_CERT_URL=https://s3.us-east-2.amazonaws.com/dg-training-concourse/training-bosh.pem
export BOSH_CLIENT=$(bosh int ~/creds.yml --path /username)
export BOSH_CLIENT_SECRET=$(bosh int ~/creds.yml --path /admin_password)
export BOSH_DEPLOYMENT=rmhco-nginx
export BOSH_DIRECTOR='https://10.4.1.4:25555'
export BOSH_ENVIRONMENT='training'
export BOSH_CLIENT=admin

cd source-code/nginx_release

curl -LO ${CA_CERT_URL}
bosh alias-env ${BOSH_ENVIRONMENT} --ca-cert training-bosh.pem -e ${BOSH_DIRECTOR}

bosh login

bosh upload-release releases/release.gz
