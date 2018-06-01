Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 1 Jun 2018 09:11:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 4/7] ACPI/hotplug/PCI: Do not scan all bridges when
 native PCIe hotplug is used
Message-ID: <20180601141118.GC119987@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529160155.1738-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529160155.1738-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 29, 2018 at 07:01:55PM +0300, Mika Westerberg wrote:
> When a system is using native PCIe hotplug for Thunderbolt it will be
> only present in the system when there is a device connected. This pretty
> much follows the BIOS assisted hotplug behaviour.
> 
> Thunderbolt host router integrated PCIe switch has two additional PCIe
> downstream bridges that lead to NHI (Thunderbolt host controller) and xHCI
> (USB 3 host controller) respectively. These downstream bridges are not
> marked being hotplug capable. Reason for that is to preserve resources.
> Otherwise the OS would distribute remaining resources between all
> downstream bridges making these two bridges consume precious resources
> of the actual hotplug bridges.
> 
> Now, because these two bridges are not marked being hotplug capable the OS
> will not enable hotplug interrupt for them either and will not receive
> interrupt when devices behind them are hot-added. Solution to this is
> that the BIOS sends ACPI Notify() to the root port let the OS know it
> needs to rescan for added and/or removed devices.
> 
> Here is how the mechanism is supposed to work when a Thunderbolt
> endpoint is connected to one of the ports. In case of a standard USB-C
> device only the xHCI is hot-added otherwise steps are the same.
> 
> 1. Initially there is only the PCIe root port that is controlled by
>    the pciehp driver
> 
>   00:1b.0 (Hotplug+) --
> 
> 2. Then we get native PCIe hotplug interrupt and once it is handled the
>    topology looks as following
> 
>   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 --
>                                   +- 02:01.0 (HotPlug+)
>                                   \- 02:02.0 --

Help me out here.  In PCIe terms, I assume we basically hot-added this
switch:

  01:00.0 Switch Upstream port
  02:00.0 Switch Downstream Port
  02:01.0 Switch Downstream Port
  02:02.0 Switch Downstream Port

Only 02:01.0 has PCI_EXP_SLTCAP_HPC set.  We can assign secondary bus
number space to all the downstream ports, but there are currently no
devices below any of them.  Well, duh, that's exactly what you said
below:

> 3. Bridges 02:00.0 and 02:02.0 are not marked as hotplug capable and
>    they don't have anything behind them currently. Bridge 02:01.0 is
>    hotplug capable and used for extending the topology. At this point
>    the required PCIe devices are enabled and ACPI Notify() is sent to
>    the root port. The resulting topology is expected to look like
> 
>   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
>                                   +- 02:01.0 (HotPlug+)
>                                   \- 02:02.0 -- xHCI host controller
> 

I guess this means we should ultimately end up with these new devices:

  03:00.0 Thunderbolt host controller
  39:00.0 xHCI host controller

(Can you send "lspci -vv" output so I can see the names, device types,
etc?  I'm still trying to map the Thunderbolt "host router", NHI, etc
terminology into PCIe concepts.)

> However, the current ACPI hotplug implementation scans the whole 00:1b.0
> hotplug slot and everything behind it regardless whether native PCIe is
> used or not, and it expects that the BIOS has configured bridge
> resources upfront. If that's not the case it assigns resources using
> minimal allocation (everything currently found just barely fit)
> preventing future extension. 

I assume we got a Bus Check notification to the root port.  The spec
says OSPM should re-enumerate starting from the root port (I'm looking
at ACPI 6.2, sec 5.6.6).  It would sure be nice if the spec somehow
indicated that this re-enumeration should skip parts of the tree.

I'm not really sure how we were supposed to infer this coordination
requirement from the existing specs.  It does suggest that the Notify
should be sent as close as possible to the point where it's required,
which would be 02:00.0 and 02:02.0 here, but since that whole switch
was hot-added by pciehp, the firmware doesn't necessarily know
anything about it.

