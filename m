Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH 1/3] of/pci: dma-ranges to account highest possible host
 bridge dma_mask
Date: Sat, 25 Mar 2017 11:01:31 +0530
Message-Id: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 bcm-kernel-feedback-list@broadcom.com, Oza Pawandeep <oza.oza@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

it is possible that PCI device supports 64-bit DMA addressing,
and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
however PCI host bridge may have limitations on the inbound
transaction addressing. As an example, consider NVME SSD device
connected to iproc-PCIe controller.

Currently, the IOMMU DMA ops only considers PCI device dma_mask
when allocating an IOVA. This is particularly problematic on
ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to
PA for in-bound transactions only after PCI Host has forwarded
these transactions on SOC IO bus. This means on such ARM/ARM64
SOCs the IOVA of in-bound transactions has to honor the addressing
restrictions of the PCI Host.

current pcie frmework and of framework integration assumes dma-ranges
in a way where memory-mapped devices define their dma-ranges.
dma-ranges: (child-bus-address, parent-bus-address, length).

but iproc based SOCs and even Rcar based SOCs has PCI world dma-ranges.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;

of_dma_configure is specifically witten to take care of memory mapped devices.
but no implementation exists for pci to take care of pcie based memory ranges.
in fact pci world doesnt seem to define standard dma-ranges

this patch implements of_pci_get_dma_ranges to cater to pci world dma-ranges.
so then the returned size get best possible (largest) dma_mask.
for e.g.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
we should get dev->coherent_dma_mask=0x7fffffffff.

Reviewed-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/of/device.c b/drivers/of/device.c
index b1e6beb..d362a98 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/of_pci.h>
 
 #include <asm/errno.h>
 #include "of_private.h"
@@ -104,7 +105,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	if (!dev->dma_mask)
 		dev->dma_mask = &dev->coherent_dma_mask;
 
-	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	if (dev_is_pci(dev))
+		ret = of_pci_get_dma_ranges(np, &dma_addr, &paddr, &size);
+	else
+		ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+
 	if (ret < 0) {
 		dma_addr = offset = 0;
 		size = dev->coherent_dma_mask + 1;
diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 0ee42c3..c7f8626 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -283,6 +283,52 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
+
+int of_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
+{
+	struct device_node *node = of_node_get(np);
+	int rlen, ret = 0;
+	const int na = 3, ns = 2;
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+
+	if (!node)
+		return -EINVAL;
+
+	parser.node = node;
+	parser.pna = of_n_addr_cells(node);
+	parser.np = parser.pna + na + ns;
+
+	parser.range = of_get_property(node, "dma-ranges", &rlen);
+
+	if (!parser.range) {
+		pr_debug("pcie device has no dma-ranges defined for node(%s)\n", np->full_name);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	parser.end = parser.range + rlen / sizeof(__be32);
+	*size = 0;
+
+	for_each_of_pci_range(&parser, &range) {
+		if (*size < range.size) {
+			*dma_addr = range.pci_addr;
+			*size = range.size;
+			*paddr = range.cpu_addr;
+		}
+	}
+
+	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
+		 *dma_addr, *paddr, *size);
+		 *dma_addr = range.pci_addr;
+		 *size = range.size;
+
+out:
+	of_node_put(node);
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
 #endif /* CONFIG_OF_ADDRESS */
 
 #ifdef CONFIG_PCI_MSI
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 0e0974e..907ace0 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -76,6 +76,7 @@ static inline void of_pci_check_probe_only(void) { }
 int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
+int of_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size);
 #else
 static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
@@ -83,6 +84,11 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 {
 	return -EINVAL;
 }
+
+static inline int of_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
