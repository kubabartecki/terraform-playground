FROM node:22.4.1-slim as build

WORKDIR /app
COPY . .

RUN npm install
CMD ["npm", "start"]

# this build is just for the simplicity of the example (developer/testing mode)
# in production, you should build the app and serve it with a web server like Nginx
