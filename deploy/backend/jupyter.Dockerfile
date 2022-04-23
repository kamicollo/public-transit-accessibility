FROM jupyter/base-notebook
LABEL author="aurimas"
LABEL tag="jupyter"
ARG NB_USER="jovyan"
ARG NB_UID="1000"

USER root

RUN \
 apt-get update && \
 apt-get install -y libpq-dev && \
 apt-get install -y gcc musl-dev && \
 apt-get install -y fiona

WORKDIR /code
COPY ./src /code/

RUN python3 -m pip install -r requirements.txt

USER $NB_UID

CMD ["jupyter", "notebook","--NotebookApp.token=''","--NotebookApp.password=''"]