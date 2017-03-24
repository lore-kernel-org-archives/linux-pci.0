Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH V9 00/11] IOMMU probe deferral support
Date: Fri, 24 Mar 2017 15:09:49 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA81750BC12@lhreml504-mbs>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
 <20170324144340.GA17560@red-moon>
In-Reply-To: <20170324144340.GA17560@red-moon>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Sricharan R <sricharan@codeaurora.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: Friday, March 24, 2017 2:44 PM
> To: Shameerali Kolothum Thodi
> Cc: Sricharan R; Wangzhou (B); robin.murphy@arm.com;
> will.deacon@arm.com; joro@8bytes.org; iommu@lists.linux-foundation.org;
> linux-arm-kernel@lists.infradead.org; linux-arm-msm@vger.kernel.org;
> m.szyprowski@samsung.com; bhelgaas@google.com; linux-
> pci@vger.kernel.org; linux-acpi@vger.kernel.org; tn@semihalf.com;
> hanjun.guo@linaro.org; okaya@codeaurora.org
> Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
> 
> On Fri, Mar 24, 2017 at 09:27:51AM +0000, Shameerali Kolothum Thodi wrote:
> 
> [...]
> 
> > @@ -107,7 +107,7 @@ int of_dma_configure(struct device *dev, struct
> device_node *np)
> >   	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> >   	if (ret < 0) {
> >   		dma_addr = offset = 0;
> >  -		size = dev->coherent_dma_mask + 1;
> >  +		size = max(dev->coherent_dma_mask, dev-
> >coherent_dma_mask + 1);
> >
> > @@ -1386,7 +1387,8 @@ int acpi_dma_configure(struct device *dev, enum
> dev_dma_attr attr)
> >   	 * Assume dma valid range starts at 0 and covers the whole
> >   	 * coherent_dma_mask.
> >   	 */
> >  -	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1,
> iommu,
> >  +	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask +
> 1);
> 
> size is not defined in acpi_dma_configure(), so there is something missing in
> the diff above, just to make sure we are testing the same thing.
> 
> Mind posting kernel logs with and without patch above (fixed) for DT boot
> and ACPI boot please.

Sure. We will rerun the tests to create the logs again and share.

Also need to double check, v9 patches are applied correctly on top of our branch.
If I remember correctly v7 was fine with DT(didn't test with ACPI). But then as 
Shicharan said it had that size fix.

Thanks,
Shameer
[...]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
