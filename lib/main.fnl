(local lume (require :lume))
(local fun (require :fun))

(local style (require :lib.style))
(local parser (require :lib.parse))
(local engine (require :lib.engine))

(fn load-puzzle [n]
  (->> n (.. :puzzles/microban-) (parser.parse) (parser.invariants)))

(local game {;; game mode DFA state
             :mode :titlescreen
             ;; track boot sound effect playback
             :booted false
             ;; current game number, parsed into puzzle
             :number 1
             :puzzle (load-puzzle 1)})

(local hum (doto (love.audio.newSource :transformer.wav :static)
             (: :setVolume 0.25)))

(local boot (love.audio.newSource :crt-on.wav :static))

(fn love.update [dt]
  (when (not game.booted)
    (love.audio.play boot)
    (set game.booted true))
  (when (not (hum:isPlaying))
    (love.audio.play hum)))

(fn love.draw []
  ;; TODO: this is re-drawing some constant parts of the screen
  ;; refactor into one-time setup and continuous components
  (style.universe)
  (case game.mode
    :titlescreen (style.titlescreen)
    :help (style.help)
    :solving (style.render game)))

(fn next-puzzle []
  (set game.number (+ game.number 1))
  (set game.puzzle (load-puzzle game.number)))

;; fnlfmt: skip
(fn love.keypressed [event]
  (case event
    (where (or :w :a :s :d))
      (do
        (->> (engine.tick event game.puzzle)
            (set game.puzzle.dynamic))
        (when (engine.won? game)
          (next-puzzle)))
    :m (doto hum
             (: :setVolume 0))
    :b (if (not= game.mode :boss) (set game.mode :boss))
    :escape (case game.mode
      :titlescreen (love.event.quit)
      :help (set game.mode :titlescreen)
      :boss (set game.mode :titlescreen)
      :solving (set game.mode :titlescreen))
    :return (case game.mode
      :titlescreen (set game.mode :help)
      :help (set game.mode :solving)
      :boss (set game.mode :solving))
    ;; FIXME: debug
    ;; TODO: copy this logic into won check
    :n (case game.mode
       :solving (next-puzzle))
    :r (->> game.number (load-puzzle) (set game.puzzle))))
