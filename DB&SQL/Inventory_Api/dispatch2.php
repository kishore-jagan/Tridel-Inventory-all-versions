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

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get data from the request
    $data = json_decode(file_get_contents('php://input'), true);
    $customerName = isset($data['customerName']) ? $data['customerName'] : null;
    $products = isset($data['products']) ? $data['products'] : null;

    // Log the received data
    error_log("Received customerName: " . print_r($customerName, true));
    error_log("Received products: " . print_r($products, true));

    // Validate customer name
    if (!$customerName || empty($customerName)) {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'Customer name is required']);
        exit;
    }

    // Validate products
    if (!$products || empty($products)) {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'Products list is required']);
        exit;
    }

    try {
        // Prepare SQL statement to insert the dispatch record
        $sql = "INSERT INTO dispatches (customer_name, products) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        if (!$stmt) {
            // Log the error
            error_log("Prepare failed: (" . $conn->errno . ") " . $conn->error);
            http_response_code(500);
            echo json_encode(['status' => 'error', 'message' => 'Failed to prepare statement']);
            exit;
        }

        $stmt->bind_param("ss", $customerName, json_encode($products));

        // Log the query to be executed
        error_log("Executing query: " . $sql);
        error_log("With parameters: customerName=" . $customerName . ", products=" . json_encode($products));

        // Execute the statement
        if ($stmt->execute()) {
            http_response_code(200);
            echo json_encode(['status' => 'success', 'message' => 'Products dispatched successfully']);
        } else {
            // Log the error
            error_log("Execute failed: (" . $stmt->errno . ") " . $stmt->error);
            http_response_code(500);
            echo json_encode(['status' => 'error', 'message' => 'Failed to dispatch products']);
        }

        // Close the statement
        $stmt->close();
    } catch (Exception $e) {
        // Log the exception
        error_log("Exception: " . $e->getMessage());
        http_response_code(500);
        echo json_encode(['status' => 'error', 'message' => 'Internal Server Error']);
    }
} else {
    // Handle invalid request method
    http_response_code(405);
    echo json_encode(['status' => 'error', 'message' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();
?>