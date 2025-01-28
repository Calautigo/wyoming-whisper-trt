# Use the base TensorRT image
FROM nvcr.io/nvidia/tensorrt:25.01-py3

WORKDIR /usr/src

# Install system packages and clone your repo,
# but DO NOT run script/setup here.
RUN apt-get update && apt-get install -y \
    python3-venv \
    ffmpeg \
    git \
    && git clone --recursive https://github.com/JonahMMay/wyoming-whisper-trt \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy your run.sh script into the container
WORKDIR /
COPY run.sh ./
RUN chmod +x run.sh

EXPOSE 10300

# We simply run /run.sh at container start
ENTRYPOINT ["bash", "/run.sh"]
