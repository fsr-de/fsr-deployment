FROM nginx:latest

RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g yarn

COPY portal /app
WORKDIR /app
RUN yarn
RUN yarn build
RUN cp -r dist/* /usr/share/nginx/html
