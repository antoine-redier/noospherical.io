# noospherical.io

## Using the app in development environment

### **Dependencies**

  * You'll need [**Elixir 1.5, OTP 22**](https://elixir-lang.org/install.html) and [**Phoenix 1.4.16**](https://hexdocs.pm/phoenix/installation.html) installed on your computer for mix dependencies, [**Node.js**](https://nodejs.org/en/download/) for npm dependencies.

    * Install **Elixir** dependencies with `mix deps.get`

    * Install **Node.js** dependencies with `cd assets && npm install`

### **Database**

  * You'll need [**postgresql**](https://computingforgeeks.com/install-postgresql-12-on-ubuntu/) up and running... long story short: 

    * Make sure you have all database / admin rights on your current user, unless you want to switch to the default `postgres` user all the time.

    * Identification method should be set to **password** inside `pg_hba.conf`. Default `postgres` user password should be changed to something secure.

    * Add said password to your **dev.exs** file in config directory.

  * Create your database with `mix ecto.create`, then use `mix ecto.migrate` to create and alter tables accordingly to migration files.
    > 

### **Up and running**

 Start Phoenix endpoint with `mix phx.server`.

Now you can visit [**localhost:4000**](http://localhost:4000) from your browser.


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
