require 'bundler/setup'
Bundler.require
require 'net/http'
require 'uri'
require 'json'
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
end

class Genre < ActiveRecord::Base
  has_many :categories, dependent: :destroy
end

class Category < ActiveRecord::Base
  belongs_to :genre
  has_many :menus, dependent: :destroy
end

class Menu < ActiveRecord::Base
  belongs_to :category
  has_many :ingredient, dependent: :destroy
end

class Ingredient < ActiveRecord::Base
  belongs_to :menu
end
