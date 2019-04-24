#!/bin/bash

set -e
set -u


while getopts "f:o:r:t:" OPTION; do
  case $OPTION in
    f )
      DEFINITION_FILE=$OPTARG
      ;;
    o )
      SIF_FILE=$OPTARG
      ;;
    r )
      REGISTRY=$OPTARG
      ;;
    t ) # process option image:tag
      IMAGE=$OPTARG
      ;;
    ? ) 
        echo "Usage: build.sh -f <DEFINITION> -o <SIF>  -r <REGISTRY> -t <IMAGE>" >&2
        exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

#ACR Populates the docker config for you if you have authentication enabled.
export SINGULARITY_DOCKER_USERNAME=$(cat ~/.docker/config.json | jq -r  '.auths."$REGISTRY".auth' | base64 -d -)
export SINGULARITY_DOCKER_PASSWORD=$(cat ~/.docker/config.json | jq -r  '.auths."$REGISTRY".identitytoken')

if [ -z "$SINGULARITY_DOCKER_USERNAME" ]
    then
       echo ERR: SINGULARITY_DOCKER_USERNAME not set. 
fi

if [ -z "$SINGULARITY_DOCKER_PASSWORD" ]
    then
       echo ERR: SINGULARITY_DOCKER_PASSWORD not set. 
fi



echo "Building DEF: $DEFINITION_FILE"
echo "Output SIF: $SIF_FILE"

singularity build $SIF_FILE $DEFINITION_FILE


FULL_IMAGE_NAME="oras://$REGISTRY/$IMAGE"

echo "Pushing image : $FULL_IMAGE_NAME"
singularity push $SIF_FILE $FULL_IMAGE_NAME
