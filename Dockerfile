FROM nginx:mainline-alpine
# remove the default config 
RUN rm /etc/nginx/conf.d/*
# adding index.html
COPY . index.html /usr/share/nginx/html/

EXPOSE 80