#!/usr/bin/env bash

PROJECTS=( gtr-crm )

for project in "${PROJECTS[@]}"
do
  ${project}/docker/entrypoint.sh
done