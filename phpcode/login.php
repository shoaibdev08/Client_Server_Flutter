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

if (!$data || !isset($data->username) || !isset($data->password)) {
    http_response_code(400); // Bad request
    echo json_encode(array("message" => "Invalid input"));
    exit();
}

$username = $data->username;
$password = $data->password;

// Check if username exists and verify password
$sql = "SELECT password FROM users WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    if (password_verify($password, $row['password'])) {
        http_response_code(200); // OK
        echo json_encode(array("message" => "Login successful."));
    } else {
        http_response_code(401); // Unauthorized
        echo json_encode(array("message" => "Invalid password."));
    }
} else {
    http_response_code(404); // Not found
    echo json_encode(array("message" => "User not found."));
}

$conn->close();
?>
