Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44530 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbcCLAUn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 19:20:43 -0500
Date: Fri, 11 Mar 2016 18:20:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: Move PCIe ports to D3hot during suspend
Message-ID: <20160312002039.GK4725@localhost>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
 <1456750566-116248-4-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456750566-116248-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 02:56:03PM +0200, Mika Westerberg wrote:
> Currently the PCI core does not do this automatically as it avoids changing
> power state for bridges and PCIe ports. With recent hardware PCIe ports can
> be moved to D3hot given that we take into account few restrictions:
> 
>   - Devices connected to the ports are effectively in D3cold once the root
>     port is moved to D3hot (the config space is not accessible anymore and
>     the link may be powered down).
> 
>   - The device needs to be able to transition to D3cold.

I think this is talking about "devices below the PCIe port", right?

>   - If the device is capable of waking the system it needs to be able to
>     do so from D3cold (PME from D3cold).

Again, "a device below the PCIe port"?

> We assume all recent hardware (starting from 2015) is capable of doing this
> but make it possible to add exceptions via entries in pcie_port_configs[].

Since you have no exceptions yet, I'm not sure it's worth having the
exception infrastructure.  That infrastructure kind of obscures the
meat of the patch, so if we really do need it right away, maybe it
could be added in a new separate patch.

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 103 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 6c6bb03392ea..fe3349685141 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -20,6 +20,7 @@
>  
>  #include "portdrv.h"
>  #include "aer/aerdrv.h"
> +#include "../pci.h"
>  
>  /*
>   * Version Information
> @@ -78,11 +79,105 @@ static int pcie_portdrv_restore_config(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +enum pcie_port_type {
> +	PCIE_PORT_DEFAULT,
> +};
> +
> +struct pcie_port_config {
> +	bool suspend_allowed;
> +};
> +
> +static const struct pcie_port_config pcie_port_configs[] = {
> +	[PCIE_PORT_DEFAULT] = {
> +		.suspend_allowed = true,
> +	},
> +};
> +
>  #ifdef CONFIG_PM
> +static const struct pcie_port_config *pcie_port_get_config(struct pci_dev *pdev)
> +{
> +	const struct pci_device_id *id = pci_match_id(pdev->driver->id_table,
> +						      pdev);
> +	return &pcie_port_configs[id->driver_data];
> +}
> +
> +static int pcie_port_check_d3cold(struct pci_dev *pdev, void *data)
> +{
> +	bool *d3cold_ok = data;
> +
> +	if (pdev->no_d3cold || !pdev->d3cold_allowed)
> +		*d3cold_ok = false;
> +	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
> +		*d3cold_ok = false;
> +
> +	return !*d3cold_ok;
> +}
> +
> +static bool pcie_port_can_suspend(struct pci_dev *pdev)
> +{
> +	bool d3cold_ok = true;
> +
> +	/*
> +	 * When the port is put to D3hot the devices behind the port are
> +	 * effectively in D3cold as their config space cannot be accessed
> +	 * anymore and the link may be powered down.
> +	 *
> +	 * We only allow the port to go to D3hot the devices:

s/the devices/if the subordinate devices/

> +	 *  - Are allowed to go to D3cold
> +	 *  - Can wake up from D3cold if they are wake capable
> +	 */
> +	pci_walk_bus(pdev->subordinate, pcie_port_check_d3cold, &d3cold_ok);
> +	return d3cold_ok;

What happens if the PCIe port initially can be put in D3hot, but we we
later hot-add a device that would disqualify it?

Oh, I think I see -- we walk the subordinate devices every time we
would like to put the port in D3hot:

  pcie_port_suspend_noirq
    pcie_port_suspend_allowed
      dmi_get_date
      pcie_port_can_suspend
        pci_walk_bus

I guess that should work, but it seems clunky to do all that work,
even though it's not really a performance path.  What if we did this:

  - add a d3hot_allowed bit in struct pci_dev

  - when enumerating a port, set d3hot_allowed if BIOS is new enough
    (it makes me a bit nervous that we apparently default to enabling
    D3hot on arches without DMI)

  - when enumerating devices, clear d3hot_allowed in upstream bridge
    if necessary

  - when removing last device on a bus, re-do port config (set
    d3hot_allowed if appropriate)

> +}
> +
> +static bool pcie_port_suspend_allowed(struct pci_dev *pdev)
> +{
> +	const struct pcie_port_config *config = pcie_port_get_config(pdev);
> +
> +	/*
> +	 * Older hardware is not capable of moving PCIe ports to D3 so
> +	 * anything earlier than 2015 is assumed not to support this.
> +	 */
> +	if (dmi_available) {
> +		unsigned year;
> +
> +		if (!dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) ||
> +		    year < 2015) {
> +			return false;
> +		}
> +	}
> +
> +	/* Per port configuration can forbid it as well */
> +	if (!config->suspend_allowed)
> +		return false;
> +
> +	return pcie_port_can_suspend(pdev);
> +}
> +
> +static int pcie_port_suspend_noirq(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pcie_port_suspend_allowed(pdev)) {
> +		pci_save_state(pdev);
> +		pci_set_power_state(pdev, PCI_D3hot);
> +		/*
> +		 * All devices behind the port are assumed to be in D3cold
> +		 * so update their state now.
> +		 */
> +		__pci_bus_set_current_state(pdev->subordinate, PCI_D3cold);
> +	}
> +
> +	return 0;
> +}
> +
>  static int pcie_port_resume_noirq(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +
>  	/*
>  	 * Some BIOSes forget to clear Root PME Status bits after system wakeup
>  	 * which breaks ACPI-based runtime wakeup on PCI Express, so clear those
> @@ -100,6 +195,7 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.thaw		= pcie_port_device_resume,
>  	.poweroff	= pcie_port_device_suspend,
>  	.restore	= pcie_port_device_resume,
> +	.suspend_noirq	= pcie_port_suspend_noirq,
>  	.resume_noirq	= pcie_port_resume_noirq,
>  };
>  
> @@ -285,10 +381,11 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>  /*
>   * LINUX Device Driver Model
>   */
> -static const struct pci_device_id port_pci_ids[] = { {
> +static const struct pci_device_id port_pci_ids[] = {
>  	/* handle any PCI-Express port */
> -	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> -	}, { /* end: all zeroes */ }
> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> +	  .driver_data = PCIE_PORT_DEFAULT },
> +	{ /* end: all zeroes */ }
>  };
>  MODULE_DEVICE_TABLE(pci, port_pci_ids);
>  
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
