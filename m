Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45162 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab2LEHSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Dec 2012 02:18:18 -0500
Message-ID: <1354691878.2351.2.camel@pasglop>
Subject: Re: [linuxppc-release][PATCH] powerpc/pci-hotplug: fix init issue
 of rescanned pci device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuanquan Chen <B41889@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org,
	r61911@freescale.com, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 05 Dec 2012 18:17:58 +1100
In-Reply-To: <1354674717-14426-1-git-send-email-B41889@freescale.com>
References: <1354674717-14426-1-git-send-email-B41889@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-12-05 at 10:31 +0800, Yuanquan Chen wrote:
> On powerpc arch, some fixup work of PCI/PCI-e device is just done during the
> first scan at booting time. For the PCI/PCI-e device rescanned after linux OS
> booting up, the fixup work won't be done, which leads to dma_set_mask error or
> irq related issue in rescanned PCI/PCI-e device's driver. So, it does the same
> fixup work for the rescanned device to avoid this issue.

Hrm, the patch is a bit gross. First the code shouldn't be copy/pasted
that way but factored out.

I'm surprised also that is_added is false when pcibios_enable_device()
gets called ... that looks strange to me. At what point is that enable
happening in the hotplug sequence ?

How do you trigger the rescan anyway ?

I think the problem needs to be solve at a higher level, I'm adding
linux-pci & Bjorn to the CC list.

Cheers,
Ben.

> Signed-off-by: Yuanquan Chen <B41889@freescale.com>
> ---
>  arch/powerpc/kernel/pci-common.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 7f94f76..f0fb070 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1496,6 +1496,26 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  		if (ppc_md.pcibios_enable_device_hook(dev))
>  			return -EINVAL;
>  
> +	if (!dev->is_added) {
> +		/* 
> +		 * Fixup NUMA node as it may not be setup yet by the generic
> +		 * code and is needed by the DMA init
> +		 */
> +		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
> +
> +		/* Hook up default DMA ops */
> +		set_dma_ops(&dev->dev, pci_dma_ops);
> +		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
> +
> +		/* Additional platform DMA/iommu setup */
> +		if (ppc_md.pci_dma_dev_setup)
> +			ppc_md.pci_dma_dev_setup(dev);
> +
> +		/* Read default IRQs and fixup if necessary */
> +		pci_read_irq_line(dev);
> +		if (ppc_md.pci_irq_fixup)
> +			ppc_md.pci_irq_fixup(dev);
> +	}
>  	return pci_enable_resources(dev, mask);
>  }
>  


