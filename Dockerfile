# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Use RHEL base image
FROM registry.access.redhat.com/ubi8/ubi AS base

# Install necessary packages
RUN yum install -y \
    python3 \
    make \
    gcc-c++

WORKDIR /usr/src/app

COPY package*.json ./

# Install Node.js and npm (assuming they are not already installed in the base RHEL image)
RUN curl -fsSL https://rpm.nodesource.com/setup_16.x | bash - && \
    yum install -y nodejs && \
    npm install --only=production

# Multi-stage build to reduce final image size
FROM base AS without-grpc-health-probe-bin

WORKDIR /usr/src/app

# Copy node_modules from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

COPY . .

EXPOSE 50051

ENTRYPOINT [ "node", "index.js" ]

FROM without-grpc-health-probe-bin AS final

# Install grpc_health_probe binary
ENV GRPC_HEALTH_PROBE_VERSION=v0.4.18
RUN curl -fsSL https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 -o /bin/grpc_health_probe && \
    chmod +x /bin/grpc_health_probe
