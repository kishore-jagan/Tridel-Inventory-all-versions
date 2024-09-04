<?php
// Enable CORS (Cross-Origin Resource Sharing)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Database configuration
$dbHost = 'localhost';
$dbName = 'inventory_db';
$dbUser = 'root';
$dbPassword = '';

// Create a database connection
$conn = new mysqli($dbHost, $dbUser, $dbPassword, $dbName);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to get total rows from a table


// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get total rows for each table
    $result = $conn->query("SELECT COUNT(*) AS total_rows FROM vendor");

    // Return the total rows as JSON
    http_response_code(200);
    echo json_encode(
        $result ? $result->fetch_assoc() : [],
    );
} else {
    // Handle invalid request method
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();
?>