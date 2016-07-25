Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36440 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbcGYR6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 13:58:30 -0400
Date: Mon, 25 Jul 2016 12:58:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: Allow additional busses for hotplug bridges
Message-ID: <20160725175825.GG12484@localhost>
References: <1469158828-4179-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469158828-4179-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 21, 2016 at 09:40:28PM -0600, Keith Busch wrote:
> A user may hot add a switch requiring more than one bus to enumerate. This
> previously required a system reboot if BIOS did not sufficiently pad
> the bus resource, which they frequently don't do. This patch allows
> a user specify the minimum number of resources to reserve for a hotplug
> bridge's subordinate busses so rebooting won't be necessary.
> 
> The default is 1, which is equivalent to previous behavior.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied to pci/hotplug for v4.8, thanks, Keith!

> ---
>  Documentation/kernel-parameters.txt | 3 +++
>  drivers/pci/pci.c                   | 8 ++++++++
>  drivers/pci/probe.c                 | 9 +++++++++
>  include/linux/pci.h                 | 1 +
>  4 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 82b42c9..ce4b45b 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -3016,6 +3016,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  		hpmemsize=nn[KMG]	The fixed amount of bus space which is
>  				reserved for hotplug bridge's memory window.
>  				Default size is 2 megabytes.
> +		hpbussize=nn		The minimum amount of additional bus
> +				space which is reserved for hotplug bridge's
> +				bus window. Default is 1.
>  		realloc=	Enable/disable reallocating PCI bridge resources
>  				if allocations done by BIOS are too small to
>  				accommodate resources required by all child
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c8b4dbd..7d290f7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -81,6 +81,9 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
>  unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
>  
> +#define DEFAULT_HOTPLUG_BUS_SIZE	(1)
> +unsigned long pci_hotplug_bus_size  = DEFAULT_HOTPLUG_BUS_SIZE;
> +
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
>  
>  /*
> @@ -5021,6 +5024,11 @@ static int __init pci_setup(char *str)
>  				pci_hotplug_io_size = memparse(str + 9, &str);
>  			} else if (!strncmp(str, "hpmemsize=", 10)) {
>  				pci_hotplug_mem_size = memparse(str + 10, &str);
> +			} else if (!strncmp(str, "hpbussize=", 10)) {
> +				pci_hotplug_bus_size =
> +					simple_strtoul(str + 10, &str, 0);
> +				if (pci_hotplug_bus_size > 0xff)
> +					pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>  			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
>  				pcie_bus_config = PCIE_BUS_TUNE_OFF;
>  			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e3ef72..9454396 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2077,6 +2077,15 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
>  		}
>  
>  	/*
> +	 * Make sure a hot plug bridge has at least the minimum requested
> +	 * number of busses.
> +	 */
> +	if (bus->self && bus->self->is_hotplug_bridge && pci_hotplug_bus_size) {
> +		if (max - bus->busn_res.start < pci_hotplug_bus_size - 1)
> +			max = bus->busn_res.start + pci_hotplug_bus_size - 1;
> +	}
> +
> +	/*
>  	 * We've scanned the bus and so we know all about what's on
>  	 * the other side of any bridges that may be on this bus plus
>  	 * any devices.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b67e4df..0c28325 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1706,6 +1706,7 @@ extern u8 pci_cache_line_size;
>  
>  extern unsigned long pci_hotplug_io_size;
>  extern unsigned long pci_hotplug_mem_size;
> +extern unsigned long pci_hotplug_bus_size;
>  
>  /* Architecture-specific versions may override these (weak) */
>  void pcibios_disable_device(struct pci_dev *dev);
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
