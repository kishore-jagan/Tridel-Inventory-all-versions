<?php

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

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Retrieve all registered users' names, email IDs, and phone numbers from the database
    $sql = "SELECT id, receiverName FROM receiver";
    $result = $conn->query($sql);

    if ($result) {

        $receivers = [];

        // Fetch data from the result set
        while ($row = $result->fetch_assoc()) {
            $receivers[] = [
                'id' => $row['id'],
                'receiverName' => $row['receiverName'],

            ];
        }

        // Output the users' data in JSON format
        http_response_code(200);
        echo json_encode(['receivers' => $receivers]);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch receivers']);
    }
} else {
    // Handle invalid request method
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();

?>