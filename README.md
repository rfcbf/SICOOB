# Desenvolvimento
Foi desenvolvido um app conforme solicitação abaixo pelo SICOOB.
Desenvolvido por: Renato Ferraz Castelo Branco Ferreira
email: rfcbf@me.com / renatoferrazdf@gmail.com
Tel: (61) 99368-4628

| <center>iOS</center>  |  <center>Android</center> |
| ------------------------ | ------------------------ |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/iphone1.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/android1.png" width="480" height="720" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/iphone2.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/android2.png" width="480" height="720" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/iphone3.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/android3.png" width="480" height="720" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/iphone4.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/android4.png" width="480" height="720" /> |

| <center>iPAD</center>
| ------------------------ |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/ipad1.png" width="480" height="720" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/ipad2.png" width="480" height="720" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/ipad3.png" width="480" height="720" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/ipad4.png" width="480" height="720" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/ipad5.png" width="720" height="480" /> |
| <img src="https://github.com/rfcbf/SICOOB/blob/master/Imagens/ipad6.png" width="720" height="480" /> |




## Como foi feito?
O app foi desenvolvido em Flutter. 
O Flutter, um framework desenvolvido pelo Google na linguagem Dart, permite o desenvolvimento de aplicações nativas tanto para Android quanto para iOS a partir da composição de Widgets. Podemos utilizar blocos prontos desenvolvidos pela equipe do Google, como botões, cards, menus e muitos outros, para agilizar o desenvolvimento, mas também podemos personalizar e/ou criar Widgets livremente.

Mais informações: [clique aqui](http://flutter.dev "clique aqui")
Instalação e configuração: [clique aqui](https://flutter.dev/docs/get-started/install "clique aqui")
Configuração do editor: [clique aqui](https://flutter.dev/docs/get-started/editor?tab=vscode "clique aqui") - Vale informar que utilizei o VSCode.

## O que foi feito?
* Exibir uma lista contendo filmes mais populares.  :fa-check:
* Cada filme apresentará uma imagem e o título do filme;  :fa-check:
* Ao clicar em um filme será exibida uma página com detalhes do filme;  :fa-check:
  * Título  :fa-check:
  * Imagem  :fa-check:
  * Duração  :fa-check:
  * Gênero  :fa-check:
  * Sinopse  :fa-check:
  
### Pontos extras
Não são obrigatórios, mas seria legal ter no seu projeto:

* Animações  :fa-check:
* Testes unitários
* Testes automatizados
* Utilização de *frameworks* de terceiros  :fa-check:
* Telas adequadas para diversos tamanhos  :fa-check:
* Utilização de banco de dados  :fa-check:
* Use sua imaginação para aprimorar a experiência do usuário  :fa-check:

------------

# Desafio Sicoob

## O que será avaliado?
Nesse desafio queremos avaliar sua habilidade em desenvolver um aplicativo e avaliar o seu conhecimento.

Inclua suas considerações das atividades em um arquivo de texto ou README dentro do projeto.

Vamos avaliar tudo que você fizer. Envie o que conseguir terminar, mesmo que você não consiga completar todas as tarefas do desafio.

## Desafio

Nesse desafio, você irá criar um aplicativo que exiba os filmes mais populares usando uma API de Cinema:


### 1. Especificação

Para este desafio é necessário uma listagem para buscar os filmes e quando algum filme for selecionado, deverá exibir uma tela com detalhamento do filme selecionado.

* Exibir uma lista contendo filmes mais populares. Consulte [aqui](https://developers.themoviedb.org/3/movies/get-popular-movies) para obter mais informações;
* Cada filme apresentará uma imagem e o título do filme;
* Ao clicar em um [filme](https://developers.themoviedb.org/3/movies/get-movie-details), será exibida uma página com detalhes do filme;
  * Título
  * Imagem
  * Duração
  * Gênero
  * Sinopse
  
### Pontos extras
Não são obrigatórios, mas seria legal ter no seu projeto:

* Animações
* Testes unitários
* Testes automatizados
* Utilização de *frameworks* de terceiros
* Telas adequadas para diversos tamanhos
* Utilização de banco de dados
* Use sua imaginação para aprimorar a experiência do usuário

### API Utilizada

Utilizaremos a API do `themoviedb.org`
Como criar sua conta gratuita e utilizar a API

* Acesse https://www.themoviedb.org/account/signup para solicitar uma chave
  * Informe uso educacional
  * Você também terá que fornecer algumas informações pessoais para completar o pedido.
  * Você receberá a sua chave por e-mail
  
Para fazer requisições a API de filmes, você deve usar os endpoints abaixo:
`http://api.themoviedb.org/3/movie/popular?api_key=[SUA_CHAVE_DA_API]`

Estudando a API, você vai verificar que no detalhe do filme é fornecido um caminho relativo para a imagem. Por exemplo, o caminho de retorno do cartaz para Capitão Marvel é `/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg`.
 
A URL é formada por 3 partes :
1. A URL Base: http://image.tmdb.org/t/p/;
2. Então você vai precisar de um "tamanho", que será um dos seguintes procedimentos :
" w92 ", " W154 ", " w185 ", " w342 ", " w500 ", " w780 " , ou " original" . Para a maioria
dos telefones recomendamos a utilização de " w185 ";
3. E, finalmente, o caminho de Cartaz devolvido pela consulta, neste caso
/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg Combinando as três partes temos:
http://image.tmdb.org/t/p/w185//AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg
