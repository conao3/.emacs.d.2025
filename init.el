;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; My init.el.

;;; Code:

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  (use-package leaf :ensure t)

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init)))

;; ここにいっぱい設定を書く

(leaf leaf-convert
  :doc "Convert many format to leaf format"
  :req "emacs-26.1" "leaf-3.6.0" "leaf-keywords-1.1.0" "ppp-2.1"
  :tag "tools" "emacs>=26.1"
  :url "https://github.com/conao3/leaf-convert.el"
  :added "2024-07-13"
  :emacs>= 26.1
  :ensure t)

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))

  :bind (("M-ESC ESC" . c/redraw-frame))
  :custom '((user-full-name . "Naoya Yamashita")
            (user-mail-address . "conao3@gmail.com")
            (user-login-name . "conao3")
            (create-lockfiles . nil)
            (tab-width . 4)
            (debug-on-error . t)
            (init-file-debug . t)
            (frame-resize-pixelwise . t)
            (enable-recursive-minibuffers . t)
            (history-length . 1000)
            (history-delete-duplicates . t)
            (scroll-preserve-screen-position . t)
            (scroll-conservatively . 100)
            (mouse-wheel-scroll-amount . '(1 ((control) . 5)))
            (ring-bell-function . 'ignore)
            (text-quoting-style . 'straight)
            (truncate-lines . t)
            (use-dialog-box . nil)
            (use-file-dialog . nil)
            (menu-bar-mode . t)
            (tool-bar-mode . nil)
            (scroll-bar-mode . nil)
            (indent-tabs-mode . nil))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (keyboard-translate ?\C-h ?\C-?))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :global-minor-mode global-auto-revert-mode)

(leaf delsel
  :doc "delete selection if you insert"
  :tag "builtin"
  :global-minor-mode delete-selection-mode)

(leaf paren
  :doc "highlight matching paren"
  :tag "builtin"
  :global-minor-mode show-paren-mode)

(leaf simple
  :doc "basic editing commands for Emacs"
  :tag "builtin" "internal"
  :custom ((kill-read-only-ok . t)
           (kill-whole-line . t)
           (eval-expression-print-length . nil)
           (eval-expression-print-level . nil)))

(leaf files
  :doc "file input and output commands for Emacs"
  :tag "builtin"
  :global-minor-mode auto-save-visited-mode
  :custom `((auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
            (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
                                        (,tramp-file-name-regexp . nil)))
            (version-control . t)
            (delete-old-versions . t)
            (auto-save-visited-interval . 1)))

(leaf startup
  :doc "process Emacs shell arguments"
  :tag "builtin" "internal"
  :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-"))))

(leaf savehist
  :doc "Save minibuffer history"
  :tag "builtin"
  :added "2024-07-13"
  :custom `((savehist-file . ,(locate-user-emacs-file "savehist")))
  :global-minor-mode t)

(leaf flymake
  :doc "A universal on-the-fly syntax checker"
  :tag "builtin"
  :added "2024-06-13"
  :bind ((prog-mode-map
          ("M-n" . flymake-goto-next-error)
          ("M-p" . flymake-goto-prev-error))))

