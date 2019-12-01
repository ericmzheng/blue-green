FROM python:3.7.4-slim
WORKDIR /app

COPY requirements.txt /tmp/
RUN apt-get clean \
    && apt-get -y update \
    && apt-get -y install python3-dev build-essential \
    && pip install -U pip \
    && pip install -r /tmp/requirements.txt

CMD ["uwsgi", "--ini", "uwsgi.ini"]

