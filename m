Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 27 Mar 2017 18:33:14 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
Message-ID: <20170327173314.GA17035@red-moon>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
 <db3d68f8-713c-9ae2-7df9-324bc1b375b1@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA81750CCC4@lhreml504-mbs>
 <f67fb561-4238-6933-04f3-0f910f9232d1@arm.com>
MIME-Version: 1.0
In-Reply-To: <f67fb561-4238-6933-04f3-0f910f9232d1@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "tn@semihalf.com" <tn@semihalf.com>, Sricharan R <sricharan@codeaurora.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 27, 2017 at 05:18:15PM +0100, Robin Murphy wrote:

[...]

> >> [  145.212351] iommu: Adding device 0000:81:10.0 to group 5
> >> [  145.212367] ixgbevf 0000:81:10.0: 0x0 0x100000000, 0x0 0xffffffffffff,
> >> 0xffffffff 0xffffffff
> >> [  145.213261] ixgbevf 0000:81:10.0: enabling device (0000 -> 0002)
> >> [  145.213394] ixgbe 0000:81:00.0 eth0: VF Reset msg received from vf 0
> >> [  145.214272] ixgbe 0000:81:00.0: VF 0 has no MAC address assigned, you
> >> may have to assign one manually
> >> [  145.224379] ixgbevf 0000:81:10.0: MAC address not assigned by
> >> administrator.
> >> [  145.224384] ixgbevf 0000:81:10.0: Assigning random MAC address
> >> [  145.225941] ixgbevf 0000:81:10.0: 1a:85:06:48:a7:19
> >> [  145.225944] ixgbevf 0000:81:10.0: MAC: 1
> >> [  145.225946] ixgbevf 0000:81:10.0: Intel(R) 82599 Virtual Function
> >> [  145.299961] ixgbe 0000:81:00.0 eth0: NIC Link is Up 1 Gbps, Flow Control:
> >> None
> >> [  154.947742] nfs: server 172.18.45.166 not responding, still trying
> >> [  191.025780] nfs: server 172.18.45.166 not responding, still trying
> >> [  191.026122] nfs: server 172.18.45.166 OK
> >> [  191.026317] nfs: server 172.18.45.166 OK
> >> [  263.706402] VFIO - User Level meta-driver version: 0.3
> >> [  269.757613] vfio-pci 0000:81:10.0: 0x0 0x0, 0x0 0xffffffffffff, 0xffffffffffffffff
> >> 0xffffffffffffffff
> >> [  269.757617] specified DMA range outside IOMMU capability
> >> [  269.757618] Failed to set up IOMMU for device 0000:81:10.0; retaining
> >> platform DMA ops
> >>
> >>  From the logs its clear that  when ixgbevf driver originally probes and adds
> >> the device
> >>  to smmu  the dma mask is 32, but when it binds to vfio-pci, it becomes 64 bit.
> > 
> > Just to add to that, the mask is set to 64 bit in the ixgebvf driver probe[1]
> 
> Aha, but of course it's still the same struct device getting bound to
> VFIO later, so whatever mask the first driver set is still in there when
> we go through of_dma_configure() the second time (and the fact that we
> go through more than once being the new behaviour). So yes, this is a
> legitimate problem and we really do need to be robust against size
> overflow. I reckon the below tweak of your fix is probably the way to
> go; cleaning up the arch_setup_dma_ops() interface can happen later.

Yes. On ACPI the additional issue is, given that we now call
*_dma_configure multiple times, we end up adding the _same_ stream
id to an existing fwspec ids array which triggers the SMMUv3 driver bug,
because we try to configure the same id twice (it does not happen
in DT since you have a check similar to the one I added below).

ACPI fix(es) below please let me know if it actually fixes the issues:

-- >8 --
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 36a9abf..e7b1940 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -543,6 +543,14 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 	const struct iommu_ops *ops = NULL;
 	int ret = -ENODEV;
 	struct fwnode_handle *iort_fwnode;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+
+	/*
+	 * If we already translated the fwspec there
+	 * is nothing left to do, return the iommu_ops.
+	 */
+	if (fwspec && fwspec->ops)
+		return fwspec->ops;
 
 	if (node) {
 		iort_fwnode = iort_get_fwnode(node);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 823b005..2a513cc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1376,18 +1376,20 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 {
 	const struct iommu_ops *iommu;
+	u64 size;
 
 	iort_set_dma_mask(dev);
 
 	iommu = iort_iommu_configure(dev);
 	if (IS_ERR(iommu))
 		return PTR_ERR(iommu);
+
+	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	/*
 	 * Assume dma valid range starts at 0 and covers the whole
 	 * coherent_dma_mask.
 	 */
-	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
-			   attr == DEV_DMA_COHERENT);
+	arch_setup_dma_ops(dev, 0, size, iommu, attr == DEV_DMA_COHERENT);
 
 	return 0;
 }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
