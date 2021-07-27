FROM rocker/shiny-verse:3.6.3

# ENV cran_repo=https://nexus.beta.innovation.insee.eu/repository/r-public/
# ENV http_proxy=http://proxy-rie.http.insee.fr:8080
# ENV https_proxy=http://proxy-rie.http.insee.fr:8080
ENV no_proxy=".mesos,.thisdcos.directory,.dcos.directory,.zk,127.0.0.1,localhost,.intra,.insee.test,.innovation.insee.eu,.mesos,master.mesos,.thisdcos.directory,.dcos.directory,.zk,127.0.0.1,10.192.255.21,10.192.255.22,10.192.254.31,10.192.254.32,10.192.254.33,10.192.253.51,10.192.253.52,10.192.253.53,10.192.253.54,10.192.253.55,10.192.253.56,10.192.253.57,10.192.253.58,10.192.253.59,10.192.253.61,10.192.253.62,10.192.253.63,10.192.253.64,10.192.1.41,10.192.1.42,9.0.0.0/8,localhost" 


# Install required packages
# RUN echo 'Acquire::http::Proxy "http://proxy-rie.http.insee.fr:8080";' >> /etc/apt/apt.conf &&
RUN apt-get update -q \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends --fix-missing \
 libssl-dev \
 libgdal-dev \
 libudunits2-dev \
 libmagick++-dev \
 libxml2-dev \
 libavfilter-dev \
 libpoppler-cpp-dev \
 libtesseract-dev \
 tesseract-ocr-eng \
 cargo \
 curl \
 tzdata \
 cabal-install \
 imagemagick \
 librsvg2-bin \
 librsvg2-common \
 zlib1g \
 zlib1g-dev \
 libsodium-dev \
 libsasl2-dev \
 libv8-dev \
 libtool \ 
 make \
 g++ \
 unzip\
 libprotobuf-dev \
 libjq-dev

# we remember the path to pandoc in a special variable
ENV PANDOC_DIR=/root/.cabal/bin/

# add pandoc to the path
ENV PATH=${PATH}:${PANDOC_DIR}

# Add certificates (config https)
# RUN curl http://bootstrap.alpha.innovation.insee.eu/ca-certs/ACRacine.crt >> /usr/local/share/ca-certificates/ac-racine-insee.# crt \
#    && curl http://bootstrap.alpha.innovation.insee.eu/ca-certs/ACSubordonnee.crt >> /usr/local/share/ca-certificates/# ac-subordonnee-insee.crt \
#    && update-ca-certificates 

# RUN echo " \
#        \n# Configure proxy \
#        \nhttp_proxy=${http_proxy} \
#        \nhttps_proxy=${https_proxy} \
#        \nno_proxy=${no_proxy} " >> /usr/local/lib/R/etc/Renviron.site


RUN R -e "install.packages(c('devtools'), dependencies=TRUE)" #repos='${cran_repo}'

RUN R -e "devtools::install_github('InseeFr/R-Insee-Data');insee::get_idbank_list()"

RUN R -e "devtools::install_github('tutuchan/shinyflags');devtools::install_github('sboysel/fredr')"
RUN R -e "install.packages(c('rlang'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "install.packages(c('covid19mobility', 'mongolite', 'rtsdata'), repos='https://cran.rstudio.com/', dependencies=TRUE)"


RUN R -e "install.packages(c('protolite', 'jqr', 'gtrendsR', 'BARIS'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "install.packages(c('tools', 'highcharter', 'tesseract', 'magick'), dependencies=TRUE)"
RUN R -e "install.packages(c('shiny', 'tidyverse','shinydashboard', 'shinydashboardPlus', 'shinyWidgets', 'shinyjs'), dependencies=TRUE)"
RUN R -e "install.packages(c('DT', 'rhandsontable', 'lubridate', 'zoo', 'rmarkdown', 'plotly'),dependencies=TRUE)"
RUN R -e "install.packages(c('RColorBrewer', 'ggthemes', 'eia', 'eurostat', 'Quandl', 'rdbnomics', 'rwebstat'), dependencies=TRUE)"
RUN R -e "install.packages(c('saqgetr', 'rsdmx', 'pdfetch','jsonlite' ,'RJSONIO','xml2', 'rvest', 'aws.s3', 'idbr', 'wiesbaden'), dependencies=TRUE)"

#
#repos = 'https://cran.rstudio.com/'
