Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56672 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbbBEVnX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Feb 2015 16:43:23 -0500
Message-ID: <54D3E3C3.1040104@ti.com>
Date: Thu, 5 Feb 2015 16:42:27 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Robin Murphy <Robin.Murphy@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/6] of: fix size when dma-range is not used
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com> <1422052359-12384-4-git-send-email-m-karicheri2@ti.com> <54C77616.80301@arm.com> <54C7DF13.20402@ti.com> <20150128110523.GC6646@e104818-lin.cambridge.arm.com> <54C9068D.8050701@arm.com> <20150128173048.GE31752@e104818-lin.cambridge.arm.com> <54CBC823.3020905@ti.com> <20150202121843.GD22661@e104818-lin.cambridge.arm.com>
In-Reply-To: <20150202121843.GD22661@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/02/2015 07:18 AM, Catalin Marinas wrote:
> On Fri, Jan 30, 2015 at 06:06:27PM +0000, Murali Karicheri wrote:
>> On 01/28/2015 12:30 PM, Catalin Marinas wrote:
>>> I think we can remove this check altogether (we leaved without it for a
>>> while) but we need to add 1 when calculating the mask:
>>>
>>> 	dev->coherent_dma_mask = min(DMA_BIT_MASK(32),
>>> 				     DMA_BIT_MASK(ilog2(size + 1)));
>>>
>> For Keystone, the dma_addr is to be taken care as well to determine the
>> mask. The above will not work.
>
> This was discussed before (not on this thread) and dma_addr should not
> affect the mask, it only affects the pfn offset.
>
>> Based on the discussion so far, this is the function I have come up with
>> incorporating the suggestions. Please review this and see if I have
>> missed out any. This works fine on Keystone.
>>
>> void of_dma_configure(struct device *dev, struct device_node *np)
>> {
>> 	u64 dma_addr = 0, paddr, size;
>> 	int ret;
>> 	bool coherent;
>> 	unsigned long offset = 0;
>> 	struct iommu_ops *iommu;
>>
>> 	/*
>> 	 * Set default size to cover the 32-bit. Drivers are expected to setup
>> 	 * the correct size and dma_mask.
>>     	 */
>> 	size = 1ULL<<  32;
>>
>> 	ret = of_dma_get_range(np,&dma_addr,&paddr,&size);
>> 	if (!ret) {
>> 		offset = PFN_DOWN(paddr - dma_addr);
>> 		if (!size) {
>> 			dev_err(dev, "Invalid size (%llx)\n",
>> 				size);
>> 			return;
>> 		}
>> 		if (size&  1) {
>> 			size = size + 1;
>> 			dev_warn(dev, "Incorrect usage of size (%llx)\n",
>> 				 size);
>> 		}
>> 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>> 	}
>> 	dev->dma_pfn_offset = offset;
>>
>> 	/*
>> 	 * Coherent DMA masks larger than 32-bit must be explicitly set by the
>> 	 * driver.
>> 	 */
>> 	dev->coherent_dma_mask = min(DMA_BIT_MASK(32),
>> 				     DMA_BIT_MASK(ilog2(dma_addr + size)));
>
> That's not correct, coherent_dma_mask should still be calculated solely
> based on size, not dma_addr.
>
> Functions like swiotlb_dma_supported() use phys_to_dma() which on ARM
> (32-bit) subtracts the dma_pfn_offset, so the mask based on size works
> fine.
>
> In the arm64 tree, we haven't taken dma_pfn_offset into account for
> phys_to_dma() yet but if needed for a SoC, we'll add it.
>
Catalin,

The size based dma mask calculation itself can be a separate topic 
patch. This series is adding important fix to get the PCI driver 
functional and I would like to get this merged as soon as possible. I 
also want to hear from Arnd about yout comment as we had discussed this 
in the initial discussion of this patch series and 8/8 is essentially 
added based on that discussion. I will add a simple check to catch and 
warn the incorrect size setting in DT for dma-range as suggested by Rob 
Herring and create a new patch to for size based mask calculation. I 
will be sending v6 (expected to be merged soon) today and will work to 
add a new patch. Before that we need to agree on what is the content of 
the patch.

1. On keystone, DMA address start at 0x8000_0000 and DMA-able memory is 
2G from the above base address. So without taking into account the 
dma_addr, mask calculated will be 0x7fff_ffff where as we need that to 
be 0xffff_ffff for keystone. So need to use this in the calculation.

2. W.r.t arm_pfn_offset, this was added to support Keystone as the DDR 
physical address for LPAE startes at 0x8_0000_0000 and the pfn offset is 
calculated as the PFN of (0x8_0000_0000 - 0x8000_0000) to do the dma 
address to DDR address translation. I haven't looked at 
swiotlb_dma_supported() but will do so.

Murali



-- 
Murali Karicheri
Linux Kernel, Texas Instruments
