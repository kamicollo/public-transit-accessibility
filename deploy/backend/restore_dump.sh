#create the database anyway
createdb --owner=postgres main

if [ "$DO_RESTORE" = true ] ; then \
    echo "restoring from dump..." \
    && psql -c "CREATE DATABASE main;" \
    && psql -U postgres -d main < /data/main.sql \
    ; \
    else \
    echo "not restoring from dump" \
    ; \
    fi