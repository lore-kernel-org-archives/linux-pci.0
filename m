Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ra.se.axis.com ([195.60.68.13]:54793 "EHLO ra.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab2FTMYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Jun 2012 08:24:45 -0400
Date: Wed, 20 Jun 2012 14:17:40 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mikael Starvik <starvik@axis.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-cris-kernel <linux-cris-kernel@axis.com>
Subject: Re: [PATCH] cris/PCI: remove pcibios_assign_resources()
Message-ID: <20120620121739.GR25226@axis.com>
References: <20120618181853.6254.2635.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120618181853.6254.2635.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 18, 2012 at 08:18:53PM +0200, Bjorn Helgaas wrote:
> There's no caller of pcibios_assign_resources() in the tree.  It is
> exported, so an out-of-tree module *could* call it, but no other arch
> exports pcibios_assign_resources(), so it would have to be a CRIS-specific
> module.  I doubt such a caller exists.

There was such a caller, but it was never used and has rotted completely.
I'll take this into the CRIS-tree, thanks!

> CC: Mikael Starvik <starvik@axis.com>
> CC: Jesper Nilsson <jesper.nilsson@axis.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/cris/arch-v32/drivers/pci/bios.c |   25 -------------------------
>  arch/cris/include/asm/pci.h           |    1 -
>  2 files changed, 0 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
> index bc0cfda..f748ced 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -102,28 +102,3 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  		pcibios_enable_irq(dev);
>  	return 0;
>  }
> -
> -int pcibios_assign_resources(void)
> -{
> -	struct pci_dev *dev = NULL;
> -	int idx;
> -	struct resource *r;
> -
> -	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
> -		int class = dev->class >> 8;
> -
> -		/* Don't touch classless devices and host bridges */
> -		if (!class || class == PCI_CLASS_BRIDGE_HOST)
> -			continue;
> -
> -		for(idx=0; idx<6; idx++) {
> -			r = &dev->resource[idx];
> -
> -			if (!r->start && r->end)
> -				pci_assign_resource(dev, idx);
> -		}
> -	}
> -	return 0;
> -}
> -
> -EXPORT_SYMBOL(pcibios_assign_resources);
> diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
> index 9f1cd56..146da90 100644
> --- a/arch/cris/include/asm/pci.h
> +++ b/arch/cris/include/asm/pci.h
> @@ -19,7 +19,6 @@ extern unsigned long pci_mem_start;
>  
>  void pcibios_config_init(void);
>  struct pci_bus * pcibios_scan_root(int bus);
> -int pcibios_assign_resources(void);
>  
>  void pcibios_set_master(struct pci_dev *dev);
>  void pcibios_penalize_isa_irq(int irq);
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
