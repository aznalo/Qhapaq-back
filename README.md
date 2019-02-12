# Qhapaq-back

## APIの仕様

### User関連
#### SignIn
> (POST) http://localhost:4567/user/sign_in

### Genre関連
#### ジャンル一覧を取得
> (GET) http://localhost:4567/genres

#### ジャンルを登録
> (POST) http://localhost:4567/genre
### Menu関連

#### メニュー一覧を取得
> (GET) http://localhost:4567/menu/:id (:idはジャンルのIDを指定する)

#### メニューを新規作成
> (POST) http://localhost:4567/menu

#### メニューを更新
> (POST) http://localhost:4567/menu/:id
