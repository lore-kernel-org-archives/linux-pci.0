Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36262 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFGC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:02 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 19/29] MIPS/PCI: Defer IRQ assignment to device enable time
Date: Fri, 23 Oct 2015 06:03:52 +0100
Message-Id: <1445576642-29624-20-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently mips PCI IRQs are assigned at boot, this creates an extra
pass over the PCI bus and causes hot-plugged devices which are not
present at boot to not be given IRQs, this patch set fixes this by
registering assignment functions which are then run later during the
device enable code path.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 arch/mips/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index b8a0bf5..137d3fe 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -247,13 +247,18 @@ static int __init pcibios_init(void)
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
2.6.2

