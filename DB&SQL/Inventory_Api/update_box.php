<?php
// db_config.php file inclusion
include 'db_config.php';

// Get the POST data
$data = json_decode(file_get_contents('php://input'), true);

if ($data) {
    // Extract data from the input
    $token = $data['token']; // Unique token for the row
    $productName = $data['name']; // Name of the product to remove
    $productQty = $data['qty'];   // Quantity of the product to remove

    // Fetch the current JSON data from the database
    $sql = "SELECT products, status FROM boxDetails WHERE token = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $token);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();

    if ($row) {
        // Decode the JSON data into a PHP array
        $products = json_decode($row['products'], true);

        // Remove the specific item from the array
        $found = false;
        foreach ($products as $key => $product) {
            if ($product['name'] == $productName && $product['qty'] == $productQty) {
                unset($products[$key]);
                $found = true;
                break;
            }
        }

        if ($found) {
            // Re-index the array (optional)
            $products = array_values($products);

            // Check if the array is empty after removal
            $status = 0; // Default status is false
            if (empty($products)) {
                $status = 1; // Set status to true if the array is empty
            }

            // Encode the array back into JSON
            $updatedProductsJson = json_encode($products);

            // Update the JSON data and status in the database
            $updateSql = "UPDATE boxDetails SET products = ?, status = ? WHERE token = ?";
            $updateStmt = $conn->prepare($updateSql);
            $updateStmt->bind_param("sis", $updatedProductsJson, $status, $token);

            if ($updateStmt->execute()) {
                echo json_encode(['status' => 'success', 'message' => 'Product removed successfully.', 'status_changed' => $status]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Failed to update the products.']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Product not found.']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No record found for the provided token.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input data.']);
}

// Close the connection
$conn->close();
?>