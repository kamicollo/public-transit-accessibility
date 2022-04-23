CURRENT_PATH=`pwd`
CONFIG_PATH="$CURRENT_PATH/config"
BE_CONFIG_PATH="/code/config"

NETWORK_NAME="cse6242"

# CREATE NETWORK
docker network inspect $NETWORK_NAME >/dev/null 2>&1 || \
    docker network create --driver bridge $NETWORK_NAME


docker container rm -f jupyter

# RUN OTP, database and analysis containers
docker run -d --network=$NETWORK_NAME --name jupyter -p 8888:8888 -v "$CONFIG_PATH:$BE_CONFIG_PATH" pta-jupyter

