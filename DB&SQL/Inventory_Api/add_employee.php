<?php



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
    $name = isset($_POST['name']) ? $_POST['name'] : null;
    $userName = isset($_POST['user_name']) ? $_POST['user_name'] : null;
    $phone_number = isset($_POST['phone_number']) ? $_POST['phone_number'] : null;
    $password = isset($_POST['password']) ? $_POST['password'] : null;
    $email_id = isset($_POST['email_id']) ? $_POST['email_id'] : null;
    $role = isset($_POST['role']) ? $_POST['role'] : null;
    $employee_id = isset($_POST['employee_id']) ? $_POST['employee_id'] : null;

    // Check if all required fields are provided
    if ($name && $password && $email_id && $phone_number && $userName && $role && $employee_id) {

        if (!is_numeric($employee_id)) {
            http_response_code(400);
            echo json_encode(['status' => 'failed', 'message' => 'Employee ID must contain only numbers']);
            exit();
        }

        // Validate phone_number (only numbers)
        if (!is_numeric($phone_number)) {
            http_response_code(400);
            echo json_encode(['status' => 'failed', 'message' => 'Phone number must contain only numbers']);
            exit();
        }

        // Validate email format
        if (!filter_var($email_id, FILTER_VALIDATE_EMAIL)) {
            http_response_code(400);
            echo json_encode(['status' => 'failed', 'message' => 'Invalid email format']);
            exit();
        }
        // Hash the password (consider using password_hash() in a real-world scenario)
        $hashed_password = md5($password);

        // Check if employee_id already exists
        $check_query = "SELECT * FROM persons WHERE employee_id = ?";
        $check_stmt = $conn->prepare($check_query);
        $check_stmt->bind_param("s", $employee_id);
        $check_stmt->execute();
        $check_result = $check_stmt->get_result();

        if ($check_result->num_rows > 0) {
            // Employee ID already exists
            http_response_code(409); // Conflict status code
            echo json_encode(['status' => 'failed', 'message' => 'Employee ID already exists']);
        } else {
            // Insert user data into the database 
            $insert_query = "INSERT INTO persons (name, userName, phone_number, password, email_id, role, employee_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($insert_query);
            $stmt->bind_param("sssssss", $name, $userName, $phone_number, $hashed_password, $email_id, $role, $employee_id);

            if ($stmt->execute()) {
                http_response_code(200);
                echo json_encode(['status' => 'success', 'message' => 'Employee created successfully']);
            } else {
                http_response_code(500);
                echo json_encode(['status' => 'failed', 'message' => 'Registration failed']);
            }

            $stmt->close();
        }

        $check_stmt->close();
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