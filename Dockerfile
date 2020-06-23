FROM rocker/shiny-verse:3.6.3

ENV http_proxy=http://proxy-rie.http.insee.fr:8080
ENV https_proxy=http://proxy-rie.http.insee.fr:8080

# Install required packages
RUN echo 'Acquire::http::Proxy "http://proxy-rie.http.insee.fr:8080";' >> /etc/apt/apt.conf && apt-get update -q \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
 libssl-dev \
 libgdal-dev \
 libudunits2-dev 
#libxml2-dev
 
#RUN R -e "install.packages(c('highcharter'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "install.packages(c('shiny', 'tidyverse','shinydashboard', 'shinydashboardPlus', 'shinyWidgets', 'shinyjs'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('DT', 'rhandsontable', 'lubridate', 'zoo', 'rmarkdown', 'plotly'),dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages(c('RColorBrewer', 'ggthemes', 'eia', 'eurostat', 'Quandl', 'highcharter'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('saqgetr', 'rsdmx', 'pdfetch', 'RJSONIO','xml2', 'rvest','devtools', 'aws.s3'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "devtools::install_github('tutuchan/shinyflags')"


