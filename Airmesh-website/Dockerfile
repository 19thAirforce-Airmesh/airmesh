FROM node:22-alpine

LABEL maintainer="sosumi000"
LABEL description="Airmesh website"


WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY src ./src

ENV STORAGE_DIR=/data

EXPOSE 5257

CMD ["npm", "start"]
