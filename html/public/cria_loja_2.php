<?php

include 'open_database.php';

if (!empty($_REQUEST)) {
	$nome_da_loja = $_REQUEST['nome_da_loja'];
} else {
	header("Location: cria_loja_1.php");
}

?>

<!DOCTYPE html>
<html>
<head>
	<title>RD Commerce | Criando Sua Loja</title>

	<!-- Meta -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">

	<!-- Facebook Pixel Code -->
<script>
  !function(f,b,e,v,n,t,s)
  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
  n.callMethod.apply(n,arguments):n.queue.push(arguments)};
  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
  n.queue=[];t=b.createElement(e);t.async=!0;
  t.src=v;s=b.getElementsByTagName(e)[0];
  s.parentNode.insertBefore(t,s)}(window, document,'script',
  'https://connect.facebook.net/en_US/fbevents.js');
  fbq('init', '448695528895764');
  fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
  src="https://www.facebook.com/tr?id=448695528895764&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->


	<!-- Favicon -->
	<link rel="shortcut icon" href="assets/favicon.ico">

	<!-- Web Fonts -->
	<link rel='stylesheet' type='text/css' href='//fonts.googleapis.com/css?family=Open+Sans:400,300,600&amp;subset=cyrillic,latin'>

	<!-- CSS Global Compulsory -->
	<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/style.css">

	<!-- CSS Implementing Plugins -->
	<link rel="stylesheet" href="assets/plugins/animate.css">
	<link rel="stylesheet" href="assets/plugins/line-icons/line-icons.css">
	<link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome.min.css">

	<!-- CSS Page Style -->    
	<link rel="stylesheet" href="assets/css/pages/page_log_reg_v2.css">    

	<!-- CSS Theme -->    
	<link rel="stylesheet" href="assets/css/theme-colors/orange.css" id="style_color">
	<link rel="stylesheet" href="assets/css/theme-skins/dark.css">

	<!-- CSS Customization -->
	<link rel="stylesheet" href="assets/css/custom.css">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

	<script>
		$(document).ready(function() {
			loading();
		});

		function loading(){
			$.ajax({
				type: "POST",
				url: "cria_loja_background.php",
				data: "nome_da_loja=<?php echo $nome_da_loja?>",
				success: function(content) {				
					$('#desc_loja').hide();

					$('#log_loja').html(content.html);

					var button_action = '<button class="btn-u btn-block"><a href="cria_loja_1.php">Tentar Novamente</a></button>';

					if (content.status === 'true') {
						button_action = '<button class="btn-u btn-block"><a href="cria_loja_3.php">Continuar</a></button>';
					}

					$('#box_log').after(button_action);

					$('#box_log').show();
				}
			});
		}
	</script>
</head> 

<body>
	<!--=== Content Part ===-->    
	<div class="container">
		<!--Reg Block-->
		<div class="reg-block">
			<div class="reg-block-header" style="margin-bottom:30px;">
				<img src="https://rdcommerce.com.br/site/img/logo.png" class="img-responsive logo">
				<h2>Criando Sua Loja :)</h2>
				<ul class="social-icons text-center">
					<li><a class="rounded-x social_facebook" data-original-title="Facebook" href="https://www.facebook.com/RDCommerce/"></a></li>
					<li><a class="rounded-x social_linkedin" data-original-title="Linkedin" href="https://www.linkedin.com/company/rdcommerce"></a></li>
				</ul>
			</div>
			<div id="desc_loja" style="display:block;">
				<center>
					<img src="loading.gif" style="margin-bottom:30px;"><br>
					<p>Aguarde um instante... Estamos criando a sua loja.</p>
					<p>Em menos de 30 segundos estará tudo pronto!</p>
				</center>
			</div>
			<div id="box_log" style="display:none; border:1px solid #ebebe0; background: black; width:100%; height: 250px; overflow: scroll; padding: 5px; margin-bottom: 15px;">
				<p id="log_loja" style="color:white; font-size: 14px; white-space: nowrap;"></p>
			</div>
		</div>
		<!--End Reg Block-->

	</div><!--/container-->
	<!--=== End Content Part ===-->
	<?php include ("termos/footer/footer.php"); ?>