(leaf exec-path-from-shell
  :doc "Get environment variables such as $PATH from the shell"
  :req "emacs-24.4"
  :tag "environment" "unix" "emacs>=24.4"
  :url "https://github.com/purcell/exec-path-from-shell"
  :added "2024-07-13"
  :emacs>= 24.4
  :ensure t
  :defun (exec-path-from-shell-initialize)
  :custom ((exec-path-from-shell-check-startup-files)
           (exec-path-from-shell-variables . '("PATH" "GOPATH" "JAVA_HOME")))
  :config
  (exec-path-from-shell-initialize))

(leaf which-key
  :doc "Display available keybindings in popup"
  :req "emacs-25.1"
  :tag "emacs>=25.1"
  :added "2024-07-14"
  :emacs>= 25.1
  :ensure t
  :global-minor-mode t)

(leaf vertico
  :doc "VERTical Interactive COmpletion"
  :req "emacs-27.1" "compat-30"
  :tag "completion" "matching" "files" "convenience" "emacs>=27.1"
  :url "https://github.com/minad/vertico"
  :added "2024-07-14"
  :emacs>= 27.1
  :ensure t
  :global-minor-mode t)

(leaf marginalia
  :doc "Enrich existing commands with completion annotations"
  :req "emacs-27.1" "compat-30"
  :tag "completion" "matching" "help" "docs" "emacs>=27.1"
  :url "https://github.com/minad/marginalia"
  :added "2024-07-14"
  :emacs>= 27.1
  :ensure t
  :global-minor-mode t)

(leaf consult
  :doc "Consulting completing-read"
  :req "emacs-27.1" "compat-30"
  :tag "completion" "files" "matching" "emacs>=27.1"
  :url "https://github.com/minad/consult"
  :added "2024-07-14"
  :emacs>= 27.1
  :ensure t
  :hook (completion-list-mode-hook . consult-preview-at-point-mode)
  :preface
  (defun c/consult-line (&optional at-point)
    "Consult-line uses things-at-point if set C-u prefix."
    (interactive "P")
    (if at-point
        (consult-line (thing-at-point 'symbol))
      (consult-line)))
  :custom ((xref-show-xrefs-function . #'consult-xref)
           (xref-show-definitions-function . #'consult-xref)
           (consult-line-start-from-top . t))
  :bind (;; C-c bindings (mode-specific-map)
         ([remap switch-to-buffer] . consult-buffer) ; C-x b
         ([remap project-switch-to-buffer] . consult-project-buffer) ; C-x p b

         ;; M-g bindings (goto-map)
         ([remap goto-line] . consult-goto-line)    ; M-g g
         ([remap imenu] . consult-imenu)            ; M-g i
         ("M-g f" . consult-flymake)

         ;; s-s bindings
         ("C-s" . c/consult-line)
         ("s-s s" . isearch-forward)
         ("s-s S" . isearch-forward-regexp)
         ("s-s r" . consult-ripgrep)

         (minibuffer-local-map
          :package emacs
          ("C-r" . consult-history))))

(leaf affe
  :doc "Asynchronous Fuzzy Finder for Emacs"
  :req "emacs-27.1" "consult-1.0"
  :tag "completion" "files" "matching" "emacs>=27.1"
  :url "https://github.com/minad/affe"
  :added "2024-07-14"
  :emacs>= 27.1
  :ensure t
  :custom ((affe-highlight-function . 'orderless-highlight-matches)
           (affe-regexp-function . 'orderless-pattern-compiler))
  :bind (("s-s r" . affe-grep)
         ("s-s f" . affe-find)))

(leaf orderless
  :doc "Completion style for matching regexps in any order"
  :req "emacs-27.1"
  :tag "extensions" "emacs>=27.1"
  :url "https://github.com/oantolin/orderless"
  :added "2024-07-14"
  :emacs>= 27.1
  :ensure t
  :custom ((completion-styles . '(orderless))
           (completion-category-defaults . nil)
           (completion-category-overrides . '((file (styles partial-completion))))))

(leaf embark-consult
  :doc "Consult integration for Embark"
  :req "emacs-27.1" "compat-29.1.4.0" "embark-1.0" "consult-1.0"
  :tag "convenience" "emacs>=27.1"
  :url "https://github.com/oantolin/embark"
  :added "2024-07-14"
  :emacs>= 27.1
  :ensure t
  :bind ((minibuffer-mode-map
          :package emacs
          ("M-." . embark-dwim)
          ("C-." . embark-act))))

(leaf corfu
  :doc "COmpletion in Region FUnction"
  :req "emacs-27.1" "compat-30"
  :tag "text" "completion" "matching" "convenience" "abbrev" "emacs>=27.1"
  :url "https://github.com/minad/corfu"
  :added "2024-07-14"
  :emacs>= 27.1
  :ensure t
  :global-minor-mode global-corfu-mode corfu-popupinfo-mode
  :custom ((corfu-auto . t)
           (corfu-auto-delay . 0)
           (corfu-auto-prefix . 1)
           (corfu-popupinfo-delay . nil)) ; manual
  :bind ((corfu-map
          ("C-s" . corfu-insert-separator))))

(leaf cape
  :doc "Completion At Point Extensions"
  :req "emacs-27.1" "compat-29.1.4.4"
  :tag "text" "completion" "matching" "convenience" "abbrev" "emacs>=27.1"
  :url "https://github.com/minad/cape"
  :added "2024-07-15"
  :emacs>= 27.1
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

(leaf puni
  :doc "Parentheses Universalistic"
  :req "emacs-26.1"
  :tag "tools" "lisp" "convenience" "emacs>=26.1"
  :url "https://github.com/AmaiKinono/puni"
  :added "2024-06-13"
  :ensure t
  :global-minor-mode puni-global-mode
  :bind (puni-mode-map
         ;; default mapping
         ;; ("C-M-f" . puni-forward-sexp)
         ;; ("C-M-b" . puni-backward-sexp)
         ;; ("C-M-a" . puni-beginning-of-sexp)
         ;; ("C-M-e" . puni-end-of-sexp)
         ;; ("M-)" . puni-syntactic-forward-punct)
         ;; ("C-M-u" . backward-up-list)
         ;; ("C-M-d" . backward-down-list)
         ("C-)" . puni-slurp-forward)
         ("C-}" . puni-barf-forward)
         ("M-(" . puni-wrap-round)
         ("M-s" . puni-splice)
         ("M-r" . puni-raise)
         ("M-U" . puni-splice-killing-backward)
         ("M-z" . puni-squeeze))
  :config
  (leaf elec-pair
    :doc "Automatic parenthesis pairing"
    :tag "builtin"
    :added "2024-06-29"
    :global-minor-mode electric-pair-mode))

(leaf eglot
  :doc "The Emacs Client for LSP servers"
  :tag "builtin"
  :added "2024-07-14"
  :hook ((clojure-mode-hook . eglot-ensure))
  :custom ((eldoc-echo-area-use-multiline-p . nil)
           (eglot-connect-timeout . 600)))

(leaf eglot-booster
  :when (executable-find "emacs-lsp-booster")
  :vc ( :url "https://github.com/jdtsmith/eglot-booster")
  :global-minor-mode t)

(leaf cider
  :doc "Clojure Interactive Development Environment that Rocks"
  :req "emacs-26" "clojure-mode-5.19" "parseedn-1.2.1" "queue-0.2" "spinner-1.7" "seq-2.22" "sesman-0.3.2" "transient-0.4.1"
  :tag "cider" "clojure" "languages" "emacs>=26"
  :url "https://www.github.com/clojure-emacs/cider"
  :added "2024-07-14"
  :emacs>= 26
  :ensure t)

(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
