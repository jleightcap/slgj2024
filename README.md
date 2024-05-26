# ./soko.bin

Retrocomputing-themed sliding block puzzle game **Sokoban** executing [David Skinner's _Microban I_](https://web.archive.org/web/20221007061329/http://www.abelmartin.com/rj/sokobanJS/Skinner/David%20W.%20Skinner%20-%20Sokoban_files/Microban.txt) puzzle set.

> See: Patricia Taxxon,
> [David W. Skinner's Microban is Among the Best "Games" (?) Ever Designed](https://www.youtube.com/watch?v=_9RItVU_Py4)

Written for the [Spring Lisp Game Jam 2024](https://itch.io/jam/spring-lisp-game-jam-2024)
in [Fennel](https://wiki.fennel-lang.org/) for the [LÖVE game framework](https://www.love2d.org/wiki/Main_Page)

## Building

Requires:

- [fennel](https://wiki.fennel-lang.org/Packaging)
- [luafun](https://luafun.github.io/)

Build with

```sh
$ make
```

## Running

if needed, use `LOVE` environment variable, like:

```sh
$ LOVE=./love-11.5-x86_64.AppImage make run
```

## Assets

- Proggy Tiny font ([LICENSE](./assets/LICENSE.font))
- [DefectLineTransformer](https://freesound.org/people/blaukreuz/sounds/440128/) ([LICENSE](./assets/LICENSE.audio))
- [monitor computer CRT on, off](https://freesound.org/people/kyles/sounds/454090/) ([LICENSE](./assets/LICENSE.audio))
