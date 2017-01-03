Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
Date: Wed, 04 Jan 2017 00:13:16 +0100
Message-ID: <5224989.KFLmAz9Gqk@wuerfel>
In-Reply-To: <20170103184444.GP6986@arm.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170103184444.GP6986@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, artemi.ivanov@cogentembedded.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 3, 2017 6:44:44 PM CET Will Deacon wrote:
> > @@ -347,6 +348,16 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
> >  
> >  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
> >  {
> > +#ifdef CONFIG_PCI
> > +     if (dev_is_pci(hwdev)) {
> > +             struct pci_dev *pdev = to_pci_dev(hwdev);
> > +             struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
> > +
> > +             if (br->dev.dma_mask && (*br->dev.dma_mask) &&
> > +                             (mask & (*br->dev.dma_mask)) != mask)
> > +                     return 0;
> > +     }
> > +#endif
> 
> Hmm, but this makes it look like the problem is both arm64 and swiotlb
> specific, when in reality it's not. Perhaps another hack you could try
> would be to register a PCI bus notifier in the host bridge looking for
> BUS_NOTIFY_BIND_DRIVER, then you could proxy the DMA ops for each child
> device before the driver has probed, but adding a dma_set_mask callback
> to limit the mask to what you need?
> 
> I agree that it would be better if dma_set_mask handled all of this
> transparently, but it's all based on the underlying ops rather than the
> bus type.

This is what I prototyped a long time ago when this first came up.
I still think this needs to be solved properly for all of arm64, not
with a PCI specific hack, and in particular not using notifiers.

	Arnd

commit 9a57d58d116800a535510053136c6dd7a9c26e25
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Nov 17 14:06:55 2015 +0100

    [EXPERIMENTAL] ARM64: check implement dma_set_mask
    
    Needs work for coherent mask
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 243ef256b8c9..a57e7bb10e71 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -22,6 +22,7 @@ struct dev_archdata {
 	void *iommu;			/* private IOMMU data */
 #endif
 	bool dma_coherent;
+	u64 parent_dma_mask;
 };
 
 struct pdev_archdata {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 290a84f3351f..aa65875c611b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -352,6 +352,31 @@ static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return 1;
 }
 
+static int __swiotlb_set_dma_mask(struct device *dev, u64 mask)
+{
+	/* device is not DMA capable */
+	if (!dev->dma_mask)
+		return -EIO;
+
+	/* mask is below swiotlb bounce buffer, so fail */
+	if (!swiotlb_dma_supported(dev, mask))
+		return -EIO;
+
+	/*
+	 * because of the swiotlb, we can return success for
+	 * larger masks, but need to ensure that bounce buffers
+	 * are used above parent_dma_mask, so set that as
+	 * the effective mask.
+	 */
+	if (mask > dev->archdata.parent_dma_mask)
+		mask = dev->archdata.parent_dma_mask;
+
+
+	*dev->dma_mask = mask;
+
+	return 0;
+}
+
 static struct dma_map_ops swiotlb_dma_ops = {
 	.alloc = __dma_alloc,
 	.free = __dma_free,
@@ -367,6 +392,7 @@ static struct dma_map_ops swiotlb_dma_ops = {
 	.sync_sg_for_device = __swiotlb_sync_sg_for_device,
 	.dma_supported = __swiotlb_dma_supported,
 	.mapping_error = swiotlb_dma_mapping_error,
+	.set_dma_mask = __swiotlb_set_dma_mask,
 };
 
 static int __init atomic_pool_init(void)
@@ -957,6 +983,18 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (!dev->archdata.dma_ops)
 		dev->archdata.dma_ops = &swiotlb_dma_ops;
 
+	/*
+	 * we don't yet support buses that have a non-zero mapping.
+	 *  Let's hope we won't need it
+	 */
+	WARN_ON(dma_base != 0);
+
+	/*
+	 * Whatever the parent bus can set. A device must not set
+	 * a DMA mask larger than this.
+	 */
+	dev->archdata.parent_dma_mask = size;
+
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 }


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
