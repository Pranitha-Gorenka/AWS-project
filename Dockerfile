# Stage 1: Build React frontend
FROM node:16-alpine AS frontend-builder
WORKDIR /client
COPY client/package.json client/package-lock.json ./
RUN npm install
COPY client/ ./
RUN npm run build

# Stage 2: Build backend + serve frontend
FROM node:16-alpine
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --production
COPY server.js ./
COPY routes/ models/ controllers/ config/ ./
# Copy built frontend into backend's public folder (assuming Express serves it)
COPY --from=frontend-builder /client/build ./client/build

EXPOSE 8080
CMD ["node", "server.js"]
