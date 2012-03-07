Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:39069 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030605Ab2CGWdH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2012 17:33:07 -0500
Received: by mail-we0-f202.google.com with SMTP id x9so269745wej.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2012 14:33:06 -0800 (PST)
Subject: [PATCH v3 12/34] unicore32/PCI: use pci_flags PCI_PROBE_ONLY instead
	of arm-specific flag
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Guan Xuetao <gxt@mprc.pku.edu.cn>
Date: Wed, 07 Mar 2012 15:33:05 -0700
Message-ID: <20120307223305.25669.46919.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/unicore32/include/asm/pci.h |    1 +
 arch/unicore32/kernel/pci.c      |    5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index dd38677..f5e108f 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -14,6 +14,7 @@
 
 #ifdef __KERNEL__
 #include <asm-generic/pci-dma-compat.h>
+#include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci.h>
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index a8f07fe..2fc2b1b 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 
 static int debug_pci;
-static int use_firmware;
 
 #define CONFIG_CMD(bus, devfn, where)	\
 	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
@@ -276,7 +275,7 @@ static int __init pci_common_init(void)
 
 	pci_fixup_irqs(pci_common_swizzle, pci_puv3_map_irq);
 
-	if (!use_firmware) {
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
 		/*
 		 * Size the bridge windows.
 		 */
@@ -303,7 +302,7 @@ char * __devinit pcibios_setup(char *str)
 		debug_pci = 1;
 		return NULL;
 	} else if (!strcmp(str, "firmware")) {
-		use_firmware = 1;
+		pci_add_flags(PCI_PROBE_ONLY);
 		return NULL;
 	}
 	return str;

