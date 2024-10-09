# MESA-logs

Mesa logs service

Josiah Schwab
Philip Mocz
2024

[blog post](https://yoshiyahu.org/research/computing/2021/08/01/mesa-logs/)

A Python Flask app (served with Gunicorn and Nginx) to upload and serve Mesa logs at:

https://logs.mesastar.org/<commit>/<computer_name>/<test_case>/


## Running locally

Set up nginx to see your `nginx.conf` file (https://gist.github.com/netpoetica/5879685).

Start nginx:

```console
sudo nginx
```

Serve the Flask App with gunicorn

```console
bash bin/run.sh
```

Go to: http://localhost:80

At the end, stop nginx:

```console
sudo nginx -s stop
```


## Running with Docker


```console
docker-compose up --build
```

