# nikki

[English](README.md) | 日本語

## 概要

`nikki` はBashで書かれたCLIの日記管理プログラムです。

## 特徴

* 単一のシェルスクリプト
* 強力なZsh補完
* マークダウン形式
* 日記の読み、書き、復元、または削除が簡単にできる

## 要件

* [Bash](https://www.gnu.org/software/bash/) (macOSに同梱されているBashは古いですが十分です。)
* [less](https://www.greenwoodsoftware.com/less/index.html)
* [Tree](https://oldmanprogrammer.net/source.php?dir=projects/tree)
* [Git](https://git-scm.com/)
* [diff-highlight](https://github.com/git/git/tree/master/contrib/diff-highlight)
* [bat](https://github.com/sharkdp/bat)
* [Glow](https://github.com/charmbracelet/glow)

また、環境変数 `EDITOR` または `VISUAL` もセットしてください。

> [!IMPORTANT]
> `nikki` はこれらのコマンドがインストールされているかを確認しません！

### Homebrew (macOS)

```sh
brew update
brew install tree git bat glow
ln -s /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight "${XDG_BIN_HOME:-$HOME/.local/bin}"
```

### Pacman (ArchベースのLinuxディストリビューション)

```sh
sudo pacman -Syu
sudo pacman -S less tree git bat glow
ln -s /usr/share/git/diff-highlight/diff-highlight "${XDG_BIN_HOME:-$HOME/.local/bin}"
```

### pkg (FreeBSD)

```sh
doas pkg update
doas pkg install bash less tree git bat glow
ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight "${XDG_BIN_HOME:-$HOME/.local/bin}"
```

## インストール

```sh
git clone 'https://codeberg.org/qdz13/nikki.git'
cd nikki
sudo make install
```

## 使い方

`nikki --help` を実行することでグローバルオプション及び構文を確認できます。

`nikki` には複数のサブコマンドがあります。
`nikki <subcommand> --help` を実行することで使い方を確認できます。

## 解説

### 準備

1. `nikki` のインストール

[インストールセクション](#インストール)に従ってください。

2. エディタの設定

お好みのエディタを `EDITOR` または `VISUAL` 環境変数に指定してください。
例:

```sh
export EDITOR=nvim
```

`XDG_DATA_HOME` 環境変数の設定も推奨されます。
この変数が未設定または空の場合、データディレクトリは `~/.local/share/nikki` になります。

### 日記を書く

日記を書くには、単に `nikki` を実行してください。
すると、自動的にエディタが開くため日記を素早く書くことができます。

形式はマークダウンです。

### 日記を読む

書いた日記を読んでみましょう。
`nikki read` を実行することでその日に書いた日記を読むことができます。

デフォルトでは、[bat](https://github.com/sharkdp/bat)がページャーとして使われます。
これを変更するには、 `--pager` グローバルオプションを利用できます。

```sh
nikki --pager less read
```

現在、4つのページャーから選択できます (cat(1)、[less](https://www.greenwoodsoftware.com/less/index.html)、
[bat](https://github.com/sharkdp/bat)、そして [glow](https://github.com/charmbracelet/glow))。

> [!TIP]
> `--pager` はグローバルオプションのため、サブコマンドの後に置かれてはなりません。

もちろん過去の日記も読むことができます。
2026年1月11日に書かれた日記を読むには:

```sh
nikki read 20260111
```

もし現在の年が2026年ならば、年を省略できます:

```sh
nikki read 0111
```

同様に、もし現在の月が1月ならば月も省略できます。

```sh
nikki read 11
```

この方法はサブコマンド `edit` や `rm` にも有効です。

> [!TIP]
> オプション `--past` は過去の日記を編集するのに必須です (これはグローバルオプションではありません！)。

### 日記の削除

日記を削除したい場合、 `rm` サブコマンドを使います:

```sh
nikki rm 20260111
```

### 日記を探す

日記が存在する年を一覧表示するには:

```sh
nikki ls
```

指定した月に書かれた日記を一覧表示するには:

```sh
nikki ls 202601
```

もちろん現在の年が2026年ならば年を省略できます:

```sh
nikki ls 01
```

または、 `tree` サブコマンドを用いて日記を木のような形式で一覧表示できます:

```sh
nikki tree
```

### 日記を復元する

日記を編集または削除する際、操作前の状態がバックアップされます。
これは3日後に自動で削除されます。

`restore` サブコマンドを用いてバックアップから日記を復元できます:

```sh
nikki restore
```

### ヒント

#### Zsh補完

Zsh補完を使うことで、タイプ数を削減できます。
例:

```sh
nikki read <tab>
```

すると過去の日記が候補として表示されます。

#### Unisonを用いたリモートとの同期

自宅にあるどのコンピューターからでも日記を書きたい場合、
[Unison](https://www.cis.upenn.edu/~bcpierce/unison/)が推奨されます。

これはプロファイルの例です:

```
root = /home/username
root = ssh://username@remotehostname//home/username

path = .local/share/nikki

batch = true
times = true
```

ユーザー名を修正し `~/.unison/nikki.prf` に配置します。

そして、 `unison nikki` を実行することで日記を同期できます。

#### Rsyncとscpを用いた日記のバックアップ

もし単に日記をリモートにバックアップしたい場合、[Rsync](https://rsync.samba.org/)が良い選択肢です。

```sh
rsync -mrt "${XDG_DATA_HOME:$HOME/.local/share}/nikki" ssh://username@remotehostname//path/to/backup/directory/nikki
```

または `scp` を使います:

```sh
scp -pr "${XDG_DATA_HOME:$HOME/.local/share}/nikki" ssh://username@remotehostname//path/to/backup/directory/nikki
```
