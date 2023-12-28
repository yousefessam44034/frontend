# Use the official Node.js image as a base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Change ownership of the npm cache directory
RUN mkdir /.npm && chown -R 1002120000:0 /.npm

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the port on which the app will run
EXPOSE 3000

# Set the command to run your application
CMD ["npm", "start"]
