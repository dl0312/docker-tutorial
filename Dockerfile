# Base Image
FROM node:10.16.0-alpine

# Create App Directory
RUN mkdir app
WORKDIR /app

# Add Files
ADD . /app

CMD ["node", "server.js"]