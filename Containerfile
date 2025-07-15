# Containerfile

FROM python:3.13-slim

ENV POETRY_HOME="/opt/poetry"
ENV PATH="${POETRY_HOME}/bin:${PATH}"

# Create non-root user
RUN useradd -ms /bin/bash dev

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl build-essential python3-dev git && \
    curl -sSL https://install.python-poetry.org | python3 - --version 2.1.1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set workdir and copy only pyproject files for layer caching
WORKDIR /home/dev/app
COPY --chown=dev:dev pyproject.toml poetry.lock* ./

# Install dependencies without root
RUN poetry install --no-root

# Copy remaining source files
COPY --chown=dev:dev . .

# Use non-root user
USER dev

CMD ["poetry", "run", "python", "src/app.py"]