<?php

$sql_server = 'localhost';
$sql_user = 'root';
$sql_password = 'R1D2C3ommerce';
$sql_database = '_lojas';

$con = new mysqli($sql_server, $sql_user, $sql_password, $sql_database);
if (!$con) {
	echo 'Erro ao conectar com o MySql!';
	exit;
}

?>