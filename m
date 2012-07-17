Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:59140 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2GQAHg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jul 2012 20:07:36 -0400
Received: by vbnl22 with SMTP id l22so618182vbn.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Jul 2012 17:07:35 -0700 (PDT)
Date: Mon, 16 Jul 2012 18:07:34 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org, yinghai@kernel.org, linuxram@us.ibm.com
Subject: Re: [PATCH 04/15] pci: weak function returns alignment
Message-ID: <20120717000734.GB32203@google.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
 <1342452631-21152-4-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342452631-21152-4-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 16, 2012 at 11:30:27PM +0800, Gavin Shan wrote:
> The patch implements the weak function to return the default I/O
> or memory alignment for P2P bridge. Currently, I/O window has 4KiB
> alignment and memory window is 4MiB aligned by default. On the other
> hand, those platforms (e.g. powernv) that have special requirements
> on the alignment could override the function by themselves.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/host-bridge.c |   17 +++++++++++++++++
>  include/linux/pci.h       |    2 ++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index abcf053..dcbc47d 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -105,3 +105,20 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>  }
>  
>  EXPORT_SYMBOL(pcibios_bus_to_resource);
> +
> +/*
> + * Retrieve the default memory or I/O alignment for the
> + * specific P2P bridge. The function has been implemented
> + * as weak so that it can be overrided by platform that
> + * has special requirments for memory and I/O alignment.
> + */
> +resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
> +						unsigned long type)

This no longer has anything to do with the host bridge, so I think it
could be moved to setup-bus.c and made static.  We shouldn't have to
repeat the default 1M and 4K code in the arch versions, so maybe we
could do something like this:

    resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus, unsigned long type)
    {
	return 1;
    }

    static resource_size_t window_alignment(struct pci_bus *bus, unsigned long type)
    {
	resource_size_t align = 1, arch_align;

	if (type & IORESOURCE_MEM)
	    align = 1024*1024;
	else if (type & IORESOURCE_IO)
	    align = 4*1024;
    
	arch_align = pcibios_window_alignment(bus, type);
	return max(align, arch_align);
    }

I made the default 1, thinking of bus number apertures (though we don't use this
path for bus numbers today).

> +{
> +	/* Memory windows must be 1MiB aligned */
> +	if (type & IORESOURCE_MEM)
> +		return 1024*1024;
> +
> +	/* I/O windows have default alignment of 4KiB */
> +	return 4*1024;
> +}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9acea4b..283da11 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -662,6 +662,8 @@ void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>  			       struct pci_bus_region *region);
>  void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>  			     struct pci_bus_region *region);
> +resource_size_t pcibios_window_alignment(struct pci_bus *bus,
> +					 unsigned long type);
>  void pcibios_scan_specific_bus(int busn);
>  extern struct pci_bus *pci_find_bus(int domain, int busnr);
>  void pci_bus_add_devices(const struct pci_bus *bus);
> -- 
> 1.7.5.4
> 
