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

OTP_BUILD_PATH="otpserver"

BASE_PATH=`pwd`

# Build Frontend
cd $FE_BUILD_PATH
echo "INTO PATH: $FE_BUILD_PATH"

#npm install
#npm run build

cd "$BASE_PATH"
echo "INTO PATH: $BASE_PATH"

rm -rf $FE_DST_PATH
rm -rf $BE_DST_PATH
echo "Cleaning up..."

cp -r "$FE_SRC_PATH" "$FE_DST_PATH"
cp -r "$BE_SRC_PATH" "$BE_DST_PATH"
echo "Copying files..."

rm -rf "$BE_DST_PATH/.git"

mode=$1 # first argument, run like 'bash build.sh fast'

# Build Docker Images
#docker build -t pta-fe ./frontend
#docker build -t pta-be ./backend
docker build -t pta-jupyter ./backend/ --file ./backend/jupyter.Dockerfile
docker build -t pta-postgres ./backend/ --build-arg do_restore=false -f ./backend/postgres.Dockerfile
