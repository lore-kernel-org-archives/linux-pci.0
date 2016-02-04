Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33229 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757537AbcBDXOB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 18:14:01 -0500
Date: Thu, 4 Feb 2016 17:13:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com, david.daney@cavium.com
Subject: Re: [PATCH 1/2] pci: Identify Enhanced Allocation (EA) BAR
 Equivalent resources
Message-ID: <20160204231358.GG7031@localhost>
References: <1453500294-3140-1-git-send-email-sean.stalley@intel.com>
 <1453500294-3140-2-git-send-email-sean.stalley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453500294-3140-2-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 22, 2016 at 02:04:53PM -0800, Sean O. Stalley wrote:
> From: Alex Williamson <alex.williamson@redhat.com>
> 
> We've done a pretty good job of abstracting EA from drivers,
> but there are some cases where flaging resources as EA would be
> useful. Specifically, EA is flexabable when it comes to resource

Heh, "flexabable" :)

> alignment & sizing. This can create issues when existing software
> makes assumptions about the PCI resources.
> 
> For example, lspci assumes any PCI resource exposed by the kernel
> that isn't visible in standard configspace comes from a VF BAR.
> vfio makes assumptions about alignment and sizing, and runs into
> problems when attempting to emulate a BAR Equivalent EA resource.
> 
> To facilitate that, a flag indicating whether a PCI resource is a
> traditional BAR or BAR equivalent seems much nicer than attempting
> to deduce where the resource came from from the size & address fields
> (which is impossible if a EA resource happens naturally aligned).
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
> ---
>  drivers/pci/pci.c      | 2 +-
>  include/linux/ioport.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d1a7105..8ff678c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2229,7 +2229,7 @@ void pci_pm_init(struct pci_dev *dev)
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>  {
> -	unsigned long flags = IORESOURCE_PCI_FIXED;
> +	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
>  
>  	switch (prop) {
>  	case PCI_EA_P_MEM:
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 24bea08..5acc194 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -105,6 +105,8 @@ struct resource {
>  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
>  #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
>  
> +/* PCI Enhanced Allocation defined BAR equivalent resource */
> +#define IORESOURCE_PCI_EA_BEI		(1<<5)

Hmmm, I didn't realize until I read the lspci patch that the resource
flags are exposed via sysfs (I think in resource_show()) and are thus
part of the sysfs ABI.  It would be nice to have a comment to that
effect here in ioport.h so we don't move bits and inadvertently break
something.

The changelog should also connect the dots a little bit more, e.g.,
mention the sysfs file affected by this patch, and that this currently
only makes lspci print slightly more correct output.

>  /* helpers to define resources */
>  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
