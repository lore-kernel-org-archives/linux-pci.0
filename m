Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Huang Ying <ying.huang@intel.com>
Subject: Re: [RFD][PATCH 7/7] PM / ACPI: Take device PM QoS flags into account
Date: Sat, 29 Sep 2012 23:39:01 +0200
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>,
	linux-pci@vger.kernel.org,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	mark gross <markgross@thegnar.org>
References: <201209282351.10663.rjw@sisk.pl> <201209282356.52558.rjw@sisk.pl> <1348888608.10452.31.camel@yhuang-dev>
In-Reply-To: <1348888608.10452.31.camel@yhuang-dev>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201209292339.02258.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, September 29, 2012, Huang Ying wrote:
> On Fri, 2012-09-28 at 23:56 +0200, Rafael J. Wysocki wrote:
> > Make ACPI power management routines and PCI power management
> > routines depending on ACPI take device PM QoS flags into account
> > when deciding what power state to put the device into.
> > 
> > In particular, after this change acpi_pm_device_sleep_state() will
> > not return ACPI_STATE_D3_COLD as the deepest available low-power
> > state if PM_QOS_FLAG_NO_POWER_OFF is requested for the device and it
> > will not require remote wakeup to work for the device in the returned
> > low-power state if there is at least one PM QoS flags request for the
> > device, but PM_QOS_FLAG_REMOTE_WAKEUP is not requested for it.
> > 
> > Accordingly, acpi_pci_set_power_state() will refuse to put the
> > device into D3cold if PM_QOS_FLAG_NO_POWER_OFF is requested for it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/acpi/sleep.c   |   16 ++++++++++++----
> >  drivers/pci/pci-acpi.c |    8 +++++++-
> >  2 files changed, 19 insertions(+), 5 deletions(-)
> > 
> > Index: linux/drivers/pci/pci-acpi.c
> > ===================================================================
> > --- linux.orig/drivers/pci/pci-acpi.c
> > +++ linux/drivers/pci/pci-acpi.c
> > @@ -17,6 +17,7 @@
> >  
> >  #include <linux/pci-acpi.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_qos.h>
> >  #include "pci.h"
> >  
> >  static DEFINE_MUTEX(pci_acpi_pm_notify_mtx);
> > @@ -257,11 +258,16 @@ static int acpi_pci_set_power_state(stru
> >  		return -ENODEV;
> >  
> >  	switch (state) {
> > +	case PCI_D3cold:
> > +		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
> > +				PM_QOS_FLAGS_ALL) {
> > +			error = -EBUSY;
> > +			break;
> > +		}
> >  	case PCI_D0:
> >  	case PCI_D1:
> >  	case PCI_D2:
> >  	case PCI_D3hot:
> > -	case PCI_D3cold:
> >  		error = acpi_bus_set_power(handle, state_conv[state]);
> >  	}
> >  
> > Index: linux/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux.orig/drivers/acpi/sleep.c
> > +++ linux/drivers/acpi/sleep.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_qos.h>
> >  
> >  #include <asm/io.h>
> >  
> > @@ -711,6 +712,7 @@ int acpi_pm_device_sleep_state(struct de
> >  	struct acpi_device *adev;
> >  	char acpi_method[] = "_SxD";
> >  	unsigned long long d_min, d_max;
> > +	bool wakeup = false;
> >  
> >  	if (d_max_in < ACPI_STATE_D0 || d_max_in > ACPI_STATE_D3)
> >  		return -EINVAL;
> > @@ -718,6 +720,8 @@ int acpi_pm_device_sleep_state(struct de
> >  		printk(KERN_DEBUG "ACPI handle has no context!\n");
> >  		return -ENODEV;
> >  	}
> > +	if (dev_pm_qos_flags(dev, PM_QOS_FLAG_NO_POWER_OFF) == PM_QOS_FLAGS_ALL)
> > +		d_max_in = ACPI_STATE_D3_HOT;
> 
> In theory, d_max_in may < ACPI_STATE_D3_HOT.

Good catch!

> So better to be
> 
> d_max_in = min_t(int, d_max_in, ACPI_STATE_D3_HOT);

In fact, we don't even need to check the PM  QoS flags if d_max_in is not D3_COLD.

> But in fact, d_max_in is introduced to support something similar to
> PM_QOS_FLAG_NO_POWER_OFF, so I think we can remove d_max_in in the
> future.

We probably can, but for now I'll fix the patch.

Thanks,
Rafael
