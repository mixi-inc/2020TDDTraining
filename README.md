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

今回はすでに `Entity` は定義してあるので、 `AlbumRepository` と `PhotobookRepository` を `TDD` で実装してみましょう

## TDDとは？
Test Driven Development

ざっくりいうと、以下の手順を言います
1. まずは落ちるテストを書く
2. とりあえずテストが通るように雑に実装する
3. リファクタリングをして、テストが通らない状態と通る状態を素早く往復する

よって、みなさんまずは落ちるテストを書いてください

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
