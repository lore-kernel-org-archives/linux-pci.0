Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <d9d33133-859a-0189-76c1-c3ec3abdaed6@codeaurora.org>
Date: Fri, 24 Mar 2017 18:20:13 +0530
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shameer,


>>> [  414.700493] specified DMA range outside IOMMU capability
>> <-- error here
>>> [  414.700496] Failed to set up IOMMU for device 0002:81:10.0; retaining
>> platform DMA ops        <-- error here
>>
>> Looks like this triggers the start of the bug.
>> So the below check in iommu_dma_init_domain fails,
>>
>>          if (domain->geometry.force_aperture) {
>>                  if (base > domain->geometry.aperture_end ||
>>                      base + size <= domain->geometry.aperture_start) {
>>
>> and the rest goes out of sync after that. Can you print out the base,
>> aperture_start and end values to see why the check fails ?
>
> dev_info(dev, "0x%llx 0x%llx, 0x%llx 0x%llx, 0x%llx 0x%llx\n", base, size, domain->geometry.aperture_start, domain->geometry.aperture_end, *dev->dma_mask, dev->coherent_dma_mask);
>
> [  183.752100] ixgbevf 0000:81:10.0: 0x0 0x100000000, 0x0 0xffffffffffff, 0xffffffff 0xffffffff
> .....
> [  319.508037] vfio-pci 0000:81:10.0: 0x0 0x0, 0x0 0xffffffffffff, 0xffffffffffffffff 0xffffffffffffffff
>
> Yes, size seems to be the problem here. When the VF  device gets attached to vfio-pci,
> somehow the dev->coherent_dma_mask is set to 64 bits and size become zero.
>
> @@ -107,7 +107,7 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>   	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>   	if (ret < 0) {
>   		dma_addr = offset = 0;
>  -		size = ';
>  +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>

But without this series, size is still set as
dev->coherent_dma_mask + 1 , somehow not sure how it works
fine in that case ?

I remember i had this change in the V7 patchset, but later
dropped it for the reason that this change is not relevant
for this series, but should be there/sent to address the 64bit
overflow separately.

> @@ -1386,7 +1387,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>   	 * Assume dma valid range starts at 0 and covers the whole
>   	 * coherent_dma_mask.
>   	 */
>  -	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
>  +	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  +	arch_setup_dma_ops(dev, 0, size, iommu,
>   			   attr == DEV_DMA_COHERENT);
>
> With the above fixes, DT boot works fine. But we still get the below crash on ACPI
>
>>> [  402.581445] kernel BUG at drivers/iommu/arm-smmu-v3.c:1064!

Looks like this happens when the ste_live becomes true during
the initial attach, but later without an detach,
attach once again happens from vfio. Just thinking why the
detach_dev is not happening only in ACPI case. Actually not
having any of arm-smmuv3 or ACPI based setup in my place.
Can i get some help by having some logs from the arm-smmv3
driver ?

>>> [  402.587007] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>> [  402.592479] Modules linked in: vfio_iommu_type1 vfio_pci irqbypass
>> vfio_virqfd vfio ixgbevf ixgb
>
>> The change that this series does is trying to add the dma/iommu ops to the
>> device after the iommu is actually probed.
>> So in your working case, does the device initially gets hooked to iommu_ops
>> and the above same check passes in working case ?
>
> I believe so. Because didn't notice the "specified DMA range outside IOMMU capability"
> in the working case.

ok, as i said above not sure why the overflow does not affect without
this series.

Regards,
  Sricharan


>
> Thanks,
> Shameer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
