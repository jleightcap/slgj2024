# development

- add readline support for REPL development: https://wiki.fennel-lang.org/Readline
- comparison to closure: https://git.sr.ht/~technomancy/fennel/tree/HEAD/item/from-clojure.md#runtime
    - https://luafun.github.io/#
    - luafun dependency makes working with iterators more Lisp-y, packaged in default.nix
- library for gamedev functions https://github.com/rxi/lume/ packaged in default.nix
    - Fennel usage https://wiki.fennel-lang.org/lume

# modules

currently using `(require :lib.grid)` for submodules, instead should follow
https://git.sr.ht/~technomancy/fennel/tree/HEAD/tutorial.md#relative-require

# conf.lua

- https://love2d.org/wiki/Config_Files

# puzzles

- http://www.abelmartin.com/rj/sokobanJS/Skinner/David%20W.%20Skinner%20-%20Sokoban.htm

parse these plaintext puzzle representations:
http://www.abelmartin.com/rj/sokobanJS/Skinner/David%20W.%20Skinner%20-%20Sokoban_files/Sasquatch.txt
into a puzzle structure

# graphics

- https://github.com/Swordfish90/cool-retro-term/tree/f157648d1e51878a10e02a8836c1e15aa8c59cc9/app/qml/fonts/modern-proggy-tiny

# references

- reflections on few basic games, basic setup and links to resources: https://beta7.io/posts/game-development-with-fennel-and-love/
- how to LOVE https://sheepolution.com/learn/book/contents
- Fennel+LOVE codebases https://wiki.fennel-lang.org/Codebases#l%C3%B6ve-games
