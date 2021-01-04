# note_app_with_sinatra

Fjord Bootcamp practice

# Environment

- Sinatra
  - Slim
- PostgreSQL

# Usage

## Create database

Login to `your_database_name`.

```
$ psql -U your_database_name
```

Create new database.

```
postgres=# CREATE DATABASE note_app;
```

Logout from `your_database_name` and relogin to `note_app`.
Create table.

```
note_app=# CREATE TABLE Note(note_id SERIAL NOT NULL, title VARCHAR NOT NULL, body VARCHAR  , PRIMARY KEY (note_id));
```

## Run note application

1. Run `bundle install`
2. Run `bundle exec note_app.rb`
