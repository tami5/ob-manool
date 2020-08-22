;;; org-manool.el --- org-babel for manool evaluation -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 Khalid W.
;;
;; Author: Khalid W. <http://github/tami5>
;; Maintainer: Khalid W. <>
;; Created: August 22, 2020
;; Modified: August 22, 2020
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/tami5/ob-manool
;; Package-Requires: ((emacs 27.1) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:

;; ob-manool.el provides Babel support for the manool programming language.
;; (see https://manool.org/specification/introduction-to-manool for details)


;;; Requirements:

;; Follow installation instructions https://manool.org/download#h:launching-manool, or
;; 1. Run: git clone https://github.com/rusini/manool; cd manool; make; sudo make install
;; 2. Export: `MNL_PATH=/usr/local/lib/manool';
;; 3. Test: in the command line.

;;; Code:

(require 'ob)

;; File extension.
(defvar org-babel-tangle-lang-exts)
(add-to-list 'org-babel-tangle-lang-exts '("manool" . "mnl"))

;; Command
(defcustom org-babel-manool-compiler "/usr/local/bin/mnlexec"
  "Name or path of the manool command."
  :group 'org-babel
  :type 'string)

;; Main Function
(defun org-babel-execute:manool (body params)
  "Execute a block of Manool code with Babel, `BODY' `PARAMS'.
This function is called by `org-babel-execute-src-block'."
  (message "executing Manool source code block")
  (let* ((tmp-src-file (org-babel-temp-file "manool-src-" ".mnl")))
    (with-temp-file tmp-src-file (insert body))
    (org-babel-eval
     (format "%s %s" org-babel-manool-compiler
             (org-babel-process-file-name tmp-src-file)) "")
    ))

(defun org-babel-prep-session:manool (_session _params)
  "Prepare a session. This function does nothing for now."
  (error "no support for sessions"))

(provide 'ob-manool)
;;; ob-manool.el ends here
