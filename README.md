# 1. ロジックをServiceクラスに切り出す
## Serviceクラスとは？
一般的にServiceクラスは「アプリケーションロジック、あるいはドメインロジックを扱うクラス」として知られています

ただ、「とりあえずコード量が多くなってきたし、Serviceクラスに切り出すか」という思想は結構危険です
あくまでも、アプリケーションのロジック, ドメインのロジックを簡潔に表現すべく使う、という心構えを忘れないことは大切です

さて、今回は「フォトブックを作成する」というドメインロジックを `PhotobooksController` から切り出すべく、 [CreatePhotobookService](https://github.com/mixi-inc/2020TDDTraining/blob/question-1/app/services/create_photobook_service.rb) というクラスを実装してみましょう

## TODO
- [ ] `PhotobooksController` から `CreatePhotobookService` にロジックを切り出す
- [ ] 異常系はErrorクラスを定義してraiseする
- [ ] Controller側で作成したServiceクラスをcallする
- [ ] Controller側でエラーハンドリングして、対応するレスポンスを返す
- [ ] `docker-compose run web rails test test/controllers/api/v1/albums/photobooks_controller_test.rb` が通ることを確認

## 答え
https://github.com/mixi-inc/2020TDDTraining/compare/question-1...answer-1
