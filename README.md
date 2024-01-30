
- Ruby version

  - ruby 3+

- System dependencies

  Before you get started, the following needs to be installed:

  - Ruby 3+ (bundler v2)
  - Ruby on Rails 7+
  - PostgreSQL 12+
  - node 16.x
  - yarn 1.22.x
  - Application Server: Puma


- Configuration

  ### Setting up the development environment

  1.  Get the code. Clone this git repository and check out the latest release

  2.  Install the required gems by running the following command in the project root directory:

  ```bash
  bundle install
  ```

  3.  Install the required packages by running the following command in the project root directory:

  ```bash
  yarn install
  yarn
  ```

  4.  Create an `.env` file by copying the example environment file configuration:

  ```bash
  touch .env
  ```

  5.  Create and populate database with seeds using:

    ```bash
    rails db:create db:migrate db:seed
    ```

  6.  Run server:

    `bin/dev`
