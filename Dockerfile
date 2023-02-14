FROM nginx:alpine
EXPOSE 80
COPY ./frontend /usr/share/nginx/html