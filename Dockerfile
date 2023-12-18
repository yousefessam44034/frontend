# Use an official Node runtime as a parent image
FROM node:latest

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY ./src /app/src
COPY ./public /app/public

COPY package*.json /app/
# Install app dependencies

# Change ownership of /.npm folder
USER root
RUN chown -R 1002120000:0 "/.npm"

# Switch back to the non-root user for the rest of the build
USER node

RUN npm install

RUN npm run build
# Expose the port the app runs on
EXPOSE 3000

# Define the command to run your app
CMD ["npm", "start"]
