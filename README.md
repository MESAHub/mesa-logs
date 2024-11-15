# MESA-logs

Mesa logs service

Josiah Schwab, 
Philip Mocz, 
Kali McLennan
(2024)

A Python Flask app (served with Gunicorn, with Docker image deployed on Flatiron Kubernetes) to upload and serve Mesa logs at:

https://logs.mesastar.org/<commit>/<computer_name>/<test_case>/

[blog post](https://yoshiyahu.org/research/computing/2021/08/01/mesa-logs/)

## Installation
- Clone this repo
- Create a file named .env in the src directory with contents:
```
FLASK_APP=uploads.py
API_KEYS='{comma separated list of keys generated with scripts/generate_api_key.sh}'
MESALOGS_TEST_API_KEY='{development API key generated with scripts/generate_api_key.sh}'
SECRET_KEY='{A long string to be used for hashing of API keys during authentication testing}'
```

## Running locally

Install requirements

```console
pip install -r src/requirements.txt
```

Serve the Flask App with gunicorn

```console
cd src && ../files/scripts/./run.sh
```

Go to: http://localhost:8000

## Running with Podman  
Build with:  
```console
podman build -t mesa-logs .
```

Create a data volume with:  
```console
podman volume create mesa-logs-data
```

Run with:  
```console
podman run --replace --name mesa-logs --volume mesa-logs-data:/var/www/mesa-logs/uploads -p 8000:8000 localhost/mesa-logs:latest
```

## Running with Docker  
Build with:  

```console
docker build -t mesa-logs .
```

Create a data volume with:  
```console
docker volume create mesa-logs-data
```

Run with: 

```console
docker run --replace --name mesa-logs --volume mesa-logs-data:/var/www/mesa-logs/uploads -p 8000:8000 mesa-logs:latest
```

## Publishing on DockerHub

```console
docker build -t mesa-logs --platform=linux/arm64/v8,linux/amd64 .
docker tag mesa-logs pmocz/mesa-logs:v1
docker push pmocz/mesa-logs:v1
```

Make sure not to publish any secrets!
