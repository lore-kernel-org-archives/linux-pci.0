Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56319 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbaJBD7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:23 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 11/18] Delayed mips setup of PCI IRQs to bus scan time
Date: Thu,  2 Oct 2014 04:50:30 +0100
Message-Id: <1412221837-17452-12-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

Currently mips PCI IRQs are assigned at boot, this creates an extra
pass over the PCI bus and causes hot-plugged devices which are not
present at boot to not be given IRQs, this patch set fixes this by
registering assignment functions which are then run later during the
device enable code path.

---
 arch/mips/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 1bf60b1..dc660a0 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -242,13 +242,18 @@ static int __init pcibios_init(void)
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
 
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
-
 	pci_initialized = 1;
 
 	return 0;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+       bridge->swizzle_irq = pci_common_swizzle;
+       bridge->map_irq = pcibios_map_irq;
+       return 0;
+}
+
 subsys_initcall(pcibios_init);
 
 static int pcibios_enable_resources(struct pci_dev *dev, int mask)
-- 
2.1.0

