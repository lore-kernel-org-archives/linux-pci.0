Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 24 May 2016 15:53:23 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Message-ID: <20160524125323.GE1789@lahna.fi.intel.com>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
 <20160523215015.GA31479@localhost>
 <20160524122357.GA20453@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160524122357.GA20453@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 07:23:57AM -0500, Bjorn Helgaas wrote:
> On Mon, May 23, 2016 at 04:50:15PM -0500, Bjorn Helgaas wrote:
> > [+cc Valdis, Dave]
> > 
> > On Mon, May 23, 2016 at 03:00:42PM -0500, Bjorn Helgaas wrote:
> > > On Mon, May 23, 2016 at 11:20:48AM +0300, Mika Westerberg wrote:
> > > > When a PCI device is removed through sysfs interface the upstream bridge
> > > > (PCIe port) can be runtime suspended if it was the last device on that bus.
> > > > Now, if the bridge is in D3 we cannot find devices below the bridge
> > > > anymore. For example following fails to find the removed device again:
> > > > 
> > > >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/0000:01:00.0/remove
> > > >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan
> > > > 
> > > > Where 0000:00:01.0 is the bridge device.
> > > > 
> > > > In order to be able to rescan devices below the bridge add
> > > > pm_runtime_get_sync()/pm_runtime_put() calls to pci_scan_bridge(). This
> > > > should keep bridges powered on while their children devices are being
> > > > scanned.
> > > > 
> > > > Reported-by: Peter Wu <peter@lekensteyn.nl>
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > This looks like basically the same idea as "ACPI / hotplug / PCI:
> > > Runtime resume bridge before rescan".
> > > 
> > > The hotplug_event() path modified by that patch eventually calls
> > > pci_scan_bridge():
> > > 
> > >   hotplug_event
> > >     enable_slot
> > >       pci_scan_bridge
> > > 
> > > so this patch looks a little more general.  Does it make "ACPI /
> > > hotplug / PCI: Runtime resume bridge before rescan" unnecessary?  
> > > Can I just replace that patch with this one?
> > 
> > I speculatively replaced "ACPI / hotplug / PCI: Runtime resume bridge
> > before rescan" with this one and pushed the result to
> > 
> >   https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pm
> > 
> > Please take a look, test it, and let me know if I need to add the ACPI
> > patch back.
> > 
> > This branch also includes the fix for the lockdep splat reported by
> > Valdis.  This is what I hope to get into v4.7-rc1.
> 
> Ping?  I'd like to ask Linus to pull this pci/pm branch before v4.7-rc1.
> It currently has these changes:
> 
>   8b71f5652eea PCI: Add runtime PM support for PCIe ports
>   af81f0fa638b PCI: Power on bridges before scanning new devices
>   9741a01c9f55 PCI: Put PCIe ports into D3 during suspend
>   b3a63ff7baf1 PCI: Don't clear d3cold_allowed for PCIe ports

Looks good to me. I've also tested those here and seems to work fine.

> I dropped "ACPI / hotplug / PCI: Runtime resume bridge before rescan"
> on the assumption that "PCI: Power on bridges before scanning new
> devices" is sufficient to cover both the ACPI and the generic PCi
> rescan cases, but I'd like some reassurance about that.

I agree with your reasoning that the patch should not be needed anymore.
However, I have the machine which needed that patch at home so I'm not
able to test it now. I'll do that later today when I get back home.

One thing I noticed, though. When a bridge is transitioned to D0 we only
wait for 10ms which is requirement for PCI functions. However, PCI PM
specification 1.2 (chapter 4.2) requires that for buses to transition
from B2 to B0 we need to wait minimum of 50ms before accessing a
function on that bus.

We even have PCI_PM_BUS_WAIT defined in include/linux/pci.h but it is
not used anywhere. Maybe it was not needed originally because we never
powered down bridges anyway but now when we do, I think it is good idea
to do what the spec requires.

What do you think? We could add a separate patch doing something like
below to make sure the spec is followed.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e785dc260e72..b3b794caa380 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2361,7 +2361,12 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 	dev->pm_cap = pm;
-	dev->d3_delay = PCI_PM_D3_WAIT;
+	/*
+	 * PCI PM 1.2 specification requires minimum of 50ms before any
+	 * function on the bus is accessed after the bus is transitioned
+	 * from B2 to B0.
+	 */
+	dev->d3_delay = pci_is_bridge(dev) ? PCI_PM_BUS_WAIT : PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
