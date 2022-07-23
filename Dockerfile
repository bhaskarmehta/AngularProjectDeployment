FROM node:latest as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod


FROM nginx:latest
COPY --from=build app/dist/project5 usr/share/nginx/html
EXPOSE 80