Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:53187 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeEOJMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 05:12:40 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 03/12] PCI: Request control of native PCIe hotplug only if supported
Date: Tue, 15 May 2018 11:12:09 +0200
Message-ID: <2185337.o0mYYtHL4u@aspire.rjw.lan>
In-Reply-To: <20180510182844.77349-4-mika.westerberg@linux.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com> <20180510182844.77349-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 10, 2018 8:28:35 PM CEST Mika Westerberg wrote:
> Currently we request control of native PCIe hotplug unconditionally.
> That may cause problems because native PCIe hotplug events are handled
> by pciehp driver and if it is not enabled those events will be lost.
> Make this bit more robust and request control of native PCIe hotplug
> only if we are actually prepared to do so (pciehp driver is enabled).
> 
> While there rename host->native_hotplug to host->native_pcie_hotplug
> because we do the same for SHPC hotplug in subsequent patches.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c         | 6 ++++--
>  drivers/pci/pcie/portdrv_core.c | 2 +-
>  drivers/pci/probe.c             | 2 +-
>  include/linux/pci.h             | 2 +-
>  include/linux/pci_hotplug.h     | 7 +++++++
>  5 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 0da18bde6a16..97590dff6bd8 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -29,6 +29,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/pci_hotplug.h>
>  #include <linux/dmar.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
> @@ -472,9 +473,10 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  	}
>  
>  	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -		| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
>  		| OSC_PCI_EXPRESS_PME_CONTROL;
>  
> +	if (pciehp_available())
> +		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>  	if (pci_aer_available()) {
>  		if (aer_acpi_firmware_first())
>  			dev_info(&device->dev,
> @@ -900,7 +902,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> -		host_bridge->native_hotplug = 0;
> +		host_bridge->native_pcie_hotplug = 0;
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
>  		host_bridge->native_aer = 0;
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index c9c0663db282..6cb30aec2452 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -199,7 +199,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	int services = 0;
>  
>  	if (dev->is_hotplug_bridge &&
> -	    (pcie_ports_native || host->native_hotplug)) {
> +	    (pcie_ports_native || host->native_pcie_hotplug)) {
>  		services |= PCIE_PORT_SERVICE_HP;
>  
>  		/*
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7c34a2ccb514..a6c3b8d30f8f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -552,7 +552,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  	 * OS from interfering.
>  	 */
>  	bridge->native_aer = 1;
> -	bridge->native_hotplug = 1;
> +	bridge->native_pcie_hotplug = 1;
>  	bridge->native_pme = 1;
>  
>  	return bridge;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 73178a2fcee0..359a197d0310 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -471,7 +471,7 @@ struct pci_host_bridge {
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>  	unsigned int	native_aer:1;		/* OS may use PCIe AER */
> -	unsigned int	native_hotplug:1;	/* OS may use PCIe hotplug */
> +	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 26213024e81b..46fb90b5164b 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -174,4 +174,11 @@ static inline int pci_get_hp_params(struct pci_dev *dev,
>  }
>  static inline bool pciehp_is_native(struct pci_dev *pdev) { return true; }
>  #endif
> +
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> +#define pciehp_available()	true
> +#else
> +#define pciehp_available()	false
> +#endif
> +
>  #endif
> 

Modulo the Lucas' comment on using IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
directly instead of the above:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
