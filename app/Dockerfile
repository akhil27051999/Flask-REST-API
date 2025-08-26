# Stage - 1 : Build dependencies
FROM python:3.10-alpine AS build
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt \
  && find /root/.local -name '*.pyc' -delete \
  && find /root/.local -name '__pycache__' -delete
# Stage - 2 : Main application
FROM python:3.10-alpine AS main
WORKDIR /app
COPY --from=build /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
ENV FLASK_APP=app
ENV FLASK_DEBUG=1
ENV PYTHONUNBUFFERED=1

# Remove unnecessary files
RUN rm -rf /var/cache/apk/* \
  && rm -rf /root/.cache \
  && find . -type d -name __pycache__ -exec rm -r {} + \
  && find . -type f -name '*.pyc' -delete
EXPOSE 5000
CMD ["flask", "run", "--host=[IP_ADDRESS]", "--port=5000"]