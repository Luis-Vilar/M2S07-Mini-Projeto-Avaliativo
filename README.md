# Notitas

**Notitas** e um aplicativo mobile desenvolvido em **Flutter** para gerenciamento de tarefas. O projeto realiza autenticação, consumo de **APIs**, persistência local com **SQLite**, armazenamento de sessão com **Shared Preferences**, Ícone personalizado do launcher com **Flutter Icons Launcher**, injeção de dependencias com **GetIt** e gerenciamento de estados com **BLoC**.

## Objetivo

O aplicativo permite que o usuário:

- Faça login utilizando a API DummyJSON;
- Mantenha sua sessão salva localmente;
- Consulte suas tarefas;
- Visualize tarefas pendentes e concluídas;
- Filtre tarefas por status e texto;
- Cadastre novas tarefas;
- Marque tarefas como concluídas;
- Elimine tarefas localmente caso estejam concluidas;
- Utilize os dados armazenados no SQLite mesmo após a sincronização;
- Receba mensagens de erro quando houver falha de conexão;
- Tente novamente o carregamento da API caso esteja logado e não recebeu resposta da API.

## Tecnologias utilizadas

- **Flutter**
- **Dart**
- **BLoC / flutter_bloc**
- **Dio**
- **SQLite / sqflite**
- **SharedPreferences**
- **Injeção de dependencias / Get It**
- **Icono personalizado / Flutter Icon Launcher**
- **Arquitetura MVVM**
- **Padrão Result**
- **Programação Orientada a Objetos**
- **Consumo de API REST**

## API utilizada

O projeto utiliza a API pública DummyJSON:

- Login: <https://dummyjson.com/auth/login>
- Tarefas do Usuario: <https://dummyjson.com/todos/user/userId>

## Usuários para teste

- Pode escolher cualquier um em : <https://dummyjson.com/user>

Ou usar algum dos siguientes :

```text
Usuário: emilys
Senha: emilyspass

Usuário: michaelw
Senha: michaelwpass
```

## Funcionalidades

### Splash Screen

Ao iniciar o aplicativo, a splash screen verifica se existe uma sessão salva no `SharedPreferences`.

- Com sessão válida: navega para a tela  **LoggedView**;
- Sem sessão válida: navega para a tela  **LoginView** .

### LoginView

A tela de login possui:

- Campo de usuário;
- Campo de senha;
- Opção para mostrar ou ocultar a senha;
- Validação dos campos obrigatórios;
- Consumo da API de autenticação;
- Exibição de mensagens de erro;
- Salvamento dos dados do usuário no `SharedPreferences`.

### LoggedView

A tela principal apresenta:

- Avatar, Nome, Sobrenome e-mail do usuário, e logout na AppBar;
- Lista de tarefas;
- Campo de busca por texto;
- Filtros para todas, pendentes e concluídas;
- Criação de novas tarefas;
- Checkbox para concluir uma tarefa;
- Icono de lixeira para excluir a tarefa localmente;
- Botão para tentar novamente quando a API falhar que so aparece em casso de erros na AppBar;
- Indicação visual para tarefas concluídas.

### Persistência local

Após o carregamento dos dados da API:

1. As respostas JSON são convertidas em objetos `TodoModel`;
2. As tarefas são salvas no SQLite;
3. Os dados são consultados utilizando db.query('todos') equivalente simplificado ao `SELECT`;
4. A interface exibe os dados retornados pelo banco local.

As alterações de conclusão são persistidas localmente apenas por tratarse de uma api publica que não permite post, put ou patch.

## Arquitetura do projeto

O projeto utiliza uma organização baseada em MVVM, separando responsabilidades entre apresentação, gerenciamento de estado, dados e serviços.

```text
lib/
├── main.dart
├── core/
│   ├── bootstrap.dart
│   ├── dark_theme.dart
│   ├── injection.dart
│   ├── light_theme.dart
│   ├── main_app.dart
│   └── routes.dart
│
├── shared/
│   ├── components/
│   │   ├── add_todo_dialog_component.dart
│   │   ├── confirm_dialog.dart
│   │   ├── input_password_component.dart
│   │   ├── input_user_component.dart
│   │   ├── list_card_component.dart
│   │   ├── login_button_component.dart
│   │   ├── login_form_component.dart
│   │   └── todo_filter_toolbar_component.dart
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── todo/todo_model.dart
│   │   │   └── user/user_model.dart
│   │   ├── repositories/
│   │   │   └── todos/todos_repository.dart
│   │   └── sources/
│   │       ├── external/
│   │       │   ├── auth_source.dart
│   │       │   └── todo_source.dart
│   │       └── local/
│   │           ├── db_helper.dart
│   │           └── shared_preferences.dart
│   │
│   ├── implementations/
│   │   ├── crud_todo_sqflite_implementation.dart
│   │   └── http_client_dio_implementation.dart
│   │
│   ├── interfaces/
│   │   ├── auth.dart
│   │   ├── crud_todo.dart
│   │   ├── http_client.dart
│   │   ├── todo_repository.dart
│   │   ├── todo_source.dart
│   │   └── ...
│   │
│   └── utils/
│       ├── enums.dart
│       ├── result_pattern.dart
│       └── ...
│
├── view/
│   ├── logged/logged_view.dart
│   ├── login/login_view.dart
│   └── splash_screen/splash_view.dart
│
└── view_models/
    └── bloc/
        ├── login_bloc.dart
        ├── login_event.dart
        ├── login_state.dart
        ├── todos_bloc.dart
        ├── todos_event.dart
        └── todos_state.dart
```

