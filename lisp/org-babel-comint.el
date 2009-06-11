;;; org-babel-comint.el --- org-babel functions for interaction with comint buffers

;; Copyright (C) 2009 Eric Schulte

;; Author: Eric Schulte
;; Keywords: literate programming, reproducible research, comint
;; Homepage: http://orgmode.org
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; These functions build on comint to ease the sending and receiving
;; of commands and results from comint buffers.
;;
;; Note that the buffers in this file are analogous to sessions in
;; org-babel at large.

;;; Code:
(require 'org-babel)
(require 'comint)

(defun org-babel-comint-buffer-livep (buffer)
  (and (buffer-live-p buffer) (get-buffer buffer) (get-buffer-process buffer)))

(defmacro org-babel-comint-in-buffer (buffer &rest body)
  "Check BUFFER with `org-babel-comint-buffer-livep' then execute
body inside the protection of `save-window-excursion' and
`save-match-data'."
  (declare (indent 1))
  `(save-window-excursion
     (save-match-data
       (unless (org-babel-comint-buffer-livep buffer)
         (error (format "buffer %s doesn't exist or has no process" buffer)))
       (set-buffer buffer)
       ,@body)))

(defun org-babel-comint-append-output-filter (text)
  (setq string-buffer (concat string-buffer text)))

(defmacro org-babel-comint-with-output (&rest body)
  `(let ((string-buffer ""))
     (add-hook 'comint-output-filter-functions 'org-babel-comint-append-output-filter)
     (condition-case nil (progn ,@body) (t))
     (remove-hook 'comint-output-filter-functions 'org-babel-comint-append-output-filter)
     string-buffer))

(defun org-babel-comint-wait-for-output (buffer)
  "Wait until output arrives"
  (org-babel-comint-in-buffer buffer
    (while (progn
             (goto-char comint-last-input-end)
             (not (re-search-forward comint-prompt-regexp nil t)))
      (accept-process-output (get-buffer-process buffer)))))

(defun org-babel-comint-input-command (buffer cmd)
  "Pass CMD to BUFFER  The input will not be echoed."
  (org-babel-comint-in-buffer buffer
    (goto-char (process-mark (get-buffer-process buffer)))
    (insert cmd)
    (comint-send-input)
    (org-babel-comint-wait-for-output buffer)))

(defun org-babel-comint-command-to-output (buffer cmd)
  "Pass CMD to BUFFER using `org-babel-comint-input-command', and
then return the result as a string using
`org-babel-comint-last-value'."
  (org-babel-comint-input-command buffer cmd)
  (org-babel-comint-last-value buffer))

(defun org-babel-comint-command-to-last (buffer cmd)
  "Pass CMD to BUFFER using `org-babel-comint-input-command', and
then return the result as a string using
`org-babel-comint-last-value'."
  (org-babel-comint-input-command buffer cmd)
  (org-babel-comint-last-value buffer))

(defun org-babel-comint-last-value (buffer)
  "Return the last comint output in BUFFER as a string."
  (org-babel-comint-in-buffer buffer
    (goto-char (process-mark (get-buffer-process buffer)))
    (forward-line 0)
    (org-babel-clean-text-properties
     (buffer-substring (+ comint-last-input-end
                          ;; because comint insists on echoing input
                          (- comint-last-input-end
                             comint-last-input-start))
                       (- (point) 1)))))

(provide 'org-babel-comint)
;;; org-babel-comint.el ends here
