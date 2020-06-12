FROM rocker/shiny-verse

ENV http_proxy=http://proxy-rie.http.insee.fr:8080
ENV https_proxy=http://proxy-rie.http.insee.fr:8080

# Install required packages
RUN echo 'Acquire::http::Proxy "http://proxy-rie.http.insee.fr:8080";' >> /etc/apt/apt.conf && apt-get update -q \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
 libssl-dev \
 libgdal-dev \
 libudunits2-dev

RUN R -e "install.packages(c('shiny', 'tidyverse'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('shinydashboard', 'shinydashboardPlus'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('shinyWidgets', 'shinyjs'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('DT',dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('lubridate', 'zoo'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('rmarkdown', 'plotly'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('RColorBrewer', 'ggthemes'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('fredr', 'eia', 'eurostat', 'Quandl'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('saqgetr', 'rsdmx', 'pdfetch', 'RJSONIO'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages(c('xml2', 'rvest'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "install.packages(c('devtools'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "devtools::install_github("tutuchan/shinyflags")"

RUN install2.r -e shiny
RUN install2.r -e tidyverse
RUN install2.r -e shinydashboard
RUN install2.r -e shinydashboardPlus
RUN install2.r -e shinyjs
RUN install2.r -e DT
RUN install2.r -e shinyWidgets
RUN install2.r -e lubridate
RUN install2.r -e zoo
RUN install2.r -e rmarkdown
RUN install2.r -e plotly
RUN install2.r -e RColorBrewer
RUN install2.r -e ggthemes
RUN install2.r -e fredr
RUN install2.r -e eia
RUN install2.r -e eurostat
RUN install2.r -e Quandl
RUN install2.r -e saqgetr
RUN install2.r -e rsdmx
RUN install2.r -e pdfetch
RUN install2.r -e RJSONIO
RUN install2.r -e xml2
RUN install2.r -e rvest
RUN install2.r -e shinyflags
