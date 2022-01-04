<?php

header('Content-Type: application/json');

$dominio_loja = 'rdcommerce.com.br';
$msg = '';
$json = Array();
include 'open_database.php';

$date = new DateTime();
$msg .= $date->format('d/m/Y - H:i') . '<br>';

try {

	if (empty($_REQUEST)) { 
		$msg .= 'Não encontramos a loja a ser gerada<br>';
		throw new Exception('');
	}

	$nome_da_loja = $_REQUEST['nome_da_loja'];

	$stmt = $con->prepare("select email,senha_inicial,nome_da_loja from _usuarios where nome_da_loja=? and status>0 limit 1");
	$stmt->bind_param('s', $nome_da_loja);
	$stmt->execute();
	$result = $stmt->get_result();

	if ($result->num_rows === 0) {
		$msg .= 'Não encontramos a loja a ser gerada<br>';
		throw new Exception('');
	}

	while ($row = $result->fetch_assoc()) {
		$nome_da_loja = $row['nome_da_loja'];
		$email = $row['email'];
		$senha_inicial = $row['senha_inicial'];
	}

	//Se o database ja existir aguarda finalizar o processo de criacao da loja
	$ja_existe = 0;
	$sql = $con->query("select schema_name from information_schema.schemata where schema_name='" . $nome_da_loja . "' limit 1");
	while ($row = $sql->fetch_assoc()) {
		$ja_existe = 1;
	}

	if ($ja_existe == 1) {
		sleep(2*60);
		
		$msg .= 'Saiu da espera para criar a loja';
		throw new Exception('');
	}

	$sql = $con->query("CREATE SCHEMA `" . $nome_da_loja . "` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci");
	if ($sql) {
		$msg .= 'Sucesso ao criar database<br>';
	} else {
		$msg .= 'Erro ao criar database<br>';
		throw new Exception('');
	}

	//Caminha para executar o mysql do XAMPP
	$xampp_mysql = "C:\\xampp\\mysql\\bin\\";

	//$command = $xampp_mysql.'mysql -u' . $sql_user .' -p' .$sql_password .' '. $nome_da_loja .' < '. realpath('../_private/opencart_roadie.sql');
	
	$command = 'mysql -u' . $sql_user .' -p' .$sql_password .' '. $nome_da_loja .' < '. realpath('../_private/opencart_roadie.sql');

	$output=array();
	exec($command,$output,$worked);

	if ($output) {
		$msg .= json_encode($output).'<br>';
	}

	if ($worked == 0) {
		$msg .= 'Sucesso ao importar database<br>';
	} else {
		$msg .= 'Erro ao importar database<br>';
		throw new Exception('');		
	}

	$sql = $con->query("truncate " . $nome_da_loja . ".oc_address");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_category");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_category_description");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_category_to_store");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_coupon");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_customer");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_download");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_download_description");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_manufacturer");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_manufacturer_to_store");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_review");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_order");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_abandoned_products");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_customer_activity");
	$sql = $con->query("truncate " . $nome_da_loja . ".oc_affiliate_activity");
	
	$sql = $con->query("delete " . $nome_da_loja . ".oc_setting where value like '%.com%'");
	$sql = $con->query("delete " . $nome_da_loja . ".oc_setting where value like '%localhost%'");
	$sql = $con->query("delete " . $nome_da_loja . ".oc_setting where value like '%127.%'");
	$sql = $con->query("delete " . $nome_da_loja . ".oc_setting where value like '%192.168%'");
	$sql = $con->query("delete " . $nome_da_loja . ".oc_setting where value like '%10.%'");

	$msg .= 'Sucesso ao apagar pedidos do template padrão<br>';

	$sql = $con->query("truncate " . $nome_da_loja . ".oc_user");
	$sql = $con->query("insert into " . $nome_da_loja . ".oc_user (user_group_id,username,password,salt,email,status,date_added,image,code,ip,firstname,lastname) values (1,'admin','','ROADIE','" . $email . "',1,now(),'','','','','')");
	$sql = $con->query("update " . $nome_da_loja . ".oc_user set password=SHA1(CONCAT(salt,SHA1(CONCAT(salt,SHA1('" . $senha_inicial . "'))))) where username='admin'");

	$msg .= 'Sucesso ao definir senha padrão<br>';

	$date = new DateTime();
	$msg .= $date->format('d/m/Y - H:i') . '<br>';	

	//Comando para criar uma pasta no Windows
	//$command='md '. realpath('../') . '\\' . $nome_da_loja;
	$command='mkdir '. realpath('../') . '/' . $nome_da_loja;
	
	$output=array();
	exec($command,$output,$worked);

	if ($worked == 0) {
		$msg .= 'Sucesso ao criar a pasta no diretório de lojas<br>';
	} else {
		$msg .= 'Erro ao tentar criar a pasta no diretório de lojas<br>';
		throw new Exception('');		
	}

	//Caminho para executar o WinRAR instalado no servidor Windows
	$windows_winrar = "\"C:\\Program Files\\WinRAR\\WinRAR.exe\"";

	//$command = $windows_winrar.' x -ibck '. realpath('../_private/opencart_roadie.zip') .' *.* '. realpath('../' . $nome_da_loja);
	
	$command = 'cd ' . realpath('../' . $nome_da_loja) . '; unzip  '. realpath('../_private/opencart_roadie.zip');

	$output=array();
	exec($command,$output,$worked);

	if ($output) {
		$msg .= json_encode($output).'<br>';
	}

	//if ($worked == 0) {
	if ($worked == 1) {
		$msg .= 'Sucesso ao descompactar arquivos<br>';
	} else {
		$msg .= 'Erro ao descompactar arquivos<br>' . $worked .'<br>' ;
		throw new Exception('');		
	}

	$file = file_get_contents('opencart_config.php');
	$file = str_replace("#nome_da_loja#", $nome_da_loja, $file);
	$file = str_replace("#dominio_loja#", $dominio_loja, $file);
	file_put_contents(realpath('../' . $nome_da_loja . '/config.php'), $file);

	$file = file_get_contents('opencart_config_admin.php');
	$file = str_replace("#nome_da_loja#", $nome_da_loja, $file);
	$file = str_replace("#dominio_loja#", $dominio_loja, $file);
	file_put_contents(realpath('../' . $nome_da_loja . '/admin/config.php'), $file);

	$msg .= 'Modificado arquivos de configurações<br>';

	$sql = $con->query("select nome_da_loja from _usuarios where status>0");

	$htaccess = '#Este arquivo é gerado automaticamente através do script de criação de lojas' . PHP_EOL . PHP_EOL;
	$htaccess = $htaccess . 'RewriteEngine On'. PHP_EOL;
	while ($row = $sql->fetch_assoc()) {
		$nome_da_loja = $row['nome_da_loja'];

		$htaccess = $htaccess . 'RewriteCond %{HTTP_HOST} ' . $nome_da_loja . '.' . $dominio_loja . '$' . PHP_EOL;
		$htaccess = $htaccess . 'RewriteCond %{REQUEST_URI} !^/' . $nome_da_loja . PHP_EOL;
		$htaccess = $htaccess . 'RewriteRule ^(.*)$ /' . $nome_da_loja . '/$1 [L]'. PHP_EOL . PHP_EOL;
	}


	$sql = $con->query("select dominio, nome_da_loja from _dominios");

	$htaccess = $htaccess . '#Aqui gera-se as lojas com dominio proprio' . PHP_EOL . PHP_EOL;
	//$htaccess = $htaccess . 'RewriteEngine On'. PHP_EOL;
	while ($row = $sql->fetch_assoc()) {
		$dominio = $row['dominio'];
		$nome_da_loja = $row['nome_da_loja'];

		$htaccess = $htaccess . 'RewriteCond %{HTTP_HOST} ' . $dominio . '$' . PHP_EOL;
		$htaccess = $htaccess . 'RewriteCond %{REQUEST_URI} !^/' . $nome_da_loja . PHP_EOL;
		$htaccess = $htaccess . 'RewriteRule ^(.*)$ /' . $nome_da_loja . '/$1 [L]'. PHP_EOL . PHP_EOL;
	}

	file_put_contents('../.htaccess', $htaccess);

	$msg .= 'Gerado subdomínio<br>';

	$sql = $con->query("update _usuarios set status=2 where nome_da_loja='" . $nome_da_loja . "'");

	$date = new DateTime();
	$msg .= $date->format('d/m/Y - H:i') . '<br>';	

	$json['status'] = 'true';

} catch (Exception $e) {
	
	$json['status'] = 'false';

} finally {	

	$json['html'] = $msg;	
	echo json_encode($json);

}