# Stage 1: Build dependencies
FROM python:3.10-alpine AS build
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt \
  && find /root/.local -name '*.pyc' -delete \
  && find /root/.local -name '__pycache__' -delete

# Stage 2: Main app
FROM python:3.10-alpine AS main
WORKDIR /app
COPY --from=build /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
ENV FLASK_APP=wsgi.py
EXPOSE 5000

# Use Gunicorn instead of Flask dev server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "wsgi:app", "--workers", "2"]
