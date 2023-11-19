## Build Stage
FROM node:18-alpine as builder

WORKDIR /usr/src/app

COPY package*.json ./
COPY tsconfig.json ./

RUN npm install
RUN npm install -g typescript

COPY . .
RUN npm run build

## Runner Stage
FROM node:18-alpine as runner

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/build ./

RUN npm install --omit=dev

ENV PORT=8080

CMD ["node", "index.js"]




