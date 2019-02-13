# ジャンル一覧
get '/genres' do
  Genre.all.to_json
end

# ジャンルの詳細
get '/genre/:id' do
  Genre.find_by(id: params[:id]).to_json
end

# ジャンルの作成
post '/genre' do
  genre_params = JSON.parse(request.body.read)
  genre = Genre.new({ name: genre_params['name'] })
  if genre.save
    status 201
  else
    status 500
  end
end

# 該当IDのジャンル削除
delete '/genre/:id' do
  genre = Genre.find_by(id: params[:id])
  if genre
    genre.destroy
  else
    status 404
  end
end

# 該当IDのジャンル編集
put '/genre/:id' do
  genre_params = JSON.parse(request.body.read)
  genre = Genre.find_by(id: params[:id])
  if genre
    genre.update({name: genre_params['name']})
    genre.to_json
  else
    status 404
  end
end
