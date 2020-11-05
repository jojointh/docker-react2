# Use an existing docker image as a base
FROM node:alpine as builder

WORKDIR '/app'

# Download and install a dependency
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# Tell the image what to do when it starts as a container
