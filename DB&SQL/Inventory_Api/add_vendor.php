<?php
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

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get data from the request
    $vendorName = isset($_POST['vendorName']) ? $_POST['vendorName'] : null;

    // Check if all required fields are provided
    if ($vendorName) {
        // Check if the vendor name already exists in the database
        $checkSql = "SELECT * FROM vendor WHERE vendorName = ?";
        $checkStmt = $conn->prepare($checkSql);
        $checkStmt->bind_param("s", $vendorName);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();

        if ($checkResult->num_rows > 0) {
            // Vendor name already exists, return a response
            http_response_code(200);
            echo json_encode(['message' => 'Vendor already available']);
        } else {
            // Vendor name does not exist, insert into the database
            $insertSql = "INSERT INTO vendor (vendorName) VALUES (?)";
            $insertStmt = $conn->prepare($insertSql);
            $insertStmt->bind_param("s", $vendorName);

            if ($insertStmt->execute()) {
                http_response_code(200);
                echo json_encode(['message' => 'Vendor added successfully']);
            } else {
                http_response_code(500);
                echo json_encode(['error' => 'Registration failed']);
            }

            $insertStmt->close();
        }

        $checkStmt->close();
    } else {
        http_response_code(400);
        echo json_encode(['error' => 'Missing required fields']);
    }
} else {
    // Handle invalid request method
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();
?>