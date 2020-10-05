FROM python:3.8-alpine

ENV PYTHONUNBUFFERED 1

# Install requirements
COPY ./requirements.txt /requirements.txt

RUN apk update
RUN apk add --update --no-cache postgresql-client

## Temp build dependencies
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev

RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
