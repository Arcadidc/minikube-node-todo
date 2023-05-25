# Specify the base image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy application files
COPY . /app

# Install dependencies
RUN npm install

# Expose the necessary port
EXPOSE 8080

# Specify the startup command
CMD [ "npm", "start" ]