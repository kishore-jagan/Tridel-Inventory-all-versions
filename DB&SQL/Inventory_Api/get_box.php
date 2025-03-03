<?php
// db_config.php file inclusion
$dbHost = 'localhost';
$dbName = 'inventory_db';
$dbUser = 'root';
$dbPassword = '';

// Create a database connection
$conn = new mysqli($dbHost, $dbUser, $dbPassword, $dbName);
if ($conn->connect_error) {
    die(json_encode(['status' => 'error', 'message' => 'Database connection failed']));
}

// Fetch all records from the boxDetails table
$query = "SELECT * FROM boxDetails";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $boxDetails = [];

    while ($row = $result->fetch_assoc()) {
        $boxDetails[] = $row;
    }

    // Return the data as a JSON response
    echo json_encode(['status' => 'success', 'data' => $boxDetails]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'No records found']);
}

$conn->close();
?>