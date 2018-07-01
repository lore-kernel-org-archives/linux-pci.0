Return-Path: <SRS0=8O55=JR=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=8O55=JR=h08.hostsharing.net=foo00@kernel.org>
Date: Sun, 1 Jul 2018 13:51:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Oza Pawandeep <poza@codeaurora.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Prevent runtime power management during recovery
Message-ID: <20180701115126.GA4101@wunner.de>
References: <20180611222918.1708-1-keith.busch@intel.com>
 <20180630195827.GD9547@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180630195827.GD9547@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 30, 2018 at 02:58:27PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 11, 2018 at 04:29:18PM -0600, Keith Busch wrote:
> > A bridge that supports D3 but not hotplug will be subject to runtime
> > power management placing it in a non-operation power state if it doesn't
> > have any devices attached. This patch will prevent this power management
> > during error recovery so that the rescan at the end may be successful.
> 
> I assume you're seeing a problem that's fixed by this patch?
> 
> I'm not very familiar with the pm_runtime_*() interfaces.  The fact
> that drivers/pci/ only contains two calls to pm_runtime_forbid() and
> two to pm_runtime_allow() (one in a quirk) makes me wonder if this is
> the right approach.

The use of pm_runtime_forbid() / pm_runtime_allow() is wrong here.
The user may forbid and allow runtime PM on a device by writing "on"
or "auto" to its power/control file in sysfs.  The two functions have
the same effect, but the user may override them at any time.  If the
intention is to ensure the bridge is runtime resumed while a rescan
is in progess, the appropriate functions to call are pm_runtime_get_sync()
and pm_runtime_put().


> Do we need something similar in other enumeration paths, e.g.,
> boot-time enumeration, hot-add, sysfs "rescan" entry, etc?

Definitely not on boot-time enumeration.  PCI devices are kept in D0
if not bound to a driver, and the PCI core first scans all devices,
only then attaches drivers.

As for hot-add, hotplug bridges are currently always kept in D0,
but I've posted a patch series two weeks ago to add runtime PM.
Did you get a chance to look at it?  Patch [28/32] of that series
resumes the bridge to D0 on hot-add ("PCI: pciehp: Resume to D0 on
enable/disable").

As for sysfs "rescan", this does lack runtime PM calls currently,
as do many other sysfs accessors.  The above-mentioned series
adds runtime PM to sysfs "reset" in patch [30/32] ("PCI: sysfs:
Resume to D0 on function reset").  The patch does not depend on the
preceding patches in the series, it could be applied out of order.
Amending all the other accessors would be another big project.
It's not as trivial as sprinkling a few runtime PM calls, it requires
careful thought.  E.g. if only config space is accessed, it's
sufficient to resume the parent with pci_config_pm_runtime_get()
instead of the device itself with pm_runtime_get_sync().  In other
cases the information is read from config space even though it's cached,
e.g. secondary_bus_number_show().  In those cases it might be better
to always return the cached data instead of adding runtime PM calls.

FWIW, from a quick look proc.c seems fine as far as runtime PM is
concerned.

Thanks,

Lukas

> 
> > Cc: Oza Pawandeep <poza@codeaurora.org>
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/pci/pcie/err.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index f7ce0cb0b0b7..247b6ce14f0d 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/errno.h>
> >  #include <linux/aer.h>
> > +#include <linux/pm_runtime.h>
> >  #include "portdrv.h"
> >  #include "../pci.h"
> >  
> > @@ -294,6 +295,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
> >  		udev = dev->bus->self;
> >  
> >  	parent = udev->subordinate;
> > +	pm_runtime_forbid(&udev->dev);
> >  	pci_lock_rescan_remove();
> >  	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> >  					 bus_list) {
> > @@ -329,6 +331,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
> >  	}
> >  
> >  	pci_unlock_rescan_remove();
> > +	pm_runtime_allow(&udev->dev);
> >  }
> >  
> >  /**
> > -- 
> > 2.14.3
