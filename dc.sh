#!/usr/bin/env bash

PROJECT=$1
COMMAND=$2
ARGUMENTS="${@:3}"
COMPOSE_FILES="-f docker-compose.yml"

# Command that not required specify container name
EXCLUDED_COMMANDS=( stop down )

# Adding docker-compose file of requested project
if [ ! -z ${PROJECT} ]
    then

    if [[ " ${EXCLUDED_COMMANDS[*]} " != *" ${PROJECT} "* ]]; then
        COMPOSE_FILES="$COMPOSE_FILES -f projects/$PROJECT/docker-compose.yml"
        COMPOSE_FILES="$COMPOSE_FILES -f projects/$PROJECT/docker-compose.local.yml"
    fi
fi

# Default container, wil lbe started always
DEFAULT="weave-scope portainer"

# Adding related services projects to gtr-crm project, it requires
if [ ${PROJECT} = 'gtr-crm' ]
    then
    PROJECT="$PROJECT nginx-1.10 postgres-9.5"
fi

if [ ${PROJECT} = 'gtr-crm-front' ]
    then
    COMPOSE_FILES="$COMPOSE_FILES -f projects/gtr-crm-api/docker-compose.yml"
    COMPOSE_FILES="$COMPOSE_FILES -f projects/gtr-crm-api/docker-compose.local.yml"

    PROJECT="$PROJECT gtr-crm-api postgres-9.5 nginx-1.10"
fi

if [ ${PROJECT} = 'gtr-crm-api' ]
    then
    PROJECT="$PROJECT nginx-1.10 postgres-9.5 rabbitmq"
fi

if [ ${PROJECT} = 'crm.gdmfx.com' ]
    then
    PROJECT="$PROJECT nginx-1.10 postgres-9.5 mysql-5.6"
fi

if [ ${PROJECT} = 'migrations' ]
    then
    PROJECT="$PROJECT postgres-9.5"
fi

if [ ${PROJECT} = 'gdm-replicator' ]
    then
    PROJECT="$PROJECT postgres-9.5 mysql-5.6 rabbitmq"
fi

if [ ${PROJECT} = 'comm.calculation' ]
    then
    PROJECT="$PROJECT postgres-9.5 rabbitmq"
fi

if [ ${PROJECT} = 'secure.gdmfx.com' ]
    then
    PROJECT="$PROJECT postgres-9.5 mysql-5.6 rabbitmq nginx-1.10"
fi

if [ ${PROJECT} = 'api-v2.gdmfx.com' ]
    then
    PROJECT="$PROJECT postgres-9.5 rabbitmq nginx-1.10"
fi

if [ ${PROJECT} = 'api-v1.gdmfx.com' ]
    then
    PROJECT="$PROJECT postgres-9.5 nginx-1.10 mysql-5.6 rabbitmq"
fi

if [ ${PROJECT} = 'api.gdmfx.com' ]
    then
    PROJECT="$PROJECT postgres-9.5 nginx-1.10 mysql-5.6"
fi

if [ ${PROJECT} = 'contest.gdmfx.com' ]
    then
    PROJECT="$PROJECT nginx-1.10"
fi

PROJECT="$PROJECT $DEFAULT"

# Check if command is not require specify container name
if [[ " ${EXCLUDED_COMMANDS[*]} " == *" ${COMMAND} "* ]]
    then
    PROJECT=''
fi

echo "Command: docker-compose -p docker ${COMPOSE_FILES} ${COMMAND} ${ARGUMENTS} ${PROJECT}"

docker-compose -p docker ${COMPOSE_FILES} ${COMMAND} ${ARGUMENTS} ${PROJECT}