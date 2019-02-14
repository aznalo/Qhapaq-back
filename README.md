# Qhapaq-back

## Installation

```bash
docker-compose run bundle install --path vendor/bundle --without production -j4

docker-compose run web bundle exec rake db:create

docker-compose run web bundle exec rake db:migrate

docker-compose run web bundle exec rake db:seed
```

## Usage

```bash
docker-compose up
```

## APIの仕様

### User関連
#### SignIn
> (POST) http://localhost:4567/user/sign_in

##### 送るデータ
```js
{
  "name": "xxxx",
  "password": "xxxx"
}
```

##### 返却データ

###### 認証成功時
```js
{
  "user": {
    "name": "xxx",
  },
  "token": "xxxx-xxxx-xxxx-xxxx"
}
```

###### 認証失敗時
`ステータス 400 を返却`

### Genre関連
#### ジャンル一覧を取得
> (GET) http://localhost:4567/genres

##### 返却データ
```js
[
  {
    "id": 1,
    "name": "主食",
    "description": null,
    "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx",
    "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx"
  },
{
    "id": 2,
    "name": "副菜",
    "description": null,
    "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx",
    "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx"
  }
  ...
]
```

#### ジャンルを登録
> (POST) http://localhost:4567/genre

##### 送るデータ
```js
{
  "name": "xxxx",
  "description": "xxxx"
}
```

##### 返却データ

###### 作成成功時
`ステータス 201 を返却`
###### 作成失敗時
`ステータス 500 を返却`


#### ジャンルを編集
> (POST) http://localhost:4567/genre/:id

##### 送るデータ
```js
{
  "name": "xxxx",
  "description": "xxxx"
}
```

##### 返却データ

###### 作成成功時
```js
{
  "name": "xxxx",
  "description": "xxxx"
}
```

###### 作成失敗時
`ステータス 500 を返却`

### Menu関連

#### メニュー一覧を取得
> (GET) http://localhost:4567/menus/:id (:idはジャンルのユニークIDを指定する)
カテゴリ１（今回は主食)に属するメニュー一覧を取得する

```js
[
  {
    "id": 1, //メニューのユニークID
    "category_id": 1, //属しているカテゴリのID
    "genre_id": 1, //属しているカテゴリのID
    "name": "鯖の味噌煮",//メニュー名
    "description": null, //メニューの説明
    "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx", //メニューが作られた日
    "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx" //メニューの最終更新日
  },
  {
    "id": 2,
    "category_id": 2,
    "genre_id": 1,
    "name": "回鍋肉",
    "description": null,
    "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx",
    "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx"
  }
  ...
]

```

#### メニューの詳細を取得
> (GET) http://localhost:4567/menu/:id (:idはmenuのIDを指定する)

```js
{
  "id": 18, // メニューのユニークID
  "category_id": 1, //属しているカテゴリのID
  "genre_id": 1, //属しているジャンルのID
  "name": "ペペロンチーノ", //メニュー名
  "description": null, //説明
  "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx", //このメニューが作られた日
  "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx", //このメニューの最終更新日
  "ingredients": [
    {
      "id": 31, //材料のユニークID
      "menu_id": 18, //属しているメニューID
      "name": "パスタ", //材料の名前
      "amount": 100, //材料の量
      "unit": "g", //材料の単位
      "cost": 40, //材料の値段
      "description": "８分茹でる", //材料の説明
      "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx", //この材料の作られた日
      "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx" //この材料の最終更新日
    },
    {
      "id": 32,
      "menu_id": 18,
      "name": "オリーブオイル",
      "amount": 30,
      "unit": "ml",
      "cost": 7,
      "description": "",
      "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx",
      "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx"
    },
    {
      "id": 33,
      "menu_id": 18,
      "name": "にんにく",
      "amount": 8,
      "unit": "枚",
      "cost": 10,
      "description": "オリーブオイルで焦がす",
      "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx",
      "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx"
    }
  ]
 }
```

#### メニューを新規作成
> (POST) http://localhost:4567/menu

##### 送るデータ
```js
{
  "name": "", //メニュー名
  "genre_id": "", //属したいジャンルのID
  "ingredients": [ //材料
    {
      "name": "", //材料名
      "amount": 0, //量
      "unit": "", //単位
      "cost": 0, //値段
      "description": "" //説明
    },
    {
      "name": "",
      "amount": 0,
      "unit": "",
      "cost": 0,
      "description": ""
    }
  ]
}
```

##### 返却データ

###### 作成成功時
```js
{
  "id": 20,
  "category_id": 1,
  "genre_id": 1,
  "name": "ハンバーグ",
  "description": null,
  "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx",
  "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx"
}
```

###### 作成失敗時
`ステータス 500 を返却`


#### メニューを更新
> (POST) http://localhost:4567/menu/:id
`/:id` の部分は更新したいメニューのユニークID

最低限URLが合っていれば更新したい項目の`key`と`value`を入れてくれれば更新できます。

##### 送るデータ
```js
{
  "name": "ハンバーグ",
  "description": null,
  "ingredients": [ //最低限材料のユニークIDと更新したい項目今回はnameだけ更新したい場合
    {"id": 37, "name": "ひき肉"}
  ],
  "removeIngredientItemList": [ //削除したい材料のユニークIDを入れる
    {"id": 38}
  ]
}
```

##### 返却データ

###### 作成成功時
```js
{
  "id": 20,
  "category_id": 1,
  "genre_id": 1,
  "name": "ハンバーグ",
  "description": null,
  "created_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx",
  "updated_at": "xxxx-xx-xxTxx:xx:xx.xx+xx:xx"
}
```

###### 作成失敗時
`ステータス 500 を返却`
