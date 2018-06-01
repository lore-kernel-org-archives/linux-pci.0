Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 1 Jun 2018 16:35:05 -0500
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
Message-ID: <20180601213505.GA199634@bhelgaas-glaptop.roam.corp.google.com>
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
> ...

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

Here we test "dev->is_hotplug_bridge" and below we use
"hotplug_is_native(bus->self)".  Is the difference significant, or
should we use hotplug_is_native() here as well?

If we do need to use is_hotplug_bridge here, maybe a comment about the
difference would be helpful.

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
