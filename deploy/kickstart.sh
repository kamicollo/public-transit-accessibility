CURRENT_PATH=`pwd`
CONFIG_PATH="$CURRENT_PATH/config"
BE_CONFIG_PATH="/code/config"
NGINX_CONFIG_PATH="/etc/nginx/nginx.conf"
NETWORK_NAME="bridge"

docker run -d --network=bridge --name be -v "$CONFIG_PATH:$BE_CONFIG_PATH" pta-be
docker run -d --network=bridge --name fe -p 80:80 -v "$CONFIG_PATH/nginx.conf:$NGINX_CONFIG_PATH" pta-fe

if [ "$mode" = "fast" ]; then
    # RUN prepackaged version of OTP Server    
    docker run -d --network=bridge --name otp pta-otp-prepackaged
elif [ "$mode" = "complete" ]; then
    # RUN prepackaged version of OTP Server    
    docker run -d --network=bridge --name otp pta-otp-complete
else
    # Exit with a notification
    printf "${COLOR_LIGHT_RED}Unknown mode - run with parameter 'fast' or 'complete' (e.g. ./build.sh 'fast')${COLOR_NC}"
fi