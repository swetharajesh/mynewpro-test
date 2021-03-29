#!/bin/sh

echo 'Start Docker';
nohup sh -c 'dockerd' & sleep 1;

echo 'Pulling image to scan:';
docker pull "docker-production.cernerrepos.net/${IMAGE}";

docker images

echo 'Generating TLOCK Token';
TLOCK_TKN=$(curl -ks \
  -H 'Content-Type: application/json' \
  -d "{\"username\":\"${USERNAME}\",\"password\":\"${PASSWORD}\"}" \
  "${TLOCK_URL}/api/v1/authenticate" | jq --raw-output '.token');

echo "Performing CLI Scan on image $IMAGE";

./twistcli images scan \
  --address "${TLOCK_URL}" \
  --token "${TLOCK_TKN}" \
  --details --publish \
  ${IMAGE};
