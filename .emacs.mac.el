(global-font-lock-mode t)
(column-number-mode t)
(show-paren-mode t)
(transient-mark-mode t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(global-auto-revert-mode t)
(auto-revert-mode t)
(setq default-fill-column 80)
(setq default-major-mode 'text-mode)
(setq frame-title-format "emacs@%b")
(setq inhibit-startup-message t)
(mouse-avoidance-mode 'cat-and-mouse)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq ns-alternate-modifier 'super)
(setq ns-command-modifier 'meta)

(server-start)

(set-language-environment "UTF-8")
(set-frame-font "Menlo-13")
;(set-frame-font "Consolas-10")
;(set-fontset-font "fontset-default" 'han (font-spec :family "WenQuanYi Micro Hei Mono"))
;(set-frame-font "Consolas-12")
;(set-fontset-font "fontset-default" 'han (font-spec :family "Microsoft YaHei"))
;; (set-fontset-font "fontset-default" '(#x0B01 . #x0B70) (font-spec :family "Kalinga"))
;; (set-fontset-font "fontset-default" '(#x2200 . #x22FF) (font-spec :family "Arial Unicode MS"))
;; (set-fontset-font "fontset-default" '(#x2150 . #x218F) (font-spec :family "Arial Unicode MS"))
;; (set-fontset-font "fontset-default" '(#x2700 . #x27FF) (font-spec :family "Code2000"))
;; (set-fontset-font "fontset-default" '(#xFF00 . #xFFEF) (font-spec :family "MingLiU"))
;; (set-fontset-font "fontset-default" '(#x1000 . #x109F) (font-spec :family "Code2000"))

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

(load-file "~/cedet-1.1/common/cedet.el")
(semantic-load-enable-excessive-code-helpers)
(setq-mode-local c-mode
                 semanticdb-find-default-throttle
                 '(project unloaded system recursive omniscience))
(setq semanticdb-default-save-directory "~/semanticdb")

(defun test-inhibt ()
  (string-match-p "xxxx" (buffer-file-name)))

(defun my-semantic-init ()
  (semantic-stickyfunc-mode t)
  (semantic-decoration-mode t)
  (semantic-mru-bookmark-mode nil)
  (semantic-highlight-edits-mode t)
  (semantic-show-parser-state-mode t))

;; (remove-hook 'senator-minor-mode-hook 'senator-hippie-expand-hook)
(add-hook 'senator-minor-mode-hook
	  '(lambda ()
	     (my-semantic-init)
	     (define-key senator-mode-map [(tab)] 'ac-expand)))

;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(require 'package)
(add-to-list 'package-archives
;;	     '("marmalade" . "http://marmalade-repo.org/packages/")
         '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
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
    (labels ((next-theme (po lst)
                         (if (eql po rand-pos)
                             (and (functionp (car lst)) (funcall (car lst)))
                           (next-theme (1+ po) (cdr lst)))))
      (next-theme 0 *favorite-themes*))))

;(select-random-theme)
;(color-theme-taylor)
;(color-theme-classic)
; (color-theme-zenburn)
(color-theme-solarized-dark)
;(color-theme-solarized-light)

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
	     (c-set-style "gnu")
	     (c-toggle-auto-state)
	     (c-toggle-hungry-state)
	     (setq semanticdb-project-system-databases
		   (list (semanticdb-create-database
			  semanticdb-new-database-class
			  "/usr/include/")))
	     (define-key c-mode-base-map [backtab] 'indent-relative)
         (setq c-cleanup-list 
               '(empty-defun-braces
                 scope-operator one-liner-defun
                 defun-close-semi list-close-comma
                 scope-operator comment-close-slash))
         (make-local-variable 'before-save-hook)
         (add-to-list 'before-save-hook 'c-delete-tail-blank)
         (setq ac-sources (append '(ac-source-abbrev ac-source-words-in-same-mode-buffers ac-source-clang-async ac-source-imenu ac-source-filename ac-source-dictionary )
                                  ac-sources)
         )
         (define-key c-mode-map [(meta ?/)] 'ac-complete-clang-async)))

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (c-set-style "stroustrup")
	     (c-toggle-auto-state)
	     (c-toggle-hungry-state)
	     (setq semanticdb-project-system-databases
		   (list (semanticdb-create-database
			  semanticdb-new-database-class
			  "/usr/include/")))
	     (define-key c-mode-base-map [backtab] 'indent-relative)
         (setq c-cleanup-list 
               '(empty-defun-braces
                 scope-operator one-liner-defun
                 defun-close-semi list-close-comma
                 scope-operator comment-close-slash))
         (make-local-variable 'before-save-hook)
         (add-to-list 'before-save-hook 'c-delete-tail-blank)
         (setq ac-sources (append '(ac-source-abbrev ac-source-words-in-same-mode-buffers ac-source-clang-async ac-source-imenu ac-source-filename ac-source-dictionary )
                                  ac-sources))
         (define-key c++-mode-map [(meta ?/)] 'ac-complete-clang-async)
         (set-local-clang-flags)))

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
 '(ac-modes (quote (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode clojure-mode java-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode slime-mode slime-repl-mode lisp-mode jde-mode)))
 '(c-cleanup-list (quote (empty-defun-braces one-liner-defun defun-close-semi list-close-comma scope-operator comment-close-slash)))
 '(c-macro-cppflags "-std=c++0x -I/usr/local/include/guile/2.0 -I/usr/include/c++/4.4.4 -I/usr/include/c++/4.4.4/x86_64-slackware-linux -I/usr/local/stow/stackless-271-export/include/python2.7/")
 '(doc-view-ghostscript-program (executable-find "gswin32c"))
 '(ecb-options-version "2.32")
 '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
 '(global-semantic-highlight-edits-mode nil nil (semantic-util-modes))
 '(global-semantic-highlight-func-mode t nil (semantic-util-modes))
 '(global-semantic-idle-completions-mode nil nil (semantic-idle))
 '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
 '(global-semantic-idle-summary-mode t nil (semantic-idle))
 '(global-semantic-idle-tag-highlight-mode t nil (semantic-idle))
 '(global-semantic-mru-bookmark-mode t nil (semantic-util-modes))
 '(global-semantic-show-parser-state-mode nil nil (semantic-util-modes))
 '(global-semantic-show-unmatched-syntax-mode nil nil (semantic-util-modes))
 '(global-semantic-stickyfunc-mode t nil (semantic-util-modes))
 '(global-senator-minor-mode t nil (senator))
 '(jde-global-classpath (quote ("/home/tyg/android-sdk-linux_x86/platforms/android-8" "")))
 '(jde-jdk-registry (quote (("1.6.0" . "/usr/local/stow/jdk1.6.0_26"))))
 '(jde-lib-directory-names (quote ("/android.*$" "/lib$" "/jar$")))
 '(password-cache-expiry nil)
 '(semantic-c-dependency-system-include-path (quote ("E:\\project\\share\\include" "E:\\project\\boost_1_38_0\\boost_1_38_0" "D:\\Program Files\\Microsoft Visual Studio 9.0\\VC\\include")))
 '(semantic-inhibit-functions (quote (test-inhibt)))
 '(semanticdb-global-mode t nil (semanticdb))
 '(slime-net-coding-system (quote utf-8-unix))
 '(which-function-mode t)
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta)))
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
(setq tramp-default-method "plink")
(setq recentf-auto-cleanup 'never)

;;(setq auto-complete-dir "~/auto-complete-1.3.1")
;;(add-to-list 'load-path auto-complete-dir)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories (concatenate 'string auto-complete-dir "/ac-dict"))
(ac-config-default)


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



(add-hook 'lisp-mode-hook (lambda ()
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

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

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

