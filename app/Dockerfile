# Stage - 1 : Build dependencies

# Use an official Python runtime as a parent image
FROM python:3.10-alpine AS build
# copy only requirements to cache them in docker layer
COPY requirements.txt .
# Install build dependencies
RUN pip install --user --no-cache-dir -r requirements.txt \
  && find /root/.local -name '*.pyc' -delete \
  && find /root/.local -name '__pycache__' -delete
  
# Stage - 2 : Main application

# Use an official Python runtime as a parent image
FROM python:3.10-alpine AS main
# Set working directory
WORKDIR /app
# Copy installed dependencies from the build stage
COPY --from=build /root/.local /root/.local
# Copy application files
COPY . .
# Set environment variables
ENV PATH=/root/.local/bin:$PATH
# Remove unnecessary files and caches
RUN rm -rf /var/cache/apk/* \
  && rm -rf /root/.cache \
  && find . -type d -name __pycache__ -exec rm -r {} + \
  && find . -type f -name '*.pyc' -delete
# Expose the port and run the application
EXPOSE 5000
# Run the application
CMD ["flask", "run", "--host=[IP_ADDRESS]", "--port=5000"]