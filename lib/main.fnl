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
             :number 0
             :puzzle (load-puzzle 0)})

(local hum (doto (love.audio.newSource :assets/transformer.wav :static)
             (: :setVolume 0.25)))

(local boot (love.audio.newSource :assets/crt-on.wav :static))

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
    :boss (style.boss)
    :solving (style.render game)
    :complete (style.complete)))

(fn next-puzzle []
  (if (= game.number 78)
      (set game.mode :complete)
      (do
        (set game.number (+ game.number 1))
        (set game.puzzle (load-puzzle game.number)))))

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
    :b (set game.mode :boss)
    :escape (if (or (= game.mode :titlescreen) (= game.mode :complete))
                (love.event.quit)
                (set game.mode :titlescreen))
    :return (case game.mode
      :titlescreen (set game.mode :help)
      :help (set game.mode :solving)
      :boss (set game.mode :solving))
    ;; FIXME: debug
    ;; TODO: copy this logic into won check
    :n (case game.mode :solving (next-puzzle))
    :r (->> game.number (load-puzzle) (set game.puzzle))))
