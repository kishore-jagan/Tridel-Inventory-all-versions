<?php
header('Content-Type: application/json');

// Database configuration
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "inventory_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

// Function to handle the API request
function handleRequest($conn)
{
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Get input data from POST request
        $id = isset($_POST['id']) ? (int) $_POST['id'] : null;
        $category = isset($_POST['category']) ? $_POST['category'] : null;

        if ($id && $category) {
            // Escape category to prevent SQL injection
            $category = $conn->real_escape_string($category);

            // Fetch data from the specified category table by id
            $sql = "SELECT * FROM `$category` WHERE id = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();

                // Prepare SQL to insert the data into bin table
                $columns = implode(", ", array_keys($row));
                $placeholders = implode(", ", array_fill(0, count($row), '?'));

                $insertSql = "INSERT INTO `bin` ($columns) VALUES ($placeholders)";
                $insertStmt = $conn->prepare($insertSql);

                // Bind parameters dynamically
                $types = str_repeat('s', count($row)); // All values are treated as strings
                $values = array_values($row);
                $insertStmt->bind_param($types, ...$values);

                if ($insertStmt->execute()) {
                    // Delete the row from the original table
                    $deleteSql = "DELETE FROM `$category` WHERE id = ?";
                    $deleteStmt = $conn->prepare($deleteSql);
                    $deleteStmt->bind_param('i', $id);

                    if ($deleteStmt->execute()) {
                        echo json_encode(["status" => "success", "message" => "Data moved to bin and deleted from $category table."]);
                    } else {
                        echo json_encode(["status" => "error", "message" => "Failed to delete data from $category table."]);
                    }
                } else {
                    echo json_encode(["status" => "error", "message" => "Failed to insert data into bin table."]);
                }
            } else {
                echo json_encode(["status" => "error", "message" => "No data found for the given id in $category table."]);
            }
        } else {
            echo json_encode(["status" => "error", "message" => "Invalid or missing id or category."]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid request method. Use POST."]);
    }
}

// Handle the request
handleRequest($conn);

// Close the connection
$conn->close();
?>