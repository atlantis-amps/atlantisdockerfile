FROM rocker/tidyverse:latest
MAINTAINER hmorzaria@hotmail.com
# Install minimum requirements
RUN timedatectl set-timezone America/Los_Angeles
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libhdf5-dev \
    libnetcdf-dev \
    libgdal-dev \
    libudunits2-dev \
    libxml2-dev \
    libproj-dev \
    libproj12 \
    libssl-dev \
    libv8-dev \
    libgeos-dev \
    libgeo-proj4-perl \
    libgeos++-dev \
    libpoppler-cpp-dev \
    librsvg2-dev \
    libx11-dev \
    libprotobuf-dev \
    lsscsi \
    libcairo2 \
    libcairo2-dev \
    libapparmor1 \
    subversion \
    flip \
    autoconf \
    curl \
    gdebi-core \
    openssl \
    proj-bin \
    proj-data \
    rpm \
    ntp \
    ntpdate \
    htop \
    protobuf-compiler \
    mesa-common-dev \
    libglu1-mesa-dev \
    texlive-latex-extra \
    netcdf-bin \
    
RUN apt-get -y --no-install-recommends install \
    gdal-bin \
    python2.7 \
    python-pip \
    python-dev \
    python-gdal \
    python3-gdal \
    libjq-dev
         
#Install AzCopy, ver. 7.2 includes .NET Core dependencies; they do not need to install them a pre-requisite
#https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-linux
RUN \
    apt-get update && apt-get -y upgrade &&\
    apt-get -y install rsync wget &&\
    wget -O azcopy.tar.gz https://aka.ms/downloadazcopylinuxrhel6 &&\
    tar -xzf azcopy.tar.gz &&\
    ./install.sh &&\
    rm -Rf azcopy* install.sh
    
    #setup R configs
    
 RUN Rscript -e "install.packages( c( \
    'digest', \
    'data.table', \
    'fields', \
    'devtools', \
    'readxl', \
    'rgdal', \
    'RNetCDF', \
    'httr', \
    'parallel', \
    'futures', \
    'doSNOW', \
    'raster'), \
 dependencies = TRUE)"
  
RUN Rscript -e "devtools::install_github('jporobicg/shinyrAtlantis')"
RUN Rscript -e "devtools::install_github('Atlantis-Ecosystem-Model/ReactiveAtlantis')"
RUN Rscript -e "devtools::install_github('Azure/rAzureBatch')"
RUN Rscript -e "devtools::install_github('Azure/doAzureParallel')"

ENV TZ America/Los_Angeles
RUN ln -snf /usr/share/timezone/$TZ /etc/localtime && echo $TZ > /etc/timezone
CMD ["R"]
© 2019 GitHub, Inc.
