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
    $name = isset($_POST['name']) ? $_POST['name'] : null;
    $serial_no = isset($_POST['serial_no']) ? $_POST['serial_no'] : null;
    $model_no = isset($_POST['model_no']) ? $_POST['model_no'] : null;
    $qty = isset($_POST['qty']) ? (int) $_POST['qty'] : null;
    $Stock_in_out = isset($_POST['Stock_in_out']) ? $_POST['Stock_in_out'] : null;
    $main_category = isset($_POST['main_category']) ? $_POST['main_category'] : null;
    $category = isset($_POST['category']) ? $_POST['category'] : null;
    $price = isset($_POST['price']) ? $_POST['price'] : null;

    if ($main_category && $model_no && $qty !== null && $price !== null && $Stock_in_out !== null) {
        if ($Stock_in_out === 'Stock In') {
            stockIn($conn, $main_category, $model_no, $qty, $price);
        } elseif ($Stock_in_out === 'Stock Out') {
            stockOut($conn, $main_category, $model_no, $qty, $price, $name, $serial_no, $category, $Stock_in_out);
        } else {
            http_response_code(400);
            echo json_encode(['error' => 'Invalid Stock_in_out value']);
        }
    } else {
        http_response_code(400);
        echo json_encode(['error' => 'Missing required fields']);
    }
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

// Close the database connection
$conn->close();

function stockIn($conn, $main_category, $model_no, $qty, $price)
{
    $checkSql = "SELECT * FROM $main_category WHERE model_no = ?";
    $checkStmt = $conn->prepare($checkSql);
    $checkStmt->bind_param("s", $model_no);
    $checkStmt->execute();
    $checkResult = $checkStmt->get_result();

    if ($checkResult->num_rows > 0) {
        $existingData = $checkResult->fetch_assoc();
        $currentQty = (int) $existingData['qty'];
        $newQty = $currentQty + $qty;
        $newPrice = $newQty * $price;

        $updateSql = "UPDATE $main_category SET qty = ?, price = ?, total_price = ? WHERE model_no = ?";
        $updateStmt = $conn->prepare($updateSql);
        $updateStmt->bind_param("idss", $newQty, $price, $newPrice, $model_no);

        if ($updateStmt->execute()) {
            http_response_code(200);
            echo json_encode(['status' => 'success', 'remark' => 'Product successfully updated']);
        } else {
            http_response_code(500);
            echo json_encode(['error' => 'Failed to update product: ' . $updateStmt->error]);
        }

        $updateStmt->close();
    } else {
        http_response_code(404);
        echo json_encode(['error' => 'Product not found']);
    }

    $checkStmt->close();
}

function stockOut($conn, $main_category, $model_no, $qty, $price, $name, $serial_no, $category, $Stock_in_out)
{
    $checkSql = "SELECT * FROM $main_category WHERE model_no = ?";
    $checkStmt = $conn->prepare($checkSql);
    $checkStmt->bind_param("s", $model_no);
    $checkStmt->execute();
    $checkResult = $checkStmt->get_result();

    if ($checkResult->num_rows > 0) {
        $existingData = $checkResult->fetch_assoc();
        $currentQty = (int) $existingData['qty'];
        $newQty = $currentQty - $qty;
        $newPrice = $newQty * $price;

        if ($newQty <= 0) {
            $deleteSql = "DELETE FROM $main_category WHERE model_no = ?";
            $deleteStmt = $conn->prepare($deleteSql);
            $deleteStmt->bind_param("s", $model_no);

            if ($deleteStmt->execute()) {
                $deleteStmt->close();
            } else {
                http_response_code(500);
                echo json_encode(['error' => 'Failed to remove product']);
                exit();
            }
        } else {
            $updateSql = "UPDATE $main_category SET qty = ?, price = ?, total_price = ? WHERE model_no = ?";
            $updateStmt = $conn->prepare($updateSql);
            $updateStmt->bind_param("idss", $newQty, $price, $newPrice, $model_no);

            if ($updateStmt->execute()) {
                $updateStmt->close();
            } else {
                http_response_code(500);
                echo json_encode(['error' => 'Failed to update product: ' . $updateStmt->error]);
                exit();
            }
        }

        $insertStockoutSql = "INSERT INTO stockout (name, serial_no, model_no, main_category, category, qty, price, total_price, stock, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $insertStockoutStmt = $conn->prepare($insertStockoutSql);
        $stockPrice = $qty * $price;
        $date = date('Y-m-d');
        $insertStockoutStmt->bind_param("ssssssssss", $name, $serial_no, $model_no, $main_category, $category, $qty, $price, $stockPrice, $Stock_in_out, $date);

        if ($insertStockoutStmt->execute()) {
            echo json_encode(['status' => 'success', 'remark' => 'New data added to stockout']);
        } else {
            echo json_encode(['error' => 'Failed to insert into stockout: ' . $insertStockoutStmt->error]);
        }

        $insertStockoutStmt->close();
    } else {
        http_response_code(404);
        echo json_encode(['error' => 'Product not found']);
    }

    $checkStmt->close();
}
?>