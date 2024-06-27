import 'package:flutter/material.dart';
import 'package:notiday_1/screens/login.dart';


class _TermosPoliticas extends State<TermosPoliticas> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Termos e Políticas',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: AppBar( shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Notiday(),
                        ),
                      );
                    },
                    color: Colors.black,
                  ),
                   SizedBox(width:60.0),
                    Text(
                      'Termos e Políticas',
                      style: TextStyle(
                          fontFamily: AutofillHints.birthday,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              """DEFINIÇÕES

Considera-se, para o presente instrumento, as seguintes definições:
Notiday Aplicativo de Agenda Pessoal: é um aplicativo de Gestão Diária, desenvolvido por um grupo de alunos de 3° período de Informática para internet, pela Escola Técnica Anna de Oliveira Ferraz.
Cliente: Corresponde ao titular da conta , com quem foi formalizada a relação contratual, que terá direito ao usufruto de todos os benefícios do produto, ao mesmo tempo que se responsabilizará pelas obrigações nele previstas.
Usuários (ou “Usuário”): Constitui-se pelos Clientes que utilizarão o Aplicativo, qualificados como pessoas capazes para a prática dos atos da vida civil. 
Aplicativo: programa desenvolvido com intuito de melhoria estudantil, trabalhista, e de melhor aproveitamento de tempo, com base em gestão de tempo dos usuários. Agenda pessoa irá facilitar aos usuários a gerir seus dias de maneira mais dinâmica e centrada.
  
  2. FINALIDADE

O cadastramento a que se refere o presente termo compreende o acesso ao Aplicativo Notiday, que possibilita aos seus Usuários criar, programar e acompanhar seus compromissos, maximizando o tempo dos usuários, através do mesmo podendo fazer chamada de aplicativos de localidade e de transporte.

CADASTRO
Os dados cadastrais contemplarão dados pessoais e dados pessoais sensíveis, tais como nome, sobrenome, telefone e e-mail, os quais serão necessários para a identificação do Usuário. Compromete-se o Usuário à veracidade dos dados informados, estando ciente a imprecisão deles impedir o acesso ou utilização do Aplicativo, sem prejuízo de responsabilização civil, penal e administrativa.
o Notiday, sempre que entender necessário ou em decorrência de exigência legal, regulatória ou para cumprimento de ordem judicial, poderá solicitar a atualização ou confirmação de determinados dados e informações, bem como o envio de informações do usuário. Em caso de divergências ou omissões nos dados, o Notiday poderá, a qualquer momento e sem aviso prévio, negar ou suspender a análise da solicitação de cadastro ou, ainda, suspender ou bloquear o acesso ao aplicativo.
O Usuário se compromete a não fornecer, emprestar ou permitir que suas informações de acesso permaneçam com terceiros, mantendo-os sob guarda segura e garantindo que sua senha não seja revelada ou exposta a outras pessoas, isentando Notiday de qualquer responsabilidade dessa ordem.
Além das demais obrigações previstas, o Usuário se compromete a assegurar a veracidade e atualização de seus dados pessoais, informações financeiras, endereço para correspondência e demais informações incluídas na plataforma, comprometendo-se a comunicar o Notiday de quaisquer alterações, de forma imediata.

ACESSO
No Aplicativo, para o acesso às informações pelo Usuário, será necessário que esse efetue o seu cadastramento junto à plataforma, com login e senha. Inclusive, todas as informações fornecidas ao cadastramento estarão de acordo com a Política de Privacidade do Notiday. Para saber mais sobre esses dispositivos, acesse nossa Política de Privacidade.
Efetuando o cadastramento, o Usuário será titular de uma conta de utilização que somente poderá ser acessada por ele.
Poderão ser alterados, a qualquer tempo, os termos e condições relativas à utilização do Aplicativo, hipótese em que serão atualizados junto à própria ferramenta. Verificada a continuidade do uso, mesmo após a efetiva postagem da atualização, restará configurada a ciência do Usuário, fato que justifica o necessário monitoramento do Portal e correio eletrônico.

VIOLAÇÕES E RESPONSABILIDADES
Pelo presente, o Usuário assume a responsabilidade pela observância às seguintes obrigações:
Não autorizar terceiros(as) a utilizarem ou acessarem a Conta do Usuário, mesmo se eles estiverem em sua companhia;
Não ceder ou transferir a sua Conta, em nenhuma hipótese, a outra pessoa ou entidade;
Observar e cumprir todas as leis aplicáveis enquanto utilizar ao Aplicativo, manipulando-o apenas para finalidades legítimas
Dispõe-se como expressamente proibidas ao Usuário, durante a utilização do Aplicativo, as seguintes ações:
Dentre outras condutas, fica expressamente vedada a violação de direitos de terceiros, inclusive dos direitos de sigilo e privacidade
Realizar a prática de quaisquer atos que propiciem a transmissão ou propagação de vírus, trojans, malware, worm, bot, backdoor, spyware, rootkit, ou quaisquer outros dispositivos que venham a ser criados, que prejudiquem os equipamentos do Notiday ou de terceiros;
Utilizar de qualquer sinal distintivo ou bem de propriedade intelectual de titularidade do Notiiday, como nome empresarial, marca ou nome de domínio.
Em nenhuma hipótese, oNotiday será responsável:
Pelo uso indevido, danos e eventuais práticas ilegais realizadas pelo Usuário, mesmo que relacionadas com o acesso ao Aplicativo;
Por eventuais falhas ou impossibilidades técnicas decorrentes da má instalação, uso indevido ou insuficiência técnica do aparelho do Usuário em que esteja instalado o App;

LICENÇA
De acordo com os termos postos, o Notiday  transfere ao Usuário uma licença limitada, não exclusiva, não passível de transferência, revogável e não transferível para o:
Uso da plataforma eletrônica em seu dispositivo pessoal. 
Acesso ao conteúdo, dado ou material disponibilizado a partir da utilização dos serviços especificado, cabendo, em cada caso, o acesso restrito ao uso pessoal, estabelecendo-se o necessário dever de sigilo.
É de exclusiva propriedade do Notiday todos os direitos inerentes ao App, inclusive no que diz respeito aos seus textos, imagens, layouts, software, códigos, bases de dados, gráficos, artigos, fotografias e demais conteúdos nele produzidos direta ou indiretamente. Inclusive, todos os conteúdos do App são protegidos pela lei de propriedade intelectual, sendo proibido aos Usuários usar, copiar, reproduzir, modificar, publicar, transmitir, distribuir, executar, exibir, licenciar, vender ou explorar qualquer conteúdo do App, seja por qualquer finalidade, sem que obtenha o consentimento prévio e expresso do Notiday.
Inclusive, o Notiday poderá analisar, monitorar ou remover o conteúdo a seu exclusivo critério, a qualquer momento e por qualquer motivo, independentemente de prévio aviso.

POLÍTICA DE PRIVACIDADE
Você já deve ter ouvido falar da Lei Geral de Proteção Dados (Lei 13.709/2018) (“LGPD”), que entrou em vigor em 18 de setembro de 2020. O presente documento (“Política de Privacidade”) foi elaborado justamente para que Você consiga compreender, de forma transparente, como será realizado o tratamento de seus dados pessoais, quais as nossas práticas de proteção em relação aos seus dados pessoais e quais seus direitos como titular dos dados.
A partir do momento que Você se cadastra para utilizar nossos Serviços e clica em “Li e concordo com a Política de Privacidade”, você concordará de forma livre, expressa e informada com o uso de seus dados conforme descrito na presente Política de Privacidade.
Assim, é importante que você leia atentamente todos os termos desta Política de Privacidade antes de decidir concordar com ela.
Mas não se preocupe! Se tiver quaisquer dúvidas, reclamações ou quiser exercer quaisquer de seus direitos relacionados aos seus dados pessoais tratados pela Instituição, você pode entrar em contato conosco por meio dos nossos canais de atendimento via WhatsApp, ou entrar em contato diretamente com nosso encarregado pelo tratamento de dados pessoais (Data Protection Officer - DPO) por meio do contato. Além disso, no nosso site Você sempre encontrará a última versão desta política, com as respectivas alterações e um controle de versões que indicará a versão atual e a data de sua última alteração.

POLÍTICA DE PRIVACIDADE
A Política de Privacidade (“Política”) do Notiday é o documento pelo qual mostramos o nosso compromisso em tratar com segurança, privacidade e transparência os seus dados pessoais. Ela também demonstra a postura requerida por todos os colaboradores no uso dos dados sob sua responsabilidade.
A presente Política aplica-se especificamente aos clientes e aos prospectos do Notiday. Entende-se por prospectos as pessoas que se interessaram pelos nosso produto .

CONCEITOS
Alguns conceitos-chave para entendimento da Política de Privacidade são:
Dados pessoais são informações que possam ser relacionadas a uma pessoa específica, como nome, documento de identificação, histórico de relacionamento com a empresa, fotos e assim por diante. Titular é a pessoa a quem os dados se referem – no nosso caso, você é o titular.
Tratamento de dados pessoais é o uso, propriamente dito, dos dados. Esse termo engloba a coleta, classificação, utilização, acesso, processamento, armazenamento, modificação, eliminação, compartilhamento e todos os outros usos possíveis.
Encarregado é o responsável interno por cuidar dos assuntos relacionados à privacidade no Notiday.

POR QUE UTILIZAMOS DADOS PESSOAIS?
Os dados coletados são necessários para oferecermos os nossos serviços da melhor maneira possível e atendermos às exigências legais e regulatórias.

COLETA DE DADOS PESSOAIS
Os seus dados pessoais podem ser coletados somente de uma forma:

a) Informados por você.

DADOS INFORMADOS PELO TITULAR
Os dados pessoais informados por você podem ser:

a) Dados cadastrais (nome, sobrenome e outros).
b) Dados de contato (número de telefone, e-mail, endereço e outros).
Você será o único e exclusivo responsável pela veracidade dos dados pessoais fornecidos na realização do seu cadastro, cotação e/ou contratação de eventuais produtos ou serviços.
O Notiday não possui qualquer responsabilidade pela veracidade dos dados fornecidos, bem como por eventuais danos decorrentes da inexatidão e/ou desatualização de referidas informações.

DADOS DE NAVEGAÇÃO E DO DISPOSITIVO
Os dados pessoais coletados automaticamente durante sua navegação no aplicativo do Notiday podem ser:

a) Cookies necessários e opcionais, esses últimos mediante consentimento.
b) Dados técnicos sobre a sua conexão e sobre o seu dispositivo.
c) Informações de geolocalização do dispositivo, mediante autorização, caso o acesso se dê pelo aplicativo.

SEGURANÇA
Os dados pessoais tratados pelo Notiday são mantidos em ambiente seguro e controlado, seguindo padrões de segurança adequados. Possuímos restrições de acesso a sistemas e plataformas, com senhas, monitoramento contínuo do ambiente, análises e testes de segurança. Também são realizadas auditorias periódicas, tanto de times internos.

APROVAÇÃO/VIGÊNCIA
A presente Política de Privacidade foi aprovada pela Diretoria e entra em vigor a partir da sua aprovação. O diretor responsável pela segurança cibernética na instituição e o responsável pela área de compliance realizarão a revisão e atualização anual desta política.
Além disso, em casos de alterações na legislação vigente e mudanças na estrutura física, tecnológica, organizacional ou em processos da Instituição, os responsáveis poderão, a qualquer momento, iniciar o processo de revisão deste documento, atendendo, assim, aos direitos dos titulares dos dados.

ALTERAÇÕES DO ACESSO E DOS TERMOS DE USO E POLÍTICAS DE PRIVACIDADE
Notiday, a qualquer tempo, a seu exclusivo critério e sem necessidade de qualquer aviso prévio ou posterior a qualquer Usuário ou terceiros, poderá:

(i) suspender, cancelar ou interromper o acesso ao Aplicativo
(ii) remover, alterar e/ou atualizar no todo ou em parte o Aplicativo bem como seus respectivos conteúdos e/ou Termos de Uso e Política de Privacidade. Qualquer alteração e/ou atualização destes Termos de Uso e Política de Privacidade passará a vigorar a partir da data de sua publicação no Aplicativo e deverá ser integralmente observada pelos Usuários.

LEGISLAÇÃO E FORO:
Estes Termos de Uso e Política de Privacidade são regidos de acordo com a legislação brasileira. Quaisquer disputas ou controvérsias oriundas de quaisquer atos praticados no âmbito da utilização dos Aplicativos pelos Usuários, inclusive com relação ao descumprimento dos Termos de Uso e Política de Privacidade ou pela violação dos direitos do Notiday, de outros Usuários e/ou de terceiros, inclusive direitos de propriedade intelectual, de sigilo e de personalidade, serão processadas em Araraquara onde se encontra a matriz Notiday.
""",
              style: TextStyle(fontSize: 10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class TermosPoliticas extends StatefulWidget {
  @override
  _TermosPoliticas createState() => _TermosPoliticas();
}
