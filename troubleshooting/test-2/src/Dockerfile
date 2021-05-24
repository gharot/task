FROM python:3.9-alpine

WORKDIR /app

RUN apk update && apk add gcc python3-dev musl-dev postgresql-dev
RUN pip install flask psycopg2

COPY ./app.py /app/

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
