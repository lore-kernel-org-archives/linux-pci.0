Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2834 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbcCNJdE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Mar 2016 05:33:04 -0400
Date: Mon, 14 Mar 2016 11:32:59 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: Move PCIe ports to D3hot during suspend
Message-ID: <20160314093259.GD1796@lahna.fi.intel.com>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
 <1456750566-116248-4-git-send-email-mika.westerberg@linux.intel.com>
 <20160312002039.GK4725@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160312002039.GK4725@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 06:20:39PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 29, 2016 at 02:56:03PM +0200, Mika Westerberg wrote:
> > Currently the PCI core does not do this automatically as it avoids changing
> > power state for bridges and PCIe ports. With recent hardware PCIe ports can
> > be moved to D3hot given that we take into account few restrictions:
> > 
> >   - Devices connected to the ports are effectively in D3cold once the root
> >     port is moved to D3hot (the config space is not accessible anymore and
> >     the link may be powered down).
> > 
> >   - The device needs to be able to transition to D3cold.
> 
> I think this is talking about "devices below the PCIe port", right?

That's right. I'll fix it in the next version.

> >   - If the device is capable of waking the system it needs to be able to
> >     do so from D3cold (PME from D3cold).
> 
> Again, "a device below the PCIe port"?

Right (will fix in the next version).

> > We assume all recent hardware (starting from 2015) is capable of doing this
> > but make it possible to add exceptions via entries in pcie_port_configs[].
> 
> Since you have no exceptions yet, I'm not sure it's worth having the
> exception infrastructure.  That infrastructure kind of obscures the
> meat of the patch, so if we really do need it right away, maybe it
> could be added in a new separate patch.

I don't think we need it right now. I'll drop it from the patch.

> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pcie/portdrv_pci.c | 103 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 100 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> > index 6c6bb03392ea..fe3349685141 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -20,6 +20,7 @@
> >  
> >  #include "portdrv.h"
> >  #include "aer/aerdrv.h"
> > +#include "../pci.h"
> >  
> >  /*
> >   * Version Information
> > @@ -78,11 +79,105 @@ static int pcie_portdrv_restore_config(struct pci_dev *dev)
> >  	return 0;
> >  }
> >  
> > +enum pcie_port_type {
> > +	PCIE_PORT_DEFAULT,
> > +};
> > +
> > +struct pcie_port_config {
> > +	bool suspend_allowed;
> > +};
> > +
> > +static const struct pcie_port_config pcie_port_configs[] = {
> > +	[PCIE_PORT_DEFAULT] = {
> > +		.suspend_allowed = true,
> > +	},
> > +};
> > +
> >  #ifdef CONFIG_PM
> > +static const struct pcie_port_config *pcie_port_get_config(struct pci_dev *pdev)
> > +{
> > +	const struct pci_device_id *id = pci_match_id(pdev->driver->id_table,
> > +						      pdev);
> > +	return &pcie_port_configs[id->driver_data];
> > +}
> > +
> > +static int pcie_port_check_d3cold(struct pci_dev *pdev, void *data)
> > +{
> > +	bool *d3cold_ok = data;
> > +
> > +	if (pdev->no_d3cold || !pdev->d3cold_allowed)
> > +		*d3cold_ok = false;
> > +	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
> > +		*d3cold_ok = false;
> > +
> > +	return !*d3cold_ok;
> > +}
> > +
> > +static bool pcie_port_can_suspend(struct pci_dev *pdev)
> > +{
> > +	bool d3cold_ok = true;
> > +
> > +	/*
> > +	 * When the port is put to D3hot the devices behind the port are
> > +	 * effectively in D3cold as their config space cannot be accessed
> > +	 * anymore and the link may be powered down.
> > +	 *
> > +	 * We only allow the port to go to D3hot the devices:
> 
> s/the devices/if the subordinate devices/

OK

> > +	 *  - Are allowed to go to D3cold
> > +	 *  - Can wake up from D3cold if they are wake capable
> > +	 */
> > +	pci_walk_bus(pdev->subordinate, pcie_port_check_d3cold, &d3cold_ok);
> > +	return d3cold_ok;
> 
> What happens if the PCIe port initially can be put in D3hot, but we we
> later hot-add a device that would disqualify it?
> 
> Oh, I think I see -- we walk the subordinate devices every time we
> would like to put the port in D3hot:
> 
>   pcie_port_suspend_noirq
>     pcie_port_suspend_allowed
>       dmi_get_date
>       pcie_port_can_suspend
>         pci_walk_bus
> 
> I guess that should work, but it seems clunky to do all that work,
> even though it's not really a performance path.  What if we did this:
> 
>   - add a d3hot_allowed bit in struct pci_dev
> 
>   - when enumerating a port, set d3hot_allowed if BIOS is new enough
>     (it makes me a bit nervous that we apparently default to enabling
>     D3hot on arches without DMI)
> 
>   - when enumerating devices, clear d3hot_allowed in upstream bridge
>     if necessary
> 
>   - when removing last device on a bus, re-do port config (set
>     d3hot_allowed if appropriate)

Sounds reasonable. I'll give it a try.
