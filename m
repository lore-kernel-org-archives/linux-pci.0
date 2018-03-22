Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:28433
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751628AbeCVQwO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Mar 2018 12:52:14 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Subject: [PATCH] pciutils: add tags\TAGS generation
Date: Thu, 22 Mar 2018 19:51:37 +0300
Message-Id: <1521737497-9578-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds 'ctags' and 'TAGS' targets to Makefile

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8c7edb7..96fffca 100644
--- a/Makefile
+++ b/Makefile
@@ -101,9 +101,17 @@ example.o: example.c $(PCIINC)
 %.8 %.7: %.man
 	M=`echo $(DATE) | sed 's/-01-/-January-/;s/-02-/-February-/;s/-03-/-March-/;s/-04-/-April-/;s/-05-/-May-/;s/-06-/-June-/;s/-07-/-July-/;s/-08-/-August-/;s/-09-/-September-/;s/-10-/-October-/;s/-11-/-November-/;s/-12-/-December-/;s/\(.*\)-\(.*\)-\(.*\)/\3 \2 \1/'` ; sed <$< >$@ "s/@TODAY@/$$M/;s/@VERSION@/pciutils-$(VERSION)/;s#@IDSDIR@#$(IDSDIR)#"
 
+ctags:
+	rm -f tags
+	find . -name '*.[hc]' -exec ctags --append {} +
+
+TAGS:
+	rm -f TAGS
+	find . -name '*.[hc]' -exec etags --append {} +
+
 clean:
 	rm -f `find . -name "*~" -o -name "*.[oa]" -o -name "\#*\#" -o -name TAGS -o -name core -o -name "*.orig"`
-	rm -f update-pciids lspci setpci example lib/config.* *.[78] pci.ids.* lib/*.pc lib/*.so lib/*.so.*
+	rm -f update-pciids lspci setpci example lib/config.* *.[78] pci.ids.* lib/*.pc lib/*.so lib/*.so.* tags
 	rm -rf maint/dist
 
 distclean: clean
@@ -156,4 +164,4 @@ endif
 pci.ids.gz: pci.ids
 	gzip -9n <$< >$@
 
-.PHONY: all clean distclean install install-lib uninstall force
+.PHONY: all clean distclean install install-lib uninstall force tags TAGS
-- 
2.7.4
