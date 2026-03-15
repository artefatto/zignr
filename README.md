# zignr

This is a CLI tool to generate `.gitgnore` files written in zig.



# Installation

Install from our pre-built binary by running:

```sh
curl -sSL https://raw.githubusercontent.com/ivansantiagojr/zignr/main/install.sh | bash -
```

> To make `zignr` available globally you should have `~/.local/bin` on you `PATH`

# Usage

To create a .gitgnore file you can simply use `zignr <language> > .gitnore`. This command will overwrite your .gitignore file. Example:
```bash
zignr zig > .gitgnore
```

Multi language example:
```bash
zignr zig,python,lua > .gitgnore
```

To see the list of all .gitignore templates you can call `zignr` with, just use:
```bash
zignr list
```

# References
This project started as a Zig learning experience (and still is), so I will link my references below:
First of all, zignr is heavily inspired by [ignr.py](https://github.com/Antrikshy/ignr.py), which uses the [gitignore.io](https://www.toptal.com/developers/gitignore) API.

Zig references I used:

- [Zig Cookbook](https://zigcc.github.io/zig-cookbook/) 
- [Zig documentation](https://ziglang.org/documentation/master/) 
- [Zig Common Tasks](https://renatoathaydes.github.io/zig-common-tasks/) 
- [Ziglings](https://codeberg.org/ziglings)
- [Zig Guides](https://github.com/tr1ckydev/zig_guides)
- [Introduction to Zig](https://pedropark99.github.io/zig-book/)
