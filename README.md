## Setup

Requirements:

-Docker
-Docker Compose

Before running ocker-compose up -d for the first time, you need to run the following commands:

==> docker-compose run --rm -d -v $HOME/.cache/composer:/tmp -e COMPOSER_HOME=/tmp php composer install

==> docker-compose run --rm -d node npm ci

Now you can run:

==> docker-compose up -d
