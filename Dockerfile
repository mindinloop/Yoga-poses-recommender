# 1. Base Image: Start from an official, lightweight Python image
FROM python:3.9-slim

# 2. Working Directory: Set the directory where subsequent commands will run
WORKDIR /app

# 3. Dependencies: Copy requirements first to take advantage of Docker caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Application Code: Copy the rest of your project files
COPY . .

# 5. Environment Variable: Cloud Run needs the container to listen on the PORT variable
#    This line sets a default, but Cloud Run will override it.
ENV PORT 8080

# 6. Startup Command: Define the command that runs your web application
#    This assumes you have a Flask/FastAPI app instance named 'app' in a file named 'app.py'
CMD ["gunicorn", "-b", "0.0.0.0:${PORT}", "app:app"]
