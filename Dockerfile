# Base image
FROM registry.access.redhat.com/ubi8/ubi AS base

# Builder image
FROM base AS builder

# Install additional packages required for building dependencies
RUN yum install -y \
    python3 \
    make \
    gcc-c++

WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Set npm proxy if needed (uncomment and modify if necessary)
# ENV HTTP_PROXY=http://your.proxy.server:port
# ENV HTTPS_PROXY=http://your.proxy.server:port
# RUN npm config set proxy http://your.proxy.server:port
# RUN npm config set https-proxy http://your.proxy.server:port

# Update npm (specific version to avoid issues)
RUN npm install -g npm@7.24.0 \
    && npm cache clean --force \
    && npm install --only=production --verbose || (cat /root/.npm/_logs/2024-07-14T08_05_56_507Z-debug-0.log && exit 1)

# Final image without grpc-health-probe binary
FROM base AS without-grpc-health-probe-bin

WORKDIR /usr/src/app

# Copy the node_modules directory from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Copy application source code
COPY . .

# Expose port 7000 (adjust according to your application's needs)
EXPOSE 7000

# Specify the command to run your application
CMD ["node", "server.js"]
