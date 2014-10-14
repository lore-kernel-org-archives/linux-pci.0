Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33959 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaJNSq0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 14:46:26 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so15850333igb.7
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 11:46:25 -0700 (PDT)
Date: Tue, 14 Oct 2014 12:46:22 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 12/18] Delayed mn10300 setup of PCI IRQs to bus scan time
Message-ID: <20141014184622.GJ10125@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-13-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-13-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:40AM +0100, matt@masarand.com wrote:
> From: Matthew Minter <matt@masarand.com>
> 
> 
> PCI IRQs are being asigned during pcibios_irq_init currently, this causes
> a problem by which hot-plug devices connected after boot will not recieve
> an IRQ, this patch-set fixes this by registering the IRQ assignment
> functions at boot, to then be called later by the device enable code.
> 
> Signed-off-by: Matthew Minter <matt@masarand.com>
> 
> ---
>  arch/mn10300/unit-asb2305/pci-asb2305.h |  5 +----
>  arch/mn10300/unit-asb2305/pci-irq.c     | 25 +++++--------------------
>  arch/mn10300/unit-asb2305/pci.c         | 21 ++++++++-------------
>  3 files changed, 14 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.h b/arch/mn10300/unit-asb2305/pci-asb2305.h
> index 9e17aca..fb520cf 100644
> --- a/arch/mn10300/unit-asb2305/pci-asb2305.h
> +++ b/arch/mn10300/unit-asb2305/pci-asb2305.h
> @@ -67,9 +67,6 @@ struct irq_routing_table {
>  } __attribute__((packed));
>  
>  extern unsigned int pcibios_irq_mask;
> -
> -extern void pcibios_irq_init(void);
> -extern void pcibios_fixup_irqs(void);
> -extern void pcibios_enable_irq(struct pci_dev *dev);
> +extern int pci_map_irq(struct pci_dev *, u8 slot, u8 pin);
>  
>  #endif /* PCI_ASB2305_H */
> diff --git a/arch/mn10300/unit-asb2305/pci-irq.c b/arch/mn10300/unit-asb2305/pci-irq.c
> index fcb28ce..5be6fea 100644
> --- a/arch/mn10300/unit-asb2305/pci-irq.c
> +++ b/arch/mn10300/unit-asb2305/pci-irq.c
> @@ -20,27 +20,12 @@
>  #include <asm/smp.h>
>  #include "pci-asb2305.h"
>  
> -void __init pcibios_irq_init(void)
> +int pci_map_irq(struct pci_dev *, u8 slot, u8 pin)
>  {
> -}
> -
> -void __init pcibios_fixup_irqs(void)
> -{
> -	struct pci_dev *dev = NULL;
> -	u8 line, pin;
> +	u8 line;
>  
> -	for_each_pci_dev(dev) {
> -		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> -		if (pin) {
> -			dev->irq = XIRQ1;
> -			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
> -					      dev->irq);
> -		}
> -		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
> -	}
> -}
> -
> -void pcibios_enable_irq(struct pci_dev *dev)
> -{
> +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> +	dev->irq = XIRQ1;
>  	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
> +	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
>  }
> diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
> index 6b4339f..22f8786 100644
> --- a/arch/mn10300/unit-asb2305/pci.c
> +++ b/arch/mn10300/unit-asb2305/pci.c
> @@ -377,13 +377,18 @@ static int __init pcibios_init(void)
>  	pci_add_resource_offset(&resources, &pci_ioport_resource, io_offset);
>  	pci_add_resource_offset(&resources, &pci_iomem_resource, mem_offset);
>  	pci_scan_root_bus(NULL, 0, &pci_direct_ampci, NULL, &resources);
> -
> -	pcibios_irq_init();
> -	pcibios_fixup_irqs();
>  	pcibios_resource_survey();
>  	return 0;
>  }
>  
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	bridge->swizzle_irq = NULL;
> +	bridge->map_irq = pci_map_irq;

I would lean toward omitting the "= NULL" initializations here and
elsewhere, because it will make git grep and cscope searches for
swizzle_irq more useful because they will show only the arches that
actually need it.  But it's fine either way.

> +	return 0;
> +}
> +
> +
>  arch_initcall(pcibios_init);
>  
>  char *__init pcibios_setup(char *str)
> @@ -396,16 +401,6 @@ char *__init pcibios_setup(char *str)
>  	return str;
>  }
>  
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> -{
> -	int err;
> -
> -	err = pci_enable_resources(dev, mask);
> -	if (err == 0)
> -		pcibios_enable_irq(dev);
> -	return err;

I would personally do this as two patches -- one that does the IRQ change,
and a second that drops the pcibios_enable_device() implementation because
it is now the same as the default one in drivers/pci/pci.c.  That way it's
clear that there really two logical changes happening here and reviewers
can easily verify that the two pcibios_enable_device() implementations are
identical.

> -}
> -
>  /*
>   * disable the ethernet chipset
>   */
> -- 
> 2.1.0
> 
