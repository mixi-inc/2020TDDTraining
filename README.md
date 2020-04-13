# 2. Serviceクラスに依存を外から渡す
さて、Fat ControllerからロジックをServiceクラスに切り出せたので、今度はそのクラスにテストを書きたくなるところです

しかし、このままではテストは書けません、なぜでしょう？

それは、依存性を外から渡していないからです

ここでいう依存性は、 `Album` や `Photobook` などのmodelクラスを指します
(RailsのModelクラスはいわゆるORMで、DBへのアクセスを司ります)

## Dependency Injectionとは？
Dependency Injection(以下DI)という言葉を聞いたことがあるでしょうか

その名の通り、依存性を外から渡すことを指します

例えば以下のメソッドを例にします

```rb
def callComponentA()
  componentA = ComponentA.new
  componentA.call()
end
```

このメソッドは、内部でComponentAを初期化してメソッドコールしています
これだと `callComponentA` が本当に `ComponentA#call` を呼び出しているかがテストできません

なので、以下のようにメソッドの引数で外部から `ComponentA` を受け取れるようにします

```rb
def call(componentA:)
  componentA.call()
end
```

これにより、以下のようなテストが書けるようになりました
(テストの書き方は次の問題で詳しく説明します)


```rb
class MockComponentA
  attr_reader :called

  def initialize
    @called = false
  end
  
  def call
    @called = true
  end
end

mock = MockComponentA.new
call(componentA: mock)

assert mock.called # trueが返ればテストが通る
```

これにより、テストが書ける他、依存関係がスッキリしたり、(Rubyではあまりないが)Interfaceを先に切って置くことで依存先の実装を先延ばしにすることが可能になったりします

今回は、イニシャライザ引数でModelをServiceに外から渡すことで、とりあえずテストが書ける状態を目指しましょう

## 余談
Railsであまりこういったことはしません
基本的には [DBにテストデータを簡易に作成できる便利gem](https://github.com/thoughtbot/factory_bot) を使って良い感じにテストが書けてしまうからです...

## TODO
- [ ] `Album` , `Photobook` , `PhotobookPage` をイニシャライザ引数で外から渡す
- [ ] Service内のModelを、外から渡されたものに差し替える
- [ ] Controller側でのService初期化処理を修正
- [ ] `docker-compose run web rails test test/controllers/api/v1/albums/photobooks_controller_test.rb` が通ることを確認
