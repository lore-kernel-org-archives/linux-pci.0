Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 1 Jun 2018 08:49:58 -0500
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
Subject: Re: [PATCH v8 1/7] PCI: Take all bridges into account when
 calculating bus numbers for extension
Message-ID: <20180601134958.GB119987@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180528124756.78512-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528124756.78512-2-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 28, 2018 at 03:47:50PM +0300, Mika Westerberg wrote:
> When distributing extra buses between hotplug bridges for future
> extension we currently fail to take into account the fact that there
> might be non-hotplug bridges on the bus after the hotplug bridges. In
> this particular system we have following topology:
> 
>   01:00.0 --+- 02:00.0 -- Thunderbolt host controller
>             +- 02:01.0 (HotPlug+)
>             \- 02:02.0 -- xHCI host controller
> 
> Now, pci_scan_child_bus_extend() is supposed to distribute remaining bus
> numbers to the hotplug bridge at 02:01.0 but only after all bridges on
> that bus have been been accounted for. Since we don't check upfront that
> there will be another non-hotplug bridge after the hotplug bridge
> 02:01.0 it will inadvertently extend over the bus space of the
> non-hotplug bridge:

Just to make sure I understand this correctly, I think this situation
arises when we hot-add 01:00.0.  The port above 01:00.0 was probably
programmed by the BIOS like this:

  pci 0000:00:1b.0: PCI bridge to [bus 01-39]

01:00.0 is the only device on bus 01, so we give it everything that's
left:

>   pci 0000:01:00.0: PCI bridge to [bus 02-39]
>   ...

There are three bridges on bus 02, so we need to distribute the
remaining [bus 03-39] range among them.  Previously we only assigned
bus numbers to "is_hotplug_bridge" devices (basically those with
PCI_EXP_SLTCAP_HPC or ACPI hotplug methods).

In this case, the only one with "is_hotplug_bridge" is 02:01.0.

We looked at 02:00.0, which is a bridge but doesn't have
PCI_EXP_SLTCAP_HPC set, so we gave it one secondary bus number:

  pci 0000:02:00.0: PCI bridge to [bus 03]

Then we looked at 02:01.0, which *does* have PCI_EXP_SLTCAP_HPC, and
we know it's the only "is_hotplug_bridge", so we gave it the rest:

  pci 0000:02:01.0: PCI bridge to [bus 04-39]

Then we get to 02:02.0.  There are no bus numbers available, so we
can't reach anything below it.

And this patch fixes it by assigning at least one bus number to every
bridge, even if it doesn't have PCI_EXP_SLTCAP_HPC?

Is that right?

(The messages we print are sort of weird because we claim to scan bus
3a, but config accesses to 3a will never even reach the 01:00.0
bridge.  But that's a problem for another day.)

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
>                              ^^   +-01.0-[04-39]--
>                                   \-02.0-[3a]----00.0
>                                           ^^
> The xHCI host controller (3a:00.0) behind downstream bridge at 02:02.0
> is not usable anymore.
> 
> To fix this reserve at least one bus for each bridge during scanning of
> already configured bridges. Then we use this information in the second
> scan to correct the available extra bus space for hotplug bridges.
> 
> After this change the 'lspci -t' output is what is expected:
> 
>   +-1b.0-[01-39]----00.0-[02-39]--+-00.0-[03]----00.0
>                                   +-01.0-[04-38]--
>                                   \-02.0-[39]----00.0
> 
> Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
> Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/probe.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index d14e8f827d53..8f384e7ca2c2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2634,7 +2634,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  	for_each_pci_bridge(dev, bus) {
>  		cmax = max;
>  		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
> -		used_buses += cmax - max;
> +		/*
> +		 * Reserve one bus for each bridge now to avoid
> +		 * extending hotplug bridges too much during the second
> +		 * scan below.
> +		 */
> +		used_buses++;
> +		if (cmax - max > 1)
> +			used_buses += cmax - max - 1;
>  	}
>  
>  	/* Scan bridges that need to be reconfigured */
> @@ -2657,12 +2664,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
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
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
