FROM node:9.11.1-alpine

RUN mkdir -p /app
COPY . /app
WORKDIR /app
# Expose the app port
EXPOSE 3000
ENV HOST 0.0.0.0
ENV PORT 3000

RUN set -x \
  && apk upgrade --no-cache \
  && apk --update add tzdata \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && apk del tzdata \
  && rm -rf /var/cache/apk/*


RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN npm install && npm cache verify
RUN npm run build
CMD ["npm", "start"]
