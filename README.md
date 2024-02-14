
<div align="center">

# Craft Beer Brewery Database - Project Description

<br>
  
[![Commits](https://img.shields.io/github/commit-activity/w/CrafDb-Team/crafdb)](https://github.com/COS301-SE-2023/FridgeToPlate/activity)
[![CI/CD](https://github.com/CrafDb-Team/crafdb/actions/workflows/dev-db-ci-cd.yml/badge.svg)](https://github.com/CrafDb-Team/crafdb/actions/workflows/dev-db-ci-cd.yml)

</div>

ABC Craft Beers new database management system, which hopes to enhance resource efficiency, customer order tracking, and the brewing processes.

## Project Resources:

[![Documentation](https://img.shields.io/badge/View-Project%20Documentation-blue?style=for-the-badge)](https://crafdb.atlassian.net/wiki/spaces/CrafDB/overview)&ensp;

[![Project Management](https://img.shields.io/badge/View-Project%20Issue%20Board-blue?style=for-the-badge)](https://bbdcloud.atlassian.net/jira/software/projects/CRAF/boards/24)&ensp;


## Run Locally

Clone the project

```bash
  git clone https://github.com/CrafDb-Team/crafdb
```

Go to the project directory

```bash
  cd crafdb
```

Install liquibase

```bash
  wget -O- https://repo.liquibase.com/liquibase.asc | gpg --dearmor > liquibase-keyring.gpg && \
  cat liquibase-keyring.gpg | sudo tee /usr/share/keyrings/liquibase-keyring.gpg > /dev/null && \
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/liquibase-keyring.gpg] https://repo.liquibase.com stable main' | sudo tee /etc/apt/sources.list.d/liquibase.list
```

Create a liquibase.properties file

```bash
  echo "changelog-file: <changelog_file>" >> liquibase.properties
  echo "url: jdbc:postgresql://<db_url>:<port>/<db_name>" >> liquibase.properties
  echo "username: <db_username>" >> liquibase.properties
  echo "password: <db_password>" >> liquibase.properties
```

Run migration

```bash
  liquibase update
```
