<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Your database credentials
$dbHost = 'localhost';
$dbName = 'inventory_db';
$dbUser = 'root';
$dbPassword = '';

// Create connection
$conn = new mysqli($dbHost, $dbUser, $dbPassword, $dbName);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch dispatched products
$sql = "SELECT * FROM dispatches";
$result = $conn->query($sql);

$dispatchedProducts = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $dispatchedProducts[] = $row;
    }
}

http_response_code(200);
echo json_encode(['status' => 'success', 'data' => $dispatchedProducts]);

// Close the database connection
$conn->close();
?>