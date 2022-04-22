FE_BUILD_PATH="../frontend/"

FE_SRC_PATH="../frontend/dist/"
BE_SRC_PATH="../backend/"

FE_DST_PATH="./frontend/src"
BE_DST_PATH="./backend/src"

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

rm -rf "$BE_DST_PATH/.git"

# Build Docker Image
docker build -t pta-fe ./frontend
docker build -t pta-be ./backend