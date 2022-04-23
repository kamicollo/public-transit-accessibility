# COLOR UTILS
COLOR_NC='\033[0m'
COLOR_BLACK='\033[0;30m'
COLOR_GRAY='\033[1;30m'
COLOR_RED='\033[0;31m'
COLOR_LIGHT_RED='\033[1;31m'
COLOR_GREEN='\033[0;32m'
COLOR_LIGHT_GREEN='\033[1;32m'
COLOR_BROWN='\033[0;33m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_LIGHT_BLUE='\033[1;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_LIGHT_PURPLE='\033[1;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHT_CYAN='\033[1;36m'
COLOR_LIGHT_GRAY='\033[0;37m'
COLOR_WHITE='\033[1;37m'

# PATHS
CURRENT_PATH=`pwd`
CONFIG_PATH="$CURRENT_PATH/config"
BE_CONFIG_PATH="/code/config"
NGINX_CONFIG_PATH="/etc/nginx/nginx.conf"
NETWORK_NAME="cse6242"

# CREATE NETWORK
docker network inspect $NETWORK_NAME >/dev/null 2>&1 || \
    docker network create --driver bridge $NETWORK_NAME

mode=$1 # first argument, run like 'bash kickstart.sh fast'

if [ "$mode" = "fast" ]; then
    # RUN postgres
    docker run -d --network=$NETWORK_NAME --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=ThisisADockerPassword pta-postgres-full
    # RUN prepackaged version of OTP Server
    #docker run -d --network=$NETWORK_NAME --name otp -p 8062:8062 pta-otp-packaged
elif [ "$mode" = "complete" ]; then
    #OTP and postgress should be running already - only inform the user
    printf "${COLOR_LIGHT_RED}This script assumes that pta-otp-complete and pta-postgres-empty are already running. Restart them manually if previously they were stopped${COLOR_NC}"
else
    # Exit with a notification
    printf "${COLOR_LIGHT_RED}Unknown mode - run with parameter 'fast' or 'complete' (e.g. ./kickstart.sh 'fast')${COLOR_NC}"
fi

# RUN BE SERVER AND FE SERVER
docker run -d --network=$NETWORK_NAME --name be -v "$CONFIG_PATH:$BE_CONFIG_PATH" pta-be
docker run -d --network=$NETWORK_NAME --name fe -p 80:80 -v "$CONFIG_PATH/nginx.conf:$NGINX_CONFIG_PATH" pta-fe