# Loany

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To start server within Docker container:

```bash
docker-compose up
```

Run migrations:
```bash
docker-compose run --rm loany_app mix ecto.create
docker-compose run --rm loany_app mix ecto.migrate
```

Run bash within container:
```bash
docker exec -it loany_app /bin/bash
docker attach loany_app # allows console input
```



## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

