#Development environment with Docker

###Introducing

The docker development environment uses for launch projects that support docker and docker-compose on local machines and
development server.

###Structure of the project
```
docker/ -
        |-docker/         - The directory with common containers like - databases, weave-scope...
        |-projects/       - The directory with projects itself  
        |-tmp/            - The folder with temp objects like logs etc...       
        |-docker.env.dist - File with environment variabels, affect on common containers
        ...
```   
Each project must be cloned to `docker/projects` directory.  Projects must contain at least two docker-compose files:
docker-compose.yml and docker-compose.local.yml. The first one is common docker compose configuration the second is 
related only for local launch.
There are two bash scripts-helpers in the root directory:
- `source dm.sh COMMAND DM_NAME` - Command wrapper of `docker-machine COMMAND DM_NAME` and `eval $(docker-machine env 
DM_NAME)`.
The command start docker machine and init environment variables in current console session. See [docker-machine cli](https://docs.docker.com/machine/reference/). Arguments:
    - `COMMAND` - docker-machine command like start, stop ... (see `man docker-machine`)
    - `DM_NAME` - docker machine name
- `source dc.sh PROJECT_NAME COMMAND ARGUMENTS` - Command wrapper for launch docker-compose with specified docker-compose 
files depends on each project. Arguments
    - `PROJECT_NAME` - the name of the project, must equal to the folder of project inside `docker/projects` directory
    - `COMMAND` - docker-compose command, possible values: `up`, `start`, `stop`, `down` (be careful, `down` commands 
    removes the container and working directory, it can drop database DATA folder forever). See [docker-compose cli](https://docs.docker.com/compose/reference/). With `up` command you can use:
        - `ARGUMENTS` - docker-compose up arguments like `-d`, `--build`. See [docker-compose up](https://docs.docker.com/compose/reference/up/)
    
###Using
For launch the project `foo_project`, you need clone the projects to the `docker/projects` directory and launch
the command `./dc.sh foo_project up`. The command will launch all linked side containers like postgresql, weave-scope 
etc... By default the command hold the console and show the logs of launched containers. If you don\`t want the command 
hold the console - specify `-d` option.
The `--build` option needs only if someone or you change the files related to docker containers. This option rebuild 
the containers from scratch depends on Dockerfiles. 

###Contains
The containers that inside the default docker-compose file:
- weave-scope, default port 4040. The viewer of docker containers. See [weave-scope](https://www.weave.works/products/weave-scope/).
- postgresql-9.5, default port 5432. PostgreSQL database v9.5.
- mysql-5.6, default port 3306. MySQL datavase v5.6.
- nginx-1.10, default ports 80, 443. Nginx webserver v1.10. See [nginx](https://nginx.org/en/).
- rabbitmq, default ports 5672, 15671, 15672. RabbitMQ queue manager, latest available version. See [rabbitmq](https://www.rabbitmq.com/).
- pgadmin, default port 5050. Browser based viewer of Postgres databases, latest available version. See [pgadmin](https://www.pgadmin.org/).

###Configuration
All default ports you can replace by own in the `docker.env.dist` file. Just uncomment need config line and set needed port.
