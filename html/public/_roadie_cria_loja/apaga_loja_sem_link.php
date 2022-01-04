<?php

include 'open_database.php';

echo '<h1>Pega todos os databases e verifica se existe o respectivo diretorio</h1>';

//Pega todos os databases e verifica se existe o respectivo diretorio

$sql = $con->query("show databases");

while ($row = $sql->fetch_assoc()) {
	$database = $row['Database'];

	if ($database == 'information_schema') {
		continue;
	}

	if ($database == 'mysql') {
		continue;
	}

	if ($database == 'phpmyadmin') {
		continue;
	}

	if ($database == 'performance_schema') {
		continue;
	}

	if ($database == 'sys') {
		continue;
	}

	if (strpos($database,'_') === 0) {
		continue;
	}

	if (strpos($database,'rdcommer_') === 0) {
		continue;
	}

	if (strpos($database,'blog_') === 0) {
		continue;
	}

	if (strpos($database,'painel_') === 0) {
		continue;
	}

	//Buscar diretórios com tratamento especial, ex: loja_manutencao, inativo_loja

	if (count(glob("../".$database."_*")) > 0) {
		continue;
	}

	if (count(glob("../*_".$database)) > 0) {
		continue;
	}

	if (is_dir('../' . $database)) {
		continue;
	}
	
	echo $database .' - <font color=red>nao possui diretorio</font><br/>';

	// $sql2 = $con->query("drop database " . $database);
	// if ($sql2) {
	// 	echo '- apagado';
	// } else {
	// 	echo ' - ativo';
	// }

}

//Pega todos os diretorios e verifica se existe o respectivo database

echo '<h1>Pega todos os diretorios e verifica se existe o respectivo database</h1>';

$path = '../';
$dir = new DirectoryIterator($path);
foreach ($dir as $fileinfo) {
	if ($fileinfo->isDir() && !$fileinfo->isDot()) {

		$dirname = $fileinfo->getFilename();

		if (strpos($dirname,'_') === 0) {
			continue;
		}

		if ($dirname == 'blog') {
			continue;
		}

		if ($dirname == 'site') {
			continue;
		}

		if ($dirname == 'lojasvirtuais') {
			continue;
		}

		if (count(explode("_", $dirname)) > 1) {
			echo $dirname .' - é um diretório com tratamento especial<br/>';
			continue;
		}

		$sql = $con->query("select schema_name from information_schema.schemata where schema_name = '" . $dirname . "' or  schema_name = 'rdcommer_" . $dirname . "' limit 1");

		if ($sql->num_rows === 0) {
			echo $dirname .' - <font color=red>nao possui database</font><br/>';

			//deleteDirectory('../' . $dirname);

			continue;
		}
			
		$sql = $con->query("SELECT nome_da_loja FROM _usuarios WHERE nome_da_loja = '" . $dirname . "' limit 1");

		if ($sql->num_rows > 0) {
			continue;
		}

		$nome_da_loja = $dirname;
		$senha = '';
		$nome = 'RD';
		$email = 'desenvolvimento@rdcommerce.com.br'; 
		$ddd = '';
		$telefone = '';

		$stmt = $con->prepare("INSERT INTO _usuarios (nome_da_loja, senha_inicial, nome, email, ddd, telefone, created_at, status) values (?, ?, ?, ?, ?, ?, now(),1)");
		$stmt->bind_param('ssssss', $nome_da_loja, $senha, $nome, $email, $ddd, $telefone);
		
		if ($stmt->execute()) {
			echo $dirname .' foi adicionado à tabela [_usuarios]<br/>';
		}

	}
}

echo '<h1>Pega todos os nomes de loja do database Usuário e Domínio e verifica se existe o respectivo diretorio</h1>';

clearDatabase($con, '_dominios', 'nome_da_loja');
clearDatabase($con, '_usuarios', 'nome_da_loja');

function clearDatabase ($con, $database, $column) {
	echo "Limpando o database [". $database ."]<br/>";

	$sql = $con->query("SELECT id, ". $column ." FROM ". $database);

	while ($row = $sql->fetch_assoc()) {
		$id = $row['id'];
		$nome_loja = $row[$column];

		if (count(glob("../".$nome_loja."_*")) > 0) {
			continue;
		}

		if (count(glob("../*_".$nome_loja)) > 0) {
			continue;
		}

		if (is_dir("../".$nome_loja)) {
			continue;
		}		

		$sql2 = $con->query("DELETE FROM ". $database ." WHERE id = ". $id);

		if ($sql2) {
			echo $nome_loja .' > <font color=red>foi deletado da tabela ['. $database .']</font><br/>';
		}
	
	}

	echo '<br>';
}

function deleteDirectory($dirPath) {
    if (is_dir($dirPath)) {
        $objects = scandir($dirPath);
        foreach ($objects as $object) {
            if ($object != "." && $object !="..") {
                if (filetype($dirPath . DIRECTORY_SEPARATOR . $object) == "dir") {
                    deleteDirectory($dirPath . DIRECTORY_SEPARATOR . $object);
                } else {
                    unlink($dirPath . DIRECTORY_SEPARATOR . $object);
                }
            }
        }
    reset($objects);
    rmdir($dirPath);
    }
}