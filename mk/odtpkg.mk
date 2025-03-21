include mk/server.mk		# for version

.PHONY:	version odtpkg

help helpall helpserver::
	$(info )
	$(info Maintenance)
	$(info ===========)
	$(info odtpkg             - create ODT package)

helpserver::
	@echo ""

SERVROOT			= ../kjambunathan.github.io/elpa
DOCROOT				= ./docs

ORG_GIT_DIR			= .



pkg:
	git clean -d -f
	find . -name '*~' -delete
	find . -name '*#*' -delete
	@$(MAKE) GITVERSION=$(GITVERSION:release_%=%)-elpa version autoloads
	-@$(RM) $(ELPA_PKG_DIR) $(ELPA_PKG_DIR).tar $(ELPA_PKG_NAME)-pkg.el
	-@$(RM) $(SERVROOT)/$(ELPA_PKG_NAME)-*.tar
	ln -s . $(ELPA_PKG_DIR)
	echo "(define-package \"$(ELPA_PKG_NAME)\""								> $(ELPA_PKG_NAME)-pkg.el
	echo " \"$(ELPA_PKG_VERSION)\" \"$(ELPA_PKG_DOC)\" '($(ELPA_PKG_REQ)))" >> $(ELPA_PKG_NAME)-pkg.el
	echo ";; Local Variables:"												>> $(ELPA_PKG_NAME)-pkg.el
	echo ";; tab-width: 4"													>> $(ELPA_PKG_NAME)-pkg.el
	echo ";; End:"															>> $(ELPA_PKG_NAME)-pkg.el
	echo ";; no-byte-compile: t"											>> $(ELPA_PKG_NAME)-pkg.el
	echo ";; End:"															>> $(ELPA_PKG_NAME)-pkg.el
	git -C $(SERVROOT) reset --hard
	git -C $(SERVROOT) clean -d -f -x
	tar $(ELPA_PKG_TAR_ARGS) -cf $(ELPA_PKG_DIR).tar $(foreach file, $(ELPA_PKG_FILES), $(ELPA_PKG_DIR)/$(file))
	$(BATCH) -l package-x --eval '(let ((package-archive-upload-base "$(SERVROOT)")) (with-demoted-errors "Error: %S" (package-upload-file "$(ELPA_PKG_DIR).tar")))'
	-@$(RM) $(ELPA_PKG_DIR) $(ELPA_PKG_DIR).tar $(ELPA_PKG_NAME)-pkg.el



odtpkg: ELPA_PKG_NAME				= ox-odt
odtpkg: ELPA_PKG_GIT_DIR			= $(ORG_GIT_DIR)

odtpkg: ELPA_PKG_VERSION0			= $(ORGVERSION)
odtpkg: ELPA_PKG_VERSION			= $(ELPA_PKG_VERSION0).$(shell git --git-dir=$(ELPA_PKG_GIT_DIR)/.git \
										log --format=oneline release_$(ELPA_PKG_VERSION0).. | wc -l)

odtpkg: ELPA_PKG_VERSION0_L			= $(shell $(BATCH) --eval '(prin1 (version-to-list "$(ELPA_PKG_VERSION0)"))')

odtpkg: ELPA_PKG_DOC				= "OpenDocument Text Exporter for Org Mode"

