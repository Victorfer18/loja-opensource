<?php
include 'open_database.php';

if (!empty($_REQUEST)) {

	$nome = $_REQUEST['nome'];
	$email = $_REQUEST['email'];
	$ddd = $_REQUEST['ddd'];
	$telefone = $_REQUEST['telefone'];
	$nome_da_loja = $_REQUEST['nome_da_loja'];
	$senha = $_REQUEST['senha'];

	$nome = substr($nome, 0, 250);
	$email = substr($email, 0, 250);
	$ddd = preg_replace('/[^0-9]+/', '', $ddd);
	$ddd = substr($ddd, 0, 2);
	$telefone = preg_replace('/[^0-9]+/', '', $telefone);
	$telefone = substr($telefone, 0, 9);
	$nome_da_loja = substr($nome_da_loja, 0, 50);
	$nome_da_loja = strtolower($nome_da_loja);

	$erro='';
	if ($nome == '') {
		$erro = $erro . '<li> Informe o seu nome';
	} else {
		if (preg_match('/[^a-zA-Z ]+/', $nome)) {
			$erro = $erro . "<li>O seu nome pode conter apenas letras e espaço"; 
		}
	}

	if ($email == '') {
		$erro = $erro . '<li> Informe o seu e-mail';
	} else {
		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
			$erro = $erro . "<li>O e-mail informado não é válido"; 
		}
	}

	if ($ddd == '') {
		$erro = $erro . '<li> Informe o DDD do seu telefone';
	} else {
		if (strlen($ddd) != 2) {
			$erro = $erro . '<li> O DDD deve conter 2 dígitos';
		}
	}

	if ($telefone == '') {
		$erro = $erro . '<li> Informe o seu telefone';
	} else {
		if (strlen($telefone) != 8 && strlen($telefone) != 9) {
			$erro = $erro . '<li> O telefone deve conter 8 ou 9 dígitos';
		}
	}

	if ($nome_da_loja == '') {
		$erro = $erro . '<li> Informe um nome para a sua loja';
	} else {
		$nome_loja_reservado = Array('mysql', 'phpmyadmin', 'sys', 'blog', 'site', 'lojasvirtuais');

		if (in_array($nome_da_loja, $nome_loja_reservado)) {
			$erro = $erro . '<li> Já existe uma loja com o nome informado. Por gentileza escolha um outro nome para a sua loja.';
		}

		if (preg_match('/[^a-zA-Z0-9]+/', $nome_da_loja)) {
			$erro = $erro . '<li>O nome da sua loja pode conter apenas letras e números (espaço ou caracteres especiais não são permitidos)';
		}
	}

	if ($senha == '') {
		$erro = $erro . '<li> Informe uma senha para administrar a sua loja';
	} 

	if (!isset($_REQUEST['cond'])) {
		$erro = $erro . '<li> Leia os termos e condições';
		;
	} 

	if ($erro == '') {
		$stmt = $con->prepare("select id from _usuarios where nome_da_loja=? and status>0");
		$stmt->bind_param('s', $nome_da_loja);
		$stmt->execute();
		$stmt->store_result();

		if ($stmt->num_rows == 0) {

			//enviar email
			require_once("class/class.phpmailer.php");
			require 'class/PHPMailerAutoload.php';
			$mail = new PHPMailer;
			$mail->IsSMTP(); // Define que a mensagem será SMTP
			try {

			    $mail->Host = 'ssl://mail.rdcommerce.com.br'; // Endereço do servidor SMTP (Autenticação, utilize o host smtp.seudomínio.com.br)
				$mail->SMTPAuth   = true;  // Usar autenticação SMTP (obrigatório para smtp.seudomínio.com.br)
				$mail->Port       = 465; //  Usar 587 porta SMTP
				$mail->Username = 'lojas@rdcommerce.com.br'; // Usuário do servidor SMTP (endereço de email)
				$mail->Password = 'rd123.'; // Senha do servidor SMTP (senha do email usado)
				$mail->SetFrom('lojas@rdcommerce.com.br', 'RD Commerce'); //Seu e-mail
				$mail->AddReplyTo('lojas@rdcommerce.com.br', 'RD Commerce'); //Seu e-mail
				$mail->Subject = 'Loja Criada Com Sucesso!';//Assunto do e-mail
				$mail->CharSet = 'UTF-8';
				$mail->AddAddress($email, $nome);

				$mail->AddBCC('desenvolvimento@rdcommerce.com.br', 'RD Commerce'); // Cópia Oculta
				//$mail->AddBCC('teste@laquamaria.com.br', 'RD Commerce'); // Cópia Oculta

				function clean_string($string) {
					$bad = array("content-type","bcc:","to:","cc:","href");
					return str_replace($bad,"",$string);
				}

				$email_message = "<img class='img-responsive' src='faixa.png'><br>";
				$email_message .= "<h3>Olá, tudo bem?</h3>";
				$email_message .="<p>Sou David Gonçalves, CEO da RDCommerce e estou aqui para dar as boas vindas à nossa plataforma.</p>";
				$email_message .="<p>A RDCommerce foi desenvolvida para suprir as deficiências de outras plataformas que não atendem o pequeno e médio empreendedor de forma satisfatória. Você, a partir de agora, tem acesso a todas nossa funcionalidades, além de várias vantagens como SSL Grátis, PDV e envio de e-mail marketing. Para mais informações acesse seu painel e nos procure no Chat!</p>";
				$email_message .="<p>Agora segue os dados de sua loja.</p>";

				$email_message .= "Nome da loja: ".clean_string($nome_da_loja)."<br>";
				$email_message .= "Acesse o painel da sua loja: ".clean_string($nome_da_loja).".rdcommerce.com.br/admin"."<br>";
				$email_message .= "Usuário: admin"."<br>";
				$email_message .= "Senha: ".clean_string($senha)."<br>";

				$email_message .= "<p>Seja bem vindo a RDCommerce, que possamos te ajudar a concretizar muitas vendas!</p>";

				$email_message .= "<p>David Gonçalves</p>";
				$email_message .= "<p>CEO RDCommerce</p>";

				$mail->MsgHTML($email_message); 

				if($mail->Send()) {
					echo "<script>alert('Estamos Criando sua loja!');</script>";
					$stmt = $con->prepare("insert into _usuarios (nome_da_loja,senha_inicial,nome,email,ddd,telefone,created_at,status) values (?, ?, ?, ?, ?, ?, now(),1)");
					$stmt->bind_param('ssssss', $nome_da_loja, $senha, $nome, $email, $ddd, $telefone);
					$stmt->execute();					

					header("Location: cria_loja_2.php?nome_da_loja=" . $nome_da_loja);
					//header("Location: cria_loja_background.php?nome_da_loja=" . $nome_da_loja);	

				} else {
					echo 'Mensagem não enviada.';
					echo 'Erro: ' . $mail->ErrorInfo;
				}   

			} catch (phpmailerException $e) {
			    echo $e->errorMessage(); //Mensagem de erro costumizada do PHPMailer
			}
			//fim enviar email

		} else {
			$erro = $erro . '<li> Já existe uma loja com o nome informado. Por gentileza escolha um outro nome para a sua loja.';
		}

	}

	if ($erro != '') {
		echo '<div class="reg-block" style="margin-bottom:0px!important;"> Por gentileza verifique os seguintes campos:<br>';
		echo $erro;
		echo '</div>';
	}

} else {

	$nome = '';
	$email = '';
	$ddd = '';
	$telefone = '';
	$nome_da_loja = '';
	$senha = '';

}

