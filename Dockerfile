FROM python:3.11-slim


COPY ./requirements.txt /bkjbj/requirements.txt
COPY App3.py /App3/App3.py

WORKDIR /App3

RUN pip install -r requirements.txt

COPY App3.py /

ENTRYPOINT ["python"]

EXPOSE 5000

CMD ["python", "App3.py"]
