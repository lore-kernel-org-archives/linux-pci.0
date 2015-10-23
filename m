Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36283 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbbJWFGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:09 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 26/29] PCI: Update pcie-iproc to use IRQ deffered assignment
Date: Fri, 23 Oct 2015 06:03:59 +0100
Message-Id: <1445576642-29624-27-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pcie-iproc device is using the fixup irqs code which
will be removed later in the code to migrate to deffered irq
assignment. This patch migrates it to use the new code path and
adds support for deffered irq assignment.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/host/pcie-iproc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index fe2efb1..b2e3305 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -195,6 +195,9 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	int ret;
 	void *sysdata;
 	struct pci_bus *bus;
+#ifdef CONFIG_ARM
+	struct pci_host_bridge *bridge;
+#endif
 
 	if (!pcie || !pcie->dev || !pcie->base)
 		return -EINVAL;
@@ -235,12 +238,13 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	}
 
 	iproc_pcie_enable(pcie);
-
-	pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
 #ifdef CONFIG_ARM
-	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
+	bridge = pci_find_host_bridge(bus);
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = pcie->map_irq;
 #endif
+	pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
 	return 0;
-- 
2.6.2

