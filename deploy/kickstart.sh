CURRENT_PATH=`pwd`
CONFIG_PATH="$CURRENT_PATH/config"
BE_CONFIG_PATH="/code/config"
NGINX_CONFIG_PATH="/etc/nginx/nginx.conf"
NETWORK_NAME="bridge"


docker run -d --network=bridge --name be --add-host=host.docker.internal:host-gateway -v "$CONFIG_PATH:$BE_CONFIG_PATH" pta-be
docker run -d --network=bridge --name fe -p 80:80 -v "$CONFIG_PATH/nginx.conf:$NGINX_CONFIG_PATH" pta-fe