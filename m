Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34631 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbbLQRld (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 12:41:33 -0500
Date: Thu, 17 Dec 2015 11:41:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv6 2/7] pci: child bus alloc fix on constrained resource
Message-ID: <20151217174129.GD23549@localhost>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449523949-21898-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 07, 2015 at 02:32:24PM -0700, Keith Busch wrote:
> Does not allocate a child bus if the new bus number does not fit in the
> parent's bus resource window.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Other nits: please make this similar to previous changelogs in
capitalization, sentence structure, etc.  If we figure out that this
is safe, and I end up applying it, I can just tweak it myself, but if
you post it again, something like this is what I'm looking for:

  PCI: Don't allocate child bus outside parent bus number range

  Don't allocate a child bus if the new bus number does not fit in the
  parent's bus resource window.

The next patch is missing a subject line:

  PCI/MSI: Export MSI and IRQ functions for use by modules

  Export the following functions for use by modules:
  
    msi_desc_to_pci_dev()
    pci_msi_create_irq_domain()
    irq_domain_set_info()

And the following:

  x86/PCI: Allow PCI domain-specific DMA ops

I know this seems pedantic, but try to use "x86/PCI" consistently
because I think it's distracting to have the boiler-plate be different
in non-useful ways, e.g.,

  510fb6779eed x86/pci: Initial commit for new VMD device driver
  510fb6779eed x86/pci: Initial commit for new VMD device driver
  b7a48e92f508 x86-pci: allow pci domain specific dma ops
  8affb487d4a4 x86/PCI: Don't alloc pcibios-irq when MSI is enabled
  991de2e59090 PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()

Bjorn

> ---
>  drivers/pci/probe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index edb1984..6e29f7a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -704,6 +704,12 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  	int i;
>  	int ret;
>  
> +	if (busnr > parent->busn_res.end) {
> +		dev_printk(KERN_DEBUG, &parent->dev,
> +			  "can not alloc bus:%d under %pR\n", busnr,
> +			  &parent->busn_res);
> +		return NULL;
> +	}
>  	/*
>  	 * Allocate a new bus, and inherit stuff from the parent..
>  	 */
> -- 
> 2.6.2.307.g37023ba
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
