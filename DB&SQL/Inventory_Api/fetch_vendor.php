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
    $sql = "SELECT id, vendorName FROM vendor";
    $result = $conn->query($sql);

    if ($result) {

        $users = [];

        // Fetch data from the result set
        while ($row = $result->fetch_assoc()) {
            $users[] = [
                'id' => $row['id'],
                'vendorName' => $row['vendorName'],

            ];
        }

        // Output the users' data in JSON format
        http_response_code(200);
        echo json_encode(['vendors' => $users]);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch users']);
    }
} else {
    // Handle invalid request method
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();

?>