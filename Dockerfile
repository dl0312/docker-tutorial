# Base Image
FROM node:10.16.0-alpine

# Create App Directory
RUN mkdir -p /app
WORKDIR /app

# Move Codes
COPY package.json .

RUN npm install

COPY src .

CMD ["node", "index.js"]