?>
<?php include ("termos/header/header.php"); ?>
<script type="text/javascript" src="https://d335luupugsy2.cloudfront.net/js/integration/stable/rd-js-integration.min.js"></script>  
<script type="text/javascript">
	var meus_campos = {
		'nome': 'nome',
		'email': 'email',
		'telefone': 'telefone',
		'nome_da_loja': 'empresa'
	};
	options = { fieldMapping: meus_campos };
	RdIntegration.integrate('e1d66b9b3e066f40657ebf9d69b08805', 'criar loja', options);  
</script>
<!--=== Content Part ===-->    
<div class="container">
	<!--Reg Block-->
	<div class="reg-block">
		<div class="reg-block-header">
			<img src="https://rdcommerce.com.br/site/img/logo.png" class="img-responsive logo">
			<h2>Crie Sua Loja</h2>
			<ul class="social-icons text-center">
				<li><a class="rounded-x social_facebook" data-original-title="Facebook" href="https://www.facebook.com/RDCommerce/"></a></li>
				<li><a class="rounded-x social_linkedin" data-original-title="Linkedin" href="https://www.linkedin.com/company/rdcommerce"></a></li>
			</ul>
		</div>


		<form>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-user"></i></span>
				<input type="text" class="form-control" size="20" name="nome" maxlength="250" placeholder="Nome" value="<?php echo $nome?>">
			</div>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
				<input type="text" class="form-control" placeholder="E-mail" size="20" name="email" maxlength="250" value="<?php echo $email?>">
			</div>


			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-phone"></i></span>
				<input type="text" placeholder="DDD" class="form-control form-control2 c1" size="2" name="ddd" maxlength="2" value="<?php echo $ddd?>">&nbsp;<input type="text" class="form-control form-control2 c2" placeholder="Telefone" size="9" name="telefone" maxlength="9" value="<?php echo $telefone?>">
			</div>

			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-home"></i></span>
				<input type="text" class="form-control" placeholder="Nome da Loja" size="20" name="nome_da_loja" maxlength="50" value="<?php echo $nome_da_loja?>">
			</div>			

			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-user"></i></span>
				<input type="text" class="form-control" placeholder="Administrador" size="20" name="senha" maxlength="10" value="admin" disabled>
			</div>

			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-lock"></i></span>
				<input type="text" class="form-control" placeholder="Senha" size="20" name="senha" maxlength="10" value="<?php echo $senha?>">
			</div>
			<hr>

			<div class="checkbox">            
				<label>
					<input type="checkbox" name="cond" value="cond"> 
					Eu li e concordo com os <a target="_self" href="termos/">Termos e Condições.</a>
				</label>
			</div>

			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<button type="submit" name="Criar Loja" Value="Criar Loja" class="btn-u btn-block">Criar Sua Loja</button>                
				</div>
			</div>
		</form>
	</div>
	<!--End Reg Block-->

</div><!--/container-->
<!--=== End Content Part ===-->
<?php include ("termos/footer/footer.php"); ?>

