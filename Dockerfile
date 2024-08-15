FROM python:3.12-slim

WORKDIR /src

COPY pyproject.toml poetry.lock ./

RUN python -m pip install setuptools poetry

RUN poetry config virtualenvs.create false

RUN poetry install

COPY ./ ./

EXPOSE 1717

CMD ["python manage.py runserver 0.0.0.0:1717"]