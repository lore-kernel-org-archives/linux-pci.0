Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180213163200.8787-2-mika.westerberg@linux.intel.com>
References: <20180213163200.8787-1-mika.westerberg@linux.intel.com> <20180213163200.8787-2-mika.westerberg@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2018 18:43:00 +0100
Message-ID: <CAJZ5v0h7okRkBsNmSkLQ9AOZ_zPk5G0vbu=hKxwm2vjEthvxOA@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: Make sure all bridges reserve at least one bus number
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 5:31 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> When distributing extra buses between hotplug bridges we need to make
> sure each bridge reserve at least one bus number, even if there is
> currently nothing connected to it. For instance ACPI hotplug may bring
> in additional devices to non-hotplug bridges later on. To make sure we
> don't run out of bus numbers for non-hotplug bridges reserve one bus
> number for them upfront before distributing buses for hotplug bridges.
>
> Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
> Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org

Just a few notation-related nits below.

> ---
>  drivers/pci/probe.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ef5377438a1e..3e91d2191a7d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2561,7 +2561,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>         for_each_pci_bridge(dev, bus) {
>                 cmax = max;
>                 max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
> -               used_buses += cmax - max;
> +               /* Reserve one bus for each bridge */
> +               used_buses += cmax - max ?: 1;

I would write this as

used_buses++;
if (cmax - max > 1)
        used_buses += cmax - max - 1;

to make this and the new code below look analogous.

>         }
>
>         /* Scan bridges that need to be reconfigured */
> @@ -2584,12 +2585,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>                          * bridges if any.
>                          */
>                         buses = available_buses / hotplug_bridges;
> -                       buses = min(buses, available_buses - used_buses);
> +                       buses = min(buses, available_buses - (used_buses - 1));

You can write the inner expression as "available_buses - used_buses +
1" (without the extra parens).

>                 }
>
>                 cmax = max;
>                 max = pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
> -               used_buses += max - cmax;
> +               /* One bus is already accounted so don't add it again */
> +               if (max - cmax > 1)
> +                       used_buses += (max - cmax) - 1;

The parens on the right-hand side are not necessary here AFAICS.

>         }
>
>         /*
> --