odtpkg: ELPA_PKG_REQ				= (org \"$(ELPA_PKG_VERSION0)\") \
										(citeproc \"20240722.1110\") \
										(peg \"1.0.1\") \
										(rnc-mode \"0.3\") \
										(seq \"2.24\") \

# Dependencies for `ox-odt' package distributed from https://kjambunathan.github.io/elpa/
# ========================================================================================
#
# |-----------------------------------------------------+-----------------------------------------------+------------------|
# | Package & Description                               |                                       Version | Distributed from |
# |                                                     | (as on Mar 5, 2025 @ Emacs GNU Emacs 31.0.50) |                  |
# |-----------------------------------------------------+-----------------------------------------------+------------------|
# | org: Outline-based notes management and organizer   |                                        9.7.11 | built-in         |
# |                                                     |                                        9.7.24 | gnu              |
# |                                                     |                       9.8pre0.20250302.151417 | gnu-devel        |
# |-----------------------------------------------------+-----------------------------------------------+------------------|
# | citeproc: A CSL 1.0.2 Citation Processor            |                                 20240722.1110 | melpa            |
# |-----------------------------------------------------+-----------------------------------------------+------------------|
# | peg: Parsing Expression Grammars in Emacs Lisp      |                                         1.0.1 | built-in         |
# |                                                     |                                         1.0.1 | gnu              |
# |                                                     |                        1.0.1.0.20221221.81502 | gnu-devel        |
# |-----------------------------------------------------+-----------------------------------------------+------------------|
# | rnc-mode: Emacs mode to edit Relax-NG Compact files |                                           0.3 | gnu              |
# |                                                     |                          0.3.0.20221221.81910 | gnu-devel        |
# |-----------------------------------------------------+-----------------------------------------------+------------------|
# | seq: Sequence manipulation functions                |                                          2.24 | built-in         |
# |                                                     |                                          2.24 | gnu              |
# |                                                     |                        2.24.0.20240201.135317 | gnu-devel        |
# |-----------------------------------------------------+-----------------------------------------------+------------------|

odtpkg: ELPA_PKG_DIR				= $(ELPA_PKG_NAME)-$(ELPA_PKG_VERSION)

odtpkg: ELPA_PKG_FILES				= lisp/ox-odt.el																\
										lisp/ox-ods.el																\
										lisp/odt.el																	\
										etc/styles/																	\
										etc/schema/odf1.0/OpenDocument-manifest-schema-v1.0-os.rnc					\
										etc/schema/odf1.0/OpenDocument-schema-v1.0-os.rnc							\
										etc/schema/odf1.0/OpenDocument-strict-schema-v1.0-os.rnc					\
										etc/schema/odf1.1/OpenDocument-strict-schema-v1.1.rnc						\
										etc/schema/odf1.1/OpenDocument-manifest-schema-v1.1.rnc						\
										etc/schema/odf1.1/OpenDocument-schema-v1.1.rnc								\
										etc/schema/odf1.2/OpenDocument-v1.2-os-manifest-schema.rnc					\
										etc/schema/odf1.2/OpenDocument-v1.2-os-schema.rnc							\
										etc/schema/odf1.2/OpenDocument-v1.2-os-dsig-schema.rnc						\
										etc/schema/odf1.3/OpenDocument-schema-v1.3.rnc								\
										etc/schema/odf1.3/OpenDocument-manifest-schema-v1.3.rnc						\
										etc/schema/odf1.3/OpenDocument-dsig-schema-v1.3.rnc							\
										etc/schema/libreoffice/OpenDocument-dsig-schema-v1.3+libreoffice.rnc		\
										etc/schema/libreoffice/OpenDocument-schema-v1.3+libreoffice.rnc				\
										etc/schema/libreoffice/OpenDocument-schema-v1.3.rnc							\
										etc/schema/libreoffice/OpenDocument-manifest-schema-v1.3+libreoffice.rnc	\
										etc/schema/od-manifest-schema.rnc											\
										etc/schema/od-schema.rnc													\
										etc/schema/schemas.xml														\
										contrib/odt/LibreOffice/OrgModeUtilities.oxt								\
										testing/examples/odt/														\
										docs/																		\
										$(ELPA_PKG_NAME)-pkg.el

odtpkg: ELPA_PKG_TAR_ARGS			= --exclude=test-new.odt									\
										--exclude=subdocument2.*								\
										--exclude=testing/examples/odt/table-templates			\
										--exclude=etc/styles/LOAllFactoryStyles.odt				\
										--transform='s|contrib/lisp/||'							\
										--transform='s|lisp/||'									\
										--transform='s|contrib/odt/LibreOffice|LibreOffice/|'	\
										--transform='s|testing/examples/odt|samples|'			\



odtpkg: pkg

odtmanual:
	git clean -d -f
	make
	make -C doc org-odt.html
	$(RM) $(DOCROOT)/*
	mv doc/org-odt-manual/*.html $(DOCROOT)
	mv doc/org-odt.info $(DOCROOT)
	$(CP) doc/org-odt-manual/*.png $(DOCROOT)
	$(CP) doc/org-odt-manual/*.css $(DOCROOT)
	make -C doc org-odt.pdf
	mv doc/org-odt.pdf $(DOCROOT)
	make -C doc clean

## `gitlabpages` is a target that needs to be run on a gitlab checkout
##  - origin :: git@gitlab.com:kjambunathan/org-mode-ox-odt.git
##  - github :: git@github.com:kjambunathan/org-mode-ox-odt.git
gitlabpages:
	git reset --hard origin/master
	git clean -d -f -x
	git pull --rebase github master
	git rm -r public
	git commit -am "* public: Removed"
	zip -rTq docs.zip docs
	unzip -j docs.zip -d public
	git add public
	git commit -am "* public: Copy over docs/ for publishing"
	git push --force

# Local Variables:
# tab-width: 4
# End:
