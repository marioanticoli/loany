# Loany

## Basic steps

- Clone the project `git clone https://github.com/marioanticoli/loany.git`
- Install dependencies with `mix deps.get`

## Development env

To start your Phoenix server:

- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Production env

**THIS STEP REQUIRES docker AND docker-compose**

- Create the image `make build`
- Instantiate the service `docker-compose up`

Now you can visit [`localhost`](http://localhost) from your browser.

## Usage

To access the application list is necessary to login with username `admin@example.com` and password `admin`
