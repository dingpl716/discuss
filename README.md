# Discuss

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Generate Migration files

  ```
  mix ecto.gen.migration add_topics
  mix ecto.migrate
  mix phoenix.routes
  ```

## OAuth with Github

  1. Add deps to mix.exs: ueberauth & ueberauth_github
  2. Add application to mix.exs: ueberauth & ueberauth_github
  3. mix deps.get
  4. Register an OAuth application on github.com
