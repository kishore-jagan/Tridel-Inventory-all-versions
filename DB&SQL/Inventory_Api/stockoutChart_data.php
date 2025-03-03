<?php
$dbHost = 'localhost';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'inventory_db';

$conn = new mysqli($dbHost, $dbUsername, $dbPassword, $dbName);


if ($conn->connect_error) {
    die("connection failed: " . $conn->connect_error);
}

$sql = "SELECT date, qty, name, main_category, category From stockout";
$result = $conn->query($sql);

$data = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = array(
            "date" => $row["date"],
            "qty" => $row["qty"],
            "name" => $row["name"],
            "main_category" => $row["main_category"],
            "category" => $row["category"],
        );
    }
} else {
    echo "0 results";
}

echo json_encode($data);

$conn->close();
?>