Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33888 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbdEEL5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2017 07:57:36 -0400
Received: by mail-qt0-f182.google.com with SMTP id j29so2677339qtj.1
        for <linux-pci@vger.kernel.org>; Fri, 05 May 2017 04:57:36 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.pawandeep@gmail.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH v3 3/3] PCI/of fix of_dma_get_range; get PCI specific dma-ranges
Date: Fri,  5 May 2017 17:27:17 +0530
Message-Id: <1493985437-2748-3-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1493985437-2748-1-git-send-email-oza.oza@broadcom.com>
References: <1493985437-2748-1-git-send-email-oza.oza@broadcom.com>
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

this patch fixes the bug in of_dma_get_range, which with as is,
parses the PCI memory ranges and return wrong size as 0.

in order to get largest possible dma_mask. this patch also
retuns the largest possible size based on dma-ranges,

for e.g.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
we should get dev->coherent_dma_mask=0x7fffffffff.

based on which IOVA allocation space will honour PCI host
bridge limitations.

the implementation hooks bus specific callbacks for getting
dma-ranges.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903..cc0fc28 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -6,6 +6,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -46,6 +47,8 @@ struct of_bus {
 				int na, int ns, int pna);
 	int		(*translate)(__be32 *addr, u64 offset, int na);
 	unsigned int	(*get_flags)(const __be32 *addr);
+	int		(*get_dma_ranges)(struct device_node *np,
+					  u64 *dma_addr, u64 *paddr, u64 *size);
 };
 
 /*
@@ -171,6 +174,146 @@ static int of_bus_pci_translate(__be32 *addr, u64 offset, int na)
 {
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
+
+static int of_bus_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr,
+				     u64 *paddr, u64 *size)
+{
+	struct device_node *node = of_node_get(np);
+	int ret = 0;
+	struct resource_entry *window;
+	LIST_HEAD(res);
+
+	if (!node)
+		return -EINVAL;
+
+	if (of_bus_pci_match(np)) {
+		*size = 0;
+		/*
+		 * PCI dma-ranges is not mandatory property.
+		 * many devices do no need to have it, since
+		 * host bridge does not require inbound memory
+		 * configuration or rather have design limitations.
+		 * so we look for dma-ranges, if missing we
+		 * just return the caller full size, and also
+		 * no dma-ranges suggests that, host bridge allows
+		 * whatever comes in, so we set dma_addr to 0.
+		 */
+		ret = of_pci_get_dma_ranges(np, &res);
+		if (!ret) {
+			resource_list_for_each_entry(window, &res) {
+			struct resource *res_dma = window->res;
+
+			if (*size < resource_size(res_dma)) {
+				*dma_addr = res_dma->start - window->offset;
+				*paddr = res_dma->start;
+				*size = resource_size(res_dma);
+				}
+			}
+		}
+		pci_free_resource_list(&res);
+
+		/*
+		 * return the largest possible size,
+		 * since PCI master allows everything.
+		 */
+		if (*size == 0) {
+			pr_debug("empty/zero size dma-ranges found for node(%s)\n",
+				np->full_name);
+			*size = DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1;
+			*dma_addr = *paddr = 0;
+			ret = 0;
+		}
+
+		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
+			 *dma_addr, *paddr, *size);
+	}
+
+	of_node_put(node);
+
+	return ret;
+}
+
+static int get_dma_ranges(struct device_node *np, u64 *dma_addr,
+		          u64 *paddr, u64 *size)
+{
+	struct device_node *node = of_node_get(np);
+	const __be32 *ranges = NULL;
+	int len, naddr, nsize, pna;
+	int ret = 0;
+	u64 dmaaddr;
+
+	if (!node)
+		return -EINVAL;
+
+	while (1) {
+		naddr = of_n_addr_cells(node);
+		nsize = of_n_size_cells(node);
+		node = of_get_next_parent(node);
+		if (!node)
+			break;
+
+		ranges = of_get_property(node, "dma-ranges", &len);
+
+		/* Ignore empty ranges, they imply no translation required */
+		if (ranges && len > 0)
+			break;
+
+		/*
+		 * At least empty ranges has to be defined for parent node if
+		 * DMA is supported
+		 */
+		if (!ranges)
+			break;
+	}
+
+	if (!ranges) {
+		pr_debug("no dma-ranges found for node(%s)\n", np->full_name);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	len /= sizeof(u32);
+
+	pna = of_n_addr_cells(node);
+
+	/* dma-ranges format:
+	 * DMA addr	: naddr cells
+	 * CPU addr	: pna cells
+	 * size		: nsize cells
+	 */
+	dmaaddr = of_read_number(ranges, naddr);
+	*paddr = of_translate_dma_address(np, ranges);
+	if (*paddr == OF_BAD_ADDR) {
+		pr_err("translation of DMA address(%pad) to CPU address failed node(%s)\n",
+		       dma_addr, np->full_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	*dma_addr = dmaaddr;
+
+	*size = of_read_number(ranges + naddr + pna, nsize);
+
+	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
+		 *dma_addr, *paddr, *size);
+
+out:
+	of_node_put(node);
+
+	return ret;
+}
+
+static int of_bus_isa_get_dma_ranges(struct device_node *np, u64 *dma_addr,
+				     u64 *paddr, u64 *size)
+{
+	return get_dma_ranges(np, dma_addr, paddr, size);
+}
+
+static int of_bus_default_get_dma_ranges(struct device_node *np, u64 *dma_addr,
+					 u64 *paddr, u64 *size)
+{
+	return get_dma_ranges(np, dma_addr, paddr, size);
+}
+
 #endif /* CONFIG_OF_ADDRESS_PCI */
 
 #ifdef CONFIG_PCI
@@ -424,6 +567,7 @@ static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 		.map = of_bus_pci_map,
 		.translate = of_bus_pci_translate,
 		.get_flags = of_bus_pci_get_flags,
+		.get_dma_ranges = of_bus_pci_get_dma_ranges,
 	},
 #endif /* CONFIG_OF_ADDRESS_PCI */
 	/* ISA */
@@ -435,6 +579,7 @@ static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 		.map = of_bus_isa_map,
 		.translate = of_bus_isa_translate,
 		.get_flags = of_bus_isa_get_flags,
+		.get_dma_ranges = of_bus_isa_get_dma_ranges,
 	},
 	/* Default */
 	{
@@ -445,6 +590,7 @@ static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 		.map = of_bus_default_map,
 		.translate = of_bus_default_translate,
 		.get_flags = of_bus_default_get_flags,
+		.get_dma_ranges = of_bus_default_get_dma_ranges,
 	},
 };
 
