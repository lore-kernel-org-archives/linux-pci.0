Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34197 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbcAUW2v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Jan 2016 17:28:51 -0500
Message-ID: <1453415330.32741.384.camel@redhat.com>
Subject: Re: [PATCH 1/2] pci: Identify Enhanced Allocation (EA) BAR
 Equivalent resources
From: Alex Williamson <alex.williamson@redhat.com>
To: "Sean O. Stalley" <sean.stalley@intel.com>,
	linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com
Cc: david.daney@cavium.com
Date: Thu, 21 Jan 2016 15:28:50 -0700
In-Reply-To: <1453414410-27072-2-git-send-email-sean.stalley@intel.com>
References: <1453414410-27072-1-git-send-email-sean.stalley@intel.com>
	 <1453414410-27072-2-git-send-email-sean.stalley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-01-21 at 14:13 -0800, Sean O. Stalley wrote:
> From: Alex Williamson <alex.williamson@redhat.com>
> 
> We've done a pretty good job of abstracting EA from drivers, but there
> are some properties of BAR Equivalent resources that don't really jive
> with traditional PCI BARs.  In particular, natural alignment is only
> encouraged, not required.
> 
> Why does this matter?  There are drivers like vfio-pci that will
> happily gobble up the EA abstraction that's been implemented and
> expose a device using EA to userspace as if those resources are
> traditional BARs.  Pretty cool.  The vfio API is bus agnostic, so it
> doesn't care about alignment.  The problem comes with PCI config space
> emulation where we don't let userspace manipulate the BAR value, but
> we do emulate BAR sizing.  The abstraction kind of falls apart if
> userspace gets garbage when they try to size what appears to be a
> traditional BAR, but is actually a BAR equivalent.
> 
> We could simply round up the size in vfio to make it naturally
> aligned, but then we're imposing artificial sizes to the user and we
> have the discontinuity that BAR size emulation and vfio region size
> reporting don't agree on the size.  I think what we want to do is
> expose EA to the user, reporting traditional BARs with BEIs as
> zero-sized and providing additional regions for the user to access
> each EA region, whether it has a BEI or not.
> 
> To facilitate that, a flag indicating whether a PCI resource is a
> traditional BAR or BAR equivalent seems much nicer than attempting
> to size the BAR ourselves or deducing it through the EA capability.
> 
> Thoughts?
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---

Feel free to rewrite this changelog and tailor it to the use case
that's currently driving the change.  Add a sign-off for yourself too
since the patch is passing through your hands.  Thanks,

Alex

>  drivers/pci/pci.c      | 2 +-
>  include/linux/ioport.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d1a7105..8ff678c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2229,7 +2229,7 @@ void pci_pm_init(struct pci_dev *dev)
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>  {
> -	unsigned long flags = IORESOURCE_PCI_FIXED;
> +	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
>  
>  	switch (prop) {
>  	case PCI_EA_P_MEM:
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 24bea08..5acc194 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -105,6 +105,8 @@ struct resource {
>  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
>  #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
>  
> +/* PCI Enhanced Allocation defined BAR equivalent resource */
> +#define IORESOURCE_PCI_EA_BEI		(1<<5)
>  
>  /* helpers to define resources */
>  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\

