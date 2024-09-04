<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$dbHost = 'localHost';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'inventory_db';

$conn = new mysqli($dbHost, $dbUsername, $dbPassword, $dbName);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    $sql = "SELECT * FROM stockout";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $stockOutRecords = [];

        while ($row = $result->fetch_assoc()) {
            $stockOutRecords[] = $row;
        }

        echo json_encode($stockOutRecords);

    } else {

        echo json_encode([]);
    }

} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

$conn->close();
?>