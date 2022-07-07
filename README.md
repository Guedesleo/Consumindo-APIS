# ReposFind - Challenge: Consuming APIs

Instructions: [Consumindo APIs](https://www.notion.so/Desafio-01-Consumindo-APIs-59b66c4fc14147ff82a6e73b9ce23e85), [Testando requisições com bypass](https://www.notion.so/Desafio-02-Testando-requisi-es-com-bypass-e67ba498dee64089ac32e872812d20f6), [Autenticação JWT](https://www.notion.so/Desafio-01-Autentica-o-JWT-5c2fd6b53afb41b8b9f053deedecdf2f) and [Token refresh](https://www.notion.so/Desafio-02-Token-refresh-09ab7b3c0254453893faa39f3fa94ccf).

## Base URL
http://localhost:4000/

## Routes
### /api/users
* [<span style="color:#663399">GET</span>] / 
  + ReposFindWeb.UsersController :index
* [<span style="color:#79c900">POST</span>] /sigin
  + ReposFindWeb.UsersController :sign_in
* [<span style="color:#663399">GET</span>] /signout
  + ReposFindWeb.UsersController :sign_out
* [<span style="color:#663399">GET</span>] /current_token
  + ReposFindWeb.UsersController :current_token
* [<span style="color:#663399">GET</span>] /:id 
  + ReposFindWeb.UsersController :show
* [<span style="color:#79c900">POST</span>] / 
  + ReposFindWeb.UsersController :create
* [<span style="color:#ffc000">PATCH</span>] /:id 
  + ReposFindWeb.UsersController :update
* [<span style="color:#ff8c00">PUT</span>] /:id 
  + ReposFindWeb.UsersController :update
* [<span style="color:#ff0000">DELETE</span>] /:id 
  + ReposFindWeb.UsersController :delete

### /api/repos
* [<span style="color:#663399">GET</span>] / 
  + ReposFindWeb.RepositoriesController :index
* [<span style="color:#663399">GET</span>] /:username
  + ReposFindWeb.RepositoriesController :show 
## Tests
Tests: 9 total
## Project commands
### Prepare project
```bash
  # Intall dependencies
  mix deps.get

  # Start PostgreSQL service
  service postgresql start

  # Reset migrations
  mix ecto.reset
  MIX_ENV=test mix ecto.reset 

  # View app routes
  mix phx.routes
```
### Run project
```bash
  # Start Phoenix server
  mix phx.server
```

### Run tests
```bash
  # Intall dependencies
  mix test

  # Check coverage of tests
  mix test --cover
```

## Phoenix Server

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
