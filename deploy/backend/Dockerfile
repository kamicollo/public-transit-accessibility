FROM continuumio/miniconda3
LABEL author="mengyang"
LABEL tag="backend"
WORKDIR /code

RUN \
 apt-get update && \
 apt-get install -y libpq-dev && \
 apt-get install -y gcc musl-dev && \
 apt-get install -y fiona

#RUN conda install -y 
RUN pip install fastapi orjson bson h3 psycopg2 sqlalchemy geoalchemy2 shapely geopandas uvicorn

COPY ./src /code/

WORKDIR /code/src/api
CMD ["uvicorn", "serve:app", "--reload", "--host", "0.0.0.0", "--port", "8080"]