# Omit

This is a CLI tool to generate `.gitignore` files written in zig.

# Installation

Install on MacOS or GNU/Linux from our pre-built binary by running:

```sh
curl -sSL https://raw.githubusercontent.com/artefatto/omit/main/install.sh | bash -
```

> To make `omit` available globally you should have `~/.local/bin` on you `PATH`

# Usage

To create a .gitignore file you can simply use `omit <language> > .gitignore`. This command will overwrite your .gitignore file. Example:
```bash
omit zig > .gitignore
```

Multi language example:
```bash
omit zig,python,lua > .gitignore
```

To see the list of all .gitignore templates you can call `omit` with, just use:
```bash
omit list
```

# References
This project started as a Zig learning experience (and still is), so I will link my references below:
First of all, omit is heavily inspired by [ignr.py](https://github.com/Antrikshy/ignr.py), which uses the [gitignore.io](https://www.toptal.com/developers/gitignore) API.

Zig references I used:

- [Zig Cookbook](https://zigcc.github.io/zig-cookbook/) 
- [Zig documentation](https://ziglang.org/documentation/master/) 
- [Zig Common Tasks](https://renatoathaydes.github.io/zig-common-tasks/) 
- [Ziglings](https://codeberg.org/ziglings)
- [Zig Guides](https://github.com/tr1ckydev/zig_guides)
- [Introduction to Zig](https://pedropark99.github.io/zig-book/)
