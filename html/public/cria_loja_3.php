<?php

$dominio_loja = 'rdcommerce.com.br';

if (!empty($_REQUEST)) {
	$nome_da_loja = $_REQUEST['nome_da_loja'];
} else {
	header("Location: cria_loja_1.php");
}

?>

<?php include ("termos/header/header.php"); ?>
<div class="container">
	<!--Reg Block-->
	<div class="reg-block">
		<h1>A sua loja foi criada com sucesso!</h1>
		<ul>
			
			<li style="list-style:none;"><i class="fa fa-home"></i>&nbsp;&nbsp;<a href="http://<?php echo $nome_da_loja?>.<?php echo $dominio_loja?>" target="_blank">Acessar a loja</a></li>
			
			<li style="list-style:none;"><i class="fa fa-user"></i>&nbsp;&nbsp;<a href="http://<?php echo $nome_da_loja?>.<?php echo $dominio_loja?>/admin" target="_blank">Acessar o administrativo da loja</a></li>
		</ul>
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
			<a href="https://rdcommerce.com.br"><button class="btn-u btn-block">Retornar para o Site</button></a>           
			</div>
		</div>
	</div>
</div>
<!--End Reg Block-->

</div><!--/container-->
<!--=== End Content Part ===-->

<?php include ("termos/footer/footer.php"); ?>
