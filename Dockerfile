FROM rocker/shiny-verse:3.6.3

ENV http_proxy=http://proxy-rie.http.insee.fr:8080
ENV https_proxy=http://proxy-rie.http.insee.fr:8080

# Install required packages
RUN echo 'Acquire::http::Proxy "http://proxy-rie.http.insee.fr:8080";' >> /etc/apt/apt.conf && apt-get update -q \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
 libssl-dev \
 libgdal-dev \
 libudunits2-dev \
 libxml2-dev
 
RUN R -e "install.packages(c('highcharter'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "install.packages(c('shiny', 'tidyverse'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('shinydashboard', 'shinydashboardPlus'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('shinyWidgets', 'shinyjs'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('DT', 'rhandsontable'),dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('lubridate', 'zoo'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('rmarkdown', 'plotly'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('RColorBrewer', 'ggthemes'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('eia', 'eurostat', 'Quandl'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('saqgetr', 'rsdmx', 'pdfetch', 'RJSONIO'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('xml2', 'rvest'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "install.packages(c('devtools'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "devtools::install_github('tutuchan/shinyflags')"

RUN R -e "install.packages(c('aws.s3'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

