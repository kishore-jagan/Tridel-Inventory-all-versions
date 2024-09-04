<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Database configuration
$dbHost = 'localhost';
$dbName = 'api';
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
    $serial_no = isset($_POST['serial_no']) ? $_POST['serial_no'] : null;
    $model_no = isset($_POST['model_no']) ? $_POST['model_no'] : null;
    // $vendorName = isset($_POST['vendor_name']) ? $_POST['vendor_name'] : null;
    $qty = isset($_POST['qty']) ? (int) $_POST['qty'] : null;
    $Stock_in_out = isset($_POST['Stock_in_out']) ? $_POST['Stock_in_out'] : null;
    $category = isset($_POST['category']) ? $_POST['category'] : null;
    $price = isset($_POST['price']) ? $_POST['price'] : null;
    $total_price = isset($_POST['total_price']) ? $_POST['total_price'] : null;

    // Check if all required fields are provided
    if ($category && $model_no && $qty !== null && $price !== null && $Stock_in_out !== null) {
        // Check if the product exists
        $checkSql = "SELECT * FROM $category WHERE model_no = ?";
        $checkStmt = $conn->prepare($checkSql);
        $checkStmt->bind_param("s", $model_no);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();

        if ($checkResult->num_rows > 0) {
            // Product exists, update quantity based on stock in/out status
            $existingData = $checkResult->fetch_assoc();
            $currentQty = (int) $existingData['qty'];


            if ($Stock_in_out === 'Stock In') {
                // Increment quantity for stock in
                $newQty = $currentQty + $qty;
                $newPrice = $newQty * $price;


            } elseif ($Stock_in_out === 'Stock Out') {
                // Decrement quantity for stock out
                $newQty = $currentQty - $qty;
                $newPrice = $newQty * $price;
                // If qty is 0, remove the product
                if ($newQty <= 0) {
                    $deleteSql = "DELETE FROM $category WHERE model_no = ?";
                    $deleteStmt = $conn->prepare($deleteSql);
                    $deleteStmt->bind_param("s", $model_no);

                    if ($deleteStmt->execute()) {
                        // Successfully removed product
                        http_response_code(200);
                        echo json_encode(['status' => 'success', 'remark' => 'Product successfully removed']);
                        exit();
                    } else {
                        // Failed to remove product
                        http_response_code(500);
                        echo json_encode(['error' => 'Failed to remove product']);
                        exit();
                    }
                }
            } else {
                // Invalid Stock_in_out value
                http_response_code(400);
                echo json_encode(['error' => 'Invalid Stock_in_out value']);
                exit();
            }

            // Update quantity in the database
            $updateSql = "UPDATE $category SET qty = ?, price = ?,total_price = ? WHERE model_no = ?";
            $updateStmt = $conn->prepare($updateSql);
            $updateStmt->bind_param("idss", $newQty, $price, $newPrice, $model_no);

            if ($updateStmt->execute()) {
                // Successfully updated product
                http_response_code(200);
                echo json_encode(['status' => 'success', 'remark' => 'Product successfully updated']);



                // Check if the product exists in the stockout table
                if ($Stock_in_out === 'Stock Out') {
                    $checkStockoutSql = "SELECT * FROM stockout WHERE model_no = ?";
                    $checkStockoutStmt = $conn->prepare($checkStockoutSql);
                    $checkStockoutStmt->bind_param("s", $model_no);
                    $checkStockoutStmt->execute();
                    $checkStockoutResult = $checkStockoutStmt->get_result();



                    if ($checkStockoutResult->num_rows > 0) {
                        $existingStockoutData = $checkStockoutResult->fetch_assoc();
                        $currentStockoutQty = (int) $existingStockoutData['qty'];
                        $newStockoutQty = $currentStockoutQty + $qty;
                        $newStockoutPrice = $newStockoutQty * $price;
                        $date = date('Y-m-d');

                        // Product exists in stockout table, update quantity
                        $updateStockoutSql = "UPDATE stockout SET qty = qty + ?, total_price = ?, date = ? WHERE model_no = ?";


                        $updateStockoutStmt = $conn->prepare($updateStockoutSql);
                        $updateStockoutStmt->bind_param("isss", $qty, $newStockoutPrice, $date, $model_no);
                        $updateStockoutStmt->execute();
                    } else {
                        $stockPrice = $qty * $price;
                        $date = date('Y-m-d');
                        // Product doesn't exist in stockout table, insert new row
                        $insertStockoutSql = "INSERT INTO stockout (name, serial_no, model_no, category, qty, price, total_price, stock, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        $insertStockoutStmt = $conn->prepare($insertStockoutSql);
                        $insertStockoutStmt->bind_param("sssssssss", $name, $serial_no, $model_no, $category, $qty, $price, $stockPrice, $Stock_in_out, $date);
                        $insertStockoutStmt->execute();
                    }

                    echo json_encode(['status' => 'success', 'remark' => 'Data added to stockout']);
                }
            } else {
                // Failed to update product
                http_response_code(500);
                echo json_encode(['error' => 'Failed to update product: ' . $updateStmt->error]);
            }

            $updateStmt->close();
            if (isset($checkStockoutStmt))
                $checkStockoutStmt->close();
            if (isset($updateStockoutStmt))
                $updateStockoutStmt->close();
        } else {
            // Product does not exist
            http_response_code(404);
            echo json_encode(['error' => 'Product not found']);
        }

        $checkStmt->close();
    } else {
        // Missing required fields
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