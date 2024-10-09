FROM python:3.11.3-slim-buster

# set a directory for the app
WORKDIR /var/www/mesa-logs

# copy all the files to the container
COPY . .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# define the port number the container should expose
EXPOSE 80

ENTRYPOINT ["bash", "/var/www/mesa-logs/bin/run.sh"]