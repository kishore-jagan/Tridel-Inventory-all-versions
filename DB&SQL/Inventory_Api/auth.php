<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

error_reporting(0);
ini_set('display_errors', 0);

// Database configuration
$dbHost = 'localhost';
$dbName = 'inventory_db'; // Replace with your database name
$dbUser = 'root'; // Replace with your database username
$dbPassword = ''; // Replace with your database password

// Create a database connection
$conn = new mysqli($dbHost, $dbUser, $dbPassword, $dbName);

// Check the connection
if ($conn->connect_error) {
    die(json_encode(['status' => 'error', 'message' => 'Database connection failed']));
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get data from the request
    $userInput = isset($_POST['email_or_username']) ? $_POST['email_or_username'] : null;
    $password = isset($_POST['password']) ? $_POST['password'] : null;

    // Check if all required fields are provided
    if ($userInput && $password) {
        // Query to check if user exists and retrieve user details
        $query = "SELECT * FROM persons WHERE email_id = ? OR userName = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("ss", $userInput, $userInput);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // User found, fetch user details
            $user = $result->fetch_assoc();
            $hashed_password = $user['password'];
            $username = $user['userName']; // Get the stored hashed password

            // Verify the password
            if (md5($password) === $hashed_password) {
                // User authenticated successfully, fetch user details
                $username = isset($user['userName']) ? $user['userName'] : ''; // Example: Retrieve username
                // You can retrieve any other relevant user information here

                http_response_code(200);
                echo json_encode([
                    'status' => 'success',
                    'message' => 'Login successful',
                    'user' => [
                        'username' => $username,
                        // Add other user details as needed
                    ]
                ]);
            } else {
                // Invalid credentials
                http_response_code(401);
                echo json_encode(['status' => 'error', 'message' => 'Invalid email or password']);
            }
        } else {
            // User not found
            http_response_code(401);
            echo json_encode(['status' => 'error', 'message' => 'Invalid email or password']);
        }

        $stmt->close();
    } else {
        http_response_code(400);
        echo json_encode(['message' => 'Missing required fields']);
    }
} else {
    // Handle invalid request method
    http_response_code(405);
    echo json_encode(['message' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();

?>