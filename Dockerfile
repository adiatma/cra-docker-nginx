FROM node:12.13.0 as build

WORKDIR /web
COPY web/ .

RUN yarn install
RUN yarn build
COPY . .

FROM nginx
COPY --from=build /web/build /usr/share/nginx/html
COPY config/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx-debug", "-g", "daemon off;"]
