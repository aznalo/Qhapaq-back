genres = ['主食', '副菜', '汁物', '甘味']
genres.each do |t|
  Genre.create(name: t)
end

main_categories = ['和食', '中華', 'フレンチ', 'イタリアン', 'トルコ', 'その他']

categories.each do |t|
  Category.create(name: t)
end

genres.each do |t|
  categories.each do |tt|
    GenreCategory.create(
      genre: Genre.find_by(name: t),
      category: Category.find_by(name: tt)
    )
  end
end

[ 
  {name: '鯖の味噌煮', category: '和食'},
  {name: '回鍋肉', category: '中華'}, 
  {name: '白身魚のナージュ', category: 'フレンチ'}
].each do |t|
  Menu.create(
    name: t[:name],
    category: Category.find_by(name: t[:category])
  )
end
