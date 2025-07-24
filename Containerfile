# Containerfile
FROM python:3.13-slim

# 1) System deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl git gcc libffi-dev libpq-dev build-essential python3-dev python3-pip && \
    rm -rf /var/lib/apt/lists/*

# 2) Install uv into /usr/local/bin
RUN curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh

# 3) Install Poetry + export plugin, disable its venvs
ENV POETRY_HOME="/opt/poetry" \
    PATH="/opt/poetry/bin:/usr/local/bin:$PATH"
RUN curl -sSL https://install.python-poetry.org | python3 - --version 2.1.1 && \
    poetry self add poetry-plugin-export && \
    poetry config virtualenvs.create false

# 4) Create non‑root user & workdir
RUN useradd -ms /bin/bash dev
WORKDIR /home/dev/app

# 5) Copy lockfiles for caching
COPY --chown=dev:dev pyproject.toml poetry.lock* ./

# 6) Export & install ALL deps (main + dev) via Poetry → uv pip
RUN poetry export \
    --format requirements.txt \
    --without-hashes \
    --with main \
    --with dev \
    | uv pip install --system -r /dev/stdin

# 7) Copy source
COPY --chown=dev:dev . .

# 8) Switch to non‑root
USER dev

# 9) Default command
CMD ["python", "-m", "src"]
