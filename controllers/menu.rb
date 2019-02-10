get '/menu/:id' do
  menu = Menu.find_by(id: params[:id])
  {
    menu: menu,
    ingredients: menu.ingredients
  }.to_json
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
