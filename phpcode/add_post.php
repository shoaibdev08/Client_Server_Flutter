<?php
include 'db.php';

$title = $_POST['title'];
$body = $_POST['body'];

$sql = "INSERT INTO posts (title, body) VALUES ('$title', '$body')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("message" => "Post added successfully"));
} else {
    echo json_encode(array("message" => "Error: " . $conn->error));
}

$conn->close();
?>
