FROM node:14.17-alpine AS development

WORKDIR /app

COPY app .

RUN npm ci

ENTRYPOINT [ "npm" ]
CMD [ "start" ]

FROM node:14.17-alpine AS build

WORKDIR /app

COPY app .

RUN npm ci && npm run build

FROM nginx:1.20-alpine

COPY docker /
COPY --from=build /app/build /usr/share/nginx/html