Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 27 Mar 2018 13:57:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180327185742.GB7759@bhelgaas-glaptop.roam.corp.google.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226132112.81447-2-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 04:21:08PM +0300, Mika Westerberg wrote:
> When distributing extra buses between hotplug bridges we need to make
> sure each bridge reserve at least one bus number, even if there is
> currently nothing connected to it. For instance ACPI hotplug may bring
> in additional devices to non-hotplug bridges later on.

I guess you mean ACPI hotplug can add devices below bridges that have
"bridge->is_hotplug_bridge == 0"?  Why don't we set is_hotplug_bridge
in that case?  I do see that acpiphp sets it in *some* cases (see
check_hotplug_bridge()).  Are we missing some case?

> Here is what happens on one system when a Thunderbolt device is plugged in:
> 
>   pci 0000:01:00.0: PCI bridge to [bus 02-39]
>   ...
>   pci_bus 0000:04: [bus 04-39] extended by 0x35
>   pci_bus 0000:04: bus scan returning with max=39
>   pci_bus 0000:04: busn_res: [bus 04-39] end is updated to 39
>   pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
>   pci_bus 0000:3a: scanning bus
>   pci_bus 0000:3a: bus scan returning with max=3a
>   pci_bus 0000:3a: busn_res: [bus 3a] end is updated to 3a
>   pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:02 [bus 02-39]
>   pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:01 [bus 01-39]
>   pci_bus 0000:02: bus scan returning with max=3a
>   pci_bus 0000:02: busn_res: [bus 02-39] end can not be updated to 3a
> 
> Resulting 'lspci -t' output looks like this:
> 
>   +-1b.0-[01-39]----00.0-[02-3a]--+-00.0-[03]----00.0
>                                   +-01.0-[04-39]--
>                                   \-02.0-[3a]----00.0
> 
> The device behind downstream port at 02:02 is the integrated xHCI (USB 3
> host controller) and is not fully accessible because the hotplug bridge
> is reserving too many bus numbers.

Thanks for the details here, but I can't tell what happened before and
was broken, vs. what happens now.  Which is the hotplug bridge?  Which
is the Thunderbolt controller?

I guess 02:01.0 must be the bridge consuming too many bus numbers
([bus 04-39])?

And 02:02.0 might be the Thunderbolt controller that wants to use bus
3a?  But obviously that won't work because 1b.0 doesn't route things
to bus 3a, since it only consumes [bus 01-39].

(The device behind 02:02.0 is more than just "not fully accessible" --
it's not accessible via config space *at all*.)

I guess the 'lspci -t' above must be without this patch, and with this
patch, we'd have

  pci 0000:02:00.0: PCI bridge to [bus 03]
  pci 0000:02:01.0: PCI bridge to [bus 04-38]
  pci 0000:02:02.0: PCI bridge to [bus 39]

This patch might fix the situation for simple hot-added devices, but
won't we have the same problem again if we hot-add a bridge?  It seems
like we need a more comprehensive solution.  I don't mean we need to
go whole hog and reassign everybody's bus numbers dynamically, but we
ought to at least be able to notice the situation, decline to enable
the bridge leading to devices we can't reach, and give a meaningful
error message.

Nit unrelated to this patch: "bridge 0000:02" is not a bridge, it's a
bus.  Apparently bus 3a is hidden because 1b.0's subordinate bus is
39.

> To make sure we don't run out of bus numbers for non-hotplug bridges reserve
> one bus number for them upfront before distributing buses for hotplug bridges.
> 
> Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
> Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

Sorry, this should be trivial, but I'm having a hard time wrapping my
mind around it.

AFAICT, "cmax" is the highest known bus number below this bus, "max"
is the highest bus number below "dev" (one of the bridges on "bus").

I assume "used_buses++" accounts for the fact that every enabled
bridge must consume one bus number for its secondary side.

And I guess "used_buses += cmax - max - 1" adds in the bus numbers
downstream from "dev" (subtracting the one used for its secondary
bus)?

pci_scan_bridge_extend() seems to return something related to the
number of bus numbers used below "dev".  Why doesn't *it* account for
the secondary bus number of "dev"?

It might help if the pci_scan_bridge_extend() function comment were
extended to say what it actually returns.

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
> 2.16.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
