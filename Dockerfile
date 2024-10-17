FROM python:3.11.3-slim-buster

# set a directory for the app
WORKDIR /var/www/mesa-logs

# copy support scripts to container
COPY src/env /var/www/mesa-logs/.env
COPY src/requirements.txt /var/www/mesa-logs
COPY src/uploads.py /var/www/mesa-logs
COPY src/templates /var/www/mesa-logs/templates

# copy support scripts
COPY files/scripts/run.sh /var/www/mesa-logs
COPY files/scripts/prune-logs.sh /etc/cron.daily/

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# define the port number the container should expose
EXPOSE 8000

ENTRYPOINT ["bash", "/var/www/mesa-logs/run.sh"]
