<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

include 'db.php'; // Include your database connection

// Handle OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit();
}

// Get POST data
$data = json_decode(file_get_contents("php://input"));

if (!$data) {
    http_response_code(400); // Bad request
    echo json_encode(array("message" => "Invalid input"));
    exit();
}

$username = $data->username;
$password = password_hash($data->password, PASSWORD_DEFAULT); // Hash password

// Check if username already exists
$sql = "SELECT * FROM users WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    http_response_code(409); // Conflict: Username already exists
    echo json_encode(array("message" => "Username already exists."));
    exit();
}

// Insert new user into database
$insertSql = "INSERT INTO users (username, password) VALUES (?, ?)";
$insertStmt = $conn->prepare($insertSql);
$insertStmt->bind_param("ss", $username, $password);

if ($insertStmt->execute()) {
    http_response_code(201); // Created
    echo json_encode(array("message" => "User registered successfully."));
} else {
    http_response_code(500); // Server error
    echo json_encode(array("message" => "Registration failed."));
}

$conn->close();
?>
