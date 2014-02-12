Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:52833 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056AbaBLUQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 15:16:50 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/3] ARM: bios32: use pci_enable_resource to enable PCI resources
Date: Wed, 12 Feb 2014 20:16:10 +0000
Message-Id: <1392236171-10512-3-git-send-email-will.deacon@arm.com>
In-Reply-To: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch moves bios32 over to using the generic code for enabling PCI
resources. Since the core code takes care of bridge resources too, we
can also drop the explicit IO and MEMORY enabling for them in the arch
code.

A side-effect of this change is that we no longer explicitly enable
devices when running in PCI_PROBE_ONLY mode. This stays closer to the
meaning of the option and prevents us from trying to enable devices
without any assigned resources (the core code refuses to enable
resources without parents).

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/bios32.c | 37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 317da88ae65b..91f48804e3bb 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -608,41 +608,10 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx = 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = dev->resource + idx;
-		if (!r->start && r->end) {
-			printk(KERN_ERR "PCI: Device %s not available because"
-			       " of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
+	if (pci_has_flag(PCI_PROBE_ONLY))
+		return 0;
 
-	/*
-	 * Bridges (eg, cardbus bridges) need to be fully enabled
-	 */
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
-		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
-
-	if (cmd != old_cmd) {
-		printk("PCI: enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
+	return pci_enable_resources(dev, mask);
 }
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-- 
1.8.2.2

