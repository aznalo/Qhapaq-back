# index
get '/menus' do
  Menu.all.to_json
end

# genre filter menus
get '/menus/:id' do
  Genre.find_by(id: params[:id]).menus.to_json
end

#show
get '/menu/:id' do
  menu = Menu.find_by(id: params[:id])
  menu.attributes.merge({
    ingredients: menu.ingredients,
    steps: menu.steps
  }).to_json
end

# create
post '/menu' do
  pp menu_params = JSON.parse(request.body.read)
  (status 403) unless User.authentication(menu_params['userToken'])
  menu = Menu.new(parseMenu(menu_params))
  status 500 unless menu.save
  menu_params['ingredients'].each { |v| updateIngredients(menu, v) }
  menu_params['steps'].each { |v| updateSteps(menu, v) }
  menu.to_json
end

# update
post '/menu/:id' do
  menu_params = JSON.parse(request.body.read)
  (status 403) unless User.authentication(menu_params['userToken'])
  menu = Menu.find_by(id: params[:id])
  status 404 unless menu
  status 500 unless menu.update(parseMenu(menu_params))
  menu_params['ingredients'].each { |v| updateIngredients(menu, v) }
  menu_params['steps'].each { |v| updateSteps(menu, v) }
  menu_params['removeIngredientItemList'].each { |v| Ingredient.find_by(id: v['id']).destroy }
  menu_params['removeStepItemList'].each { |v| Step.find_by(id: v['id']).destroy }
  menu.to_json
end

private

def parseMenu(params)
  {
    genre: Genre.find_by(id: params['genre_id']),
    category_id: 1,
    name: params['name']
  }
end

def updateIngredients(menu, params)
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

def updateSteps(menu, params)
  step = Step.find_or_initialize_by(
    description: params['description'],
    menu: menu
  )
  step.update_attributes(
    menu: menu,
    description: params['description']
  )
end
