Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57391 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbE0VLL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:11:11 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 09/13] PCI: Adjust upstream bridge memories to match static
 enumeration
Date: Wed, 27 May 2015 20:59:32 +0000
Message-ID: <bf81959f74134c15aa8ea645e239c183@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After overriding the memory behind a bridge, update all upstream bridges
so that their memory bases and limits encompass the overridden values.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci_static_enum.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index 9c9ea4a..8d479a9 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -269,6 +269,10 @@ static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_st
 					      *setting)
 {
 	u16 mem_base_lo, mem_limit_lo;
+	struct pci_dev *parent;
+	struct resource *res;
+	u16 parent_base_lo, parent_limit_lo;
+	unsigned long base, limit;
 
 	dev_info(&dev->dev, "Overriding memory base and limit to %pa-%pa\n",
 		 &setting->bridgemem_start, &setting->bridgemem_end);
@@ -276,6 +280,39 @@ static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_st
 	mem_limit_lo = (setting->bridgemem_end >> 16) & ~0xf;
 	pci_write_config_word(dev, PCI_MEMORY_BASE, mem_base_lo);
 	pci_write_config_word(dev, PCI_MEMORY_LIMIT, mem_limit_lo);
+
+	/* update all upstream bridges' memory to encompass this
+	   bridge memory */
+	parent = pci_upstream_bridge(dev);
+	while (parent) {
+		res = parent->bus->resource[1];
+		pci_read_config_word(parent, PCI_MEMORY_BASE, &parent_base_lo);
+		pci_read_config_word(parent, PCI_MEMORY_LIMIT,
+				     &parent_limit_lo);
+		base =
+		    ((unsigned long)parent_base_lo & PCI_MEMORY_RANGE_MASK) <<
+		    16;
+		limit =
+		    (((unsigned long)parent_limit_lo & PCI_MEMORY_RANGE_MASK) <<
+		     16) | 0xfffff;
+		if (base > setting->bridgemem_start) {
+			dev_info(&parent->dev, "Updating memory base to %pa\n",
+				 &setting->bridgemem_start);
+			if (res)
+				res->start = setting->bridgemem_start;
+			pci_write_config_word(parent, PCI_MEMORY_BASE,
+					      mem_base_lo);
+		}
+		if (limit < setting->bridgemem_end) {
+			dev_info(&parent->dev, "Updating memory limit to %pa\n",
+				 &setting->bridgemem_end);
+			if (res)
+				res->end = setting->bridgemem_end;
+			pci_write_config_word(parent, PCI_MEMORY_LIMIT,
+					      mem_limit_lo);
+		}
+		parent = pci_upstream_bridge(parent);
+	}
 }
 
 /**
-- 
1.7.9.5

