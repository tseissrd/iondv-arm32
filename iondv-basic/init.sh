#!/bin/bash
dirList=`ls ./applications/`
echo "Init app $1"
export NODE_PATH=`pwd`
for appName in ${dirList[@]}; do
  echo "Init app $appName"
  if [ -d "./applications/$appName/meta" ]; then
    node bin/import --src ./applications/$appName --ns $appName
  fi
  if [ -d "./applications/$appName/data" ]; then
    node bin/import-data --src ./applications/$appName/data --ns $appName
  fi
done

node bin/adduser --name demo --pwd ion-demo
node bin/acl --u demo@local --role admin --p full
node bin/www
