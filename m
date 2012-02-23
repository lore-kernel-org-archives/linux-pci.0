Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:53925 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389Ab2BWTnX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 14:43:23 -0500
Received: by mail-yx0-f202.google.com with SMTP id m1so199474yen.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 11:43:23 -0800 (PST)
Subject: [PATCH v2 04/12] arm/PCI: remove arch pci_flags definition
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <rob.herring@calxeda.com>
Date: Thu, 23 Feb 2012 12:43:22 -0700
Message-ID: <20120223194322.20708.4942.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI core provides a pci_flags definition (currently __weak), so drop
the arm definition in favor of that.

We EXPORT_SYMBOL(pci_flags) as arm did previously.  I'm dubious about
this: no other architecture exports it, and I didn't see any modules in
the tree that reference it.

CC: Rob Herring <rob.herring@calxeda.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c |    2 ++
 arch/arm/mm/iomap.c      |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index f58ba35..f3fd52b 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -525,6 +525,7 @@ void __init pci_common_init(struct hw_pci *hw)
 
 	INIT_LIST_HEAD(&hw->buses);
 
+	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
 	pcibios_init_hw(hw);
@@ -559,6 +560,7 @@ void __init pci_common_init(struct hw_pci *hw)
 		pci_bus_add_devices(bus);
 	}
 }
+EXPORT_SYMBOL(pci_flags);
 
 #ifndef CONFIG_PCI_HOST_ITE8152
 void pcibios_set_master(struct pci_dev *dev)
diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index e62956e..4614208 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -32,9 +32,6 @@ EXPORT_SYMBOL(pcibios_min_io);
 unsigned long pcibios_min_mem = 0x01000000;
 EXPORT_SYMBOL(pcibios_min_mem);
 
-unsigned int pci_flags = PCI_REASSIGN_ALL_RSRC;
-EXPORT_SYMBOL(pci_flags);
-
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if ((unsigned long)addr >= VMALLOC_START &&

