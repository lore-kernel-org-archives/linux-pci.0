Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38141 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbaHKEhB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Aug 2014 00:37:01 -0400
Message-ID: <1407731815.4508.69.camel@pasglop>
Subject: [PATCH] pci/msi-x: Sanity check MSI-X table offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
Date: Mon, 11 Aug 2014 14:36:55 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the hardware device mis-behaves (such as for example crashes or
gets unplugged at the wrong time) and provides us with a bogus
MSI-X table offset, all sorts of "interesting" and potentially
very hard to debug things can happen.

For example, on POWER8, such a device caused us to ioremap an area
outside of the region assigned to the PCI bus, causing subsequent
accesses to cause a PowerBus timeout and checkstop the machine.

Since this isn't a hot path, let's add a good dose of sanity
checking to msix_map_region() to flag these issues early and limit
the damage.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/msi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 5a40516..a584f590 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -666,13 +666,30 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 {
 	resource_size_t phys_addr;
-	u32 table_offset;
+	u32 table_offset, table_end;
 	u8 bir;
 
 	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
 			      &table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
+	if (bir >= DEVICE_COUNT_RESOURCE) {
+		dev_err(&dev->dev, "MSI-X points to non-exiting BAR %d !\n",
+			bir);
+		return NULL;
+	}
+	if ((pci_resource_flags(dev, bir) & IORESOURCE_MEM) == 0) {
+		dev_err(&dev->dev, "MSI-X points to non-memory BAR %d !\n",
+			bir);
+		return NULL;
+	}
 	table_offset &= PCI_MSIX_TABLE_OFFSET;
+	table_end = table_offset + nr_entries * PCI_MSIX_ENTRY_SIZE;
+	if (table_end <= table_offset ||
+	    table_end > pci_resource_len(dev, bir)) {
+		dev_err(&dev->dev, "MSI-X table outside of BAR boundary !"
+			" (0x%08x..%08x)\n", table_offset, table_end);
+		return NULL;
+	}
 	phys_addr = pci_resource_start(dev, bir) + table_offset;
 
 	return ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);


