Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 15 Sep 2016 15:11:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 4/4] PCI: Avoid unnecessary resume on shutdown
Message-ID: <20160915131125.GA2196@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de>
 <9f9152c11c6178bbac53fd3d0ef0d38173ad4b0b.1472554278.git.lukas@wunner.de>
 <2217882.yevB8EWaHc@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2217882.yevB8EWaHc@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 02:29:52AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> > We currently perform a mandatory runtime resume of all PCI devices on
> > ->shutdown.  However it is pointless to wake devices only to immediately
> > power them down afterwards.  (Or have the firmware reset them, in case
> > of a reboot.)
> > 
> > It seems there are only two cases when a runtime resume is actually
> > necessary:  If the driver has declared a ->shutdown callback or if kexec
> > is in progress.
> > 
> > Constrain resume of a device to these cases and let it slumber
> > otherwise, thereby conserving energy and speeding up shutdown.
> > 
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/pci-driver.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index fd4b9c4..09a4e56 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -459,6 +459,11 @@ static void pci_device_shutdown(struct device *dev)
> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> >  	struct pci_driver *drv = pci_dev->driver;
> >  
> > +	/* Fast path for suspended devices */
> > +	if (pm_runtime_suspended(dev) && (!drv || !drv->shutdown) &&
> > +	    !kexec_in_progress)
> 
> What happens if runtime suspend or resume of the device happens here?

You're right, good point.  How about disabling runtime PM then, like this:

	/* Fast path for suspended devices */
	if (pm_runtime_status_suspended(dev) && (!drv || !drv->shutdown) &&
	    !kexec_in_progress) {
		pm_runtime_disable(dev);
		if (pm_runtime_status_suspended(dev))
			return;
		pm_runtime_enable(dev);
	}

All dependents (children, and in the future, consumers) should already
have been treated at that point, due to the ordering of devices_kset->list.

Thanks!

Lukas
