# Phase 1: Build (Astro Seite bauen)
FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Phase 2: Runtime (Nur das fertige Ergebnis ausliefern)
FROM nginx:stable-alpine
# Kopiert das 'dist' Verzeichnis von Astro in den Nginx-Webordner
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
