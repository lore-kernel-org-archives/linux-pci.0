Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38468 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdEPFWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2017 01:22:30 -0400
Received: by mail-wm0-f42.google.com with SMTP id v15so75931205wmv.1
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 22:22:29 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.pawandeep@gmail.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
Date: Tue, 16 May 2017 10:52:05 +0530
Message-Id: <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

current device framework and OF framework integration assumes
dma-ranges in a way where memory-mapped devices define their
dma-ranges. (child-bus-address, parent-bus-address, length).

of_dma_configure is specifically written to take care of memory
mapped devices. but no implementation exists for pci to take
care of pcie based memory ranges.

for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
world dma-ranges.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;

this patch serves following:

1) exposes interface to the pci host driver for their
inbound memory ranges

2) provide an interface to callers such as of_dma_get_ranges.
so then the returned size get best possible (largest) dma_mask.
because PCI RC drivers do not call APIs such as
dma_set_coherent_mask() and hence rather it shows its addressing
capabilities based on dma-ranges.
for e.g.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
we should get dev->coherent_dma_mask=0x7fffffffff.

3) this patch handles multiple inbound windows and dma-ranges.
it is left to the caller, how it wants to use them.
the new function returns the resources in a standard and unform way

4) this way the callers of for e.g. of_dma_get_ranges
does not need to change.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 0ee42c3..4005ed3 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -283,6 +283,101 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+
+/**
+ * of_pci_get_dma_ranges - Parse PCI host bridge inbound resources from DT
+ * @np: device node of the host bridge having the dma-ranges property
+ * @resources: list where the range of resources will be added after DT parsing
+ *
+ * It is the caller's job to free the @resources list.
+ *
+ * This function will parse the "dma-ranges" property of a
+ * PCI host bridge device node and setup the resource mapping based
+ * on its content.
+ *
+ * It returns zero if the range parsing has been successful or a standard error
+ * value if it failed.
+ */
+
+int of_pci_get_dma_ranges(struct device_node *dn, struct list_head *resources)
+{
+	struct device_node *node = of_node_get(dn);
+	int rlen;
+	int pna = of_n_addr_cells(node);
+	const int na = 3, ns = 2;
+	int np = pna + na + ns;
+	int ret = 0;
+	struct resource *res;
+	const u32 *dma_ranges;
+	struct of_pci_range range;
+
+	if (!node)
+		return -EINVAL;
+
+	while (1) {
+		dma_ranges = of_get_property(node, "dma-ranges", &rlen);
+
+		/* Ignore empty ranges, they imply no translation required. */
+		if (dma_ranges && rlen > 0)
+			break;
+
+		/* no dma-ranges, they imply no translation required. */
+		if (!dma_ranges)
+			break;
+
+		node = of_get_next_parent(node);
+
+		if (!node)
+			break;
+	}
+
+	if (!dma_ranges) {
+		pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
+			  dn->full_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	while ((rlen -= np * 4) >= 0) {
+		range.pci_space = dma_ranges[0];
+		range.pci_addr = of_read_number(dma_ranges + 1, ns);
+		range.cpu_addr = of_translate_dma_address(node,
+							dma_ranges + na);
+		range.size = of_read_number(dma_ranges + pna + na, ns);
+
+		dma_ranges += np;
+
+		/*
+		 * If we failed translation or got a zero-sized region
+		 * then skip this range.
+		 */
+		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
+			continue;
+
+		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+		if (!res) {
+			ret = -ENOMEM;
+			goto parse_failed;
+		}
+
+		ret = of_pci_range_to_resource(&range, dn, res);
+		if (ret) {
+			kfree(res);
+			continue;
+		}
+
+		pci_add_resource_offset(resources, res,
+					res->start - range.pci_addr);
+	}
+	return ret;
+
+parse_failed:
+	pci_free_resource_list(resources);
+out:
+	of_node_put(node);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
 #endif /* CONFIG_OF_ADDRESS */
 
 #ifdef CONFIG_PCI_MSI
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 0e0974e..617b90d 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -76,6 +76,7 @@ static inline void of_pci_check_probe_only(void) { }
 int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
+int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources);
 #else
 static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
@@ -83,6 +84,12 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 {
 	return -EINVAL;
 }
+
+static inline int of_pci_get_dma_ranges(struct device_node *np,
+					struct list_head *resources)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
-- 
1.9.1
