FROM getnao/nao:latest


# installer les dépendances ODBC
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    apt-transport-https \
    unixodbc \
    unixodbc-dev

# ajouter le repo Microsoft
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list \
    > /etc/apt/sources.list.d/mssql-release.list

# installer le driver SQL Server
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18

COPY . /app/project

WORKDIR /app/project