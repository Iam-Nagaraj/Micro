# Base image
FROM node:20.2.0-alpine@sha256:f25b0e9d3d116e267d4ff69a3a99c0f4cf6ae94eadd87f1bf7bd68ea3ff0bef7 AS base

# Builder image
FROM base AS builder

# Install additional packages
RUN apk add --update --no-cache \
    python3 \
    make \
    g++

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Set npm proxy if needed
# ENV HTTP_PROXY=http://your.proxy.server:port
# ENV HTTPS_PROXY=http://your.proxy.server:port
# RUN npm config set proxy http://your.proxy.server:port
# RUN npm config set https-proxy http://your.proxy.server:port

# Update npm (consider using a specific version instead of latest)
RUN npm install -g npm@7.24.0 \
    && npm cache clean --force \
    && npm install --only=production --verbose || (cat /root/.npm/_logs/2024-07-14T07_31_45_925Z-debug-0.log && exit 1)

# Without grpc-health-probe binary image
FROM base AS without-grpc-health-probe-bin

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/node_modules ./node_modules

COPY . .

EXPOSE 7000

ENTRYPOINT [ "node", "server.js" ]
