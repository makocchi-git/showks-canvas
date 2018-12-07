# Stage 0
FROM node:8-alpine

WORKDIR /build
RUN apk add --no-cache \
    build-base \
    g++ \
    cairo-dev \
    pango-dev \
    jpeg-dev
RUN npm install canvas --only=production

# Create app directory
WORKDIR /usr/src/app

# Copy built modules
RUN cp -r /build/node_modules ./node_modules

# Install app dependencies (production only)
RUN apk add --no-cache \
    cairo \
    pango \
    jpeg
COPY src/package*.json ./
RUN npm install --only=production

# Bundle app source
COPY src .

EXPOSE 8080
CMD [ "npm", "start" ]
