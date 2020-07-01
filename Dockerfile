FROM rocker/shiny-verse:3.6.3

ENV http_proxy=http://proxy-rie.http.insee.fr:8080
ENV https_proxy=http://proxy-rie.http.insee.fr:8080
ENV no_proxy=".mesos,.thisdcos.directory,.dcos.directory,.zk,127.0.0.1,localhost,.intra,.insee.test,.innovation.insee.eu,.insee.fr,.mesos,master.mesos,.thisdcos.directory,.dcos.directory,.zk,127.0.0.1,10.192.255.21,10.192.255.22,10.192.254.31,10.192.254.32,10.192.254.33,10.192.253.51,10.192.253.52,10.192.253.53,10.192.253.54,10.192.253.55,10.192.253.56,10.192.253.57,10.192.253.58,10.192.253.59,10.192.253.61,10.192.253.62,10.192.253.63,10.192.253.64,10.192.1.41,10.192.1.42,9.0.0.0/8,localhost" 


# Install required packages
RUN echo 'Acquire::http::Proxy "http://proxy-rie.http.insee.fr:8080";' >> /etc/apt/apt.conf && apt-get update -q \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
 libssl-dev \
 libgdal-dev \
 libudunits2-dev 
#libxml2-dev

# Add certificates (config https)
RUN curl http://bootstrap.alpha.innovation.insee.eu/ca-certs/ACRacine.crt >> /usr/local/share/ca-certificates/ac-racine-insee.crt \
    && curl http://bootstrap.alpha.innovation.insee.eu/ca-certs/ACSubordonnee.crt >> /usr/local/share/ca-certificates/ac-subordonnee-insee.crt \
    && update-ca-certificates 

 
#RUN R -e "install.packages(c('highcharter'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "install.packages(c('shiny', 'tidyverse','shinydashboard', 'shinydashboardPlus', 'shinyWidgets', 'shinyjs'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('DT', 'rhandsontable', 'lubridate', 'zoo', 'rmarkdown', 'plotly'),dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('RColorBrewer', 'ggthemes', 'eia', 'eurostat', 'Quandl', 'highcharter'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('saqgetr', 'rsdmx', 'pdfetch', 'RJSONIO','xml2', 'rvest','devtools', 'aws.s3'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "devtools::install_github('tutuchan/shinyflags');devtools::install_github('sboysel/fredr')"



