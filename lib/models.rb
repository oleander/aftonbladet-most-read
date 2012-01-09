class Article
  include DataMapper::Resource
  validates_presence_of :token, :published_at
  validates_uniqueness_of :token
  property :id, Serial
  property :token, Integer, unique_index: true
  property :published_at, Date
end

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "sqlite:///#{File.expand_path File.dirname(__FILE__)}/../db/database.sqlite3")
DataMapper.finalize