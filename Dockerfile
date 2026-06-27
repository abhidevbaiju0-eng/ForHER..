FROM nginxinc/nginx-unprivileged:1.25-alpine

USER root

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy the static web app files to nginx html directory
COPY --chown=nginx:nginx index.html style.css app.js ludo.html ludo.css ludo.js /usr/share/nginx/html/

# Copy the nginx template for dynamic port binding
COPY --chown=nginx:nginx default.conf.template /etc/nginx/templates/

USER nginx

HEALTHCHECK --interval=30s --timeout=3s CMD wget -q --spider http://localhost:${PORT:-8080}/ || exit 1
