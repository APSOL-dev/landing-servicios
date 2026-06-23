FROM nginx:1.27-alpine

# Instalar curl para el health check
RUN apk add --no-cache curl

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY . /usr/share/nginx/html

RUN rm -f /usr/share/nginx/html/Dockerfile \
          /usr/share/nginx/html/nginx.conf \
          /usr/share/nginx/html/.gitignore \
          /usr/share/nginx/html/README.md \
          "/usr/share/nginx/html/BASE LANDING index.html" \
          /usr/share/nginx/html/apsol-landing-generico.html \
          /usr/share/nginx/html/index-generico.html \
          "/usr/share/nginx/html/Hiper Limpieza_logo.png" \
          /usr/share/nginx/html/refri-integral-logo.jpg

EXPOSE 80

# Health check usando curl contra 127.0.0.1 (evitando problemas de resolución localhost IPv6)
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=5 \
  CMD curl -f http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
