genres = ['主食', '副菜', '汁物', '甘味']
genres.each do |t|
  Genre.create(name: t)
end

[ 
  {name: '鯖の味噌煮',       genre: '主食', category: '和食'},
  {name: '回鍋肉',           genre: '主食', category: '中華'}, 
  {name: '白身魚のナージュ', genre: '主食', category: 'フレンチ'},
  {name: 'なめこの味噌汁',   genre: '汁物', category: '和食'},
  {name: 'プリン',           genre: '甘味', category: 'その他'},
].each do |t|
  unless category = Category.find_by(name: t[:category])
    category = Category.create(name: t[:category])
  end
    Menu.create(
      name: t[:name],
      genre: Genre.find_by(name: t[:genre]),
      category: category
    )
end

User.new(
  name: 'Administrator',
  password: 'nkjk28',
  password_confirmation: 'nkjk28'
).save
