Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH 2/3] iommu/dma: account pci host bridge dma_mask for IOVA
 allocation
Date: Sat, 25 Mar 2017 11:01:32 +0530
Message-Id: <1490419893-5073-2-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
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

this patch is inspired by
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1306545.html
http://www.spinics.net/lists/arm-kernel/msg566947.html

but above inspiraiton solves the half of the problem.
the rest of the problem is descrbied below, what we face on iproc based
SOCs.

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

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8c7c244..20cfff7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -217,6 +217,9 @@ config NEED_DMA_MAP_STATE
 config NEED_SG_DMA_LENGTH
 	def_bool y
 
+config ARCH_HAS_DMA_SET_COHERENT_MASK
+	def_bool y
+
 config SMP
 	def_bool y
 
diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 73d5bab..64b4dc3 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -20,6 +20,7 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void *iommu;			/* private IOMMU data */
 #endif
+	u64 parent_dma_mask;
 	bool dma_coherent;
 };
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 81cdb2e..5845ecd 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -564,6 +564,7 @@ static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 	__dma_flush_area(virt, PAGE_SIZE);
 }
 
+
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
 				 unsigned long attrs)
@@ -795,6 +796,20 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
 }
 
+static int __iommu_set_dma_mask(struct device *dev, u64 mask)
+{
+	/* device is not DMA capable */
+	if (!dev->dma_mask)
+		return -EIO;
+
+	if (mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.alloc = __iommu_alloc_attrs,
 	.free = __iommu_free_attrs,
@@ -811,8 +826,21 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	.map_resource = iommu_dma_map_resource,
 	.unmap_resource = iommu_dma_unmap_resource,
 	.mapping_error = iommu_dma_mapping_error,
+	.set_dma_mask = __iommu_set_dma_mask,
 };
 
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (get_dma_ops(dev) == &iommu_dma_ops &&
+	    mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
+
+	dev->coherent_dma_mask = mask;
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_coherent_mask);
+
+
 /*
  * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
  * everything it needs to - the device is only partially created and the
@@ -975,6 +1003,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (!dev->dma_ops)
 		dev->dma_ops = &swiotlb_dma_ops;
 
+	dev->archdata.parent_dma_mask = size - 1;
+
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 }
diff --git a/drivers/of/device.c b/drivers/of/device.c
index d362a98..471dcdf 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -139,10 +139,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
-				     DMA_BIT_MASK(ilog2(dma_addr + size)));
-	*dev->dma_mask = min((*dev->dma_mask),
-			     DMA_BIT_MASK(ilog2(dma_addr + size)));
+	dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
+	*dev->dma_mask = dev->coherent_dma_mask;
 
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
