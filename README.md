# The Ease and Equity of Point of Interest Accessibility via Public Transit in Major US Cities

## Description

This README describes the steps required to reproduce and run the interactive visualization tool and associated analysis focused on understanding the ease and equity of point of interest accessibility via public transit in five major US cities. This tool was developed as a course project in Georgia Tech's CSE6242 class Data and Visual Analytics. At the time this README was published, the tool is accessible for demo purposes at http://20.231.46.77/.

In order to reproduce and run the tool, several components are required. To make it easier, most of them are packaged in Docker container environments. We recommend at least 16 GB RAM and 30GB disk space on the machine running the tool.

## Installation

### Docker desktop

To proceed, you will need Docker environment on your machine. The instruction vary depending on your operating system. We recommend following the [official instructions](https://docs.docker.com/desktop/) to install it.

### Postgres database

[TBD - Przemek]

### Open Trip Planner server

#### Pre-packaged version

The second required component is an [Open Trip Planner](http://docs.opentripplanner.org/en/v1.5.0/) (OTP) server which is used to generate isochrones (catchment areas) for all points of interest used in the analysis. 

We provide a pre-packaged version of the OTP server which uses pre-built graphs that we generated in the process. To build this OTP server, navigate to `DockerFiles` directory and run the following command.

`docker build -t otp-server-packaged:cse6242 - < OTP-packaged.Dockerfile`

#### Complete build

Alternatively, we provide a DockerFile that includes all the instructions required to:
 - install the OTP server
 - download General Transit Feed Specification (GTFS) data feeds used in the analysis
 - build the OTP Graphs using GTFS data and corresponding street networks downloaded from OSM
 - serve the OTP server on the 8062 port.

Note that building this Docker image may take up to 1 hour. To build it, navigate to `DockerFiles` directory and run the following command.

`docker build -t otp-server-complete:cse6242 - < OTP-full.Dockerfile`

In case you use this option, note that the GTFS feeds obtained may cover different dates than the pre-packaged versions, and you may need to adjust the associated configuration (covered in the steps below).



### Data processing (option 1)

[TBD - Przemek (if he gets to it)]

### Data processing (option 2)

[TBD - Aurimas / Junaid]

### Visualization tool

Our Visualization tool is developed mainly using Vue.JS.
```
frontend
    ├── README.md
    ├── babel.config.js
    ├── dist
    ├── node_modules
    ├── package-lock.json
    ├── package.json
    ├── public
    ├── src
    └── yarn.lock
```
```
cse6242_backend
├── README.md
├── config.ini
├── otp
│   ├── Dockerfile
│   ├── README.md
│   └── isochrones.ipynb
├── requirements.txt
└── src
    ├── __init__.py
    ├── __pycache__
    ├── accessibility_analysis
    ├── analysis.ipynb
    ├── api
    ├── basic_pgsql.ipynb
    ├── data_processing
    ├── isochrones.py
    └── sql_functions
```

After enter the frontend directory, run the following command to install all dependencies.
```
npm install
```
For development mode, just run
```
npm run servec
```
For production mode, run
```
npm run build
```

Due to CORS restrictions, the visualization tool requires NGINX to connect to the backend. For NGINX, please install it from the official NGINX website. And adjust the configuration file `nginx.conf` like our sample file deploy/config/nginx.conf.

For backend, we mainly use fastAPI to serve the API service. You also need to install other dependencies, the best way is creating a virtual environment with miniconda and installing all dependencies with the following code.

```
conda install -y psycopg2 sqlalchemy geoalchemy2 shapely geopandas uvicorn
pip install fastapi orjson bson h3
```
Then, go to the src/api directory and run the following command to install all dependencies.
```
uvicorn serve:app --reload --port 8080
```
## Execution

### Running the tool

[TBD - Aurimas]

### Key features

[TBD]

### Analysis

[TBD - Junaid & Alex]

## Authors

The project team comprised Alexander Li, Mengyang Liu, Aurimas Racas, Tejas Santanam, Junaid Syed and Przemek Zientala.

