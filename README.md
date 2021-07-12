# EasyContábil

O EasyContábil é um aplicativo que fornece aos seus usuários a possibilidade de publicar suas principais dúvidas na área de contabilidade e responder as dúvidas de outros usuários, trabalhando com um sistema de pontuação com o objetivo de recompensar os envolvidos com a resolução de uma dúvida.

<br>

## Rodando as APIs

1º: Siga o passo-a-passo de instalação do Docker através do link: https://docs.docker.com/get-docker/. (Caso esteja no linux, deve realizar a instalação do docker compose separado através do link https://docs.docker.com/compose/install/). <br>
2º: Faça download do projeto ESC-K8S (enviado via ZIP). <br>
3º: Em seu terminal, vá até o projeto ESC-K8S e rode os seguintes comandos: <br>
```bash 
docker network create esc-network
docker-compose up -d --build
```

<br>

## Rodando o Aplicativo

1º: Siga o passo-a-passo de instalação do SDK do DART através do link: https://dart.dev/get-dart. <br>
2º: Siga o passo-a-passo de instalação do SDK do Flutter e do Android Studio através do link: https://flutter.dev/docs/get-started/install. <br>
3º: Faça um clone deste repositório em sua máquina. <br>
4º: Em seu terminal, vá até a pasta da aplicação e rode o comando: <br> 
```bash 
flutter run
```
5º: Caso sua máquina esteja rodando um emulador mobile, o aplicativo irá abrir automaticamente no emulador, caso contrário o flutter dará a opção de rodar através do Google Chrome ou do Microsoft Edge, selecione a opção que preferir.



- [x] like, dislike resposta
- [x] renderizar o perfil *
- [ ] editar o perfil *
- [x] criar uma duvida *
- [x] listar comentarios das respostas *
- [+] criar uma resposta/comentario *
- [ ] fechar duvida
- [ ] pontos
- [ ] tratamento de erros da api *
- [ ] loading buttons
- [x] listagem minhas duvidas
- [x] resolver duvida baseada em uma resposta
