FROM node:10

ENV NODE_ENV production

RUN yarn global add elm@0.19.0

RUN mkdir /app
WORKDIR /app

COPY elm.json .
COPY src src
RUN elm make src/Main.elm --optimize --output=out/app.js
COPY out/* out


FROM nginx:1.15.12-alpine

# Kopier det vi vil servere til brukeren til /usr/share/nginx/html. Her kopierer vi index.html
# og img
COPY --from=0 /app/out /usr/share/nginx/html
