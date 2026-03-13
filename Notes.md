# The Missing Semester of Your CS Education
## Shell
Bourne Again SHell(bash)

command:  
`date` `echo` `which` `pwd` `cd` `ls` `mv` `cp` `mkdir` `man` `cat` `find` `tee` `sudo`

redirection operator: `<` `>` `>>`  
pipe operator: `|`

environment `$PATH`

## Shell Tolls and Scripting
function
```
mcd () {
    mkdir -p "$1"
    cd "$1"
}
```
- `$0` - Name of the script
- `$1` to `$9` - Arguments to the script. `$1` is the first argument and so on.
- `$@` - All the arguments
- `$#` - Number of arguments
- `$?` - Return code of the previous command
- `$$` - Process identification number (PID) for the current script
- `!!` - Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions; you can quickly re-execute the command with `sudo` by doing `sudo !!`
- `$_` - Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing `Esc` followed by `.` or `Alt+.`

short-circuiting

`$( CMD )` command substitution  
`<( CMD )` process substitution

globbing  
- wildcards: `?` and `*`
- curly braces: `{}`

shebang  
`env` command such as `#!/usr/bin/env python`

export

`tldr`(TLDR pages)

`find . -name [name] -type [type]`  
`fd`  
`locate`

`grep`  
`ack`  
`ag`  
`rg`

`history`  
`Ctrl+R`  
`fzf`  

`fasd`  
`autojump`  
`tree`  
`broot`

## Vim
Mode
- Normal: for moving around a file and making edits
- Insert: for inserting text
- Replace: for replacing text
- Visual (plain, line, or block): for selecting blocks of text
- Command-line: for running a command

command-line
- `:q` quit (close window)
- `:w` save (“write”)
- `:wq` save and quit
- `:e {name of file}` open file for editing
- `:ls` show open buffers
- `:help {topic}` open help
  - `:help :w` opens help for the :w command
  - `:help w` opens help for the w movement

movement
- Basic movement: `hjkl` (left, down, up, right)
- Words: `w` (next word), `b` (beginning of word), `e` (end of word)
- Lines: `0` (beginning of line), `^` (first non-blank character), `$` (end of line)
- Screen: `H` (top of screen), `M` (middle of screen), `L` (bottom of screen)
- Scroll: `Ctrl-u` (up), `Ctrl-d` (down)
- File: `gg` (beginning of file), `G` (end of file)
- Line numbers: `:{number}<CR>` or `{number}G` (line {number})
- Misc: `%` (corresponding item)
- Find: `f{character}`, `t{character}`, `F{character}`, `T{character}`
  - find/to forward/backward {character} on the current line
  - `,` / `;` for navigating matches
- Search: `/{regex}`, `n` / `N` for navigating matches

selection
- Visual: `v`
- Visual Line: `V`
- Visual Block: `Ctrl-v`

edits
- `i` enter Insert mode
  - but for manipulating/deleting text, want to use something more than backspace
- `o` / `O` insert line below / above
- `d{motion}` delete {motion}
  - e.g. `dw` is delete word, `d$` is delete to end of line, `d0` is delete to beginning of line
- `c{motion}` change {motion}
  - e.g. `cw` is change word
  - like `d{motion}` followed by `i`
- `x` delete character (equal to `dl`)
- `s` substitute character (equal to `cl`)
- Visual mode + manipulation
  - select text, `d` to delete it or `c` to change it
- `u` to undo, `<C-r>` to redo
- `y` to copy / “yank” (some other commands like `d` also copy)
- `p` to paste
- Lots more to learn: e.g. `~` flips the case of a character
- `.` repeat operation

counts
- `3w` move 3 words forward
- `5j` move 5 lines down
- `7dw` delete 7 words

modifiers
- `ci(` change the contents inside the current pair of parentheses
- `ci[` change the contents inside the current pair of square brackets
- `da'` delete a single-quoted string, including the surrounding single quotes

## Data Wranglin
`ssh`

`sed` + `s/REGEX/SUBSTITUTION/`

regular expressions
- `.` means “any single character” except newline
- `*` zero or more of the preceding match
- `+` one or more of the preceding match
- `[abc]` any one character of `a`, `b`, and `c`
- `(RX1|RX2)` either something that matches `RX1` or `RX2`
- `^` the start of the line
- `$` the end of the line
- `\d` any digit
- `\w` any alphanumeric character
- `\s` any whitespace
- `{m}` m repetitions
- `{m,n}` m to n repetitions
- `(...)` capture group

suffix * or + with a ? to make them non-greedy

`sort` `uniq -c` `head` `tail` `paste`

`awk`

do not substitude the same file with `>`, because the shell will clear the file after `>` in the first

## job control
`Ctrl-C` `SIGINT`
`Ctrl-\` `SIGQUIT`
`Ctrl-Z` `SIGSTOP`

`nohup`

tmux

## aliases
`alias alias_name="command_to_alias arg1 arg2"`

`ssh foobar@server command` 

`ssh-keygen` `ssh-agent`

copying files over SSH `ssh + tee` `scp` `rsync`

port forwarding

## git
```
// a file is a bunch of bytes
type blob = array<byte>

// a directory contains named files and directories
type tree = map<string, tree | blob>

// a commit has parents, metadata, and the top-level tree
type commit = struct {
    parents: array<commit>
    author: string
    message: string
    snapshot: tree
}

type object = blob | tree | commit

objects = map<string, object>

def store(object):
    id = sha1(object)
    objects[id] = object

def load(id):
    return objects[id]

references = map<string, string>

def update_reference(name, id):
    references[name] = id

def read_reference(name):
    return references[name]

def load_reference(name_or_id):
    if name_or_id in references:
        return load(references[name_or_id])
    else:
        return load(name_or_id)
```

commands
```
git cat-file -p

git help <command>
git init
git status
git add <filename>
git commit
git log [--all --graph --decorate --oneline]
git diff <filename>
git checkout <revision>

git branch
git branch <name>
git checkout -b <name>
git merge <revision>
git mergetool
git rebase

git remote
git remote add <name> <url>
git push <remote> <local branch>:<remote branch>
git branch --set-upstream-to=<remote>/<remote branch>
git fetch
git pull
git clone

git commit --amend
git reset HEAD <file>
git checkout -- <file>

git config
git clone --depth=1
git add -p
git rebase -i
git blame
git stash
git bisect
```

.gitignore
