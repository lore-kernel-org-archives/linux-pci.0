Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdBCUxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 15:53:33 -0500
Date: Fri, 3 Feb 2017 21:53:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv5 2/5] pci: Add device disconnected state
Message-ID: <20170203205330.GA16487@kroah.com>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486144555-5526-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 12:55:52PM -0500, Keith Busch wrote:
> This patch adds a new state to pci_dev to be set when it is unexpectedly
> disconnected. The pci driver tear down functions can observe this new
> device state so they may skip operations that will fail.
> 
> The pciehp and pcie-dpc drivers are aware when the link is down, so
> these set the flag when their handlers detect the device is disconnected.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_pci.c |  5 +++++
>  drivers/pci/pci.h                | 14 ++++++++++++++
>  drivers/pci/pcie/pcie-dpc.c      |  4 ++++
>  include/linux/pci.h              |  2 ++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 9e69403..9b2f41d 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -109,6 +109,11 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>  				break;
>  			}
>  		}
> +		if (!presence) {
> +			pci_dev_set_disconnected(dev, NULL);
> +			if (pci_has_subordinate(dev))
> +				pci_walk_bus(dev->subordinate, pci_dev_set_disconnected, NULL);
> +		}
>  		pci_stop_and_remove_bus_device(dev);
>  		/*
>  		 * Ensure that no new Requests will be generated from
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index cb17db2..81512bc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -274,6 +274,20 @@ struct pci_sriov {
>  	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
>  };
>  
> +/* pci_dev priv_flags */
> +#define PCI_DEV_DISCONNECTED 0
> +
> +static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> +{
> +	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);

Why a single bit?  Are you trying to do this without locking or
something?  And if you want a bit, what's wrong with a C bit type?  Or
just a boolean?

I applaud your attempt to make this "private" to the pci core, just
don't know if it really will work, or if it is worth it entirely...

Anyway, I'll let Bjorn judge this feature being worth it or not :)

thanks,

greg k-h
