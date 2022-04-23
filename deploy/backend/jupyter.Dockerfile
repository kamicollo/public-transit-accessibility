FROM jupyter/base-notebook
LABEL author="aurimas"
LABEL tag="jupyter"
ARG NB_USER="jovyan"
ARG NB_UID="1000"

WORKDIR /code
COPY ./src /code/

USER root

RUN \
 apt-get update && \
 apt-get install -y libpq-dev && \
 apt-get install -y gcc musl-dev && \
 apt-get install -y fiona && \
 python3 -m pip install -r requirements.txt

USER $NB_UID

CMD ["jupyter", "notebook","--NotebookApp.token=''","--NotebookApp.password=''"]