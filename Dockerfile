# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.8.10-slim

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True
# RUN apt update -y && apt install gcc -y
# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME


COPY requirements-inference.txt .
RUN pip3 install -r requirements-inference.txt

# COPY requirements.txt .
# RUN pip3 install -r requirements.txt

COPY . .
# RUN python3 -m src.api.download_model
CMD exec uvicorn src.api.main:app --port $PORT --host 0.0.0.0 --workers 1
