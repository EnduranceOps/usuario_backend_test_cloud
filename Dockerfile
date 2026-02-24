FROM node:18-slim

RUN apt-get update -y && apt-get install -y openssl libssl-dev ca-certificates

WORKDIR /app


COPY package*.json ./
COPY prisma ./prisma/


RUN npm install
RUN npx prisma generate


COPY . .


ENV PORT=8080
EXPOSE 8080

CMD ["node", "src/index.js"]