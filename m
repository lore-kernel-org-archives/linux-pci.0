Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Oct 2017 16:02:53 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        shawn.lin@rock-chips.com, dianders@chromium.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/3] PCI: Add support for wake irq
Message-ID: <20171023230252.GA53058@google.com>
References: <20171019111007.25234-1-jeffy.chen@rock-chips.com>
 <20171019111007.25234-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019111007.25234-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ PM folks

Hi Jeffy,

It's probably good if you send the whole thing to linux-pm@ in the
future, if you're really trying to implement generic PCI/PM for device
tree systems.

On Thu, Oct 19, 2017 at 07:10:05PM +0800, Jeffy Chen wrote:
> Add support for PCIE_WAKE pin.

This is kind of an important change, so it feels like you should
document it a little more thoroughly than this. Particularly, I have a
few questions below, and it seems like some of these questions should be
acknowledged up front. e.g., why does this look so different than the
ACPI hooks?

> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v7:
> Move PCIE_WAKE handling into pci core.
> 
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
> 
> Changes in v5:
> Rebase
> 
> Changes in v3:
> Fix error handling
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq
>         -- Suggested by Brian Norris <briannorris@chromium.com>
> 
>  drivers/pci/pci.c    | 34 ++++++++++++++++++++++++++++++++--
>  drivers/pci/probe.c  | 32 ++++++++++++++++++++++++++++----
>  drivers/pci/remove.c |  9 +++++++++
>  3 files changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f0d68066c726..49080a10bdf0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -603,10 +603,40 @@ static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
>  			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
>  }
>  
> +static int pci_dev_check_wakeup(struct pci_dev *dev, void *data)
> +{
> +	bool *wakeup = data;
> +
> +	if (device_may_wakeup(&dev->dev))
> +		*wakeup = true;
> +
> +	return *wakeup;
> +}
> +
>  static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
>  {
> -	return pci_platform_pm ?
> -			pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
> +	struct pci_dev *parent = dev;
> +	struct pci_bus *bus;
> +	bool wakeup = false;

It feels like you're implementing a set of pci_platform_pm_ops, except
you're not actually implementing them. It almost seems like we should
have a drivers/pci/pci-of.c to do this. But that brings up a few
questions....

> +
> +	if (pci_platform_pm)

So, if somebody already registered ops, then you won't follow the "OF"
route? That means this all breaks as soon as a kernel has both
CONFIG_ACPI and CONFIG_OF enabled. This is possible on at least ARM64,
which 'select's OF and may also be built/run with CONFIG_ACPI.

And that conflict is the same if we try to register pci_platform_pm_ops
for OF systems -- it'll be a race over who sets them up first (or
rather, last).

Also, what happens on !ACPI && !OF? Or if the device tree did not
contain a "wakeup" definition? You're now implementing a default path
that doesn't make much sense IMO; you may claim wakeup capability
without actually having set it up somewhere.

I think you could use some more comments, and (again) a real commit
message.

> +		return pci_platform_pm->set_wakeup(dev, enable);
> +
> +	device_set_wakeup_capable(&dev->dev, enable);

Why are you setting that here? This function should just be telling the
lower layers to enable the physical WAKE# ability. In our case, it just
means configuring the WAKE# interrupt for wakeup -- or, since you've
used dev_pm_set_dedicated_wake_irq() which handles most of this
automatically...do you need this at all? It seems like you should
*either* implement these callbacks to manually manage the wakeup IRQ or
else use the dedicated wakeirq infrastructure -- not both.

And even if you need this, I don't think you need to do this many times;
you should only need to set up the capabilities once, when you first set
up the device.

And BTW, the description for the set_wakeup() callback says:

 * @set_wakeup: enables/disables wakeup capability for the device

I *don't* think that means "capability" as in the device framework's
view of "wakeup capable"; I think it means capability as in the physical
ability (a la, enable_irq_wake() or similar).

> +
> +	while ((parent = pci_upstream_bridge(parent)))
> +		bus = parent->bus;
> +
> +	if (!bus || !pci_is_root_bus(bus) || !bus->bridge->parent)
> +		return -ENODEV;
> +
> +	pci_walk_bus(bus, pci_dev_check_wakeup, &wakeup);
> +	device_set_wakeup_capable(bus->bridge->parent, wakeup);

