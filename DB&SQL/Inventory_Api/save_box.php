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

// Function to generate a unique token
function generateToken()
{
    return bin2hex(random_bytes(16));
}

// Get the POST data
$data = json_decode(file_get_contents('php://input'), true);

if ($data) {
    // Extracting data from the input
    $billNo = $data['billNo'];
    $poNo = $data['poNo'];
    $date = $data['date'];
    $supplierName = $data['supplierName'];
    $remark = $data['remark'];
    $recieverName = $data['recieverName'];
    $location = $data['location'];
    $mos = $data['mos'];
    $products = $data['products']; // array of products with name and qty

    // Generate a unique token
    $token = generateToken();

    // Insert into boxDetails table with status set to false
    $status = 0; // False in MySQL
    $stmt = $conn->prepare("INSERT INTO boxDetails (billNo, poNo, date, supplierName, remark, recieverName, location, mos, products, token, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssssssssi", $billNo, $poNo, $date, $supplierName, $remark, $recieverName, $location, $mos, $products, $token, $status);

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Data saved successfully.']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to save data.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input data.']);
}

$conn->close();
?>