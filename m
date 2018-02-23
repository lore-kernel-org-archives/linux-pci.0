Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 22 Feb 2018 18:27:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180223002733.GH14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180215144000.60456-1-mika.westerberg@linux.intel.com>
 <20180215144000.60456-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180215144000.60456-2-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 15, 2018 at 05:39:55PM +0300, Mika Westerberg wrote:
> When distributing extra buses between hotplug bridges we need to make
> sure each bridge reserve at least one bus number, even if there is
> currently nothing connected to it. For instance ACPI hotplug may bring
> in additional devices to non-hotplug bridges later on. To make sure we
> don't run out of bus numbers for non-hotplug bridges reserve one bus
> number for them upfront before distributing buses for hotplug bridges.
> 
> Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
> Reported-by: Mario Limonciello <mario.limonciello@dell.com>

Is there a bugzilla or email URL we can include here?

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/probe.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ef5377438a1e..6cefd47556e3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2561,7 +2561,10 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  	for_each_pci_bridge(dev, bus) {
>  		cmax = max;
>  		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
> -		used_buses += cmax - max;
> +		/* Reserve one bus for each bridge */
> +		used_buses++;
> +		if (cmax - max > 1)
> +			used_buses += cmax - max - 1;
>  	}
>  
>  	/* Scan bridges that need to be reconfigured */
> @@ -2584,12 +2587,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  			 * bridges if any.
>  			 */
>  			buses = available_buses / hotplug_bridges;
> -			buses = min(buses, available_buses - used_buses);
> +			buses = min(buses, available_buses - used_buses + 1);
>  		}
>  
>  		cmax = max;
>  		max = pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
> -		used_buses += max - cmax;
> +		/* One bus is already accounted so don't add it again */
> +		if (max - cmax > 1)
> +			used_buses += max - cmax - 1;
>  	}
>  
>  	/*
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
