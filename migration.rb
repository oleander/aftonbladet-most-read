require "dm-migrations"
require "dm-migrations/migration_runner"

DataMapper.setup(:default, "sqlite:///#{File.expand_path File.dirname(__FILE__)}/db/database.sqlite3")
DataMapper::Logger.new(STDOUT, :debug)
DataMapper.logger.debug("Starting Migration")

migration 1, :create_articles_table do
  up do
    create_table :articles do
      column :id, Integer, serial: true
      column :token, Integer
      column :published_at, DateTime
    end
  end

  down do
    drop_table :articles
  end
end

migrate_up!