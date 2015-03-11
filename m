Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alex Williamson <alex.williamson@redhat.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
	mingo@redhat.com, bp@alien8.de, lv.zheng@intel.com, hpa@zytor.com,
	tglx@linutronix.de, yinghai@kernel.org, lenb@kernel.org,
	linux-pci@vger.kernel.org, tony.luck@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Fully disable devices before releasing IRQ resource
Date: Wed, 11 Mar 2015 23:04:19 +0100
Message-ID: <2139068.CEUJTvBkYG@vostro.rjw.lan>
In-Reply-To: <1426092450.3643.7.camel@redhat.com>
References: <20150305210529.6393.29546.stgit@gimli.home> <1425613912.5200.344.camel@redhat.com> <1426092450.3643.7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 11, 2015 10:47:30 AM Alex Williamson wrote:
> On Thu, 2015-03-05 at 20:51 -0700, Alex Williamson wrote:
> > On Fri, 2015-03-06 at 09:49 +0800, Jiang Liu wrote:
> > > On 2015/3/6 5:06, Alex Williamson wrote:
> > > > The IRQ resource for a device is established when pci_enabled_device()
> > > > is called on a fully disabled device (ie. enable_cnt == 0).  With
> > > > commit b4b55cda5874 ("x86/PCI: Refine the way to release PCI IRQ
> > > > resources") this same IRQ resource is released when the driver is
> > > > unbound from the device, regardless of the enable_cnt.  This presents
> > > > the situation that an ill-behaved driver can now make a device
> > > > unusable to subsequent drivers by an imbalance in their use of
> > > > pci_enable/disable_device().  It's one thing to break your own device
> > > > if you're one of these ill-behaved drivers, but it's a serious
> > > > regression for secondary drivers like vfio-pci, which are innocent
> > > > of the transgressions of the previous driver.
> > > > 
> > > > Resolve by pushing the device to a fully disabled state before
> > > > releasing the IRQ resource.
> > > > 
> > > > Fixes: b4b55cda5874 ("x86/PCI: Refine the way to release PCI IRQ resources")
> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > Cc: Jiang Liu <jiang.liu@linux.intel.com>
> > > > ---
> > > >  arch/x86/pci/common.c |   13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> > > > index 3d2612b..4810194 100644
> > > > --- a/arch/x86/pci/common.c
> > > > +++ b/arch/x86/pci/common.c
> > > > @@ -527,8 +527,19 @@ static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,
> > > >  	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
> > > >  		return NOTIFY_DONE;
> > > >  
> > > > -	if (pcibios_disable_irq)
> > > > +	if (pcibios_disable_irq) {
> > > > +		/*
> > > > +		 * Broken drivers may allow a device to be .remove()'d while
> > > > +		 * still enabled.  pci_enable_device() will only re-establish
> > > > +		 * dev->irq if the devices is fully disabled.  So if we want
> > > > +		 * to release the IRQ, we need to make sure the next driver
> > > > +		 * can re-establish it using pci_enable_device().
> > > > +		 */
> > > > +		while (pci_is_enabled(dev))
> > > > +			pci_disable_device(dev);
> > > > +
> > > >  		pcibios_disable_irq(dev);
> > > > +	}
> > > Hi Alex,
> > > 	Thanks for debugging and fixing it.
> > > 	Will it be feasible to give a debug message to remind those
> > > driver authors to correctly disable PCI when unbinding?
> > 
> > I can certainly add a warning to the loop, it loses a bit of its teeth
> > here though since we can't specify which driver to blame at this point.
> > Maybe that warning and perhaps this enabling roll-back should happen in
> > drivers/pci/pci-driver.c:pci_device_remove().  Bjorn, would you prefer
> > it be done generically there?  Thanks,
> 
> Unfortunately there's a long standing comment in pci_device_remove():
> 
>         /*
>          * We would love to complain here if pci_dev->is_enabled is set, that
>          * the driver should have called pci_disable_device(), but the
>          * unfortunate fact is there are too many odd BIOS and bridge setups
>          * that don't like drivers doing that all of the time.
>          * Oh well, we can dream of sane hardware when we sleep, no matter how
>          * horrible the crap we have to deal with is when we are awake...
>          */
> 
> So, unless we can somehow ignore that comment, I suspect forcing the
> device to be disabled on driver remove, whether done from pci-core or
> from x86/pci, is going to cause all sorts of breakage.  Are the
> expectations set by b4b55cda5874 really valid?  It seems like something
> needs to be done to allow the IRQ to be automatically re-established on
> x86 regardless of the driver doing the right thing when releasing the
> device.  We're still looking at a regression for v4.0 as a result of
> b4b55cda5874.

In which case we probably should revert commit b4b55cda5874 for the time being.

At least I'd be very nervous about any ad-hoc fixes at this stage of the cycle.

Gerry?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