> In addition to that, if there is another
> native PCIe hotplug going on we may find the new PCIe switch only
> partially ready (all links are not fully trained yet) confusing pciehp
> when it finally starts to enumerate for new devices.
> 
> To make this work better with the native PCIe (pciehp) and standard PCI
> (shpchp) hotplug drivers, we let them handle all slot management and
> resource allocation for hotplug bridges and restrict ACPI hotplug to
> non-hotplug bridges.

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 75 +++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 318b6a6f6341..e2bcd9fc3fd2 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -287,11 +287,12 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
>  	/*
>  	 * Expose slots to user space for functions that have _EJ0 or _RMV or
>  	 * are located in dock stations.  Do not expose them for devices handled
> -	 * by the native PCIe hotplug (PCIeHP), becuase that code is supposed to
> -	 * expose slots to user space in those cases.
> +	 * by the native PCIe hotplug (PCIeHP) or standard PCI hotplug
> +	 * (SHPCHP), because that code is supposed to expose slots to user
> +	 * space in those cases.
>  	 */
>  	if ((acpi_pci_check_ejectable(pbus, handle) || is_dock_device(adev))
> -	    && !(pdev && pdev->is_hotplug_bridge && pciehp_is_native(pdev))) {
> +	    && !(pdev && hotplug_is_native(pdev))) {
>  		unsigned long long sun;
>  		int retval;
>  
> @@ -430,6 +431,29 @@ static int acpiphp_rescan_slot(struct acpiphp_slot *slot)
>  	return pci_scan_slot(slot->bus, PCI_DEVFN(slot->device, 0));
>  }
>  
> +static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
> +{
> +	struct pci_bus *bus = bridge->subordinate;
> +	struct pci_dev *dev;
> +	int max;
> +
> +	if (!bus)
> +		return;
> +
> +	max = bus->busn_res.start;
> +	/* Scan already configured non-hotplug bridges */
> +	for_each_pci_bridge(dev, bus) {
> +		if (!dev->is_hotplug_bridge)
> +			max = pci_scan_bridge(bus, dev, max, 0);
> +	}
> +
> +	/* Scan non-hotplug bridges that need to be reconfigured */
> +	for_each_pci_bridge(dev, bus) {
> +		if (!dev->is_hotplug_bridge)
> +			max = pci_scan_bridge(bus, dev, max, 1);
> +	}
> +}
> +
>  /**
>   * enable_slot - enable, configure a slot
>   * @slot: slot to be enabled
> @@ -442,25 +466,42 @@ static void enable_slot(struct acpiphp_slot *slot)
>  	struct pci_dev *dev;
>  	struct pci_bus *bus = slot->bus;
>  	struct acpiphp_func *func;
> -	int max, pass;
> -	LIST_HEAD(add_list);
>  
> -	acpiphp_rescan_slot(slot);
> -	max = acpiphp_max_busnr(bus);
> -	for (pass = 0; pass < 2; pass++) {
> +	if (bus->self && hotplug_is_native(bus->self)) {
> +		/*
> +		 * If native hotplug is used, it will take care of hotplug
> +		 * slot management and resource allocation for hotplug
> +		 * bridges. However, ACPI hotplug may still be used for
> +		 * non-hotplug bridges to bring in additional devices such
> +		 * as Thunderbolt host controller.
> +		 */
>  		for_each_pci_bridge(dev, bus) {
> -			if (PCI_SLOT(dev->devfn) != slot->device)
> -				continue;
> -
> -			max = pci_scan_bridge(bus, dev, max, pass);
> -			if (pass && dev->subordinate) {
> -				check_hotplug_bridge(slot, dev);
> -				pcibios_resource_survey_bus(dev->subordinate);
> -				__pci_bus_size_bridges(dev->subordinate, &add_list);
> +			if (PCI_SLOT(dev->devfn) == slot->device)
> +				acpiphp_native_scan_bridge(dev);
> +		}
> +		pci_assign_unassigned_bridge_resources(bus->self);
> +	} else {
> +		LIST_HEAD(add_list);
> +		int max, pass;
> +
> +		acpiphp_rescan_slot(slot);
> +		max = acpiphp_max_busnr(bus);
> +		for (pass = 0; pass < 2; pass++) {
> +			for_each_pci_bridge(dev, bus) {
> +				if (PCI_SLOT(dev->devfn) != slot->device)
> +					continue;
> +
> +				max = pci_scan_bridge(bus, dev, max, pass);
> +				if (pass && dev->subordinate) {
> +					check_hotplug_bridge(slot, dev);
> +					pcibios_resource_survey_bus(dev->subordinate);
> +					__pci_bus_size_bridges(dev->subordinate,
> +							       &add_list);
> +				}
>  			}
>  		}
> +		__pci_bus_assign_resources(bus, &add_list, NULL);
>  	}
> -	__pci_bus_assign_resources(bus, &add_list, NULL);
>  
>  	acpiphp_sanitize_bus(bus);
>  	pcie_bus_configure_settings(bus);
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
