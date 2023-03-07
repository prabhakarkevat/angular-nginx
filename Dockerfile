
FROM node AS build

WORKDIR /app

COPY package*.json ./

RUN npm i -g npm@6.14.13

RUN npm install

COPY . .

RUN npm run build --optimization

FROM nginx

COPY --from=build /dist/s2 ./usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
