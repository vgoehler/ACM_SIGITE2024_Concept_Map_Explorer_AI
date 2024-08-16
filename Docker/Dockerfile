FROM continuumio/miniconda3:24.5.0-0

LABEL authors="Volker Göhler <volker.goehler@informatik.tu-freiberg.de>"

# RUN apt-get update && apt-get install software-properties-common wget bash -y

RUN useradd condauser -m
USER condauser:condauser

# install conda
#RUN mkdir -p ~/miniconda3 && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh && bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 && rm -rf ~/miniconda3/miniconda.sh
# make conda available in the dockerfile run cmds
ENV PATH="$PATH:/home/condauser/miniconda3/bin"

WORKDIR /home/condauser/

# create the running environment, we store the environment in ./envs to access it regardless the name
COPY environment.yml .
# use conda env create! resolution of PyPI packages needs this, had huge problems with conda create!
RUN conda env create --prefix ./envs --file environment.yml -y

SHELL ["/bin/bash", "--login", "-c"]

RUN conda init bash && \
    echo "conda activate ./envs" >> ~/.bashrc

# I tried setting the envs with an environment but this failed, but I don't know why.

CMD ["/bin/bash", "--login" ]