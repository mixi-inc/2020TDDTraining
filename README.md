# 2020年設計・テスト新卒研修
これは、2020年設計・テスト新卒研修で取り扱うRailsのサンプルプロジェクトです

## 環境準備
とりあえずdocker imageをbuildしてください

```
$ docker-compose build
```

buildできたら、以下のコマンド実行後、 localhost:3000 へアクセスしてみてRails Serverが起動しているか確認してみてください

```
$ docker-compose run web rails s
```

## 概要
まずは [こちらのPhotobooksControllerクラス](https://github.com/mixi-inc/2020TDDTraining/blob/master/app/controllers/api/v1/albums/photobooks_controller.rb) を見てください

HTTPリクエスト/レスポンスの処理だけではなく、異常系のバリデーション, アプリケーションロジック, レコードの作成まですべての責務を担っている、いわゆるFat Controllerというやつです

みなさんには、今からこのクラスをリファクタリングをしてもらいます

### PhotobooksControllerの仕様
[家族アルバムみてね](https://mitene.us/) で販売しているフォトブックを表現するオブジェクトの作成APIです

```rb
API: post '/:album_id/photobooks'
Params:
  requires :cover_media_id, type: String, desc: '表紙に使う media の id'
  requires :cover_media_taken_at, type: String, desc: '表紙に使う media の taken_at'
  optional :title, type: String, desc: 'フォトブックのタイトル'
  optional :sub_title, type: String, desc: 'フォトブックのサブタイトル'
  requires :photobook_pages, type: Array do
    requires :page_no, type: Integer, desc: 'ページ番号'
    requires :medium_uuid, type: String, desc: 'ページに入れる media の uuid'
    optional :comment, type: String, desc: 'ページに入れるコメントの本文'
  end

Response:
  正常系:
    json: {
      id: フォトブックのID,
      title: フォトブックのタイトル,
      subtitle: フォトブックのサブタイトル
    }, 
    status: 201
  該当するAlbumが存在しない:
    json: { code: 'album_not_found', message: 'アルバムが存在していません' },
    status: 404
  tiltleが20文字を超えている:
    json: { code: 'too_long_photobook_title', message: 'フォトブックのタイトルが文字数上限を超えています' },
    status: 400
  subtitleが20文字を超えている:
    json: { code: 'too_long_photobook_subtitle', message: 'フォトブックのサブタイトルが文字数上限を超えています' },
    status: 400
  commentが200文字を超えている:
    json: { code: 'too_long_photobook_comment', message: 'フォトブックのコメントが文字数上限を超えています' },
    status: 400
```

#### クラス図
<img src=https://user-images.githubusercontent.com/8536870/79121277-e2809000-7dcf-11ea-8764-8a8ede1d75db.png width=500>

### リファクタリングの方針
#### 0. Controllerのテストを書く
デグレしないようにテストを書きます

RailsのControllerのテストはかなりフレームワークの知識に偏ってしまうものになるので、ここはすでに用意しました
こちらのコマンドで実行できます

```
$ docker-compose run web rails test test/controllers/api/v1/albums/photobooks_controller_test.rb
```

以降の方針の詳細は対応するブランチのREADMEを参照してください

#### 1. ロジックをServiceクラスに切り出す
[question-1](https://github.com/mixi-inc/2020TDDTraining/tree/question-1) のブランチに切り替えてください

#### 2. Serviceクラスに依存を外から渡す
[question-2](https://github.com/mixi-inc/2020TDDTraining/tree/question-2) のブランチに切り替えてください

#### 3. モックを使ってServiceのテストを書く
[question-3](https://github.com/mixi-inc/2020TDDTraining/tree/question-3) のブランチに切り替えてください

#### 4. TDDでServiceクラスからDBアクセスをRepositoryに切り出していく
[question-4](https://github.com/mixi-inc/2020TDDTraining/tree/question-4) のブランチに切り替えてください

