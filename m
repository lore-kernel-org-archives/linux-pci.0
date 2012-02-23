Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f202.google.com ([209.85.161.202]:33702 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab2BWTn7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 14:43:59 -0500
Received: by mail-gx0-f202.google.com with SMTP id p1so202655ggn.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 11:43:59 -0800 (PST)
Subject: [PATCH v2 11/12] unicore32/PCI: use pci_flags PCI_PROBE_ONLY instead
	of arm-specific flag
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
Date: Thu, 23 Feb 2012 12:43:58 -0700
Message-ID: <20120223194358.20708.90268.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/unicore32/kernel/pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index a8f07fe..6c1248f 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -19,9 +19,9 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <asm-generic/pci-bridge.h>
 
 static int debug_pci;
-static int use_firmware;
 
 #define CONFIG_CMD(bus, devfn, where)	\
 	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
@@ -276,7 +276,7 @@ static int __init pci_common_init(void)
 
 	pci_fixup_irqs(pci_common_swizzle, pci_puv3_map_irq);
 
-	if (!use_firmware) {
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
 		/*
 		 * Size the bridge windows.
 		 */
@@ -303,7 +303,7 @@ char * __devinit pcibios_setup(char *str)
 		debug_pci = 1;
 		return NULL;
 	} else if (!strcmp(str, "firmware")) {
-		use_firmware = 1;
+		pci_add_flags(PCI_PROBE_ONLY);
 		return NULL;
 	}
 	return str;

