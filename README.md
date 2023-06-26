# Student-Aide

Alunos :

Joao Paulo da Silva Dantas<br>
Marcelo Soares Antunes<br>
Ryan Breda Santos

Descrição:

O objetivo deste aplicativo móvel é auxiliar estudantes na organização de seus estudos e no desenvolvimento de hábitos de estudo eficazes. Ele fornecerá recursos e funcionalidades que permitirão aos estudantes planejar, acompanhar e otimizar seu tempo de estudo, além de fornecer ferramentas úteis para facilitar o aprendizado.

## Requisitos

### 3.1 Requisitos Funcionais

3.1.1 [RF001] Tela de login:
	(Essencial)
O aplicativo deve possuir uma tela de cadastro de login.
Deve possuir uma tela para logar aqueles que já possuem conta.
O login será utilizado pelos usuários para que mantenham suas preferências salvas e tenham seus dados seguros.
	Obs: O ideal seria guardar somente o hash da senha para segurança, ser possível guardar a foto do usuário.

3.1.2 [RF002] Gradiente de cor para daltônicos:
(Desejável)
Para aumentar a acessibilidade da aplicação, o aplicativo implementará uma extensão que permite que a troca de cor para os usuários que possuem daltonismo possam fazer um uso melhor da aplicação.

3.1.3 [RF003]Tela de boas-vindas:
	(Importante)
Ao abrir o aplicativo, o usuário deve ser apresentado a uma tela de boas-vindas com as opções de login ou registro.
Os usuários devem escolher entre fazer login em uma conta existente ou se registrar para uma nova conta.

3.1.4 [RF004] Registro de nova conta:
	(Essencial)
Se o usuário optar por se registrar, ele deve fornecer um endereço de e-mail, nome, senha e número de telefone.
O aplicativo deve validar o endereço de e-mail e o número de telefone fornecidos pelo usuário.

3.1.5 [RF005]Recuperação de senha:
(Importante)
O aplicativo deve fornecer uma opção para recuperar a senha, caso o usuário a tenha esquecido.
Isso pode ser feito solicitando ao usuário que insira seu endereço de e-mail ou número de telefone associado à conta.

3.1.6 [RF006] Verificação de número no e-mail para nova conta:
	(Essencial)
Após o registro, o aplicativo deve enviar um e-mail de verificação ou um código de verificação para o número de telefone fornecido pelo usuário.
O usuário deve ser solicitado a inserir o código de verificação para confirmar a criação da conta.

3.1.7 [RF007] Tela principal:
	(Essencial)
Deve apresentar: 
espaço de pesquisa: permite ao usuário pesquisar por tags, serviços ou outras informações relevantes dentro do aplicativo;
Botão "Home": redireciona o usuário de volta à tela inicial;
Botão “Perfil”: permite ao usuário acessar e gerenciar suas informações de perfil.

3.1.8 [RF008] Perfil:
	(Importante)
Os usuários devem ter a opção de visualizar e editar seu perfil.
Os usuários devem poder adicionar informações, como foto de perfil, nome.
Os usuários também devem ter a capacidade de editar essas informações posteriormente.

3.1.9 [RF009] Adicionar Anotações:
(Essencial)
O aplicativo deve permitir que os usuários criem anotações.
Os usuários devem poder encontrar suas anotações com as respectivas informações: hora/data de adição, espaço das anotações .
Os usuários devem poder editar, deletar e atualizar suas anotações.
Os usuários devem poder adicionar informações, como foto ou textos para as matérias.

3.1.10 [RF010] Adicionar tags:
	(Essencial)
Os usuários devem poder adicionar tags para as anotações.
O aplicativo deve permitir que os usuários pesquisem por anotações marcadas com tags.
Os usuários também devem ter a capacidade de editar essas informações nas tags.

3.1.11 [RF011] Upload rápido de imagens:
	(Importante)
Os usuários devem ter a capacidade de fazer upload rápido de imagens para o aplicativo.
Os usuários devem poder selecionar uma imagem da galeria do dispositivo ou tirar uma nova foto diretamente do aplicativo.

3.1.11 [RF011] Alarme de estudo:
	(Importante)
O aplicativo deve notificar os usuários quando está próximo do horário de estudo.
O aplicativo deve exibir por meio de notificações push, mensagens instantâneas ou uma seção de mensagens na interface do usuário.

3.1.11 [RF011] Cronômetro de estudo:
(Importante)
Os usuários devem poder cronometrar o tempo de estudo, podendo iniciar, pausar, continuar de onde parou.
Os usuários devem poder restringir a edição do cronômetro com senhas.




### 3.2 Requisitos Não Funcionais

3.2.1 [NF001] Linguagem e IDE utilizadas:
(Essencial)
A aplicação será feita através do uso do Android Studio, utilizando a linguagem de programação Java para o desenvolvimento das funcionalidades.

3.2.2 [NF002] Teste caixa preta:
(Essencial)
Deverá ser realizado testes sob as funcionalidades da aplicação, mostrando que as funcionalidades propostas se encontram funcionando de acordo com o proposto.

3.2.3 [NF003] Utilizar recursos aprendidos na disciplina:
	(Importante)
No desenvolvimento do aplicativo, utilizar os recursos aprendidos no decorrer da disciplina para o desenvolvê-lo, exemplo: fragmentos, strings, cores, imagens, sons, notificações, menu, alarme, câmera, mapas.

3.2.4 [NF004] Fazer uma aplicação funcional e agradável ao usuário:
	(Importante)
A aplicação deve ser de fácil uso e intuitiva para os usuários, além de ter tolerância a entradas erradas e ser responsiva.

3.2.4 [NF004] Segurança na aplicação:
	(Essencial)
A aplicação deve ser segura, possibilitando que os dados dos usuários não sejam manipulados levianamente e garantindo através de um bloqueio por senha que apenas ele será capaz de visualizar o seu histórico.







