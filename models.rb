require 'bundler/setup'
Bundler.require
<<<<<<< HEAD
require './controllers/user'
require './controllers/genre'
require './controllers/category'
require './controllers/menu'
=======
require 'net/http'
require 'uri'
require 'json'
>>>>>>> eb1932f1ef684c29917e8ceca3c4a40682e250ba

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

<<<<<<< HEAD
class User < ActiveRecord::Base
  has_secure_password
  has_many :user_tokens, dependent: :destroy
end

class UserToken < ActiveRecord::Base
    belongs_to :user
end

class Genre < ActiveRecord::Base
  has_many :menus, dependent: :destroy
end

class Menu < ActiveRecord::Base
  belongs_to :genre
  belongs_to :category
  has_many :ingredients, dependent: :destroy
=======
class Genre < ActiveRecord::Base
  has_many :categories
end

class Category < ActiveRecord::Base
  belongs_to :genre
  has_many :menus
end

class Menu < ActiveRecord::Base
  belongs_to :category
  has_many :ingredient
>>>>>>> eb1932f1ef684c29917e8ceca3c4a40682e250ba
end

class Ingredient < ActiveRecord::Base
  belongs_to :menu
end
<<<<<<< HEAD

class Category < ActiveRecord::Base
  has_many :menus, dependent: :destroy
end
=======
>>>>>>> eb1932f1ef684c29917e8ceca3c4a40682e250ba
