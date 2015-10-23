Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36294 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbbJWFGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:12 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 29/29] PCI: Remove pci_fixup_irqs function
Date: Fri, 23 Oct 2015 06:04:02 +0100
Message-Id: <1445576642-29624-30-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we have removed all callers of pci_fixup_irqs and
migrated everything to pci_assign_irq delete the
pci_fixup_irqs function completely.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/setup-irq.c | 19 -------------------
 include/linux/pci.h     |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index a9b7a30..0d4b83a 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -64,22 +64,3 @@ void pci_assign_irq(struct pci_dev *dev)
 	   the real IRQ to use; the device does not use it. */
 	pcibios_update_irq(dev, irq);
 }
-
-void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
-		    int (*map_irq)(struct pci_dev *, u8, u8))
-{
-	/* This code should be removed shortly, but in the mean time
-	   it can wrap the new codepath in order to allow arches
-	   still using it to continue working */
-	struct pci_dev *dev = NULL;
-	struct pci_host_bridge *hbrg = NULL;
-
-	for_each_pci_dev(dev)
-		hbrg = pci_find_host_bridge(dev->bus);
-		hbrg->swizzle_irq = swizzle;
-		hbrg->map_irq = map_irq;
-		pci_assign_irq(dev);
-		hbrg->swizzle_irq = NULL;
-		hbrg->map_irq = NULL;
-}
-EXPORT_SYMBOL_GPL(pci_fixup_irqs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e88ad4f..6771d62 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1120,8 +1120,6 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
-void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-		    int (*)(struct pci_dev *, u8, u8));
 void pci_assign_irq(struct pci_dev *dev);
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
-- 
2.6.2

