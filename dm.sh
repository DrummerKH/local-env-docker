#!/usr/bin/env bash

COMMAND=$1
MACHINE=$2

docker-machine ${COMMAND} ${MACHINE}

if [ ${COMMAND} = 'start' ]
    then
    eval $(docker-machine env ${MACHINE})
fi