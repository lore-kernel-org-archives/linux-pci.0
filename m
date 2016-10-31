Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:54177 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbcJaKkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 06:40:17 -0400
Date: Mon, 31 Oct 2016 11:41:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCHv4 next 1/3] pci: Add is_removed state
Message-ID: <20161031104104.GA9424@wunner.de>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477695497-6207-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 28, 2016 at 06:58:15PM -0400, Keith Busch wrote:
> This adds a new state for devices that were once in the system, but
> unexpectedly removed. This is so device tear down functions can observe
> the device is not accessible so it may skip attempting to initialize
> the hardware.
> 
> The pciehp and pcie-dpc drivers are aware of when the link is down,
> so these explicitly set this flag when its handlers detect the device
> is gone.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

I'll send a follow-up patch in a few minutes which leverages the
is_removed flag to fix a soft lockup on surprise removal of the
Apple Thunderbolt Gigabit Ethernet adapter.

Thanks,

Lukas

> ---
>  drivers/pci/hotplug/pciehp_pci.c | 5 +++++
>  drivers/pci/pcie/pcie-dpc.c      | 4 ++++
>  include/linux/pci.h              | 7 +++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 9e69403..7560961 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -109,6 +109,11 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>  				break;
>  			}
>  		}
> +		if (!presence) {
> +			pci_set_removed(dev, NULL);
> +			if (pci_has_subordinate(dev))
> +				pci_walk_bus(dev->subordinate, pci_set_removed, NULL);
> +		}
>  		pci_stop_and_remove_bus_device(dev);
>  		/*
>  		 * Ensure that no new Requests will be generated from
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 9811b14..7818c88 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/pcieport_if.h>
> +#include "../pci.h"
>  
>  struct dpc_dev {
>  	struct pcie_device	*dev;
> @@ -46,6 +47,9 @@ static void interrupt_event_handler(struct work_struct *work)
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>  					 bus_list) {
>  		pci_dev_get(dev);
> +		pci_set_removed(dev, NULL);
> +		if (pci_has_subordinate(dev))
> +			pci_walk_bus(dev->subordinate, pci_set_removed, NULL);
>  		pci_stop_and_remove_bus_device(dev);
>  		pci_dev_put(dev);
>  	}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e49f70..2115d19 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -341,6 +341,7 @@ struct pci_dev {
>  	unsigned int	multifunction:1;/* Part of multi-function device */
>  	/* keep track of device state */
>  	unsigned int	is_added:1;
> +	unsigned int	is_removed:1;	/* device was surprise removed */
>  	unsigned int	is_busmaster:1; /* device is busmaster */
>  	unsigned int	no_msi:1;	/* device may not use msi */
>  	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
> @@ -417,6 +418,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
>  	return (pdev->error_state != pci_channel_io_normal);
>  }
>  
> +static inline int pci_set_removed(struct pci_dev *pdev, void *unused)
> +{
> +	pdev->is_removed = 1;
> +	return 0;
> +}
> +
>  struct pci_host_bridge {
>  	struct device dev;
>  	struct pci_bus *bus;		/* root bus */
> -- 
> 2.7.2
