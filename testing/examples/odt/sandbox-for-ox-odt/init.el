;;;; init --- Init file for test driving ox-odt package in a sandbox environment -*- lexical-binding: t; coding: utf-8-emacs; -*-

;; Copyright (C) 2025  Jambuanthan K

;; Author: Jambunathan K <kjambunathan@gmail.com>
;; Version: 
;; Homepage: https://github.com/kjambunathan/org-mode-ox-odt
;; Keywords: 
;; Package-Requires: ((emacs "24"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Put this file under "~/tmp/sandbox-for-ox-odt/" and Emacs with
;;
;;     emacs -Q --init-directory=~/tmp/sandbox-for-ox-odt/ -l ~/tmp/sandbox-for-ox-odt/init.el
;;
;; This init file automatically installs `ox-odt' from
;; https://kjambunathan.github.io/elpa/ in the above sandbox
;; directory.
;;
;; Once `ox-odt' is installed you will be dropped in to an `org'
;; buffer named `test-drive-ox-odt.org'. You can try exporting this
;; file to /*both*/ LibreOffice Writer / ODT (with `C-c C-e o O') and
;; ODS / LibreOffice Calc (with `C-c C-e o S').
;;
;; If all goes well, then you have succesfully installed a ox-odt
;; package in a custom environment.

;;; Code:

(defvar org-mode-ox-odt-sandbox-root
  (expand-file-name "~/tmp/sandbox-for-ox-odt/")
  "Sanbox directory / Init directory for testing ox-odt package.")

(defvar org-mode-ox-odt-sandbox-elpa
  (expand-file-name "package-el" org-mode-ox-odt-sandbox-root)
  "Sub-directory under the sandbox directory where ox-odt's pre-requisites are installed.")

;; Create the above directory
(make-directory org-mode-ox-odt-sandbox-elpa  'parents)

;; Configure Emacs Package Manager
(custom-set-variables
 ;; Install ox-odt & its pre-requisites in the sandbox directory.
 '(package-user-dir org-mode-ox-odt-sandbox-elpa)
 ;; The packages come from sandbox directory alone and not from elsewhere.
 '(package-directory-list (list org-mode-ox-odt-sandbox-elpa))
 ;; Set up ELPA repos
 '(package-archives
   '(("gnu-devel" . "https://elpa.gnu.org/devel/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")
     ("ox-odt" . "https://kjambunathan.github.io/elpa/")))
 ;; If a package is available from multiple ELPAs, prefer ELPAs
 ;; maintained by gnu.org, melpa.org and ox-odt in that order.
   '(package-archive-priorities
    '(("gnu" . 100)
      ("nongnu" . 90)
      ("gnu-devel" . 80)
      ("melpa" . 70)
      ("ox-odt" . 60))))

;; Initialize the Emacs Package Manager, install ox-odt and all its
;; dependencies under the sandbox directory.
(package-initialize)
(package-refresh-contents)
(package-install "ox-odt")
(package-upgrade-all)

;; Load ODS and ODT exporters.  Load `citeproc' so that ODT exporter
;; uses custom styles for Citations and Bibliographies.
(require 'citeproc)
(require 'ox-odt)
(require 'ox-ods)

;; Offer the User a sample `org' file for test driving.
(find-file (expand-file-name "./test-drive-ox-odt/test-drive-ox-odt.org"
                             org-mode-ox-odt-sandbox-root))
