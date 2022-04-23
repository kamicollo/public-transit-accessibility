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

FE_BUILD_PATH="../frontend/"

FE_SRC_PATH="../frontend/dist/"
BE_SRC_PATH="../backend/"

FE_DST_PATH="./frontend/src"
BE_DST_PATH="./backend/src"

OTP_SRC_PATH="../backend/otp"
OTP_BUILD_PATH="otpserver"

BASE_PATH=`pwd`

# Build Frontend
cd $FE_BUILD_PATH
echo "INTO PATH: $FE_BUILD_PATH"

npm install
npm run build

cd "$BASE_PATH"
echo "INTO PATH: $BASE_PATH"

rm -rf $FE_DST_PATH
rm -rf $BE_DST_PATH
echo "Cleaning up..."

cp -r "$FE_SRC_PATH" "$FE_DST_PATH"
cp -r "$BE_SRC_PATH" "$BE_DST_PATH"
echo "Copying files..."

#copy latest OTP dockerfiles to build directory
cp $OTP_SRC_PATH/OTP-*.Dockerfile $BASE_PATH/$OTP_BUILD_PATH

rm -rf "$BE_DST_PATH/.git"

mode=$1 # first argument, run like 'bash build.sh fast'

# REMOVE OLD DOCKER CONTAINERS
docker container rm -f fe
docker container rm -f be
docker container rm -f db
docker container rm -f otp

# Rremove old images
docker image rm pta-fe
docker image rm pta-fe
docker image rm pta-otp-packaged
docker image rm pta-postgres-full
docker image rm pta-otp-complete
docker image rm pta-postgres-empty

# Build Docker Images
docker build -t pta-fe ./frontend
docker build -t pta-be ./backend --file ./backend/Dockerfile
docker build -t pta-jupyter ./backend/ --file ./backend/jupyter.Dockerfile

if [ "$mode" = "fast" ]; then
    # RUN faster version of OTP Server and restore DB from dump
    printf "${COLOR_LIGHT_GREEN}Building Docker images...${COLOR_NC}"
    docker build -t pta-otp-packaged  - < $BASE_PATH/$OTP_BUILD_PATH/OTP-packaged.Dockerfile
    docker build -t pta-postgres-full ./backend --build-arg do_restore=true -f ./backend/postgres.Dockerfile
elif [ "$mode" = "complete" ]; then
    # RUN complete version of OTP Server and do NOT restore DB from dump
    printf "${COLOR_LIGHT_BLUE}Building Docker images - this will take a while...${COLOR_NC}"
    printf "${COLOR_LIGHT_BLUE}Make sure to follow data generation instructions afterwards...${COLOR_NC}"
    docker build -t pta-otp-complete  - < $BASE_PATH/$OTP_BUILD_PATH/OTP-complete.Dockerfile
    docker build -t pta-postgres-empty ./backend --build-arg do_restore=false -f ./backend/postgres.Dockerfile
else
    # Exit with a notification
    printf "${COLOR_LIGHT_RED}Unknown mode - run with parameter 'fast' or 'complete' (e.g. ./build.sh 'fast')${COLOR_NC}"
fi