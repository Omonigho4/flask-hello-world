# Python runtime as image
FROM python:3.8-slim

# Working directory to app
WORKDIR /app

# Copy current directory into the container at /app
COPY . /app

# Install required dependencies listed in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Expose port 5000
EXPOSE 5000

# Specify  environment variable
ENV NAME World

# Run app
CMD ["python", "myapp.py"]
