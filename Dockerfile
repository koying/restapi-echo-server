FROM python:3.8

USER root
WORKDIR /app

RUN pip install --upgrade --no-cache-dir pip setuptools wheel poetry

RUN useradd -m -r app && \
    chown app /app

COPY . .
RUN /bin/true\
    && poetry config virtualenvs.create false \
    && poetry install --no-interaction \
    && rm -rf /root/.cache/pypoetry

USER app

EXPOSE 8080

CMD [ "python", "-u", "-m", "restapi_echo_server", "--host",  "0.0.0.0",  "--port",  "8080" ]

