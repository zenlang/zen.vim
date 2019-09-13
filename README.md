# zen.vim

File detection and syntax highlighting for the
[zen](http://zenlang.org/) programming language.

## Installation

 * Use Vim 8 or newer
 * `mkdir -p ~/.vim/pack/plugins/start/`
 * `cd ~/.vim/pack/plugins/start/`
 * `git clone https://github.com/zenlang/zen.vim`

## Configuration

This plugin enables automatic code formatting on save by default using
`zen fmt`. To disable it, you can use this configuration in vimrc:

```
let g:zen_fmt_autosave = 0
```
