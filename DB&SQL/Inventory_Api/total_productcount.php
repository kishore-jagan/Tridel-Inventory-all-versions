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
function getTotalRows($conn, $tableName)
{
    $result = $conn->query("SELECT COUNT(*) AS total_rows FROM $tableName");

    if ($result && $row = $result->fetch_assoc()) {
        return $row['total_rows'];
    } else {
        return 0;
    }
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Get total rows for each table
    $totalRowsTable1 = getTotalRows($conn, 'geoscience');
    $totalRowsTable2 = getTotalRows($conn, 'geoinformatics');
    $totalRowsTable3 = getTotalRows($conn, 'geoengineering');
    $totalRowsTable4 = getTotalRows($conn, 'ess');

    // Return the total rows as JSON
    http_response_code(200);
    echo json_encode([
        'table1_total_rows' => $totalRowsTable1,
        'table2_total_rows' => $totalRowsTable2,
        'table3_total_rows' => $totalRowsTable3,
        'table4_total_rows' => $totalRowsTable4
    ]);
} else {
    // Handle invalid request method
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();
?>