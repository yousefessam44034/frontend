# Use the official Node.js image as a base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Add a non-root user to avoid permission issues
RUN groupadd -r app && useradd --no-log-init -r -g app app
RUN chown -R app:app /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Switch to the non-root user
USER app

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the port on which the app will run
EXPOSE 3000

# Set the command to run your application
CMD ["npm", "start"]
