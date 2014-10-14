Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:58469 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506AbaJNSUv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 14:20:51 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn15so15754318igb.9
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 11:20:50 -0700 (PDT)
Date: Tue, 14 Oct 2014 12:20:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 04/18] Delayed powerpc setup of PCI IRQs to bus scan time
Message-ID: <20141014182048.GD10125@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-5-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-5-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:32AM +0100, matt@masarand.com wrote:
> From: Matthew Minter <matt@masarand.com>
> 
> The powerpc PCI init code is currently initialising PCI device IRQ during
> the boot time pcibios phase. This results in devices which are connected
> after boot time not being asigned IRQs which can cause various problems.
> 
> This patch as part of its set fixes this be moving the IRQ initialisation
> into the PCI device enable code path so that it is run for boot time and
> hot-plugged devices alike.
> 
> Signed-off-by: Matthew Minter <matt@masarand.com>
> 
> ---
>  arch/powerpc/kernel/pci-common.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index b2814e2..a8be5a5 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -217,7 +217,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
>   * If the interrupt is used, then gets the interrupt line from the
>   * openfirmware and sets it in the pci_dev and pci_config line.
>   */
> -static int pci_read_irq_line(struct pci_dev *pci_dev)
> +static int pci_read_irq_line(struct pci_dev *pci_dev, u8 pin)
>  {
>  	struct of_phandle_args oirq;
>  	unsigned int virq;
> @@ -229,7 +229,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  #endif
>  	/* Try to get a mapping from the device-tree */
>  	if (of_irq_parse_pci(pci_dev, &oirq)) {
> -		u8 line, pin;
> +		u8 line;
>  
>  		/* If that fails, lets fallback to what is in the config
>  		 * space and map that through the default controller. We
> @@ -238,10 +238,6 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  		 * either provide a proper interrupt tree or don't use this
>  		 * function.
>  		 */
> -		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &pin))
> -			return -1;
> -		if (pin == 0)
> -			return -1;
>  		if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
>  		    line == 0xff || line == 0) {
>  			return -1;
> @@ -266,9 +262,16 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  
>  	pr_debug(" Mapped to linux irq %d\n", virq);
>  
> -	pci_dev->irq = virq;
> +	return virq;
> +}
>  
> -	return 0;
> +int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)

Should be static.

> +{
> +	/* Read default IRQs and fixup if necessary */
> +	int irq = pci_read_irq_line(dev, pin);
> +	if (ppc_md.pci_irq_fixup)
> +		ppc_md.pci_irq_fixup(dev);
> +	return irq;

The .pci_irq_fixup() can change dev->irq, so wouldn't you want to return
dev->irq, not irq, here?  Otherwise, pdev_assign_irq() (the caller of
pci_map_irq()) will overwrite the dev->irq value set by the fixup.

>  }
>  
>  /*
> @@ -766,6 +769,8 @@ int pci_proc_domain(struct pci_bus *bus)
>  
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
> +	bridge->swizzle_irq = NULL;
> +	bridge->map_irq = pci_map_irq;
>  	if (ppc_md.pcibios_root_bridge_prepare)
>  		return ppc_md.pcibios_root_bridge_prepare(bridge);
>  
> @@ -968,11 +973,6 @@ static void pcibios_setup_device(struct pci_dev *dev)
>  	/* Additional platform DMA/iommu setup */
>  	if (ppc_md.pci_dma_dev_setup)
>  		ppc_md.pci_dma_dev_setup(dev);
> -
> -	/* Read default IRQs and fixup if necessary */
> -	pci_read_irq_line(dev);
> -	if (ppc_md.pci_irq_fixup)
> -		ppc_md.pci_irq_fixup(dev);
>  }
>  
>  int pcibios_add_device(struct pci_dev *dev)
> -- 
> 2.1.0
> 
