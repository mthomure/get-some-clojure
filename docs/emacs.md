# emacs reference

| keybinding | effect |
|------------|--------|
| `C-a` / `C-e` | move to start / end of line
| `M-a` / `M-e` | move to start / end of paragraph
| `M-<` / `M->` | move to start / end of buffer
| `M-{` / `M-}` | move up / down by paragraph
| `M-v` / `C-v` | page up / down
| `M-g M-g n` | goto line `n`
| `shift-→` or `shift-←` | navigate to another window
| `M-q` | reflow paragraph (aka justify or fill)
| `M-w` | copy
| `C-/` | undo
| `C-?` | redo (using undo-tree)
| `M-h` | select paragraph
| `M-;` | toggle comment
| `M-:` | evaluate elisp expression

wrap long lines at 80 columns:
```
(set-fill-column 80)
```

https://www.gnu.org/software/emacs/manual/html_node/emacs/Moving-Point.html

## paredit shortcuts for emacs

| Shortcut | Effect |
|----------|--------|
| `M-x paredit-mode` | toggle paredit mode
| `M-(`	| paredit-wrap-round; surround expression after point in parentheses
| `C-→` or `C-)` | slurp right -- i.e., move closing parenthesis to the right
| `C-(` | slurp left -- i.e., move opening parenthesis to the left
| `C-←` or `C-}` | barf right -- i.e., move closing parenthesis to the left
| `C-{` | barf left -- i.e., move opening parenthesis to the right
| `C-M-f` / `C-M-b` | Move to the opening/closing parenthesis
| `M-↑` or `M-r` | pull remaining expression up and remove preceding expression

http://mumble.net/~campbell/emacs/paredit.html

## cider keyboard shortcuts

| key | Operation |
|-----|-----------|
| `C-c M-j` | start repl (cider-jack-in)
| `C-c C-d` | show docs for symbol
| `C-c ` | show source for symbol
| `C-c M-i` | inspect expression
| `C-c M-t` | toggle var tracing
| `C-c M-n` | switch namespace (in repl)
| `M-.` | jump to definition of symbol
| `M-,` | return to pre-jump location
| `C-c C-c` | interrupt evaluation
| `C-up` / `C-down` | cycle through input history
| `C-x C-e` | eval expression (before point)
| `C-c M-n` | set namespace to current file
| `C-c C-k` | compile current file
| `C-M-f` | move to closing paren
| `C-M-b` | move to opening paren
| `C-c ,` | evaluate midje fact (midje mode)
| `*1` | last result in repl

in repl, type `,` (comma) as first character in line to bring up command dialog.

when inspecting an object, use `Tab`/`Shift-Tab` and `Return` to navigate sub-objects, and `l` (ell) to navigate to the parent object.

disable popup on clojure error: eval `(setq cider-show-error-buffer nil)` with `M-:`.

pretty-print helper: `(defn pp ([x] (clojure.pprint/pprint x)) ([] (pp *1)))`
