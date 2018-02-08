FROM postgres:9.5

RUN apt-get update && \
    apt-get install -y --force-yes \
        git \
        build-essential \
        postgresql-server-dev-9.5

RUN git clone https://github.com/postgrespro/pg_variables

RUN cd pg_variables && \
        make USE_PGXS=1 && \
        make USE_PGXS=1 install

COPY pg_hba.conf /docker-entrypoint-initdb.d

# Copy pg_hba.conf to PGDATA directory
RUN echo "cp /docker-entrypoint-initdb.d/pg_hba.conf /var/lib/postgresql/data/pgdata/" > /docker-entrypoint-initdb.d/pg_hba.sh