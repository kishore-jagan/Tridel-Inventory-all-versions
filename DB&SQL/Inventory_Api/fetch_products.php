<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$dbHost = 'localhost';
$dbName = 'inventory_db';
$dbUser = 'root';
$dbPassword = '';

$conn = new mysqli($dbHost, $dbUser, $dbPassword, $dbName);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    $geoscienceSql = "SELECT * FROM geoscience";
    $geoscienceResult = $conn->query($geoscienceSql);
    $geoscienceData = [];

    if ($geoscienceResult->num_rows > 0) {
        while ($row = $geoscienceResult->fetch_assoc()) {
            $geoscienceData[] = $row;
        }
    }

    $geoinformaticsSql = "SELECT * from geoinformatics";
    $geoinformaticsResult = $conn->query($geoinformaticsSql);
    $geoinformaticsData = [];

    if ($geoinformaticsResult->num_rows > 0) {
        while ($row = $geoinformaticsResult->fetch_assoc()) {
            $geoinformaticsData[] = $row;
        }
    }


    $geoengineeringSql = "SELECT * from geoengineering";
    $geoengineeringResult = $conn->query($geoengineeringSql);
    $geoengineeringData = [];


    if ($geoengineeringResult->num_rows > 0) {
        while ($row = $geoengineeringResult->fetch_assoc()) {
            $geoengineeringData[] = $row;
        }
    }

    $essSql = "SELECT * from ess";
    $essResult = $conn->query($essSql);
    $essData = [];


    if ($essResult->num_rows > 0) {
        while ($row = $essResult->fetch_assoc()) {
            $essData[] = $row;
        }
    }



    $combinedData = (['status' => 'Success', 'products' => array_merge($geoscienceData, $geoinformaticsData, $geoengineeringData, $essData)]);


    http_response_code(200);
    echo json_encode($combinedData);
} else {

    http_response_code(405);
    echo json_encode(['error' => 'Method Not Allowed']);
}

$conn->close();
?>