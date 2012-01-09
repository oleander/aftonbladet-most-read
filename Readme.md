# Aftonbladet most read

Live feed available on twitter; [@AftonbladetTopp](https://twitter.com/#!/AftonbladetTopp)

## How to setup

1. Clone project. `git clone git://github.com/oleander/aftonbladet-most-read.git`
2. Install dependencies. `bundle install`
3. Create database. `touch db/database.sqlite3`
4. Migrate database. `bundle exec ruby migrate.rb`
5. Run worker. `bundle exec ruby worker.rb`