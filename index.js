// Import the Express framework.
const express = require('express');

// Create an instance of the Express application.
const app = express();

// Get the port from the environment variable, defaulting to 8080.
// This is the crucial part for Google Cloud Run compatibility.
const PORT = process.env.PORT || 8080;

// Define a handler for the root URL ('/').
app.get('/', (req, res) => {
  console.log('Request received for /');
  res.status(200).send('Hello from Cloud Run!');
});

// Start the server and listen for connections.
app.listen(PORT, () => {
  console.log(`Server is running and listening on port ${PORT}`);
});