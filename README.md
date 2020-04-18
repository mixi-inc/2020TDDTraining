# 2. Serviceクラスに依存を外から渡す
さて、Fat ControllerからロジックをServiceクラスに切り出せたので、今度はそのクラスにテストを書きたくなるところです

しかし、このままではテストは書けません、なぜでしょう？

それは、依存性を外から渡していないからです

ここでいう依存性は、 `Album` や `Photobook` などのModelクラスを指します
(RailsのModelクラスはいわゆるORMで、DBへのアクセスを司ります)

## Dependency Injection(DI)とは？
DIという言葉を聞いたことがあるでしょうか

これは、その名の通り依存性を外から注入することを指します


例えば以下のメソッドを例にします

```rb
def callComponentA()
  componentA = ComponentA.new
  componentA.call()
end
```

このメソッドは、内部でComponentAを初期化してcallメソッドを呼んでいます

このままだと `callComponentA` メソッドが本当に `ComponentA#call` を呼び出しているかがテストできません


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

これによりテストが書けるようになった他、以下のような副産物が得られます
- 依存関係が明瞭になる
- (Rubyではあまりないが)依存先のコンポーネントのInterfaceを先に切って置くことで依存先の実装を先延ばしにすることが可能になる

今回は、イニシャライザ引数でModelをServiceに外から渡すことで、とりあえずテストが書ける状態を目指しましょう

## 余談
Railsで実はあまりこういったことはしません

基本的には [DBにテストデータを簡易に作成できる便利gem](https://github.com/thoughtbot/factory_bot) や強力なモックライブラリ等を使って良い感じにテストが書けてしまうからです...

ですが、こういった便利gem達を使ってテストを強引に書いていってしまうと、コンポーネント間の依存関係を意識する時間が損なわれ、設計が崩れやすくなってしまいます

今回の研修でモックを手で書いてもらおうと考えているのは、そのような危険性を回避できるようになっていて欲しいという意図の他、Ruby以外の言語, Rails以外のフレームワークだと強引にモックできないことがあるので自分でもモックが書けるようになっていて欲しいという思いがあるからです

## TODO
- [ ] `Album` , `Photobook` , `PhotobookPage` をイニシャライザ引数で外から渡す
- [ ] Service内のModelを、外から渡されたものに差し替える
- [ ] Controller側でのService初期化処理を修正
- [ ] `docker-compose run web rails test test/controllers/api/v1/albums/photobooks_controller_test.rb` が通ることを確認

## 答え
https://github.com/mixi-inc/2020TDDTraining/compare/question-2...answer-2
