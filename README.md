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

## Execution

### Running the tool

To run the tool, simply navigate to the `deploy` directory and run `kickstart.sh fast` or `kickstart.sh complete` (depending on the choice you made in the previous sesssion). You can then access the interactive visualization tool at http://localhost/.

### Key features

[TBD]

### Analysis

[TBD - Junaid & Alex]

## Authors

The project team comprised Alexander Li, Mengyang Liu, Aurimas Racas, Tejas Santanam, Junaid Syed and Przemek Zientala.

