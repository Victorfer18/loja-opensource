<?php

include 'open_database.php';

if (!empty($_REQUEST)) {

	$nome_da_loja = $_REQUEST['nome_da_loja'];
	$dominio_do_cliente = $_REQUEST['dominio_do_cliente'];

	$nome_da_loja = substr($nome_da_loja, 0, 50);
	$nome_da_loja = strtolower($nome_da_loja);
	$dominio_do_cliente = preg_replace("/https?:\/\//", '', $dominio_do_cliente);
	$dominio_do_cliente = preg_replace("/www\./", '', $dominio_do_cliente);
	$dominio_do_cliente = preg_replace("/\/.*/", '', $dominio_do_cliente);

	$erro = '';

	if ($nome_da_loja === '') {
		$erro .= '<li> Informe um nome para a sua loja</li>';
	} else {
		$stmt = $con->prepare("select id from _usuarios where nome_da_loja=? and status>0");
		$stmt->bind_param('s', $nome_da_loja);
		$stmt->execute();
		$stmt->store_result();

		if ($stmt->num_rows === 0) {
			$erro .= '<li> Nome da loja informado não existe!</li>';
		} else {
			$stmt = $con->prepare("select id from _dominios where nome_da_loja=?");
			$stmt->bind_param('s', $nome_da_loja);
			$stmt->execute();
			$stmt->store_result();

			if ($stmt->num_rows !== 0) {
				$erro .= '<li> Já existe um domínio para loja informada!</li>';
			}
		}		
	}	

	if ($dominio_do_cliente === '') {
		$erro .= '<li> Informe o domínio contratado pelo cliente (ex. example.com.br)</li>';
	} else if (count(explode('.', $dominio_do_cliente)) < 2) {
		$erro .= '<li> Informe o domínio completo (ex. example.com.br)</li>';
	}

	if ($erro === '') {

		$stmt = $con->prepare("insert into _dominios (dominio,nome_da_loja) values (?, ?)");
		$stmt->bind_param('ss', $dominio_do_cliente, $nome_da_loja);
		$stmt->execute();

		$dominio_do_cliente = 'www.'.$dominio_do_cliente;

		$stmt = $con->prepare("insert into _dominios (dominio,nome_da_loja) values (?, ?)");
		$stmt->bind_param('ss', $dominio_do_cliente, $nome_da_loja);
		$stmt->execute();						

		$dominio_loja = 'rdcommerce.com.br';		

		$sql = $con->query("select nome_da_loja from _usuarios where status>0");

		$htaccess = '#Este arquivo eh gerado automaticamente atraves do script de criacao de lojas' . PHP_EOL . PHP_EOL;
		$htaccess = $htaccess . 'RewriteEngine On'. PHP_EOL . PHP_EOL;
		while ($row = $sql->fetch_assoc()) {
			$nome_da_loja = $row['nome_da_loja'];

			$htaccess = $htaccess . 'RewriteCond %{HTTP_HOST} ' . $nome_da_loja . '.' . $dominio_loja . '$' . PHP_EOL;
			$htaccess = $htaccess . 'RewriteCond %{REQUEST_URI} !^/' . $nome_da_loja . PHP_EOL;
			$htaccess = $htaccess . 'RewriteRule ^(.*)$ /' . $nome_da_loja . '/$1 [L]'. PHP_EOL . PHP_EOL;
		}

		$sql = $con->query("select dominio, nome_da_loja from _dominios");

		$htaccess = $htaccess . '#Aqui gera-se as lojas com dominio proprio';

		while ($row = $sql->fetch_assoc()) {
			$dominio = $row['dominio'];
			$nome_da_loja = $row['nome_da_loja'];

			$htaccess = $htaccess . PHP_EOL . PHP_EOL . 'RewriteCond %{HTTP_HOST} ' . $dominio . '$' . PHP_EOL;
			$htaccess = $htaccess . 'RewriteCond %{REQUEST_URI} !^/' . $nome_da_loja . PHP_EOL;
			$htaccess = $htaccess . 'RewriteRule ^(.*)$ /' . $nome_da_loja . '/$1 [L]';
		}

		file_put_contents('../.htaccess', $htaccess);

		echo "<script>alert('Domínios Atualizados com sucesso!');</script>";
		$nome_da_loja = '';
		$dominio_do_cliente = '';

	} else {
		echo '<div class="reg-block" style="margin-bottom:0px!important;"> Por gentileza verifique os seguintes campos:<br>';
		echo $erro;
		echo '</div>';
	}

} else {
	$nome_da_loja = '';
	$dominio_do_cliente = '';
}

include ("termos/header/header.php");

?>

<div class="container">
	<!--Reg Block-->
	<div class="reg-block">
		<div class="reg-block-header">
			<img src="https://rdcommerce.com.br/site/img/logo.png" class="img-responsive logo">
			<ul class="social-icons text-center">
				<li><a class="rounded-x social_facebook" data-original-title="Facebook" href="https://www.facebook.com/RDCommerce/"></a></li>
				<li><a class="rounded-x social_linkedin" data-original-title="Linkedin" href="https://www.linkedin.com/company/rdcommerce"></a></li>
			</ul>
		</div>
		<form>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-home"></i></span>
				<input type="text" class="form-control" placeholder="Nome da Loja" size="20" name="nome_da_loja" maxlength="50" value="<?php echo $nome_da_loja ?>">
			</div>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-desktop"></i></span>
				<input type="text" class="form-control" placeholder="Domínio do Cliente" name="dominio_do_cliente" value="<?php echo $dominio_do_cliente?>">
			</div>
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<button type="submit" name="btn_update" Value="Atualizar Domínios" class="btn-u btn-block">Atualizar Domínios</button>                
				</div>
			</div>
		</form>
	</div>
	<!--End Reg Block-->

</div><!--/container-->
<!--=== End Content Part ===-->
<?php include ("termos/footer/footer.php"); ?>
