FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html
COPY ./post.html /usr/share/nginx/html
COPY ./assets/main.css /usr/share/nginx/html/assets/
COPY ./assets/swiper-bundle.min.css /usr/share/nginx/html/assets
COPY ./assets/swiper-bundle.min.css /usr/share/nginx/html/assets
COPY ./assets/swiper-bundle.min.css /usr/share/nginx/html/assets
EXPOSE 80