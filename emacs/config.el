(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(prelude-require-packages
 '(cider
   better-defaults
   paredit))

;; disable spell-checking
(setq prelude-flyspell nil)

;; swap option/command keys
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; remember open documents
(desktop-save-mode 1)

;; no scroll bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; set font
(set-frame-font "DejaVu Sans Mono-12")

;; indents
(setq tab-width 2
      indent-tabs-mode nil)

;; comment-or-uncomment-region
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

;; eldoc in clojore buffers
;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; paredit in repl
;(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; cider configs
(setq cider-repl-history-file "~/.cider-repl-history")

;; disable bell
(setq ring-bell-function 'ignore)

;; make mouse scrolling less jumpy
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

;; allow arrow keys, too
(setq prelude-guru nil)
