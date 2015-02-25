Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33032 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbBYBxW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 20:53:22 -0500
Received: by iecar1 with SMTP id ar1so1238131iec.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 17:53:21 -0800 (PST)
Date: Tue, 24 Feb 2015 19:53:17 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v6 6/7] PCI: update dma configuration from DT
Message-ID: <20150225015317.GO6220@google.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
 <1423173179-10227-7-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423173179-10227-7-git-send-email-m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 05, 2015 at 04:52:58PM -0500, Murali Karicheri wrote:
> If there is a DT node available for the root bridge's parent device,
> use the dma configuration from that device node. For example, keystone
> PCI devices would require dma_pfn_offset to be set correctly in the
> device structure of the pci device in order to have the correct dma mask.
> The DT node will have dma-ranges defined for this. Also support using
> the DT property dma-coherent to allow coherent DMA operation by the
> PCI device.

Hi Murali,

I'm guessing this is the patch that actually fixes things for Keystone.

And it looks like it should also fix things for other hardware that has
similar characteristics.  So I'd like to include some higher-level text
about that here.  For example:

  This fixes DMA on systems where DMA addresses are a constant offset
  from CPU physical addresses.

(I don't know exactly how these patches all fit together, so that's
probably not accurate, but that's the *sort* of thing I'd like to include.)

If that actually *is* what's going on, I have to wonder why this isn't
implemented as a very simple IOMMU instead of adding dma_pfn_offset,
which is present on all arches but only used on ARM.  In some sense that
offset is parallel but incompatible with an IOMMU: they both translate DMA
addresses into system RAM addresses.

I know you're not adding this, and I assume somebody explored that option
and rejected it for good reasons.  I just missed that discussion.

> This patch use the new helper function of_pci_dma_configure() to update
> the device dma configuration.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/pci/probe.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 23212f8..d7dcd6c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -6,6 +6,7 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -1520,6 +1521,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_mask = &dev->dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
> +	of_pci_dma_configure(dev);
>  
>  	pci_set_dma_max_seg_size(dev, 65536);
>  	pci_set_dma_seg_boundary(dev, 0xffffffff);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
