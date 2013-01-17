(menu-bar-mode 0)
(tool-bar-mode 0)
(setq
    line-number-mode t
    column-number-mode t)
(setq left-fringe-width )
(load "font-lock")
(setq font-lock-maximum-size nil)
(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'load-path "/usr/share/emacs23/site-lisp/muse-el")
(require 'muse-mode)     ; load authoring mode
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Backup and auto-saves
(setq backup-inhibited t)
(auto-save-mode nil)

;; Modes
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode) t)
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . xml-mode) t)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . xml-mode) t)
(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(autoload 'python-mode "python-mode.elc" "Major mode for editing Python source." t)


;; Terminal and Keybinding Portability
(defun xterm-cfg ()
  (set-face-foreground 'font-lock-function-name-face "orange")
  (set-face-foreground 'font-lock-comment-face "blue")
  (set-face-foreground 'font-lock-string-face "yellow")
  (set-face-underline-p 'font-lock-string-face nil)
  (setq vc-mode-face 'modeline-buffer-id)
  (make-face-unitalic 'font-lock-string-face)
  (make-face-unitalic 'font-lock-function-name-face))

(defun rxvt-cfg ()
  (global-unset-key "\e[")
  (xterm-cfg)
  (global-set-key "\e[14" 'backward-kill-word)
  )

(defun dispatch-termtype (term)
  (cond ((equal term "xterm") (xterm-cfg))
        ((equal term "xterm-color") (xterm-cfg))
        ((equal term "rxvt") (rxvt-cfg))
        ((equal term "screen") (xterm-cfg))))

(if (eq window-system 'x)
    (dispatch-termtype "x-windows")
  (dispatch-termtype (getenv "TERM")))

;; Colors

;; font-lock-comment-face   Used (typically) for comments. 
;; font-lock-comment-delimiter-face   Used (typically) for comments delimiters. 
;; font-lock-doc-face   Used (typically) for documentation strings in the code. 
;; font-lock-string-face   Used (typically) for string constants. 
;; font-lock-keyword-face   Used (typically) for keywords—names that have special syntactic significance, like for and if in C. 
;; font-lock-builtin-face   Used (typically) for built-in function names. 
;; font-lock-function-name-face   Used (typically) for the name of a function being defined or declared, in a function definition or declaration. 
;; font-lock-variable-name-face   Used (typically) for the name of a variable being defined or declared, in a variable definition or declaration. 
;; font-lock-type-face   Used (typically) for names of user-defined data types, where they are defined and where they are used. 
;; font-lock-constant-face   Used (typically) for constant names. 
;; font-lock-preprocessor-face   Used (typically) for preprocessor commands. 
;; font-lock-negation-char-face   Used (typically) for easily-overlooked negation characters. 
;; font-lock-warning-face   Used (typically) for constructs that are peculiar, or that greatly change the meaning of other text. For example, this is used for ‘;;;###autoload’ cookies in Emacs Lisp, and for #error directives in C.


(set-background-color "#CECECE")
(set-default-font "Courier-11")

;; http://raebear.net/comp/emacscolors.html
(set-face-foreground 'font-lock-comment-face "dark blue")            ;; #00008b
(set-face-foreground 'font-lock-string-face "forest green")          ;; #228b22
(set-face-foreground 'font-lock-keyword-face "firebrick4")           ;; #8b1a1a
(set-face-foreground 'font-lock-builtin-face "firebrick4")           
(set-face-foreground 'font-lock-variable-name-face "Black")          ;; #000
(set-face-foreground 'font-lock-function-name-face "MediumOrchid4")  ;; #7a378b
(set-face-foreground 'font-lock-type-face "MediumOrchid4")
;; LightGoldenrod2   #eedc82       

(require 'color-theme)
(color-theme-initialize)
;;(color-theme-xemacs)

;; Software Development Environment
(add-hook 'python-mode-hook 'turn-on-font-lock)
(add-hook 'ruby-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'perl-mode-hook 'turn-on-font-lock)
(add-hook 'tex-mode-hook 'turn-on-font-lock)
(add-hook 'latex-mode-hook 'turn-on-font-lock)
(add-hook 'texinfo-mode-hook 'turn-on-font-lock)
(add-hook 'sql-mode-hook 'turn-on-font-lock)
(add-hook 'xml-mode-hook 'turn-on-font-lock)
(add-hook 'html-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix t))

(defun uncr-buffer ()
  "Removes ^M from the end of lines on the entire buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\C-m$" nil t)
      (replace-match "" nil nil))
    ))

(defun cr-buffer ()
  "Adds ^M to the end of every line in the buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (condition-case nil
      (while (re-search-forward "$" nil t)
        (replace-match "\C-m" nil nil)
        (forward-char 1))
      (end-of-buffer))
    ))
(put 'narrow-to-region 'disabled nil)


;; Whitespace Controls
(setq
  c-basic-offset 4
  c-default-style "gnu"
  tab-width 4
  default-tab-width 4
  sh-basic-offset 4
  sh-tab-width 4
  py-indent-offset 4
  php-indent-offset 4
  xml-basic-offset 4
  xml-tab-width 4
  html-basic-offset 4
  html-tab-width 4
  java-basic-offset 4
  java-tab-width 4
  jde-basic-offset 4
  jde-tab-width 4
  indent-tabs-mode nil
  require-final-newline t
)
(setq-default indent-tabs-mode nil)
(setq-default buffer-file-coding-system 'undecided-unix)
(add-hook 'find-file-hook 'uncr-buffer)
;(add-hook 'write-file-hooks 'whitespace-cleanup)
;(remove-hook 'write-file-hooks 'whitespace-cleanup)


(setq completion-ignored-extensions
  (append completion-ignored-extensions
    '(".pdf" ".png" ".pyc" ".pyo")))

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(load (concat (getenv "HOME") "/src/nxhtml/autostart.el"))
(setq mumamo-background-colors nil) 
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))
