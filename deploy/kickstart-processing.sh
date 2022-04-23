CURRENT_PATH=`pwd`
CONFIG_PATH="$CURRENT_PATH/config"
BE_CONFIG_PATH="/code/config"

NETWORK_NAME="cse6242"

# CREATE NETWORK
docker network inspect $NETWORK_NAME >/dev/null 2>&1 || \
    docker network create --driver bridge $NETWORK_NAME

docker container rm -f otp
docker container rm -f db

# RUN OTP, database and analysis containers
docker run -d --network=$NETWORK_NAME --name db -p 5432:5432 -e POSTGRES_PASSWORD=ThisisADockerPassword pta-postgres-empty
docker run -d --network=$NETWORK_NAME --name otp -p 8062:8062 pta-otp-complete

source ./kickstart-jupyter.sh


