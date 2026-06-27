# ────────────────────────────────────────────
# Stage 1 — Build the Angular app
# ────────────────────────────────────────────
FROM node:22-alpine AS builder

WORKDIR /app

# Copy package files first — Docker caches node_modules layer
COPY package.json package-lock.json ./
RUN npm ci

# Copy source and build for production
COPY . .
RUN npm run build -- --configuration production --output-path=dist/pawid

# ────────────────────────────────────────────
# Stage 2 — Serve with nginx
# ────────────────────────────────────────────
FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom nginx config
COPY nginx.conf /etc/nginx/conf.d/app.conf

# Copy built Angular app from builder stage
COPY --from=builder /app/dist/pawid/browser /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]