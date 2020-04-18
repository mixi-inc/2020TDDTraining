# 4. TDDでServiceクラスからDBアクセスをRepositoryに切り出していく
いよいよ最後の問題です、がんばっていきましょう

さて、良い感じにServiceクラスに切り出せてテストも書けましたが、まだ不安なところがあります

それは、DBアクセス周りです

ModelをDIするようにしたとはいえ、そこから取得するオブジェクトはActiveRecord(RailsのORM)のクラスであり、 `destroy` によってどこでもレコードを削除できちゃいます

このような不安な状態を解消すべく、 `Repository` を導入してみましょう

## Repositoryとは？
`Repository` とは。一般的にDBやWebAPIなどの外部システムとのインターフェースを提供するクラスとされています

今回は、この `Repository` がModelへの依存を持ち、CRUD処理を行い、その結果をORMからひっぺがして `Entity` に変換したものを返すように実装します

これにより、 `Repository` より上位のレイヤは完全に外部システムからは切り離された安全な世界となります

## Entityとは？
DDDの文脈では、 `Entity` は「一意性を担保する、ドメインロジックを表現するオブジェクト」とされています

あまり深くは語りませんが、「IDを持っていて、そのオブジェクトに関係するロジックやバリデーションを持っている人」と思ってください

今回はすでに [`Entity` は定義しておいた](https://github.com/mixi-inc/2020TDDTraining/tree/question-4/app/entities) ので、 `AlbumRepository` と `PhotobookRepository` を `TDD` で実装してみましょう

## TDDとは？
Test Driven Development

ざっくりいうと、以下の手順を言います
1. まずは落ちるテストを書く
2. とりあえずテストが通るように雑に実装する
3. リファクタリングをして、テストが通らない状態と通る状態を素早く往復する

よって、みなさんまずは落ちるテストを書いてください

### 例えば
`AlbumRepository` をTDDで作ることを考えてみましょう

まずは落ちるテストを書くところから開始します

```rb
class AlbumRepositoryTest < ActiveSupport::TestCase
  test 'AlbumRepository#find_by の返り値が AlbumEntity であること' do
    repository = AlbumRepository.new(album_model: MockAlbum.new)
    album = repository.find_by(id: 0)
    assert(album.is_a?(AlbumEntity))
  end
end

class MockAlbum
end
```

この時点で一度テストを走らせましょう、当然テストは落ちますね

次に、まずはこのテストが通るところを目指します

Repositoryを以下のようにAlbumEntityを返すように実装してみます
```rb
class AlbumRepository
  def initialize(album_model:)
    @album = album_model
  end

  def find_by(id:)
    AlbumEntity.new(id: 0, children: [])
  end
end
```

テストを走らせてみましょう、当然通りますね

当然これで実装完了なわけではありません、テストケースを増やしてみて、実装が正しいことを確認していきます

以下のテストケースを追加してみましょう
```rb
test 'AlbumRepository#find_by の返り値 AlbumEntity が期待するフィールドを持つこと' do
  repository = AlbumRepository.new(album_model: MockAlbum.new)
  album = repository.find_by(id: 0)
  assert_equal(0, album.id)
end
```

当然、テストは落ちますね

このように、まずテストケースを書いてテストを落とす、次にとりあえずそのテストが通るように素早く実装する、テストが通っている状態を維持したまま実装を修正していく...ということをテストケースを増やしながら続けていくのがTDDになります

## テスト項目
### AlbumRepository
1. `AlbumRepository#find_by` の返り値が `AlbumEntity` であること
2. `AlbumRepository#find_by` の返り値 `AlbumEntity` が期待する要素数の配列 `children` を持つこと

### PhotobookRepository
1. `PhotobookRepository#create` の返り値が `PhotobookEntity` であること
2. `PhotobookRepository#create` の返り値 `PhotobookEntity` のそれぞれのフィールドが期待する値を持つこと

## TODO
- [ ] AlbumRepositoryのテストを書く
- [ ] PhotobookRepositoryのテストを書く

## 答え
https://github.com/mixi-inc/2020TDDTraining/compare/question-4...answer-4
