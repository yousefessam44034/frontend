# Use the official Node.js image as a base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Create a non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Set ownership of the application directory to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the port on which the app will run
EXPOSE 3000

# Set the command to run your application
CMD ["npm", "start"]
