## Setup

1. Docker
2. Docker Compose


**Before running docker-compose up for the first time**

> you need to run the following command:
>
> `docker-compose run --rm -v $HOME/.cache/composer:/tmp -e COMPOSER_HOME=/tmp php composer install`
>
> `docker-compose run --rm node npm ci`



> you need to have the ".env" file in the root directory for laravel server to work


**Now you can run in the terminal**

`docker-compose up -d`


---

* ports 80 and 3306 must be open
* ".env" file must be in root directory
