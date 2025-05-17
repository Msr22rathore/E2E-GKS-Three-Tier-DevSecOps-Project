FROM node:14 AS frontend
WORKDIR /usr/src/app
COPY app/frontend/package*.json ./
COPY app/frontend/. .

RUN npm install

FROM node:14.0.0-alpine

COPY --from=frontend-builder /usr/src/app/package*.json ./
COPY --from=frontend /usr/src/app/package*.json ./




WORKDIR /app
COPY --from=frontend /usr/src/app/package*.json ./
COPY --from=frontend /usr/src/app/node_modules ./node_modules

COPY --from=frontend /usr/src/app/public .
COPY --from=frontend /usr/src/app/src .
CMD ["npm", "start"]
