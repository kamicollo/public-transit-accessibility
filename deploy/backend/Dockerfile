FROM continuumio/miniconda3
LABEL author="mengyang"
LABEL tag="backend"
WORKDIR /code

RUN conda install -y psycopg2 sqlalchemy geoalchemy2 shapely geopandas uvicorn
RUN pip install fastapi orjson bson h3 redis

COPY ./src /code/

WORKDIR /code/src/api
CMD ["uvicorn", "serve:app", "--reload", "--host", "0.0.0.0", "--port", "8080"]