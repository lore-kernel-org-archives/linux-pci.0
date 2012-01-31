Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54475 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783Ab2AaP4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 Jan 2012 10:56:45 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] update-pciids: fix PCI_COMPRESSED_IDS value when zlib is disabled
Date: Tue, 31 Jan 2012 10:56:51 -0500
Message-Id: <1328025411-8281-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If you build with zlib disabled, then PCI_COMPRESSED_IDS is not defined,
which generates the line in the update script:
	PCI_COMPRESSED_IDS=
which in turn causes the update script to warn:
	bash: [: : integer expression expected

So default it to 0 to avoid that logic.

Reported-by: AlphatPC@gmail.com
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d5ed7ac..86fb0c7 100644
--- a/Makefile
+++ b/Makefile
@@ -77,6 +77,7 @@ ls-map.o: ls-map.c $(LSPCIINC)
 setpci.o: setpci.c pciutils.h $(PCIINC)
 common.o: common.c pciutils.h $(PCIINC)
 
+PCI_COMPRESSED_IDS ?= 0
 update-pciids: update-pciids.sh
 	sed <$< >$@ "s@^DEST=.*@DEST=$(IDSDIR)/$(PCI_IDS)@;s@^PCI_COMPRESSED_IDS=.*@PCI_COMPRESSED_IDS=$(PCI_COMPRESSED_IDS)@"
 	chmod +x $@
-- 
1.7.8.4

