# index
get '/menu/:id' do
  menu = Menu.find_by(id: params[:id])
  menu.attributes.merge({ingredients: menu.ingredients}).to_json
end

# create
post '/menu' do
  menu_params = JSON.parse(request.body.read)
  menu = Menu.new(hoge(menu_params))
  status 500 unless menu.save
  menu_params['ingredients'].each { |v| fuga(menu, v) }
  menu.to_json
end

# update
post '/menu/:id' do
  menu_params = JSON.parse(request.body.read)
  menu = Menu.find_by(id: params[:id])
  status 404 unless menu
  status 500 unless menu.update(hoge(menu_params))
  menu_params['ingredients'].each { |v| fuga(menu, v) }
  menu.to_json
end

private

def hoge(params)
  {
    genre: Genre.find_by(id: params['genre_id']),
    category_id: 1,
    name: params['name']
  }
end

def fuga(menu, params)
  ingredient = Ingredient.find_or_initialize_by(
    name: params['name'],
    menu: menu
  )
  ingredient.update_attributes(
    menu:        menu,
    name:        params['name'],
    amount:      params['amount'],
    unit:        params['unit'],
    cost:        params['cost'],
    description: params['description']
  )
end

post '/menu' do
  menu_params = JSON.parse(request.body.read)
  menu = Menu.new({
    genre: Genre.find_by(id: menu_params['genre_id']),
    category_id: 1,
    name: menu_params['name']
  })
  if menu.save
    menu_params['ingredients'].each do |i|
      Ingredient.create(
        menu: menu,
        name: i['name'],
        amount: i['amount'],
        unit: i['unit'],
        cost: i['cost'],
        description: i['description']
      )
    end
    menu.to_json
  else
    status 500
  end

end
