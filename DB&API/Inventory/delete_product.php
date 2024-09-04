<?php

// Your database credentials
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "api";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Assuming you pass both ID and Category via a GET request
if (isset($_GET['id']) && isset($_GET['category'])) {
    $id = $_GET['id'];
    $category = $_GET['category'];

    // Use prepared statement to prevent SQL injection
    $stmt = $conn->prepare("DELETE FROM $category WHERE id = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        http_response_code(200);
        echo "Row deleted successfully";
    } else {
        echo "Error deleting row: " . $stmt->error;
    }

    $stmt->close();
} else {
    echo "ID or Category parameter not provided";
}

// Close connection
$conn->close();

?>
