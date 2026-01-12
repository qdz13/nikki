# nikki

`nikki` is a command-line diary manager written in Bash.

## Features

* Single shell script
* Powerful Zsh completion
* Markdown format
* Read, write, restore, or remove diaries easily

## Requirements

* [Bash](https://www.gnu.org/software/bash/) (Bash included with macOS is old, but it's enough.)
* [less](https://www.greenwoodsoftware.com/less/index.html)
* [Tree](https://oldmanprogrammer.net/source.php?dir=projects/tree)
* [Git](https://git-scm.com/)
* [diff-highlight](https://github.com/git/git/tree/master/contrib/diff-highlight)
* [bat](https://github.com/sharkdp/bat)
* [Glow](https://github.com/charmbracelet/glow)

You should also set `EDITOR` or `VISUAL` environment variable.

> [!IMPORTANT]
> `nikki` does not check if these commands are installed!

## Installation

```sh
sudo make install
```

## Usage

You can check global options and syntax by running `nikki --help`.

`nikki` has several subcommands.
Run `nikki <subcommand> --help` to check the usage.

## Tutorial

### Preparation

1. Install `nikki`

Follow the [Installation section](#Installation).

2. Set the editor

Set your favorite editor in `EDITOR` or `VISUAL` environment variable.
For example:

```sh
export EDITOR=nvim
```

It is also recommended to set `XDG_DATA_HOME` environment variable.
If this variable is unset or empty, the data directory will be `~/.local/share/nikki`.

### Write a diary

To write a diary, just run `nikki`.
After that, editor is opened automatically so you can write your diary quickly.

The format is markdown.

### Read a diary

Let's read the diary you wrote.
You can read the diary of current date by running `nikki read`.

By default, [bat](https://github.com/sharkdp/bat) is used as a pager.
To change it, you can use `--pager` global option.

```sh
nikki --pager less read
```

Currently, you can choose from four pagers (cat(1), [less](https://www.greenwoodsoftware.com/less/index.html),
[bat](https://github.com/sharkdp/bat), and [glow](https://github.com/charmbracelet/glow)).

> [!TIP]
> `--pager` is global option, so it shouldn't be placed after subcommand.

Of course you can read past diaries.
To read the diary written on January 11, 2026:

```sh
nikki read 20260111
```

If the current year is 2026, you can omit year:

```sh
nikki read 0111
```

Similarly, if the current month is January, month can be omitted.

```sh
nikki read 11
```

This way is also valid for the subcommand `edit` and `rm`.

> [!TIP]
> The option `--past` is necessary to edit past diaries (This is not a global option!).

### Remove diaries

If you want to remove past diaries, use `rm` subcommand:

```sh
nikki rm 20260111
```

### Find diaries

To list years which diaries exist:

```sh
nikki ls
```

To list diaries written in the specified month:

```sh
nikki ls 202601
```

Of course you can omit the year if the current year is 2026:

```sh
nikki ls 01
```

Or, you can use the `tree` subcommand to list diaries in a tree-like format:

```sh
nikki tree
```

### Restore diaries

When you edit or delete a diary, the state before the operation will be backed up.
This will be automatically deleted after 3 days.

You can restore diaries from a backup with the `restore` subcommand:

```sh
nikki restore
```

### Tips

By using Zsh completion, you can reduce types.

For example:

```sh
nikki read <tab>
```

Then past diaries will be displayed as a candidate.
