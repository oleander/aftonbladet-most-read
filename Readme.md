# Aftonbladet most read

Live feed avalible on twitter; [@AftonbladetTopp](https://twitter.com/#!/AftonbladetTopp)

## How to setup

0. Install dependencies. `bundle install`
1. Create database. `touch db/database.sqlite3`
2. Migrate database. `bundle exec ruby migrate.rb`
3. Run worker. `bundle exec ruby worker.rb`