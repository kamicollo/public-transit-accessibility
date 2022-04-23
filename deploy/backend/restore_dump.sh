

if [ "$DO_RESTORE" = true ] ; then \
    echo "restoring from dump..." \
    && psql -c "CREATE DATABASE main;" \
    && psql -U postgres -d main < /data/main.sql \
    ; \
    else \
    echo "not restoring from dump" \
    && createdb --owner=postgres main \
    ; \
    fi