What happens to any intermediate buses? You haven't marked them as
wakeup-capable. Should you?

And the more fundamental question here is: is this a per-device
configuration or a per-root-port configuration? The APIs here are
modeled after ACPI, where I guess this is a per-device thing. The PCIe
spec doesn't exactly specify how many WAKE# pins you need, though it
seems to say

(a) it's all-or-nothing (if one device uses it, all wakeup-capable EPs
    should be wired up to it)
(b) it *can* be done as a single input to the system controller, since
    it's an open drain signal
(c) ...but I also see now in the PCIe Card Electromechanical
    specification:

    "WAKE# may be bused to multiple PCI Express add-in card connectors,
    forming a single input connection at the PM controller, or
    individual connectors can have individual connections to the PM
    controller."

So I think you're kind of going along the lines of (b) (as I suggested
to you previously), and that matches the current hardware (we only have
a single WAKE#) and proposed DT binding. But should this be set up in a
way that suits (c) too? It's hard to tell exactly what ACPI-based
systems do, since they have this abstracted behind ACPI interfaces that
seem like they *could* support per-device or per-bridge type of hookups.

Bjorn, any thoughts? This seems like a halfway attempt in between two
different designs, and I'm not really sure which one makes more sense.

Brian

> +
> +	dev_dbg(bus->bridge->parent,
> +		"Wakeup %s\n", wakeup ? "enabled" : "disabled");
> +
> +	return 0;
>  }
>  
>  static inline bool platform_pci_need_resume(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cdc2f83c11c5..fd43ca832665 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
> @@ -17,6 +18,7 @@
>  #include <linux/acpi.h>
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include "pci.h"
>  
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
> @@ -756,11 +758,28 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	struct resource *res;
>  	char addr[64], *fmt;
>  	const char *name;
> -	int err;
> +	int err, irq;
> +
> +	if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node) {
> +		irq = of_irq_get_byname(parent->of_node, "wakeup");
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
> +		if (irq > 0) {
> +			device_init_wakeup(parent, true);
> +			err = dev_pm_set_dedicated_wake_irq(parent, irq);
> +			if (err) {
> +				dev_err(parent, "Failed to setup wakeup IRQ\n");
> +				goto deinit_wakeup;
> +			}
> +			dev_info(parent, "Wakeup enabled with IRQ %d\n", irq);
> +		}
> +	}
>  
>  	bus = pci_alloc_bus(NULL);
> -	if (!bus)
> -		return -ENOMEM;
> +	if (!bus) {
> +		err = -ENOMEM;
> +		goto clear_wake_irq;
> +	}
>  
>  	bridge->bus = bus;
>  
> @@ -856,9 +875,14 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  unregister:
>  	put_device(&bridge->dev);
>  	device_unregister(&bridge->dev);
> -
>  free:
>  	kfree(bus);
> +clear_wake_irq:
> +	if (parent)
> +		dev_pm_clear_wake_irq(parent);
> +deinit_wakeup:
> +	if (parent)
> +		device_init_wakeup(parent, false);
>  	return err;
>  }
>  
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 73a03d382590..cb7a326429e1 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -1,6 +1,7 @@
>  #include <linux/pci.h>
>  #include <linux/module.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/pm_wakeirq.h>
>  #include "pci.h"
>  
>  static void pci_free_resources(struct pci_dev *dev)
> @@ -131,17 +132,25 @@ void pci_stop_root_bus(struct pci_bus *bus)
>  {
>  	struct pci_dev *child, *tmp;
>  	struct pci_host_bridge *host_bridge;
> +	struct device *parent;
>  
>  	if (!pci_is_root_bus(bus))
>  		return;
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
> +	parent = host_bridge->dev.parent;
> +
>  	list_for_each_entry_safe_reverse(child, tmp,
>  					 &bus->devices, bus_list)
>  		pci_stop_bus_device(child);
>  
>  	/* stop the host bridge */
>  	device_release_driver(&host_bridge->dev);
> +
> +	if (parent) {
> +		dev_pm_clear_wake_irq(parent);
> +		device_init_wakeup(parent, false);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(pci_stop_root_bus);
>  
> -- 
> 2.11.0
> 
> 
