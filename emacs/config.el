(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(prelude-require-packages
 '(cider
   better-defaults
   paredit
   ))

;; work-around for bug in emacs 24.3
(setq save-interprogram-paste-before-kill nil)

;; wrap long lines at 80 characters
(set-fill-column 80)

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

;; cider configs
(setq cider-repl-history-file "~/.cider-repl-history")

;; disable bell
(setq ring-bell-function 'ignore)

;; make mouse scrolling less jumpy
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

;; allow arrow keys, too
(setq prelude-guru nil)

;; disable stack trace on error
(setq cider-show-error-buffer nil)

;; completely disable graphical dialog boxes (broken in OS X)
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
