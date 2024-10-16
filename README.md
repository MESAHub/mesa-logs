# MESA-logs

Mesa logs service

Josiah Schwab, 
Philip Mocz, 
(2024)

A Python Flask app (served with Gunicorn, with Docker image deployed on Flatiron Kubernetes) to upload and serve Mesa logs at:

https://logs.mesastar.org/<commit>/<computer_name>/<test_case>/

[blog post](https://yoshiyahu.org/research/computing/2021/08/01/mesa-logs/)


## Running locally

Serve the Flask App with gunicorn

```console
./run.sh
```

Go to: http://localhost:8000


## Running with Docker

Build with:

```console
docker build -t uploads .
```

Run with:

```console
docker run -p 80:8000 uploads
```
