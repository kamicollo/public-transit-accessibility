# Specify base image
FROM postgis/postgis:latest

# Specify static vars
ENV URL_DUMP=https://aurimasazure.blob.core.windows.net/cse6242/main.sql.gz

# Install necessary packages
RUN apt-get update && apt-get install -y wget

# Specify argument to check if we need to restore DB from backup
ARG do_restore=true
ENV DO_RESTORE=$do_restore

# Get data
RUN if [ "$DO_RESTORE" = true ] ; then mkdir /data && wget -P /data ${URL_DUMP} && cd /data && gunzip main.sql.gz ; fi
COPY restore_dump.sh /docker-entrypoint-initdb.d/