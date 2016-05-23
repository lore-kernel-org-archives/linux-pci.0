Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56500 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbcEWVuU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 17:50:20 -0400
Date: Mon, 23 May 2016 16:50:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Message-ID: <20160523215015.GA31479@localhost>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523200042.GB24375@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Valdis, Dave]

On Mon, May 23, 2016 at 03:00:42PM -0500, Bjorn Helgaas wrote:
> On Mon, May 23, 2016 at 11:20:48AM +0300, Mika Westerberg wrote:
> > When a PCI device is removed through sysfs interface the upstream bridge
> > (PCIe port) can be runtime suspended if it was the last device on that bus.
> > Now, if the bridge is in D3 we cannot find devices below the bridge
> > anymore. For example following fails to find the removed device again:
> > 
> >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/0000:01:00.0/remove
> >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan
> > 
> > Where 0000:00:01.0 is the bridge device.
> > 
> > In order to be able to rescan devices below the bridge add
> > pm_runtime_get_sync()/pm_runtime_put() calls to pci_scan_bridge(). This
> > should keep bridges powered on while their children devices are being
> > scanned.
> > 
> > Reported-by: Peter Wu <peter@lekensteyn.nl>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> This looks like basically the same idea as "ACPI / hotplug / PCI:
> Runtime resume bridge before rescan".
> 
> The hotplug_event() path modified by that patch eventually calls
> pci_scan_bridge():
> 
>   hotplug_event
>     enable_slot
>       pci_scan_bridge
> 
> so this patch looks a little more general.  Does it make "ACPI /
> hotplug / PCI: Runtime resume bridge before rescan" unnecessary?  
> Can I just replace that patch with this one?

I speculatively replaced "ACPI / hotplug / PCI: Runtime resume bridge
before rescan" with this one and pushed the result to

  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pm

Please take a look, test it, and let me know if I need to add the ACPI
patch back.

This branch also includes the fix for the lockdep splat reported by
Valdis.  This is what I hope to get into v4.7-rc1.

> > ---
> >  drivers/pci/probe.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 8004f67c57ec..15e77c92311e 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/aer.h>
> >  #include <linux/acpi.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/pm_runtime.h>
> >  #include "pci.h"
> >  
> >  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
> > @@ -832,6 +833,12 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
> >  	u8 primary, secondary, subordinate;
> >  	int broken = 0;
> >  
> > +	/*
> > +	 * Make sure the bridge is powered on to be able to access config
> > +	 * space of devices below it.
> > +	 */
> > +	pm_runtime_get_sync(&dev->dev);
> > +
> >  	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
> >  	primary = buses & 0xFF;
> >  	secondary = (buses >> 8) & 0xFF;
> > @@ -1012,6 +1019,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
> >  out:
> >  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
> >  
> > +	pm_runtime_put(&dev->dev);
> > +
> >  	return max;
> >  }
> >  EXPORT_SYMBOL(pci_scan_bridge);
> > -- 
> > 2.8.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
