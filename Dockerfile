# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy your application files
COPY . /app

# Install dependencies and LibreOffice
RUN apt-get update && \
    apt-get install -y libreoffice && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Install Google Fonts
RUN apt-get update && apt-get install -y fonts-liberation && \
    pip install googlefonts-installer && \
    googlefonts-installer install "Liberation Sans" "Arial" --skip-on-missing && \
    fc-cache -f -v

# Expose the port Streamlit will use
EXPOSE 8501

# Set the Streamlit command with the port from $PORT
CMD streamlit run pdfgenerator.py --server.port=$PORT --server.address=0.0.0.0
