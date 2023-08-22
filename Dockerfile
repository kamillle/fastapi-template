# Builder image
FROM python:3.10.9-slim as builder

WORKDIR /app

# Install poetry
RUN pip install --no-cache-dir poetry

# Copy pyproject.toml and poetry.lock for installing dependencies
COPY pyproject.toml poetry.lock /app/

# Generate requirements.txt
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

# Runtime image
FROM python:3.10.9-slim

WORKDIR /app

# Copy requirements.txt from builder image
COPY --from=builder /app/requirements.txt /app/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY . /app

# Expose the application port
EXPOSE 8000

ENV PYTHONUNBUFFERED 1

# Run the FastAPI app
CMD ["uvicorn", "app.server:app", "--host", "0.0.0.0", "--port", "80"]
