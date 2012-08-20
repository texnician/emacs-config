(global-font-lock-mode t)
(column-number-mode t)
(show-paren-mode t)
(transient-mark-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode nil)
(global-auto-revert-mode t)
(setq default-fill-column 80)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq default-major-mode 'text-mode)
(setq frame-title-format "%f[%b]")
(setq inhibit-startup-message t)
(mouse-avoidance-mode 'cat-and-mouse)
;(set-message-beep 'silent)

(require 'package)
(add-to-list 'package-archives
      '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(dolist (m (directory-files "~/.emacs.d/elpa" t "[a-zA-Z0-9].+[0-9]$"))
  (add-to-list 'load-path m))

(defun get-verbose-buffer-name-format ()
  (if (buffer-file-name)
      (concat "emacs@%f")
    (concat "emacs@%d")))

(set-language-environment 'utf-8)
(set-frame-font "Dejavu Sans Mono-10.5:antialias=natural")
;(set-frame-font "Consolas-11")
;(set-frame-font "Monaco-10")
;(set-frame-font "Inconsolata-13:antialias=none")
(set-fontset-font "fontset-default" 'han (font-spec :family "Microsoft YaHei"))
(set-fontset-font "fontset-default" 'han (font-spec :family "WenQuanYi Zen Hei"))
;; (set-fontset-font "fontset-default" '(#x0B01 . #x0B70) (font-spec :family "Kalinga"))
;; (set-fontset-font "fontset-default" '(#x2200 . #x22FF) (font-spec :family "Arial Unicode MS"))
;; (set-fontset-font "fontset-default" '(#x2150 . #x218F) (font-spec :family "Arial Unicode MS"))
;; (set-fontset-font "fontset-default" '(#xFF00 . #xFFEF) (font-spec :family "MingLiU"))
;; (set-fontset-font "fontset-default" '(#x1000 . #x109F) (font-spec :family "Code2000"))
;; (set-fontset-font "fontset-default" '(#x1F000 . #x1F02B) (font-spec :family "Symbola"))

;; Start emacs server
(server-start)

(setq tyg-home "/home/tyg")
(setq tyg-site-lisp (concat tyg-home "site-lisp"))
(add-to-list 'load-path tyg-site-lisp)

(setq backup-directory-alist nil)
(setq cxx-backup-dir "~/.emacs_backup/cxx_backup")
(setq backup-directory-alist
      '(("\\.c" . "~/.emacs_backup/cxx_backup" )
        ("\\.cpp" . "~/.emacs_backup/cxx_backup" )
        ("\\.hpp" . "~/.emacs_backup/cxx_backup" )
        ("\\.h" . "~/.emacs_backup/cxx_backup" )
        ("\\.cc" . "~/.emacs_backup/cxx_backup" )
        ("\\.inl" . "~/.emacs_backup/cxx_backup" )
        ("\\.+" . "~/.emacs_backup/others/")
        (".+" . "~/.emacs_backup/others/")))

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/site-lisp/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

(global-set-key [(meta ?/)] 'auto-complete)

(defun my-cpp-dot ()
  "Cpp-like languages dot(. or ->) prefix."
  (let ((point1 (re-search-backward "\\.\\([_a-zA-Z0-9][_a-zA-Z0-9]*\\)?\\=" nil t))
        (point2 (re-search-backward "->\\([_a-zA-Z0-9][_a-zA-Z0-9]*\\)?\\=" nil t)))
    (if point1
        (1+ point1)
        (if point2 (+ 2 point2)))))

(ac-define-source my-semantic
  '((depends semantic-ia)
    (candidates . (ac-semantic-candidates ac-prefix))
    (prefix . cpp-dot)
    (requires . 0)
    (symbol . "f")))

(ac-define-source my-filename
  '((candidates . (directory-files default-directory))
    (prefix . "^#include [\"<]\\(.*\\)")))

(add-to-list 'ac-prefix-definitions '(cpp-dot . my-cpp-dot))

(defun ac-settings-4-cpp ()
  (setq ac-sources
        '(
;;          ac-source-my-semantic
          ac-source-my-filename
          ac-source-yasnippet
          ac-source-imenu
          ac-source-words-in-buffer
          ac-source-words-in-same-mode-buffers
          ac-source-abbrev
          ac-source-filename)))

;; abbrev
(defun my-indent-or-complete ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else
    if point is at the end of a symbol, expands it. Else indents
    the current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (auto-complete nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\>")
          (auto-complete nil)
        (indent-for-tab-command)))))

(global-set-key (kbd "C-\\") 'set-mark-command)
(global-set-key (kbd "C-@") 'toggle-input-method)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-<f5>") 'revert-buffer-with-coding-system)

;; CEDET
(setq tyg-site-lisp "~/site-lisp/")
(add-to-list 'load-path tyg-site-lisp)
(setq cedet-load-file (concat tyg-site-lisp "cedet-1.1/common/cedet.el"))
(load-file cedet-load-file)
(semantic-load-enable-excessive-code-helpers)

(defun inhibit-c-headers ()
  (string-match-p "\\(.+/Jwoll_Data_Provider/.+\\|Data_Type_Define\\)" (buffer-file-name)))

(setq semantic-inhibit-functions '(inhibit-c-headers))

;(require 'linemark)
(require 'eieio)
;(require 'eieio-load)
(require 'eassist)
(global-set-key [(meta ?.)] 'semantic-ia-fast-jump)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("MF_EXPORT" . "__"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("MF_VIRTUAL" . " "))
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("TEST_EXPORT" . " "))
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("DECLARE_HANDLE32" . " "))
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("LUABIND_BINARY_OPERATOR" . " "))
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("LUABIND_UNARY_OPERATOR" . " "))

;; (setq semantic-minor-mode-alist (cdr semantic-minor-mode-alist))

;; (setq-mode-local c-mode
;;                  semanticdb-find-default-throttle
;;                  '(project unloaded system recursive omniscience))
(setq-mode-local c-mode
                 semanticdb-find-default-throttle
                 '(file))
(setq-mode-local c++-mode
                 semanticdb-find-default-throttle
                 '(file local system recursive))
(setq semanticdb-default-save-directory "~/semanticdb")

(defun my-semantic-init ()
;;  (semantic-mru-bookmark-mode -1)
  (semantic-stickyfunc-mode t)
;;  (semantic-decoration-mode t)
  (semantic-highlight-edits-mode t)
  (semantic-show-parser-state-mode t))

(add-hook 'senator-minor-mode-hook
      '(lambda ()
         (setq senator-try-function-already-enabled t)
         (my-semantic-init)
         ;; (define-key senator-mode-map [(tab)] 'my-indent-or-complete)
         (define-key senator-mode-map [(f12)] 'semantic-ia-complete-symbol-menu)
         ))

;; (require 'ede)
;; (global-ede-mode t)

;; ECB
;; (add-to-list 'load-path "~/ecb-2.40")
;; (require 'ecb)
;;(require 'ecb-autoloads)

;; (require 'xcscope)

(define-key global-map "\M-,"  'semantic-mrub-switch-tags)

(setq cscope-database-regexps
      '(("^/home/tyg/linux-2.6.23.9"
     ("/home/tyg/cscope/kernel" ("-k" ))
     t
     (t))
    ("^/home/tyg/glibc-2.7"
     ("/home/tyg/cscope/libc" ( "-k" ))
     t
     (t))
    ("^/home/tyg/inotify-tools-3.13"
     ("/home/tyg/cscope/inotify")
     t
     (t))
    ("^/home/tyg/coreutils-6.9"
     ("/home/tyg/cscope/coreutils")
     t
     (t))))

(require 'ido)
(ido-mode t)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;(require 'color-theme)

;(load-file "~/site-lisp/my-color-theme.el")
;(load-file "~/site-lisp/color-theme-2.el")
;(load-file "~/site-lisp/nga-theme.el")

;(color-theme-initialize)
;(add-to-list 'load-path "~/zenburn")
;(add-to-list 'load-path "~/solarized")
;(require 'color-theme-zenburn)
;(require 'color-theme-solarized)
;(load-theme 'zenburn t)
(load-theme 'solarized-dark t)
;; (nga-color-theme)
;;(color-theme-xp)
;; (my-color-theme)
;;(my-color-theme2)
;; (color-theme-plastic)
;;(color-theme-emacs-nw)
;; (color-theme-gnome2)
;;(color-theme-oswald)
;;(color-theme-taming-mr-arneson)
;;(color-theme-taylor)
;;(color-theme-arjen)
;; (color-theme-billw)
;;(color-theme-charcoal-black)
;;(color-theme-goldenrod)
;;(color-theme-clarity)
;;(color-theme-comidia)
;;(color-theme-jsc-dark)
;;(color-theme-dark-laptop)
;;(color-theme-euphoria)
;;(color-theme-hober)
;;(color-theme-lethe)
;;(color-theme-ld-dark)
;;(color-theme-midnight)
;; (color-theme-dark-blue2)
;; (color-theme-xemacs)
;; (color-theme-vim-colors)
;;; (color-theme-snow)
;;; (color-theme-zenburn)
;(color-theme-solarized-dark)
;(color-theme-solarized-light)

(require 'rainbow-mode)
;; (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
;; (require 'yasnippet) ;; not yasnippet-bundle
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")


;;; gtags
(autoload 'gtags-mode "gtags" "" t)

;; Make a non-standard key binding.  We can put this in
;; c-mode-base-map because c-mode-map, c++-mode-map, and so on,
;; inherit from it.
(defun my-c-initialization-hook ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)

;; offset customizations not in my-c-style
;; This will take precedence over any setting of the syntactic symbol
;; made by a style.
(setq c-offsets-alist '((member-init-intro . +)))

;; Create my personal style.
(defconst my-c-style
  '((c-basic-offset . 2)
    (c-tab-always-indent        . t)
    (c-comment-only-line-offset . 2)
    (c-hanging-braces-alist     . ((brace-list-open)
                                   (brace-entry-open)
                                   (statement-cont)
                                   (substatement-open after)
                                   (block-close . c-snug-do-while)
                                   (extern-lang-open after)
                                   (namespace-open after)
                                   (module-open after)
                                   (composition-open after)
                                   (inexpr-class-open after)

                                   (inexpr-class-close before)
                                   (arglist-cont-nonempty)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi
                                   list-close-comma
                                   one-liner-defun
                                   compact-empty-funcall
                                   comment-close-slash))
    (c-offsets-alist            . ((inexpr-class . +)
                                   (inexpr-statement . +)
                                   (lambda-intro-cont . +)
                                   (inlambda . c-lineup-inexpr-block)
                                   (template-args-cont c-lineup-template-args +)
                                   (incomposition . +)
                                   (inmodule . +)
                                   (innamespace . 0)
                                   (inextern-lang . +)
                                   (cpp-define-intro c-lineup-cpp-define +)
                                   (cpp-macro-cont . +)
                                   (cpp-macro .
                                              [0])
                                   (inclass . +)
                                   (stream-op . c-lineup-streamop)
                                   (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)
                                   (arglist-cont c-lineup-gcc-asm-reg 0)
                                   (comment-intro . 0)
                                   (access-label . -)
                                   (case-label . *)
                                   (substatement . +)
                                   (statement-case-intro . +)
                                   (inher-cont . c-lineup-multi-inher)
                                   (inher-intro . +)
                                   (member-init-cont . c-lineup-multi-inher)
                                   (member-init-intro . +)
                                   (func-decl-cont . +)
                                   (defun-block-intro . +)
                                   (c . c-lineup-C-comments)
                                   (string . c-lineup-dont-change)
                                   (topmost-intro-cont . c-lineup-topmost-intro-cont)
                                   (inline-open . +)
                                   (arglist-close . +)
                                   (arglist-intro . +)
                                   (statement-cont . +)
                                   (knr-argdecl-intro . +)
                                   (substatement-open . 0)
                                   (statement-block-intro . +)))

    (c-echo-syntactic-information-p . t))
  "My C Programming Style")
(c-add-style "tyg" my-c-style)

(add-to-list 'auto-mode-alist
             '(".+/include/.+" . c++-mode))

;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; set my personal style for the current buffer
  (c-set-style "tyg")
  ;; other customizations
  (setq tab-width 2
        ;; this will make sure spaces are used instead of tabs
        indent-tabs-mode nil)
  ;; we like auto-newline, but not hungry-delete
  (c-toggle-auto-newline 1)
  (c-toggle-hungry-state)
  (subword-mode 1)
  (gtags-mode 1)
  (define-key c-mode-base-map [backtab] 'indent-relative)
  (define-key c-mode-base-map [(control ?c) (?b)] 'ske-cpp-comment-block)
  (define-key c-mode-base-map [(control ?c) (?h)] 'ske-cpp-header-file)
  (define-key c-mode-base-map [(control ?.)] 'eassist-switch-h-cpp)
  (define-key c-mode-base-map [(control ?c) (?l)] 'my-svn-lock-current-buffer-file)
  (define-key c-mode-base-map [(control ?c) (?L)] 'my-svn-unlock-current-buffer-file)
  ;(make-cpp-abbrev)
  (setq c-macro-cppflags "-I ."))

(defun c-delete-tail-blank ()
  "Delete extra blankets at the end of file"
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-max))
      (delete-blank-lines))))

(defun program-mode-common-hook ()
  "Hooks for common programming modes"
  (progn
    (linum-mode t)
    (highlight-parentheses-mode t)
    (make-local-variable 'before-save-hook)
    (add-to-list 'before-save-hook 'c-delete-tail-blank)
    (add-to-list 'before-save-hook 'whitespace-cleanup)))

(defun add-c++0x-keywords ()
  (font-lock-add-keywords 'c++-mode
    '(("\\<\\(TODO\\):" 1 font-lock-warning-face prepend)
      ("\\<\\(tyg\\)\\>" 1 font-lock-warning-face prepend)
      ("\\<\\(static_assert\\|auto\\|decltype\\)\\>" .
       font-lock-keyword-face))))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-hook `ac-settings-4-cpp)
(setq cpp-system-src-regex "\\(Microsoft Visual Studio.+\\|/boost/.+\\|/ace/.+\\)")
;(setq-mode-local c++-mode whitespace-style '(lines-tail))
(add-hook 'c++-mode-hook
      '(lambda ()
         (program-mode-common-hook)
         (make-local-variable 'whitespace-style)
         (setq whitespace-style '(face tabs empty trailing indentation::space))
         (whitespace-mode t)
         (add-c++0x-keywords)
         (if (string-match cpp-system-src-regex
                           buffer-file-name)
             (view-mode 1))
         ))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode))

(add-hook 'emacs-lisp-mode-hook
      '(lambda()
         (program-mode-common-hook)))

;; (require 'lua-mode)

(load "desktop")
(desktop-load-default)
(desktop-read)

;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)
;; (setq session-save-file-coding-system 'utf-8-unix)

(setq ac-auto-show-menu 0.2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-indent-environment-list (quote (("verbatim" current-indentation) ("verbatim*" current-indentation) ("array") ("displaymath") ("eqnarray") ("eqnarray*") ("equation") ("equation*") ("picture") ("tabbing") ("table") ("table*") ("tabular") ("tabular*") ("lstlisting" current-indentation))))
 '(TeX-parse-self t)
 '(ac-modes (quote (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode clojure-mode java-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode makefile-gmake-mode slime-mode slime-repl-mode lisp-mode)))
 '(antlr-language-alist (quote ((java-mode "Java" nil "\"Java\"" "Java") (c++-mode "C++" "\"C\"" "C") (c++-mode "C++" "\"Cpp\"" "Cpp"))))
 '(c-cleanup-list (quote (empty-defun-braces one-liner-defun defun-close-semi scope-operator compact-empty-funcall)))
 '(ecb-options-version "2.40")
 '(ecb-wget-setup (quote cons))
 '(geiser-default-implementation (quote racket))
 '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
 '(global-semantic-highlight-edits-mode t nil (semantic-util-modes))
 '(global-semantic-highlight-func-mode t nil (semantic-util-modes))
 '(global-semantic-idle-completions-mode nil nil (semantic-idle))
 '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
 '(global-semantic-idle-summary-mode t nil (semantic-idle))
 '(global-semantic-mru-bookmark-mode t nil (semantic-util-modes))
 '(global-semantic-show-parser-state-mode nil nil (semantic-util-modes))
 '(global-semantic-show-unmatched-syntax-mode nil nil (semantic-util-modes))
 '(global-semantic-stickyfunc-mode t nil (semantic-util-modes))
 '(global-senator-minor-mode t nil (senator))
 '(gtags-ignore-case nil)
 '(hl-paren-colors (quote ("springgreen1" "springgreen2" "springgreen3" "springgreen4")))
 '(linum-format (quote dynamic))
 '(password-cache-expiry 3600)
 '(semantic-c-dependency-system-include-path (quote ("D:\\new_project\\Server_Engine" "D:\\new_project\\Jwoll_Server0824\\Game" "D:\\vs9lib\\include" "D:\\vs9lib\\include\\lua-5.1" "D:\\project\\lib\\boost_1_38_0" "D:\\new_project\\MMORPG_Engine" "D:\\Program Files\\Microsoft Visual Studio 9.0\\VC\\include\\")))
 '(semanticdb-global-mode t nil (semanticdb))
 '(slime-net-coding-system (quote utf-8-unix))
 '(tramp-terminal-type "xterm")
 '(which-function-mode t))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#fef3d1" :foreground "gray20" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Consolas"))))
;;  '(bold ((t (:background "black" :foreground "snow3" :weight bold))))
;;  '(column-marker-1 ((t (:box (:line-width 1 :color "red"))))))

(require 'tramp)
;; (setq tramp-default-method "scp")
;; (setq recentf-auto-cleanup 'never)
;(setq tramp-default-method "plink"
;      tramp-password-end-of-line "\r\n")

;; (require 'lua-mode)

;; (require 'flymake)

;; (defun flymake-lua-init ()
;;   "Invoke luac with '-p' to get syntax checking"
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;       (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "D:\\work\\lua-5.1.4\\lua-5.1.4\\src\\luac" (list "-p" local-file))))

;; (push '("\\.lua\\'" flymake-lua-init) flymake-allowed-file-name-masks)
;; (push '("^.*luac[0-9.]*\\(.exe\\)?: *\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 2 3 nil 4)
;;       flymake-err-line-patterns)


(add-hook 'lua-mode-hook
          '(lambda ()
             (program-mode-common-hook)
          ;;    "Don't want flymake mode for lua regions in rhtml
          ;; files and also on read only files"
          ;;    (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
          ;;     (flymake-mode))
          ;;    (define-key lua-mode-map [(f5)]  'flymake-start-syntax-check)
          ;;    (define-key lua-mode-map [(control f5)]  'flymake-goto-next-error)
          ;;    (define-key lua-mode-map [(meta f5)]  'flymake-goto-prev-error)
          ;;    (define-key lua-mode-map [(f6)]  'flymake-display-err-menu-for-current-line)
             ))


;;(require 'column-marker)

(defvar make-skeleton-saved-winconf nil)
(defvar make-skeleton-header ";; help for skeleton
;; (find-w3m \"http://www.panix.com/~tehom/my-code/skel-recipe.txt\")
;; (describe-function 'skeleton-insert)
;; These lines are ignored.
"
  "Help string for skeleton.")

(defun make-skeleton ()
  "Create skeleton of skeleton.
It is based on `A recipe for using skeleton.el'.
http://www.panix.com/~tehom/my-code/skel-recipe.txt

C-c C-e: Erase the skeleton contents.
C-c C-c: Finish the input.
"
  (interactive)
  (setq make-skeleton-saved-winconf (current-window-configuration))
  (switch-to-buffer "*make skeleton*")
  (make-skeleton-mode)
  (if (zerop (buffer-size))
      (make-skeleton-erase-buffer)))

(defun make-skeleton-finish ()
  (interactive)
  (set-window-configuration make-skeleton-saved-winconf)
  (insert "(define-skeleton ")
  (save-excursion
    (insert "-skeleton-\n"
            "\"Insert \" nil\n")
    (let ((lines (with-current-buffer "*make skeleton*"
                   ;; skip header
                   (goto-char (point-min))
                   (re-search-forward "^[^;]")
                   (beginning-of-line)
                   (split-string (buffer-substring (point) (point-max)) "\n"))))
      (dolist (line lines nil)
        (back-to-indentation)
        (insert (format "%S > \\n\n" line))))
    (insert ")\n")))

(defun make-skeleton-erase-buffer ()
  "Erase the skeleton contents."
  (interactive)
  (erase-buffer)
  (insert make-skeleton-header))


(define-derived-mode make-skeleton-mode fundamental-mode "skeleton"
  "Major mode for creating a skeleton of skeleton."
  (define-key make-skeleton-mode-map "\C-c\C-c" 'make-skeleton-finish)
  (define-key make-skeleton-mode-map "\C-c\C-e" 'make-skeleton-erase-buffer)
  )

(require 'skeleton)
(load-file (concat tyg-site-lisp "ske-cpp.el"))
;(load-file (concat tyg-site-lisp "python-skeleton.el"))

(require 'align)
;; ispell
(setq-default ispell-program-name "aspell")
(setq-default ispell-local-dictionary "american")


;; auctex
;; (require 'tex-site)
;; (define-abbrev-table 'TeX-mode-abbrev-table (make-abbrev-table))
(add-hook 'TeX-mode-hook (lambda ()
                           (setq abbrev-mode t)))

(add-hook 'LaTeX-mode-hook (lambda ()
                             (setq local-abbrev-table LaTeX-mode-abbrev-table)
                             (TeX-fold-mode 1)))

(require 'vc)
;(require 'vc-svn)
;; (require 'psvn)
(require 'proced)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-completion-face ((t (:foreground "DarkSeaGreen" :inverse-video t))))
 '(font-lock-warning-face ((t (:foreground "yellow" :weight bold))))
 '(hl-paren-face ((t (:weight bold))) t)
 '(ido-first-match ((t (:inverse-video t :weight bold))))
 '(ido-only-match ((t (:foreground "PaleGreen"))))
 '(info-xref ((t (:foreground "Blue" :underline t))))
 '(info-xref-visited ((t (:foreground "DarkSlateBlue" :underline t))))
 '(isearch ((t (:background "saddle brown" :foreground "light green" :inverse-video t))))
 '(lazy-highlight ((t (:background "pink" :foreground "gray18"))))
 '(linum ((t (:inherit default :foreground "honeydew3" :slant italic))))
 '(show-paren-match ((t (:background "SeaGreen1" :foreground "#3e003e" :inverse-video nil :underline nil :weight bold))))
 '(show-paren-mismatch ((t (:background "firebrick3" :foreground "white" :strike-through "white" :weight bold))))
 '(variable-pitch ((t (:background "FloralWhite" :foreground "black" :height 160 :family "Times New Roman"))))
 '(which-func ((((class color) (min-colors 88) (background dark)) (:inherit font-lock-function-name-face))))
 '(whitespace-line ((t (:background "blue" :foreground "gold"))))
 '(whitespace-trailing ((t (:background "#002b36" :foreground "firebrick" :inverse-video t :weight bold)))))

(put 'narrow-to-region 'disabled nil)

(defun ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (cond
   ((not symbol-list)
    (let ((ido-mode ido-mode)
          (ido-enable-flex-matching
           (if (boundp 'ido-enable-flex-matching)
               ido-enable-flex-matching t))
          name-and-pos symbol-names position)
      (unless ido-mode
        (ido-mode 1)
        (setq ido-enable-flex-matching t))
      (while (progn
               (imenu--cleanup)
               (setq imenu--index-alist nil)
               (ido-goto-symbol (imenu--make-index-alist))
               (setq selected-symbol
                     (ido-completing-read "Symbol? " symbol-names))
               (string= (car imenu--rescan-item) selected-symbol)))
      (unless (and (boundp 'mark-active) mark-active)
        (push-mark nil t nil))
      (setq position (cdr (assoc selected-symbol name-and-pos)))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position)))))
   ((listp symbol-list)
    (dolist (symbol symbol-list)
      (let (name position)
        (cond
         ((and (listp symbol) (imenu--subalist-p symbol))
          (ido-goto-symbol symbol))
         ((listp symbol)
          (setq name (car symbol))
          (setq position (cdr symbol)))
         ((stringp symbol)
          (setq name symbol)
          (setq position
                (get-text-property 1 'org-imenu-marker symbol))))
        (unless (or (null position) (null name)
                    (string= (car imenu--rescan-item) name))
          (add-to-list 'symbol-names name)
          (add-to-list 'name-and-pos (cons name position))))))))

(global-set-key "\C-ci" 'ido-goto-symbol) ; or any key you see fit

(defun my-svn-sync-update ()
  "Sync update svn status"
  (save-excursion
    (save-current-buffer
      (svn-run nil t 'status "status" nil "-v")
      (svn-parse-status-result)
      (svn-status-update-modeline)
      (svn-status-update-buffer))))

  "Sync update svn status"
(defun my-svn-lock-current-buffer-file ()
  "Lock current buffer file"
  (interactive)
  (save-excursion
    (if (equal 'SVN (vc-backend buffer-file-name))
        (progn
          (unless (svn-status-find-info-for-file-name
                   (file-name-nondirectory buffer-file-name))
            (progn
              (svn-status (file-name-directory buffer-file-name) nil t)
              (svn-parse-status-result)))
          (let* ((a-file-list (list buffer-file-name))
                 (file-info (svn-status-find-info-for-file-name
                             (file-name-nondirectory buffer-file-name))))
            (unless file-info
              (error "Can't find svn status %S" buffer-file-name))
            ;; If already locked then turn off read only.
            (if (svn-status-line-info->repo-locked file-info)
                (progn
                  (message "%S alread locked" (car a-file-list))
                  (if buffer-read-only
                      (toggle-read-only nil)))
              (progn
                (message "locking: %S" (car a-file-list))
                (svn-status-create-arg-file svn-status-temp-arg-file "" (list file-info) "")
                (svn-run nil t 'lock "lock" "--targets" svn-status-temp-arg-file)
                (let (err-log-string)
                  (save-current-buffer
                    (set-buffer svn-process-buffer-name)
                    (setq err-log-string (buffer-substring-no-properties (point-min) (point-max))))
                  ;; update
                  (my-svn-sync-update)
                  ;; if successfully locked.
                  (if (let ((new-file-info (svn-status-find-info-for-file-name
                                            (file-name-nondirectory buffer-file-name))))
                        (svn-status-line-info->repo-locked new-file-info))
                      ;; turn off read only
                      (progn
                        (message "%S locked." (car a-file-list))
                        ;; turn off readonly
                        (if buffer-read-only
                            (toggle-read-only nil)))
                    ;; if lock failed, report error
                    (message err-log-string)
                    ))))))
      (error "%s is not under SVN control." buffer-file-name))))

(defun my-svn-unlock-current-buffer-file ()
  "Lock current buffer file"
  (interactive)
  (save-excursion
    (if (equal 'SVN (vc-backend buffer-file-name))
        (progn
          (unless (svn-status-find-info-for-file-name
                   (file-name-nondirectory buffer-file-name))
            (progn
              (svn-status (file-name-directory buffer-file-name) nil t)
              (svn-parse-status-result)))
          (let* ((a-file-list (list buffer-file-name))
                 (file-info (svn-status-find-info-for-file-name
                             (file-name-nondirectory buffer-file-name))))
            (unless file-info
              (error "Can't find svn status %S" buffer-file-name))
            ;; If already locked then unlock
            (if (svn-status-line-info->repo-locked file-info)
                (progn
                  (message "unlocking: %S" (car a-file-list))
                  (svn-status-create-arg-file svn-status-temp-arg-file "" (list file-info) "")
                  (svn-run nil t 'unlock "unlock" "--targets" svn-status-temp-arg-file)
                  ;; update
                  (my-svn-sync-update)
                  (unless buffer-read-only
                    (toggle-read-only t))))))
      (error "%s is not under SVN control." buffer-file-name))))

(defun svn-status (dir &optional arg sync)
  "Examine the status of Subversion working copy in directory DIR.
If ARG is -, allow editing of the parameters. One could add -N to
run svn status non recursively to make it faster.
For every other non nil ARG pass the -u argument to `svn status', which
asks svn to connect to the repository and check to see if there are updates
there.

If there is no .svn directory, examine if there is CVS and run
`cvs-examine'. Otherwise ask if to run `dired'."
  (interactive (list (svn-read-directory-name "SVN status directory: "
                                              nil default-directory nil)
                     current-prefix-arg))
  (let ((svn-dir (format "%s%s"
                         (file-name-as-directory dir)
                         (svn-wc-adm-dir-name)))
        (cvs-dir (format "%sCVS" (file-name-as-directory dir))))
    (cond
     ((file-directory-p svn-dir)
      (setq arg (svn-status-possibly-negate-meaning-of-arg arg 'svn-status))
      (svn-status-1 dir arg sync))
     ((and (file-directory-p cvs-dir)
           (fboundp 'cvs-examine))
      (cvs-examine dir nil))
     (t
      (when (y-or-n-p
             (format
              (concat
               "%s "
               "is not Subversion controlled (missing %s "
               "directory). "
               "Run dired instead? ")
              dir
              (svn-wc-adm-dir-name)))
        (dired dir))))))

(defun svn-status-1 (dir &optional arg sync)
  "Examine DIR. See `svn-status' for more information."
  (unless (file-directory-p dir)
    (error "%s is not a directory" dir))
  (setq dir (file-name-as-directory dir))
  (when svn-status-load-state-before-svn-status
    (unless (string= dir (car svn-status-directory-history))
      (let ((default-directory dir))    ;otherwise svn-status-base-dir looks in the wrong place
        (svn-status-load-state t))))
  (setq svn-status-directory-history (delete dir svn-status-directory-history))
  (add-to-list 'svn-status-directory-history dir)
  (if (string= (buffer-name) svn-status-buffer-name)
      (setq svn-status-display-new-status-buffer nil)
    (setq svn-status-display-new-status-buffer t)
    ;;(message "psvn: Saving initial window configuration")
    (setq svn-status-initial-window-configuration
          (current-window-configuration)))
  (let* ((cur-buf (current-buffer))
         (status-buf (get-buffer-create svn-status-buffer-name))
         (proc-buf (get-buffer-create svn-process-buffer-name))
         (want-edit (eq arg '-))
         (status-option (if want-edit
                            (if svn-status-verbose "-v" "")
                          (if svn-status-verbose
                              (if arg "-uv" "-v")
                            (if arg "-u" "")))))
    (save-excursion
      (set-buffer status-buf)
      (setq default-directory dir)
      (set-buffer proc-buf)
      (setq default-directory dir
            svn-status-remote (when arg t))
      (set-buffer cur-buf)
      (if want-edit
          (let ((svn-status-edit-svn-command t))
            (svn-run (not sync) t 'status "status" svn-status-default-status-arguments status-option))
        (svn-run (not sync) t 'status "status" svn-status-default-status-arguments status-option)))))


(add-hook 'Info-mode-hook
      '(lambda ()
         (variable-pitch-mode)))

(add-hook 'vc-checkin-hook '(lambda ()
                              (save-excursion
                                (my-svn-sync-update))))

(require 'highlight-parentheses)

;;(toggle-debug-on-error)
(put 'downcase-region 'disabled nil)

(defun set-makefile-whitespace-style ()
  "Set Makefile white space style"
  (make-local-variable 'whitespace-style)
  (setq whitespace-style '(tab-mark trailing indentation::tab))
  (whitespace-mode t))

(add-hook 'makefile-gmake-mode-hook
          '(lambda()
             (set-makefile-whitespace-style)
             (program-mode-common-hook)))

(add-to-list 'auto-mode-alist '("\\.P\\'" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("\\.Tpo\\'" . makefile-gmake-mode))

(require 'uniquify)

(require 'htmlfontify)

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;(add-to-list 'load-path (concat tyg-site-lisp "slime-2011-06-27"))
;(add-to-list 'load-path (concat tyg-site-lisp "slime-2012-05-30"))
;(add-to-list 'load-path (concat tyg-site-lisp "technomancy-slime-c27dd18"))
(add-to-list 'load-path (concat tyg-site-lisp "slime-2010-04-04"))
(setq slime-lisp-implementations
      '((sbcl ("sbcl") :coding-system utf-8-unix)
        ;(ccl ("D:/ccl/wx86cl64.exe -K utf-8") :coding-system utf-8-unix)
        ;(clisp ("clisp -K full") :coding-system utf-8-unix)
        ;(ecl ("ecl"))
        ))
(setq inferior-lisp-program "sbcl")

(require 'slime)
(slime-setup '(slime-fancy))


(add-hook 'lisp-mode-hook (lambda ()
                            (linum-mode)
                            (make-local-variable 'before-save-hook)
                            (add-to-list 'before-save-hook 'c-delete-tail-blank)
                            (enable-paredit-mode)))

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac t)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac t)

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)

;; python
;; python-mode.el
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; Settings for pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)

;; (require 'pymacs)
;; (setq pymacs-python-command "D:\\python32\\python.exe")
;; (setq ropemacs-enable-shortcuts nil)
;; (setq ropemacs-local-prefix "C-c C-p")
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")

(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))

(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))

(add-hook 'python-mode-hook
          (lambda ()
                 (auto-complete-mode 1)
                 (subword-mode 1)
                 ;; (set (make-local-variable 'ac-sources)
                 ;;      (append ac-sources '(ac-source-rope)))
                 (set (make-local-variable 'ac-find-function) 'ac-python-find)
                 (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
                 (define-key py-mode-map [(meta ?/)] 'rope-code-assist)
                 (define-key py-mode-map [(control ?c) (?h)] 'ske-python-header)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; End Auto Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'clojure-mode)
(setq slime-use-autodoc-mode nil) ;; Workaround for Clojure 1.3. See http://groups.google.com/group/clojure/browse_thread/thread/692c3a93bbdf740c?tvc=2&pli=1

(require 'paredit)
(require 'highlight-parentheses)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook
          (lambda ()
            (highlight-parentheses-mode t)
            (paredit-mode t)
            (program-mode-common-hook)
            (slime-mode t)))
(setq hl-paren-colors
      '("red1" "orange1" "yellow1" "green1" "cyan1"
        "slateblue1" "magenta1" "purple"))

(require 'haskell-mode)
;(load "~/haskell-mode-2.8.0/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;(load-file "~/geiser/elisp/geiser.el")

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mew")

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

(set-default 'mew-decode-quoted 't)
(when (boundp 'utf-translate-cjk)
  (setq utf-translate-cjk t)
  (custom-set-variables
   '(utf-translate-cjk t)))
(if (fboundp 'utf-translate-cjk-mode)
    (utf-translate-cjk-mode 1))
(require 'flyspell)

(add-to-list 'load-path "~/site-lisp/w3m")
(add-to-list 'Info-default-directory-list "~/site-lisp/emacs-w3m/share/info")
(require 'w3m-load)

(require 'mew-w3m)
(setq mew-prog-text/html 'mew-mime-text/html-w3m)
(setq mew-prog-text/html-ext 'mew-mime-text/html-w3m)
(setq mew-prog-text/html         'mew-mime-text/html-w3m) ;; See w3m.el
(setq mew-prog-text/html-ext     "/usr/bin/firefox")

(setq mew-prog-text/xml         'mew-mime-text/html-w3m) ;; See w3m.el
(setq mew-prog-text/xml-ext     "/usr/bin/firefox")
(setq mew-prog-application/xml         'mew-mime-text/html-w3m)
(setq mew-prog-application/xml-ext     "/usr/bin/firefox")
(setq mew-prog-application/X-Dvi         "/usr/bin/xdvi")
(setq mew-mime-multipart-alternative-list '("text/html" "text/plain" "*."))
;; ;;使用w3m

(setq mew-use-w3m-minor-mode t)
(setq mew-w3m-auto-insert-image t)

;;
;; (2) And you can use keymap of w3m-mode as mew-w3m-minor-mode.
;; To activate this feaeture, add followings also:
;;
(setq mew-use-w3m-minor-mode t)
(add-hook 'mew-message-hook 'mew-w3m-minor-mode-setter)

(require 'thrift-mode)
;; Local Variables:
;; coding: utf-8
;; End:
