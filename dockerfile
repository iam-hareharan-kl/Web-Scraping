# Stage 1: Node.js Scraper Stage

FROM node:23-slim AS scraper

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
    
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgbm1 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
    
WORKDIR /app
    
COPY package*.json ./

RUN npm ci

COPY scraper.js ./

COPY .env ./
    
RUN node scraper.js

RUN ls -l /app

# Stage 2: Python-hosting Stage

FROM python:3.13-slim AS api
    
WORKDIR /app
    
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
    
COPY server.py .

COPY --from=scraper /app/details.json ./details.json
    
EXPOSE 2003
    
CMD ["python", "server.py"]