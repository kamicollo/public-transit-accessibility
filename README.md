# The Ease and Equity of Point of Interest Accessibility via Public Transit in Major US Cities

## Description

This README describes the steps required to reproduce and run the interactive visualization tool and associated analysis focused on understanding the ease and equity of point of interest accessibility via public transit in five major US cities. This tool was developed as a course project in Georgia Tech's CSE6242 class Data and Visual Analytics. At the time this README was published, the tool is accessible for demo purposes at http://20.231.46.77/.

In order to reproduce and run the tool, several components are required. To make it easier, most of them are packaged in Docker container environments. We recommend at least 16 GB RAM and 30GB disk space on the machine running the tool.

## Installation

### Prerequisites

#### Docker desktop

You will need Docker environment on your machine. The instruction vary depending on your operating system. We recommend following the [official instructions](https://docs.docker.com/desktop/) to install it.

#### Node package manager

You will also need Node.js and its package manager. Similarly to Docker, we recommend following the [official instructions](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm) corresponding to your operating system.

### Building Docker images

We provide an easy and convenient way to build Docker images for this application. All you need to do is run `build.sh` script that is within in the `/deploy` directory with parameter `fast` or `complete` (you may need to `chmod +x build.sh` to make the file executable). This script creates 5 separate Docker containers:
 - pta-be - contains the backend API of the application
 - pta-fe - contains the frontend of the application
 - pta-otp-[prepackaged|complete] - [Open Trip Planner](http://docs.opentripplanner.org/en/v1.5.0/) server which is used to generate isochrones (catchment areas).
  - pta-db - PostgreSQL database container.
  - pta-analysis - Jupyter notebook environment for data processing and post-hoc analysis.

We highly recommend using `build.sh fast` - this will use pre-packaged database backup for the PostgreSQL container and pre-packaged graph datasets for the OTP container. 

Using `build.sh complete` will instead create only an empty PostgreSQL database and will build the OTP container by downloading latest available GTFS information. The `build.sh complete` process may take up to an hour and will require execution of manual data-processing steps as described below. 

Both `build.sh fast` and `build.sh complete` will download large amounts of data, a stable and fast internet connection is recommended.

### Re-creating data processing steps

Skip to the next section if you used `build.sh fast` previously.

If you used `build.sh complete`, you will now need to run individual notebooks that re-compute accessibility statistics and recreate the database structure.

First, you will need to obtain [Open Census dataset from SafeGraph](https://docs.safegraph.com/docs/open-census-data). Please follow the instructions on the website and download 2019 5-year ACS and 2010-2019 Census Block Group geometries datasets.

Then:

1. Start the OTP, database and Jupyter notebook Docker containers using `kickstart-processing.sh` script in the `/deploy` directory.
2. Open your browser at `http://localhost:8888` - you should see Jupyter server interface.
3. Open your browser at `http://localhost:8062` - you should see OTP server interface. Note that OTP docker container may take up to 5 minutes to fully start.
4. Navigate to /src/tests/ and run `test_otp.ipynb` and `test_db.ipynb` notebooks to confirm connectivity to OTP and database containers.
5. [JUNAID TBD - where to store the data from Safegraph?]
6. Run the following notebooks in the following order:
   1. [TBD]
   2. [TBD]
   3. [TBD]
   4. [TBD]
   5. [TBD]
   6. [TBD]
   7. [TBD]

## Execution

### Running the tool

To run the tool, simply navigate to the `deploy` directory and run `kickstart.sh fast` or `kickstart.sh complete` (depending on the choice you made in the previous session). If you previously stopped any of the running docker containers, make sure to restart them.

You can then access the interactive visualization tool at http://localhost/.

### Key features

To change the city analyzed, select the desired city in the dropdown in the top left. The change will take effect after a few seconds. The default city is Atlanta.

To change the POI visualized, click on the control panel and select the desired POI type. The change will take effect after a few seconds. The default POI type is vaccination centers. The time of day for transit accessibility and desired demographic factor can also be changed in the control panel in a similar manner. The map opacity slider changes the user's ability to see through the hexagons on the map.

In order to view 30-minutes transit isochrones for POIs, set the Interaction type to Explore. This is the default interaction when the page is first loaded. The isochrones will be displayed as a green polygon when the dot for a POI on the map is clicked. While the isochrone is clicked, the doughnut graph for catchment area statistics will become active and show the demographic breakdown inside the isochrone based on the selected demographic factor in the control panel. The isochrone can be removed by clicking on the map off of the isochrone or by clicking the 'Clear visible catchments' button in the control panel.

To add POIs, set the Interaction type to Add New POIs. Then, click on the map wherever you would like to add a new POI. A dot in a different color from the existing POIs will appear. After a few seconds, the accessibility metrics in the City Level Statistics chart will change correspondingly.

To remove POIs, set the Interaction type to Remove POIs. Then, click on the dot for any POI on the map. The clicked dot will disappear. After a few seconds, the accessibility metrics in the City Level Statistics chart will change correspondingly.

Hovering over the map will bring up a tooltip for each H3 hexagon that shows the demographic breakdown inside the hexagon based on the selected demographic factor in the control panel. The hexagons are colored by accessibility score, with lighter colored hexagons being more accessible to the selected POI type.

Technical details of the tool development and methodology can be displayed in a pop-up by clicking on the methodology details button.

### Analysis

In case you would like to reproduce the machine learning analysis described in our report, you will need to start the `jupyter` container. If you used `./kickstart-processing` previously, it should be already running. If not, run `./kickstart-jupyter.sh` in the `/deploy` directory.

The jupyter interface is then accessible at http://localhost:8888. The analysis notebooks are available in the `/backend/src/accessibility_analysis` folder.

## Authors

The project team comprised Alexander Li, Mengyang Liu, Aurimas Racas, Tejas Santanam, Junaid Syed and Przemek Zientala.

