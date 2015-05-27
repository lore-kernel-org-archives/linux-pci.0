Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57497 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbbE0VMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:12:12 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 10/13] PCI: Invalidate resources conflicting with bridge
 memories
Date: Wed, 27 May 2015 20:59:40 +0000
Message-ID: <c1989e2b0f5d4a0d968c42d3ebaf4cc9@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the static enumeration profile reserves memory behind a bridge, and
that memory was already assigned to a device's BAR by the BIOS, then
invalidate those BAR resources. The core PCI subsystem will then
reassign those BARs to a different, not-conflicting location.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci_static_enum.c |   42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index 8d479a9..f000c7f 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -259,6 +259,41 @@ int pci_static_enum_get_busnr(struct pci_bus *bus, struct pci_dev *dev,
 }
 
 /**
+ * pci_static_enum_invalidate() - callback invoked while invalidating
+ * bridge resources
+ * @dev: device to examine
+ * @data: overridden bridge memory
+ *
+ * For each of @dev's BARs, if it conflicts with the memory being
+ * reserved for a bridge then invalidate it.
+ *
+ * Return: 0
+ */
+static int pci_static_enum_invalidate(struct pci_dev *dev, void *data)
+{
+	struct pci_static_enum_setting *setting =
+	    (struct pci_static_enum_setting *)(data);
+	int i;
+	struct resource *r;
+	resource_size_t start, end;
+
+	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
+		r = &dev->resource[i];
+		if (!(r->flags & IORESOURCE_MEM)
+		    || (r->flags & IORESOURCE_UNSET))
+			continue;
+		start = max(r->start, setting->bridgemem_start);
+		end = min(r->end, setting->bridgemem_end);
+		if (start >= end)
+			continue;	/* no overlap */
+		dev_info(&dev->dev, "Invalidating res %d %pR\n", i, r);
+		r->flags |= IORESOURCE_UNSET;
+	}
+
+	return 0;
+}
+
+/**
  * pci_static_enum_set_bridge_memory() - override a PCI bridge's
  * memory base and limit registers, according to its static
  * enumeration profile
@@ -270,6 +305,7 @@ static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_st
 {
 	u16 mem_base_lo, mem_limit_lo;
 	struct pci_dev *parent;
+	struct pci_bus *root = dev->bus;
 	struct resource *res;
 	u16 parent_base_lo, parent_limit_lo;
 	unsigned long base, limit;
@@ -311,8 +347,14 @@ static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_st
 			pci_write_config_word(parent, PCI_MEMORY_LIMIT,
 					      mem_limit_lo);
 		}
+		root = parent->bus;
 		parent = pci_upstream_bridge(parent);
 	}
+
+	/* invalidate any other resource that is using this bridge
+	   memory */
+	if (root)
+		pci_walk_bus(root, pci_static_enum_invalidate, setting);
 }
 
 /**
-- 
1.7.9.5

