<?php
include 'conn.php';

$name = $_POST['name'];
$email = $_POST['email'];
$mobile = $_POST['mobile'];
$password = $_POST['password'];
$fcm_token = $_POST['fcm_token'];

$sqlmax = "SELECT max(id) FROM `user`";
$resultmax = mysqli_query($connect, $sqlmax);
$rowmax = mysqli_fetch_array($resultmax);

$idnomax = ($rowmax[0] == null) ? 1 : $rowmax[0] + 1;

$query = "INSERT INTO user (id, Name, Email, Mobile, Password, fcm_token, status) VALUES ('$idnomax','$name','$email','$mobile','$password','$fcm_token', 1)";
mysqli_query($connect, $query);

mysqli_close($connect);
?>