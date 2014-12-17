Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63349 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaLQV46 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Dec 2014 16:56:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Murali Karicheri <m-karicheri2@ti.com>, gregkh@linuxfoundation.org,
	vinod.koul@intel.com, dmaengine@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] common: dma-mapping: introduce dma_get_parent_cfg() helper
Date: Wed, 17 Dec 2014 22:56:47 +0100
Message-ID: <1949667.gMcOLHe7Sk@wuerfel>
In-Reply-To: <1418839344-14393-2-git-send-email-m-karicheri2@ti.com>
References: <1418839344-14393-1-git-send-email-m-karicheri2@ti.com> <1418839344-14393-2-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 17 December 2014 13:02:23 Murali Karicheri wrote:
> Now, in Kernel, parent device's DMA parameters has to be applied to
> the child as is - to enable DMA support for the device. Usually this
> is happened in places where parent device manually instantiates child
> device such as in drivers/pci/probe.c (pci_device_add() for example).
> 
> Now DMA configuration is represented in device data structure not only
> by DMA mask and DMA params, it also includes dma_pfn_offset at least.
> Hence introduce common dma_get_parent_cfg() helper to apply dma
> configuration from parent to child, and use __weak to allow arch to
> override it if needed.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/base/dma-mapping.c  |   18 ++++++++++++++++++
>  include/linux/dma-mapping.h |    3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index 9e8bbdd..5322426 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -339,3 +339,21 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
>  	vunmap(cpu_addr);
>  }
>  #endif
> +
> +int __weak dma_get_parent_cfg(struct device *dev, struct device *parent)
> +{
> +	struct device *temp = parent;
> +
> +	if (!temp)
> +		temp = dev->parent;
> +
> +	if (temp && is_device_dma_capable(temp)) {
> +		dev->dma_mask	= temp->dma_mask;
> +		dev->coherent_dma_mask = temp->coherent_dma_mask;

As discussed, setting the pointers like this is always wrong,
so don't do it.

What's wrong with using arch_setup_dma_ops() from PCI as suggested
previously?

	Arnd
