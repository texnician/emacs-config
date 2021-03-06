(setq ns-alternate-modifier 'super)
(setq ns-command-modifier 'meta)
(global-font-lock-mode t)
(column-number-mode t)
(show-paren-mode t)
(transient-mark-mode t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq visible-bell t)
(subword-mode t)
                                        ;(menu-bar-mode 0)
(global-auto-revert-mode t)
(auto-revert-mode t)
(setq default-fill-column 80)
(setq default-major-mode 'text-mode)
(setq frame-title-format "emacs@%b")
(setq inhibit-startup-message t)
(mouse-avoidance-mode 'cat-and-mouse)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

(server-start)

(set-language-environment "UTF-8")
(set-frame-font "Menlo-14")
(set-fontset-font "fontset-default" 'han (font-spec :family "PingFang_SC"))
(set-fontset-font "fontset-default" 'oriya (font-spec :family "Oriya MN"))
;; (set-frame-font "Consolas-12")
;; (set-fontset-font "fontset-default" 'han (font-spec :family "Microsoft YaHei"))
;; (set-fontset-font "fontset-default" '(#x0B01 . #x0B70) (font-spec :family "Kalinga"))
;; (set-fontset-font "fontset-default" '(#x2200 . #x22FF) (font-spec :family "Arial Unicode MS"))
;; (set-fontset-font "fontset-default" '(#x2150 . #x218F) (font-spec :family "Arial Unicode MS"))
;; (set-fontset-font "fontset-default" '(#x2700 . #x27FF) (font-spec :family "Code2000"))
;; (set-fontset-font "fontset-default" '(#xFF00 . #xFFEF) (font-spec :family "MingLiU"))
;; (set-fontset-font "fontset-default" '(#x1000 . #x109F) (font-spec :family "Code2000"))

(when window-system (set-frame-size (selected-frame) 145 45))

(setq backup-directory-alist nil)
(setq backup-directory-alist
      '(("\\.c" . "~/.emacs.d/cxx_backup")
        ("\\.cpp" . "~/.emacs.d/cxx_backup")
        ("\\.hpp" . "~/.emacs.d/cxx_backup")
        ("\\.h" . "~/.emacs.d/cxx_backup")
        ("\\.cc" . "~/.emacs.d/cxx_backup")
        ("\\.inl" . "~/.emacs.d/cxx_backup")
        (".*" . "~/.emacs.d/backups")))

;; abbrev
(defun my-indent-or-complete ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else
    if point is at the end of a symbol, expands it. Else indents
    the current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (hippie-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\>")
          (hippie-expand nil)
        (indent-for-tab-command)))))

(global-set-key (kbd "C-\\") 'set-mark-command)
(global-set-key [(control backspace)] 'set-mark-command)
(global-set-key [(meta ?/)] 'hippie-expand)
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

;; abbrev
(defun my-indent-or-complete ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else
    if point is at the end of a symbol, expands it. Else indents
    the current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (hippie-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\>")
          (hippie-expand nil)
        (indent-for-tab-command)))))

(global-set-key (kbd "C-\\") 'set-mark-command)
(global-set-key [(meta ?/)] 'hippie-expand)
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

;; CEDET

;; (load-file "~/cedet-1.1/common/cedet.el")
;(semantic-load-enable-excessive-code-helpers)
;; (setq-mode-local c-mode
;;                  semanticdb-find-default-throttle
;;                  '(project unloaded system recursive omniscience))
;; (setq semanticdb-default-save-directory "~/semanticdb")

(defun test-inhibt ()
  (string-match-p "xxxx" (buffer-file-name)))

(defun my-semantic-init ()
  ;(semantic-stickyfunc-mode t)
  ;(semantic-decoration-mode t)
  ;(semantic-mru-bookmark-mode nil)
  ;(semantic-highlight-edits-mode t)
  ;(semantic-show-parser-state-mode t))
)

;; (remove-hook 'senator-minor-mode-hook 'senator-hippie-expand-hook)
(add-hook 'senator-minor-mode-hook
          '(lambda ()
             (my-semantic-init)
             (define-key senator-mode-map [(tab)] 'ac-expand)))

;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ))
(add-to-list 'package-archives
             ;'("melpa" . "http://melpa.milkbox.net/packages/") t
             '("melpa" . "http://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; (dolist (dir (directory-files package-user-dir t "[a-zA-Z].*[0-9]$"))
;;   (add-to-list 'load-path dir))


;; (require 'ede)
;; (global-ede-mode t)

;; ECB
;; (add-to-list 'load-path "~/ecb-2.32")
;; (require 'ecb-autoloads)

;; (require 'xcscope)
;; ;;	(define-key global-map [(control f3)]  'cscope-set-initial-directory)
;; ;;	(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
;; (define-key global-map "\M-."  'cscope-find-this-symbol)
;; (define-key global-map "\M-,"  'cscope-find-global-definition)
;; ;;	(define-key global-map [(control f7)]
;; ;;	  'cscope-find-global-definition-no-prompting)
;; ;;	(define-key global-map [(control f8)]  'cscope-pop-mark)
;; ;;	(define-key global-map [(control f9)]  'cscope-next-symbol)
;; ;;	(define-key global-map [(control f10)] 'cscope-next-file)
;; ;;	(define-key global-map [(control f11)] 'cscope-prev-symbol)
;; ;;	(define-key global-map [(control f12)] 'cscope-prev-file)
;; ;;      (define-key global-map [(meta f9)]  'cscope-display-buffer)
;; ;;      (defin-ekey global-map [(meta f10)] 'cscope-display-buffer-toggle)
;; (setq cscope-database-regexps
;;       '(("^/home/tyg/linux-2.6.23.9"
;; 	 ("/home/tyg/cscope/kernel" ("-k" ))
;; 	 t
;; 	 (t))
;; 	("^/home/tyg/glibc-2.7"
;; 	 ("/home/tyg/cscope/libc" ( "-k" ))
;; 	 t
;; 	 (t))
;; 	("^/home/tyg/inotify-tools-3.13"
;; 	 ("/home/tyg/cscope/inotify")
;; 	 t
;; 	 (t))
;; 	("^/home/tyg/coreutils-6.9"
;; 	 ("/home/tyg/cscope/coreutils")
;; 	 t
;; 	 (t))))

(define-key emacs-lisp-mode-map (kbd "C-c C-p")  'pp-eval-last-sexp)
(define-key lisp-interaction-mode-map (kbd "C-c C-p") 'pp-eval-last-sexp)

(require 'ido)
(ido-mode t)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(require 'color-theme)
(require 'color-theme-solarized)
(setq *favorite-themes* (mapcar #'car
                                '((my-color-theme)
                                  (color-theme-classic)
                                  (color-theme-oswald)
                                  (color-theme-taming-mr-arneson)
                                  (color-theme-taylor)
                                  (color-theme-arjen)
                                  (color-theme-billw)
                                  (color-theme-charcoal-black)
                                  (color-theme-goldenrod)
                                  (color-theme-clarity)
                                  (color-theme-comidia)
                                  (color-theme-jsc-dark)
                                  (color-theme-dark-laptop)
                                  (color-theme-euphoria)
                                  (color-theme-hober)
                                  (color-theme-lethe)
                                  (color-theme-ld-dark)
                                  (color-theme-gnome2)
                                  (color-theme-midnight)
                                  (color-theme-dark-blue2))))

(random t)

(defun select-random-theme ()
  (let ((rand-pos (random (length *favorite-themes*))))
    (cl-labels ((next-theme (po lst)
                         (if (eql po rand-pos)
                             (and (functionp (car lst)) (funcall (car lst)))
                           (next-theme (1+ po) (cdr lst)))))
      (next-theme 0 *favorite-themes*))))

                                        ;(select-random-theme)
                                        ;(color-theme-taylor)
                                        ;(color-theme-classic)
                                        ; (color-theme-zenburn)
;(color-theme-solarized-dark)
;(color-theme-solarized-light)

;;; helm
(require 'helm)
(require 'helm-config)
; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(helm-mode 1)

;;; yasnippet
;;; (add-to-list 'load-path "~/github/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
;;;(add-hook 'c-mode-common-hook #'yas-minor-mode)
(defun shk-yas/helm-prompt (prompt choices &optional display-fn)
  "Use helm to select a snippet. Put this into `yas-prompt-functions.'"
  (interactive)
  (setq display-fn (or display-fn 'identity))
  (if (require 'helm-config)
      (let (tmpsource cands result rmap)
        (setq cands (mapcar (lambda (x) (funcall display-fn x)) choices))
        (setq rmap (mapcar (lambda (x) (cons (funcall display-fn x) x)) choices))
        (setq tmpsource
              (list
               (cons 'name prompt)
               (cons 'candidates cands)
               '(action . (("Expand" . (lambda (selection) selection))))
               ))
        (setq result (helm-other-buffer '(tmpsource) "*helm-select-yasnippet"))
        (if (null result)
            (signal 'quit "user quit!")
          (cdr (assoc result rmap))))
    nil))
; (add-to-list 'yas-prompt-functions 'shk-yas/helm-prompt)

(defun yas/make-cc-header-guard-list (fname &optional omitted-dir)
  "Make cc-mode header guard candidate list, `fname' is full file name.
filter out dirs in `omitted-dir'."
  (let* ((dirs (mapcar #'(lambda (str) (replace-regexp-in-string "-" "_" str))
                       (split-string (file-name-directory fname) "/" t)))
         (base (file-name-base fname))
         (ext (file-name-extension fname))
         (parts (remove-if '(lambda (str)
                              (if (stringp str)
                                  (cond ((string= (substring str -1) ":") t) 
                                        ((member str omitted-dir) t)
                                        (t nil))
                                nil)) (append dirs (list (concat base "_" ext))))))
    (let (cands last)
      (dolist (elt (reverse parts))
        (setq last (cons elt last))
        (setq cands (cons last cands)))
      (setq cands (reverse cands))
      (mapcar #'(lambda (lst)
                 (mapconcat 'upcase lst "_")) cands))))

(defun my-c-initialization-hook ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)

;; offset customizations not in my-c-style
;; This will take precedence over any setting of the syntactic symbol
;; made by a style.
(setq c-offsets-alist '((member-init-intro . +)))

;; Create my personal style.
(defconst my-c-style
  '((c-basic-offset . 4)
    (c-tab-always-indent        . t)
    (c-comment-only-line-offset . 4)
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
                                   (case-label . +)
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

(defun c-delete-tail-blank ()
  "Delete extra blankets at the end of file"
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-max))
      (delete-blank-lines))))

(load-file (expand-file-name "~/.emacs.d/parse-cflags.el"))

(add-to-list 'auto-mode-alist
             '(".*/include/.+" . c++-mode))
(add-to-list 'auto-mode-alist
             '(".*\\.h" . c++-mode))
;; C mode
(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "tyg")
             (c-toggle-auto-state)
             (c-toggle-hungry-state)
             ;; (setq semanticdb-project-system-databases
             ;;       (list (semanticdb-create-database
             ;;              semanticdb-new-database-class
             ;;              "/usr/include/")))
             (define-key c-mode-base-map [backtab] 'indent-relative)
             (setq c-cleanup-list 
                   '(empty-defun-braces
                     scope-operator one-liner-defun
                     defun-close-semi list-close-comma
                     scope-operator comment-close-slash))
             (make-local-variable 'before-save-hook)
             (add-to-list 'before-save-hook 'c-delete-tail-blank)
             (setq ac-sources (append '(ac-source-abbrev ac-source-words-in-same-mode-buffers  ac-source-imenu ac-source-filename ac-source-dictionary) ac-sources))))

(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "tyg")
             (c-toggle-auto-state)
             (c-toggle-hungry-state)
             ;; (setq semanticdb-project-system-databases
             ;;       (list (semanticdb-create-database
             ;;              semanticdb-new-database-class
             ;;              "/usr/include/")))
             (define-key c-mode-base-map [backtab] 'indent-relative)
             (setq c-cleanup-list 
                   '(empty-defun-braces
                     scope-operator one-liner-defun
                     defun-close-semi list-close-comma
                     scope-operator comment-close-slash))
             (make-local-variable 'before-save-hook)
             (add-to-list 'before-save-hook 'c-delete-tail-blank)
             (setq ac-sources (append '(ac-source-abbrev ac-source-words-in-same-mode-buffers ac-source-imenu ac-source-filename ac-source-dictionary ) ac-sources))
             (electric-pair-mode t)))

(load "desktop")
(desktop-load-default)
(desktop-read)

;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode clojure-mode java-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode slime-mode slime-repl-mode lisp-mode jde-mode)))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(c-cleanup-list
   (quote
    (empty-defun-braces one-liner-defun defun-close-semi list-close-comma scope-operator comment-close-slash)))
 '(c-macro-cppflags
   "-std=c++0x -I/usr/local/include/guile/2.0 -I/usr/include/c++/4.4.4 -I/usr/include/c++/4.4.4/x86_64-slackware-linux -I/usr/local/stow/stackless-271-export/include/python2.7/")
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(doc-view-ghostscript-program (executable-find "gswin32c"))
 '(ecb-options-version "2.32")
 '(fci-rule-color "#515151")
 '(jde-global-classpath
   (quote
    ("/home/tyg/android-sdk-linux_x86/platforms/android-8" "")))
 '(jde-jdk-registry (quote (("1.6.0" . "/usr/local/stow/jdk1.6.0_26"))))
 '(jde-lib-directory-names (quote ("/android.*$" "/lib$" "/jar$")))
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(package-selected-packages
   (quote
    (yasnippet thrift textmate-to-yas quack protobuf-mode pig-mode paredit-everywhere math-symbol-lists lua-mode latex-preview-pane java-snippets highlight-stages highlight-quoted highlight-parentheses helm-unicode helm-themes helm-projectile helm-package helm-make helm-ls-svn helm-ls-git helm-google helm-gitignore helm-git-grep helm-git-files helm-git helm-c-yasnippet helm-c-moccur helm-ack geiser find-file-in-repository find-file-in-project emoji-display common-lisp-snippets color-theme-zenburn color-theme-x color-theme-wombat color-theme-vim-insert-mode color-theme-twilight color-theme-tangotango color-theme-tango color-theme-solarized color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-theme-railscasts color-theme-monokai color-theme-molokai color-theme-library color-theme-ir-black color-theme-heroku color-theme-gruber-darker color-theme-github color-theme-emacs-revert-theme color-theme-eclipse color-theme-dpaste color-theme-dg color-theme-complexity color-theme-cobalt color-theme-buffer-local color-theme-actress clojure-snippets clojure-mode-extra-font-locking auctex-latexmk ac-slime ac-helm)))
 '(password-cache-expiry nil)
 '(semantic-c-dependency-system-include-path
   (quote
    ("E:\\project\\share\\include" "E:\\project\\boost_1_38_0\\boost_1_38_0" "D:\\Program Files\\Microsoft Visual Studio 9.0\\VC\\include")))
 '(semantic-inhibit-functions (quote (test-inhibt)))
 '(slime-net-coding-system (quote utf-8-unix))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil)
 '(which-function-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:background "black" :foreground "snow3" :weight bold))))
 '(info-menu-header ((t (:inherit variable-pitch :weight bold :family "Serif"))))
 '(info-xref-visited ((t (:foreground "slateblue" :underline t))))
 '(variable-pitch ((t (:inverse-video nil :height 1.2 :family "Droid Serif")))))

(require 'tramp)
(setq tramp-default-method "ssh")
(setq password-cache-expiry 30)
;(setq password-cache nil)
(setq recentf-auto-cleanup 'never)
(setq tramp-ssh-controlmaster-options "-o ControlPath=~/.ssh/master-%%r@%%h:%%p -o ControlMaster=auto -o ControlPersist=yes")
(load-file (expand-file-name "~/.emacs.d/proxy_host_config.el"))

;;(setq auto-complete-dir "~/auto-complete-1.3.1")
;;(add-to-list 'load-path auto-complete-dir)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories (concatenate 'string auto-complete-dir "/ac-dict"))
(ac-config-default)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")


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


;; (setq ido-execute-command-cache nil)

;; (defun ido-execute-command ()
;;   (interactive)
;;   (call-interactively
;;    (intern
;;     (ido-completing-read
;;      "M-x "
;;      (progn
;;        (unless ido-execute-command-cache
;;          (mapatoms (lambda (s)
;;                      (when (commandp s)
;;                        (setq ido-execute-command-cache
;;                              (cons (format "%S" s) ido-execute-command-cache))))))
;;        ido-execute-command-cache)))))

;;(add-hook 'ido-setup-hook
;;          (lambda ()
;;            (setq ido-enable-flex-matching t)
;;            (global-set-key "\M-x" 'ido-execute-command)))

(setq enable-recursive-minibuffers t)
(define-key ido-file-dir-completion-map [(meta control ?b)] 'ido-goto-bookmark)
(defun ido-goto-bookmark (bookmark)
  (interactive
   (list (bookmark-completing-read "Jump to bookmark"
                                   bookmark-current-bookmark)))
  (unless bookmark
    (error "No bookmark specified"))
  (let ((filename (bookmark-get-filename bookmark)))
    (ido-set-current-directory
     (if (file-directory-p filename)
         filename
       (file-name-directory filename)))
    (setq ido-exit        'refresh
          ido-text-init   ido-text
          ido-rotate-temp t)
    (exit-minibuffer)))

(add-hook 'Info-mode-hook
          '(lambda ()
             (variable-pitch-mode)))

(defun fullscreen (&optional f)
  (interactive)
  (set-frame-parameter f 'fullscreen
                       (if (frame-parameter f 'fullscreen) nil 'fullboth)))

(global-set-key [f11] 'fullscreen)

(setq slime-dir "~/slime-2.12")
(add-to-list 'load-path slime-dir)  ; your SLIME directory
;; (setq slime-lisp-implementations
;;       '((sbcl ("sbcl") :coding-system utf-8-unix)
;;         (ccl ("ccl -K utf-8") :coding-system utf-8-unix)
;;         (clisp ("clisp -K full") :coding-system utf-8-unix)
;;         (ecl ("ecl"))))
                                        ;(setq inferior-lisp-program "clisp -K full") ; your Lisp system
(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
                                        ;(require 'slime)
(setq slime-contribs '(slime-fancy))
                                        ;(setq slime-net-coding-system 'utf-8-unix)



(add-hook 'lisp-mode-hook '(lambda ()
                             (linum-mode)
                             (make-local-variable 'before-save-hook)
                             (add-to-list 'before-save-hook 'c-delete-tail-blank)))

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac t)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac t)

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook (lambda () (paredit-mode +1)))

(require 'eldoc) ; if not already loaded
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

(require 'geiser)
(require 'quack)

                                        ;(require 'nterm)

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

                                        ;(require 'find-file-in-project)
(require 'find-file-in-repository)

                                        ;(require 'less)

;; (define-key dired-mode-map (kbd "C-s") 'dired-isearch-forward)
;; (define-key dired-mode-map (kbd "C-r") 'dired-isearch-backward)
;; (define-key dired-mode-map (kbd "ESC C-s") 'dired-isearch-forward-regexp)
;; (define-key dired-mode-map (kbd "ESC C-r") 'dired-isearch-backward-regexp)

;; (add-to-list 'load-path (expand-file-name "~/jdee-2.4.1/lisp"))
;; (add-to-list 'load-path (expand-file-name "~/elib-1.0"))
;; (require 'jde)
;; (fmakunbound 'mswindows-cygwin-to-win32-path)
;; (add-hook 'jde-mode-hook
;;           (lambda ()
;;             (make-local-variable 'before-save-hook)
;;             (add-to-list 'before-save-hook 'c-delete-tail-blank)
;;             (line-move t)
;;             (auto-revert-mode t)))

(require 'clojure-mode)
                                        ;(setq slime-use-autodoc-mode nil) ;; Workaround for Clojure 1.3. See http://groups.google.com/group/clojure/browse_thread/thread/692c3a93bbdf740c?tvc=2&pli=1

(require 'paredit)
(require 'paredit-everywhere)
(require 'highlight-parentheses)
(require 'highlight-quoted)
(require 'highlight-stages)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook
          (lambda ()
            (make-local-variable 'before-save-hook)
            (add-to-list 'before-save-hook 'c-delete-tail-blank)
            (linum-mode t)
            (highlight-parentheses-mode t)
            (paredit-mode t)
            (slime-mode t)))
(setq hl-paren-colors
      '("red1" "orange1" "yellow1" "green1" "cyan1"
        "slateblue1" "magenta1" "purple"))

                                        ;(add-to-list 'load-path "~/python-mode.el-6.0.3")
                                        ;(require 'python-mode)

                                        ;(add-to-list 'load-path "~/haskell-mode-2.8.0")
                                        ;(load "~/haskell-mode-2.8.0/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

                                        ;(add-to-list 'load-path "~/.emacs.d")
                                        ;(require 'auto-complete-clang-async)

;; (defun ac-cc-mode-setup ()
;;   (setq clang-complete-executable "~/.emacs.d/clang-complete")
;;   (if (stringp (buffer-file-name))
;;       (launch-completion-proc)))

(setq Tex-engine 'xetex)
(add-hook 'TeX-mode-hook
          '(lambda ()
             (make-local-variable 'before-save-hook)
             (add-to-list 'before-save-hook 'c-delete-tail-blank)
             (linum-mode t)
             (highlight-parentheses-mode t)
             (paredit-mode t)))
;(require 'auto-complete-auctex)

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

(add-hook 'makefile-mode-hook
          '(lambda ()
             (make-local-variable 'before-save-hook)
             (add-to-list 'before-save-hook 'c-delete-tail-blank)))

;; (require 'ac-clang)
;; (setq ac-clang--server-executable "/usr/local/bin/clang-server-x86_64")
;; (when (ac-clang-initialize)
;;   (add-hook 'c-mode-common-hook '(lambda ()
;;                                    (setq ac-sources '(ac-source-clang-async))
;;                                    ;(setq ac-clang-cflags CFLAGS)
;;                                    (ac-clang-activate-after-modify))))
;; (setq ac-clang-debug-log-buffer-p t)

;(setq ac-clang-async-autocompletion-automatically-p nil)

;(require 'auto-complete-clang)

;; (setq ac-clang-flags
;;       (mapcar (lambda (item)(concat "-I" item))
;;               (split-string
;;                "
;; /usr/lib64/qt/include
;;  /usr/lib64/gcc/x86_64-slackware-linux/4.4.4/../../../../include/c++/4.4.4
;;  /usr/lib64/gcc/x86_64-slackware-linux/4.4.4/../../../../include/c++/4.4.4/x86_64-slackware-linux
;;  /usr/lib64/gcc/x86_64-slackware-linux/4.4.4/../../../../include/c++/4.4.4/backward
;;  /usr/local/include
;;  /usr/lib64/gcc/x86_64-slackware-linux/4.4.4/include
;;  /usr/lib64/gcc/x86_64-slackware-linux/4.4.4/include-fixed
;;  /usr/include"
;;                )))
;; (require 'ack)
;; (require 'nav)

;; (load-file "~/.emacs.d/graphviz-dot-mode.el")

;; (require 'pretty-mode)
;; (global-pretty-mode t)

;; Local Variables:
;; coding: utf-8
;; End:

(put 'narrow-to-region 'disabled nil)

