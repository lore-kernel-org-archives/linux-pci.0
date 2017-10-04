Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 4 Oct 2017 17:24:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Scott Murray <scott@spiteful.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] pci: introduce for_each_pci_bridge() helper
Message-ID: <20171004222444.GM25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170929192123.24817-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170929192123.24817-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 29, 2017 at 10:21:23PM +0300, Andy Shevchenko wrote:
> It seems often the following pattern has been used
> 
> 	list_for_each_entry(dev, &bus->devices, bus_list) {
> 		if (pci_is_bridge(dev)) {
> 			...
> 		}
> 	}
> 
> Here for_each_pci_bridge() helper is introduced to make that code better
> to write and read by lowing indentation level. It also saves one or few
> lines of code in each occurrence.
> 
> Convert PCI core parts here at the same time.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/misc for v4.15, thanks!

> ---
>  drivers/pci/hotplug/acpiphp_glue.c     | 15 ++++++---------
>  drivers/pci/hotplug/cpci_hotplug_pci.c |  7 ++-----
>  drivers/pci/hotplug/pciehp_pci.c       |  5 ++---
>  drivers/pci/hotplug/shpchp_pci.c       |  6 ++----
>  drivers/pci/probe.c                    |  6 ++----
>  drivers/pci/setup-bus.c                |  7 +++----
>  include/linux/pci.h                    |  4 ++++
>  7 files changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5ed2dcaa8e27..5db6f1839dad 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -462,18 +462,15 @@ static void enable_slot(struct acpiphp_slot *slot)
>  	acpiphp_rescan_slot(slot);
>  	max = acpiphp_max_busnr(bus);
>  	for (pass = 0; pass < 2; pass++) {
> -		list_for_each_entry(dev, &bus->devices, bus_list) {
> +		for_each_pci_bridge(dev, bus) {
>  			if (PCI_SLOT(dev->devfn) != slot->device)
>  				continue;
>  
> -			if (pci_is_bridge(dev)) {
> -				max = pci_scan_bridge(bus, dev, max, pass);
> -				if (pass && dev->subordinate) {
> -					check_hotplug_bridge(slot, dev);
> -					pcibios_resource_survey_bus(dev->subordinate);
> -					__pci_bus_size_bridges(dev->subordinate,
> -							       &add_list);
> -				}
> +			max = pci_scan_bridge(bus, dev, max, pass);
> +			if (pass && dev->subordinate) {
> +				check_hotplug_bridge(slot, dev);
> +				pcibios_resource_survey_bus(dev->subordinate);
> +				__pci_bus_size_bridges(dev->subordinate, &add_list);
>  			}
>  		}
>  	}
> diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
> index 80c80017197d..f616358fa938 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_pci.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
> @@ -286,14 +286,11 @@ int cpci_configure_slot(struct slot *slot)
>  	}
>  	parent = slot->dev->bus;
>  
> -	list_for_each_entry(dev, &parent->devices, bus_list) {
> -		if (PCI_SLOT(dev->devfn) != PCI_SLOT(slot->devfn))
> -			continue;
> -		if (pci_is_bridge(dev))
> +	for_each_pci_bridge(dev, parent) {
> +		if (PCI_SLOT(dev->devfn) == PCI_SLOT(slot->devfn))
>  			pci_hp_add_bridge(dev);
>  	}
>  
> -
>  	pci_assign_unassigned_bridge_resources(parent->self);
>  
>  	pci_bus_add_devices(parent);
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 19f30a9f461d..c3af027ee1a6 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -60,9 +60,8 @@ int pciehp_configure_device(struct slot *p_slot)
>  		goto out;
>  	}
>  
> -	list_for_each_entry(dev, &parent->devices, bus_list)
> -		if (pci_is_bridge(dev))
> -			pci_hp_add_bridge(dev);
> +	for_each_pci_bridge(dev, parent)
> +		pci_hp_add_bridge(dev);
>  
>  	pci_assign_unassigned_bridge_resources(bridge);
>  	pcie_bus_configure_settings(parent);
> diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
> index f8cd3a27e351..ea63db58b4b1 100644
> --- a/drivers/pci/hotplug/shpchp_pci.c
> +++ b/drivers/pci/hotplug/shpchp_pci.c
> @@ -61,10 +61,8 @@ int shpchp_configure_device(struct slot *p_slot)
>  		goto out;
>  	}
>  
> -	list_for_each_entry(dev, &parent->devices, bus_list) {
> -		if (PCI_SLOT(dev->devfn) != p_slot->device)
> -			continue;
> -		if (pci_is_bridge(dev))
> +	for_each_pci_bridge(dev, parent) {
> +		if (PCI_SLOT(dev->devfn) == p_slot->device)
>  			pci_hp_add_bridge(dev);
>  	}
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ff94b69738a8..cdc2f83c11c5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2421,10 +2421,8 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
>  	}
>  
>  	for (pass = 0; pass < 2; pass++)
> -		list_for_each_entry(dev, &bus->devices, bus_list) {
> -			if (pci_is_bridge(dev))
> -				max = pci_scan_bridge(bus, dev, max, pass);
> -		}
> +		for_each_pci_bridge(dev, bus)
> +			max = pci_scan_bridge(bus, dev, max, pass);
>  
>  	/*
>  	 * Make sure a hotplug bridge has at least the minimum requested
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 958da7db9033..7ca03407404c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1921,10 +1921,9 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>  					want additional resources */
>  
>  	down_read(&pci_bus_sem);
> -	list_for_each_entry(dev, &bus->devices, bus_list)
> -		if (pci_is_bridge(dev) && pci_has_subordinate(dev))
> -				__pci_bus_size_bridges(dev->subordinate,
> -							 &add_list);
> +	for_each_pci_bridge(dev, bus)
> +		if (pci_has_subordinate(dev))
> +			__pci_bus_size_bridges(dev->subordinate, &add_list);
>  	up_read(&pci_bus_sem);
>  	__pci_bus_assign_resources(bus, &add_list, NULL);
>  	BUG_ON(!list_empty(&add_list));
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f4f8ee5a7362..3dbe947b4152 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -596,6 +596,10 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>  		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
>  }
>  
> +#define for_each_pci_bridge(dev, bus)				\
> +	list_for_each_entry(dev, &bus->devices, bus_list)	\
> +		if (!pci_is_bridge(dev)) {} else
> +
>  static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
>  {
>  	dev = pci_physfn(dev);
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
