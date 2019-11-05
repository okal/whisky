FROM python:3.8.0-slim

WORKDIR /src
COPY . /src
RUN apt-get update
RUN apt-get install build-essential -y
RUN pip install -r requirements.txt

EXPOSE 9090

ENTRYPOINT ["sh", "-c", "uwsgi --http :9090 --wsgi-file app.py"]
