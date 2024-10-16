FROM python:3.11.3-slim-buster

# set a directory for the app
WORKDIR /var/www/mesa-logs

# copy all the files to the container
COPY .env /var/www/mesa-logs/
COPY requirements.txt /var/www/mesa-logs/
COPY uploads.py /var/www/mesa-logs/
COPY run.sh /var/www/mesa-logs/
COPY templates /var/www/mesa-logs/templates
COPY prune-logs.sh /etc/cron.daily/

RUN mkdir /var/www/mesa-logs/uploads

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# define the port number the container should expose
EXPOSE 8000

ENTRYPOINT ["bash", "/var/www/mesa-logs/run.sh"]