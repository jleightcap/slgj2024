# development

- add readline support for REPL development: https://wiki.fennel-lang.org/Readline

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

# references:

- reflections on few basic games, basic setup and links to resources: https://beta7.io/posts/game-development-with-fennel-and-love/
- library for gamedev functions https://github.com/rxi/lume/ packaged in default.nix
    - Fennel usage https://wiki.fennel-lang.org/lume
- how to LOVE https://sheepolution.com/learn/book/contents
    - tick (https://sheepolution.com/learn/book/10) packaged in default.nix
- Fennel+LOVE codebases https://wiki.fennel-lang.org/Codebases#l%C3%B6ve-games

