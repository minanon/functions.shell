#functions.bash ver.1.0.0
よく使う汎用的なシェルスクリプト用関数群

Version: 1.0.0
Author : minanon
License: {{{}}}


###目次
- 概要
- インストール
- 使用方法
- 関数
  - error()
  - warn()
  - inf()
  - msg()
  - comp()
  - decorate_string()
  - truncate_string()
  - centering()
  - right_align()
  - hr()
  - shhelp-gen()
- 更新履歴

##概要
よく使う汎用的なシェルスクリプト用関数群をまとめてあります。

##インストール
GitHubから取得してください。

    git clone https://github.com/minanon/functions.bash


##使用方法
```shell-session
. functions.bash #in your bash script
```

##関数
###error()
引数にある文字列を赤色にし、標準エラー出力します。

- 引数
  - <文字列> エラー出力する文字列

####使用方法	error()
```shell-session
error <string>
```

###warn()
引数にある文字列を黄色にし、標準エラー出力します。
- 引数
  - <文字列> ワーニング出力する文字列

####使用方法	warn()
```shell-session
warn <string>
```

###inf()
引数にある文字列を青色にし、標準エラー出力します。

- 引数
  - <文字列> 情報出力する文字列

####使用方法	inf()
```shell-session
inf <string>
```

###msg()
引数にある文字列を、標準出力します。

- 引数
  - <文字列> 出力する文字列

####使用方法	msg()
```shell-session
msg <string>
```

###comp()
引数にある文字列を緑色にし、標準出力します。

- 引数
  - <文字列> 出力する文字列

####使用方法	comp()
```shell-session
comp <string>
```

###decorate_string()
文字列の装飾を行います。

- 引数
  - -b ボールド
  - -s 取消線
  - -u アンダーライン
  - -l 点滅
  - -r 文字色と背景色を入れ替える
  - -n 装飾を無効化
  - -c {color_code} 文字色
  - -g {color_code} 背景色
  - -o 装飾済み文字を返す
  - -O 装飾コード付き文字を返す
  - <文字列> 装飾対象の文字列

####color code:(number or name)  
|文字色コード|背景色コード|色名    |
|---     |---           |---       |  
|30      |40            |black     |  
|31      |41            |red       |  
|32      |42            |green     |  
|33      |43            |yellow    |  
|34      |44            |blue      |  
|35      |45            |magenta   |  
|36      |46            |cyan      |  
|37      |47            |white     |

####使用方法	decorate_string()
```shell-session
decorate_string [-bsulrnoO] [-c {color_code}] [-g {color_code}] <string>
```

###truncate_string()
文字列が画面の幅を超える時に、はみ出す分を切り捨てます。

- 引数
  - <文字列> トランケートする文字列

####使用方法	truncate_string()
```shell-session
truncate_string <string>
```

###centering()
文字列を画面中央に寄せます。

- 引数
  - <文字列> 中央寄せする文字列

####使用方法	centering()
```shell-session
centering <string>
```

###right_align()
文字列を画面右寄せします。

- 引数
  - <文字列> 右寄せする文字列

####使用方法	right_align()
```shell-session
right_align <string>
```

###hr()
区切り線を表示します。

- 引数
  - -c 中央寄せ
  - -r 右寄せ
  - -t 画面からはみ出す区切り線を切り捨てる(default)
  - -T 画面からはみ出す場合も表示する
  - -n {repeat_count} 繰り返し回数(default: 20)
  - -s {line_string} 区切り文字(default: '-')

####使用方法	hr()
```shell-session
hr [-crtT] [-n {repeat_count}] [-s {line_string}]
```

###shhelp-gen()
generate shell for README.md

- 引数
  - -j japanese
  - shell script filepath

####使用方法	shhelp-gen()
```shell-session
shhelp-gen [-j] <string>
```

##更新履歴
[README.md](https://github.com/minanon/functions.shell/blob/master/README.md#changelog)を参照してください。