@@ -820,74 +966,20 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
  *	size			: nsize cells
  *
  * It returns -ENODEV if "dma-ranges" property was not found
- * for this device in DT.
+ * for this device in DT, except if PCI device then, dma-ranges
+ * can be optional property, and in that case returns size with
+ * entire host memory.
  */
 int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
 {
-	struct device_node *node = of_node_get(np);
-	const __be32 *ranges = NULL;
-	int len, naddr, nsize, pna;
-	int ret = 0;
-	u64 dmaaddr;
-
-	if (!node)
-		return -EINVAL;
-
-	while (1) {
-		naddr = of_n_addr_cells(node);
-		nsize = of_n_size_cells(node);
-		node = of_get_next_parent(node);
-		if (!node)
-			break;
-
-		ranges = of_get_property(node, "dma-ranges", &len);
-
-		/* Ignore empty ranges, they imply no translation required */
-		if (ranges && len > 0)
-			break;
-
-		/*
-		 * At least empty ranges has to be defined for parent node if
-		 * DMA is supported
-		 */
-		if (!ranges)
-			break;
-	}
-
-	if (!ranges) {
-		pr_debug("no dma-ranges found for node(%s)\n", np->full_name);
-		ret = -ENODEV;
-		goto out;
-	}
-
-	len /= sizeof(u32);
-
-	pna = of_n_addr_cells(node);
-
-	/* dma-ranges format:
-	 * DMA addr	: naddr cells
-	 * CPU addr	: pna cells
-	 * size		: nsize cells
-	 */
-	dmaaddr = of_read_number(ranges, naddr);
-	*paddr = of_translate_dma_address(np, ranges);
-	if (*paddr == OF_BAD_ADDR) {
-		pr_err("translation of DMA address(%pad) to CPU address failed node(%s)\n",
-		       dma_addr, np->full_name);
-		ret = -EINVAL;
-		goto out;
-	}
-	*dma_addr = dmaaddr;
-
-	*size = of_read_number(ranges + naddr + pna, nsize);
-
-	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
-		 *dma_addr, *paddr, *size);
+	struct of_bus *bus;
 
-out:
-	of_node_put(node);
+	/* get bus specific dma-ranges. */
+	bus = of_match_bus(np);
+	if (bus->get_dma_ranges)
+		return bus->get_dma_ranges(np, dma_addr, paddr, size);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_get_range);
 
-- 
1.9.1
