require 'bundler/setup'
Bundler.require
require './controllers/user'
require './controllers/genre'
require './controllers/category'
require './controllers/menu'

config = YAML.load_file('./database.yml')

ActiveRecord::Base.configurations = config
if development?
  ActiveRecord::Base.establish_connection(config['development'])
else
  ActiveRecord::Base.establish_connection(config['production'])
end

Time.zone = 'Tokyo'
ActiveRecord::Base.default_timezone = :local

after do
  ActiveRecord::Base.connection.close
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :user_tokens
end

class UserToken < ActiveRecord::Base
    belongs_to :user
end

class Genre < ActiveRecord::Base
  has_many :genre_categories
  has_many :categories, through: :genre_categories
end

class GenreCategory < ActiveRecord::Base
  belongs_to :genre
  belongs_to :category
end

class Category < ActiveRecord::Base
  has_many :genre_categories
  has_many :genres, through: :genre_categories
  has_many :menus, dependent: :destroy
end

class Menu < ActiveRecord::Base
  belongs_to :category
  has_many :ingredient, dependent: :destroy
end

class Ingredient < ActiveRecord::Base
  belongs_to :menu
end
