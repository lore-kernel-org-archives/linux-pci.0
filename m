Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60330 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757064AbbCCSAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Mar 2015 13:00:36 -0500
Message-ID: <54F5F698.6000604@ti.com>
Date: Tue, 3 Mar 2015 12:59:52 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v1] of: calculate masks of the device based on dma-range
 size
References: <1423677215-28968-1-git-send-email-m-karicheri2@ti.com> <20150226002033.GR6220@google.com>
In-Reply-To: <20150226002033.GR6220@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/25/2015 07:20 PM, Bjorn Helgaas wrote:
> [+cc Catalin]
>
> On Wed, Feb 11, 2015 at 12:53:35PM -0500, Murali Karicheri wrote:
>> This patch update of_dma_configure() API to calculate the
>> masks (dma_mask and coherent_dma_mask) based on the dma-range
>> values set in DT for the device. Also limit the mask to lower
>> of the default mask and mask calculated.
>>
>> Cc: Joerg Roedel<joro@8bytes.org>
>> Cc: Grant Likely<grant.likely@linaro.org>
>> Cc: Rob Herring<robh+dt@kernel.org>
>> Cc: Bjorn Helgaas<bhelgaas@google.com>
>> Cc: Will Deacon<will.deacon@arm.com>
>> Cc: Russell King<linux@arm.linux.org.uk>
>> Cc: Arnd Bergmann<arnd@arndb.de>
>> Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
>>
>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>
> Applied with Catalin's reviewed-by to pci/iommu for v4.1, thanks!
Bjorn,

Could you point me to this? I didn't see it on pci/iommu of your repo below.

arm-pci	git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 
(fetch)

a0868495@ula0868495 ~/Project/linux-keystone $ gitlog arm-pci/pci/iommu
dd8a11b0f0d4ed0ad87c8d09e650f354021d7953 arm: dma-mapping: limit IOMMU 
mapping size
2a101e79dcd8733e3a353b0df2fa384980f94e1e PCI: Update DMA configuration 
from DT
3fd29d06e9aa92d9a4513e14b2dd3f0d69d4d2b7 of/pci: Add 
of_pci_dma_configure() to update DMA configuration
8243352097c468f982a9f386cb1f455672b473a2 PCI: Add helper functions 
pci_get[put]_host_bridge_device()
039f346ac880d4f894425ef6c540f3ff5c1b8dcf of: Fix size when dma-range is 
not used
2743a957f6a6317be06d02cc93d78bb2a847e427 of: Move of_dma_configure() to 
device.c to help re-use
f454cd01b5bdffb1bf26a5cddac30439fa5f27a1 of: iommu: Add ptr to OF node 
arg to of_iommu_configure()
c517d838eb7d07bbe9507871fab3931deccff539 Linux 4.0-rc1

Murali

>
> I agree with Catalin's comment about the "size = 1ULL<<  32" line.
> I don't see how that will make a difference, so I dropped it.  The
> patch I merged is below.  Let me know if you think we do need that
> line or any other tweaks.
>
> Bjorn
>
> commit a5a1dd69080dfcf53bfd6e179f3db68e824aeaae
> Author: Murali Karicheri<m-karicheri2@ti.com>
> Date:   Wed Feb 25 17:21:04 2015 -0600
>
>      of: Calculate device DMA masks based on DT dma-range size
>
>      Calculate the dma_mask and coherent_dma_mask based on the dma-range values
>      set in DT for the device.
>
>      Limit the mask to lower of the default mask and mask calculated.
>
>      Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>      Signed-off-by: Bjorn Helgaas<bhelgaas@google.com>
>      Reviewed-by: Catalin Marinas<catalin.marinas@arm.com>
>      CC: Joerg Roedel<joro@8bytes.org>
>      CC: Grant Likely<grant.likely@linaro.org>
>      CC: Rob Herring<robh+dt@kernel.org>
>      CC: Will Deacon<will.deacon@arm.com>
>      CC: Russell King<linux@arm.linux.org.uk>
>      CC: Arnd Bergmann<arnd@arndb.de>
>      CC: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 28e743888402..20c1332a0018 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -90,10 +90,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>   	struct iommu_ops *iommu;
>
>   	/*
> -	 * Set default dma-mask to 32 bit.  Drivers are expected to setup
> -	 * the correct supported dma_mask.
> +	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> +	 * setup the correct supported mask.
>   	 */
> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!dev->coherent_dma_mask)
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
>
>   	/*
>   	 * Set it to coherent_dma_mask by default if the architecture
> @@ -128,6 +129,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>
>   	dev->dma_pfn_offset = offset;
>
> +	/*
> +	 * Limit coherent and dma mask based on size and default mask
> +	 * set by the driver.
> +	 */
> +	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
> +				     DMA_BIT_MASK(ilog2(dma_addr + size)));
> +	*dev->dma_mask = min((*dev->dma_mask),
> +			     DMA_BIT_MASK(ilog2(dma_addr + size)));
> +
>   	coherent = of_dma_is_coherent(np);
>   	dev_dbg(dev, "device is%sdma coherent\n",
>   		coherent ? " " : " not ");


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
