Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53784 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab2AaPuh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 Jan 2012 10:50:37 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org, Kevin Pyle <gentoo@spamgourmet.com>
Subject: [PATCH] install: split out pcilib install to a dedicated target
Date: Tue, 31 Jan 2012 10:50:43 -0500
Message-Id: <1328025043-6762-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kevin Pyle <gentoo@spamgourmet.com>

The "install" target manages one set of files, and the "install-pcilib"
target manages a different set.  They both install the pci library though
so if you try to run `make -j install install-pcilib`, things randomly
fail.  So split out the commonly installed files into a dedicated target.
---
 Makefile |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f726e87..d5ed7ac 100644
--- a/Makefile
+++ b/Makefile
@@ -98,6 +98,13 @@ clean:
 
 distclean: clean
 
+install-pcilib: lib/$(PCILIB)
+	$(DIRINSTALL) -m 755 $(DESTDIR)$(LIBDIR)
+	$(INSTALL) -c -m 644 lib/$(PCILIB) $(DESTDIR)$(LIBDIR)
+
+ifeq ($(SHARED),yes)
+install: install-pcilib
+endif
 install: all
 # -c is ignored on Linux, but required on FreeBSD
 	$(DIRINSTALL) -m 755 $(DESTDIR)$(SBINDIR) $(DESTDIR)$(IDSDIR) $(DESTDIR)$(MANDIR)/man8 $(DESTDIR)$(MANDIR)/man7
@@ -107,15 +114,12 @@ install: all
 	$(INSTALL) -c -m 644 lspci.8 setpci.8 update-pciids.8 $(DESTDIR)$(MANDIR)/man8
 	$(INSTALL) -c -m 644 pcilib.7 $(DESTDIR)$(MANDIR)/man7
 ifeq ($(SHARED),yes)
-	$(DIRINSTALL) -m 755 $(DESTDIR)$(LIBDIR)
-	$(INSTALL) -c -m 644 lib/$(PCILIB) $(DESTDIR)$(LIBDIR)
 	ln -sf $(PCILIB) $(DESTDIR)$(LIBDIR)/$(LIBNAME).so$(ABI_VERSION)
 endif
 
-install-lib: $(PCIINC_INS) lib/$(PCILIB) lib/$(PCILIBPC)
-	$(DIRINSTALL) -m 755 $(DESTDIR)$(INCDIR)/pci $(DESTDIR)$(LIBDIR) $(DESTDIR)$(PKGCFDIR)
+install-lib: $(PCIINC_INS) lib/$(PCILIBPC) install-pcilib
+	$(DIRINSTALL) -m 755 $(DESTDIR)$(INCDIR)/pci $(DESTDIR)$(PKGCFDIR)
 	$(INSTALL) -c -m 644 $(PCIINC_INS) $(DESTDIR)$(INCDIR)/pci
-	$(INSTALL) -c -m 644 lib/$(PCILIB) $(DESTDIR)$(LIBDIR)
 	$(INSTALL) -c -m 644 lib/$(PCILIBPC) $(DESTDIR)$(PKGCFDIR)
 ifeq ($(SHARED),yes)
 	ln -sf $(LIBNAME).so$(ABI_VERSION) $(DESTDIR)$(LIBDIR)/$(LIBNAME).so
-- 
1.7.8.4

