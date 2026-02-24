FROM node:18-alpine

WORKDIR /app

# install production dependencies first
COPY package*.json ./
RUN npm ci --omit=dev

# copy app sources
COPY . .

# generate prisma client
RUN npx prisma generate

ENV NODE_ENV=production
EXPOSE 3000

COPY docker-entrypoint.sh ./docker-entrypoint.sh
RUN chmod +x ./docker-entrypoint.sh

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["node", "src/index.js"]
