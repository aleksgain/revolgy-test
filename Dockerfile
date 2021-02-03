FROM python:3.7-slim

WORKDIR /app

COPY ./python/* /app

RUN pip install -r /app/requirements.txt

EXPOSE 31337

CMD ["python", "./app.py"] 