<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include Barcode library
require 'vendor/autoload.php';

use Picqer\Barcode\BarcodeGeneratorHTML;

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
    $name = isset($_POST['name']) ? $_POST['name'] : null;
    $serial_no = isset($_POST['serial_no']) ? $_POST['serial_no'] : null;
    $model_no = isset($_POST['model_no']) ? $_POST['model_no'] : null;
    $main_category = isset($_POST['main_category']) ? $_POST['main_category'] : null;
    $category = isset($_POST['category']) ? $_POST['category'] : null;
    $location = isset($_POST['location']) ? $_POST['location'] : null;
    $returnable = isset($_POST['returnable']) ? $_POST['returnable'] : null;
    $type = isset($_POST['type']) ? $_POST['type'] : null;
    $qty = isset($_POST['qty']) ? $_POST['qty'] : null;
    $price = isset($_POST['price']) ? $_POST['price'] : null;
    $total_price = isset($_POST['total_price']) ? $_POST['total_price'] : null;
    $item_remarks = isset($_POST['item_remarks']) ? $_POST['item_remarks'] : null;
    $project_name = isset($_POST['project_name']) ? $_POST['project_name'] : null;
    $project_no = isset($_POST['project_no']) ? $_POST['project_no'] : null;
    $purchase_order = isset($_POST['purchase_order']) ? $_POST['purchase_order'] : null;
    $invoice_no = isset($_POST['invoice_no']) ? $_POST['invoice_no'] : null;
    $vendor_name = isset($_POST['vendor_name']) ? $_POST['vendor_name'] : null;
    $date = isset($_POST['date']) ? $_POST['date'] : null;
    $place = isset($_POST['place']) ? $_POST['place'] : null;
    $mos = isset($_POST['mos']) ? $_POST['mos'] : null;
    $receiver_name = isset($_POST['receiver_name']) ? $_POST['receiver_name'] : null;
    $vendor_remarks = isset($_POST['vendor_remarks']) ? $_POST['vendor_remarks'] : null;
    $Stock_in_out = isset($_POST['Stock_in_out']) ? $_POST['Stock_in_out'] : null;



    // Check if all required fields are provided
    if ($name && $serial_no && $model_no && $main_category && $category && $location && $type && $qty && $price && $total_price && $item_remarks && $project_name && $project_no && $purchase_order && $invoice_no && $vendor_name && $date && $place && $mos && $receiver_name && $vendor_remarks) {
        // Generate a unique barcode data
        $barcodeData = uniqid();

        // Generate Barcode HTML
        $barcodeGenerator = new BarcodeGeneratorHTML();
        $barcodeHTML = $barcodeGenerator->getBarcode($barcodeData, $barcodeGenerator::TYPE_CODE_128);

        // Check if model number already exists
        $checkSql = "SELECT * FROM $main_category WHERE serial_no = ?";
        $checkStmt = $conn->prepare($checkSql);
        $checkStmt->bind_param("s", $serial_no);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();

        if ($checkResult->num_rows > 0) {
            // Model number already exists
            http_response_code(200);
            echo json_encode(['status' => 'Failed', 'remark' => 'Serial No already available']);
        } else {

            $selectedVendor = $vendor_name;

            // Model number does not exist, proceed to save data
            $sql = "INSERT INTO $main_category (name, serial_no, model_no, main_category, category, location, returnable, type, qty, item_remarks, project_name, project_no, purchase_order, invoice_no, vendor_name, date, place, mos, receiver_name, vendor_remarks, Stock_in_out, barcode, price, total_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssssssssssssssssssssssss", $name, $serial_no, $model_no, $main_category, $category, $location, $returnable, $type, $qty, $item_remarks, $project_name, $project_no, $purchase_order, $invoice_no, $selectedVendor, $date, $place, $mos, $receiver_name, $vendor_remarks, $Stock_in_out, $barcodeData, $price, $total_price);

            if ($stmt->execute()) {
                // Successfully added product with barcode
                http_response_code(200);
                echo json_encode(['status' => 'success', 'remark' => 'Product successfully added with barcode']);
            } else {
                // Failed to add product
                http_response_code(500);
                echo json_encode(['error' => 'Failed to add product']);
            }

            $stmt->close();
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