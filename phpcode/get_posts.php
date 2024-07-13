<?php
// Allow requests from any origin (not recommended for production)
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Include your database connection logic (assuming db.php contains your connection details)
include 'db.php';

// Query to fetch posts from database
$sql = "SELECT * FROM posts";
$result = $conn->query($sql);

$posts = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $posts[] = $row;
    }
}

// Output posts data as JSON
echo json_encode($posts);

// Close database connection
$conn->close();
?>
