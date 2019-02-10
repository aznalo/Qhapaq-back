get '/menu/:id' do
  menu = Menu.find_by(id: params[:id])
  {
    menu: menu,
    ingredients: menu.ingredients
  }.to_json
end