## Responsabilidade das camadas

### `core`

Contém configurações gerais da aplicação:

- Rotas nomeadas;
- Temas claro e escuro;
- Configuração da aplicação;
- Bootstrap;
- Injeção de dependências.

### `shared/data/models`

Contém as entidades:

- `UserModel`: representa o usuário primitivo;
- `UserLoginModel`: representa os dados do usuário para login;
- `UserLoggedModel`: representa os dados do usuário autenticado;
- `TodoModel`: representa uma tarefa.

Os modelos realizam a conversão entre objetos Dart e `Map<String, dynamic>`.

### `shared/data/sources`

Contém as fontes de dados:

- Fontes externas para comunicação com a API;
- Fontes locais para SQLite e SharedPreferences.

### `shared/data/repositories`

O repositório coordena o acesso aos dados e trata exceções utilizando o padrão `Result`.

### `shared/implementations`

Contém implementações concretas das abstrações:

- Cliente HTTP baseado em Dio;
- Operações CRUD das tarefas utilizando SQLite.

### `shared/interfaces`

Define contratos para desacoplar as camadas e facilitar a manutenção e substituição das implementações.

### `shared/components`

Contém widgets reutilizáveis da aplicação, como formulários, campos de entrada, cards, filtros e diálogos.

### `view`

Contém as telas apresentadas ao usuário:

- Splash Screen;
- Login;
- Logged.

### `view_models`

Contém os BLoCs responsáveis pelo gerenciamento de estado:

- `LoginBloc`: controla  o estado da sessão e o login;
- `TodosBloc`: controla o estado de  sincronização, criação, atualização, leitura e deletamento das tarefas.

## Tratamento de erros

As exceções são capturadas nas camadas de serviço e repositório e convertidas para o padrão `Result`.

A interface apresenta mensagens para situações como:

- Usuário ou senha inválidos;
- Falha de conexão;
- API indisponível;
- Demora na resposta da API;
- Erros ao acessar o banco local.

Quando a API de tarefas não responde por algum motivo, a Home exibe uma mensagem de erro especifico, dispara un ScaffoldMessenger e disponibiliza a opção **Tentar novamente**. para isto o floatingActionButton do Scaffold muda de função de adicionar tarefa para recarregar  e também muda de cor para ser mais chamativo.

## Padrão Result

O padrão `Result` permite representar dois possíveis resultados de uma operação:

- `Ok`: operação realizada com sucesso;
- `ResultError`: operação finalizada com erro.

Dessa forma, as camadas superiores não precisam tratar diretamente todas as exceções lançadas pelas fontes de dados.

## Métodos e conceitos utilizados

O projeto utiliza conceitos exigidos na atividade:

- Classes e objetos;
- Construtores;
- Atributos;
- Encapsulamento;
- Interfaces e abstrações;
- Polimorfismo;
- `Map<String, dynamic>`;
- Listas;
- Métodos `map`, `where` e `any`;
- Funções e arrow functions;
- Condicionais `if/else`;
- Operadores lógicos e ternários;
- `ListView.builder`;
- `TextFormField` com validators;
- `Checkbox`;
- Navegação nomeada;
- SQLite;
- SharedPreferences;
- Cliente HTTP com Dio.

## Como executar

### Pré-requisitos

- Flutter instalado;
- Dart instalado;
- Android Studio ou Xcode configurado;
- Emulador ou dispositivo físico;
- Conexão com a internet para acessar a API.

Verifique a instalação do Flutter:

```bash
flutter doctor
```

### Instalação

Clone o repositório e acesse a pasta do projeto:

```bash
git clone git@github.com:Luis-Vilar/M2S07-Mini-Projeto-Avaliativo.git
cd M2S07-Mini-Projeto-Avaliativo
```

Instale as dependências:

```bash
flutter pub get
```

Inicialize o emulador Android ou Ios , logo enseguida execute:

```bash
flutter run
```

Para verificar problemas no código:

```bash
flutter analyze
```

## Fluxo da aplicação

```text
Inicialização
     |
     v
Splash Screen
     |
     ├── Sessão salva → LoggedView
     |
     └── Sem sessão →   LoginView
                            |
                            v
                     Autenticação na API
                            |
                ├── Erro → Mensagem de erro
                |
                └── Sucesso → Salva sessão → LoggedView
                                             |
                                             v
                                  API de tarefas
                                             |
                                  Salva no SQLite
                                             |
                                  Consulta local
                                             |
                                             v
                                      Lista de tarefas
```

## Melhorias futuras

- Permitir editar tarefas;
- Adicionar sincronização bidirecional com a API;
- Implementar paginação;
- Adicionar testes unitários e de widgets;
- Adicionar tema configurável pelo usuário.

## Autor

Projeto desenvolvido como atividade avaliativa do curso Mobile Flutter T1 — Módulo 02, Semana 07 por Luis Vilar.
