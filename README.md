## Setup

**Requirements**

1. Docker
2. Docker Compose

**Before running docker-compose up for the first time**

> you need to run the following command:
>
> ```plaintext
> docker-compose run --rm -v $HOME/.cache/composer:/tmp -e COMPOSER_HOME=/tmp php composer install
> ```
>
> ```plaintext
> docker-compose run --rm node npm ci
> ```

**Now you can run in the terminal**

```plaintext
docker-compose up -d
```

Finaly the server should be running on [localhost port 80](http://localhost/)

---

-   ports 80 and 3306 must be open
-   ".env" file must be in root directory
