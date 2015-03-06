Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34731 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbbCFDwW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Mar 2015 22:52:22 -0500
Message-ID: <1425613912.5200.344.camel@redhat.com>
Subject: Re: [PATCH] x86/PCI: Fully disable devices before releasing IRQ
 resource
From: Alex Williamson <alex.williamson@redhat.com>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org, rjw@rjwysocki.net, mingo@redhat.com, bp@alien8.de,
	lv.zheng@intel.com, hpa@zytor.com, tglx@linutronix.de,
	yinghai@kernel.org, lenb@kernel.org, linux-pci@vger.kernel.org,
	tony.luck@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Thu, 05 Mar 2015 20:51:52 -0700
In-Reply-To: <54F90790.7060204@linux.intel.com>
References: <20150305210529.6393.29546.stgit@gimli.home>
	 <54F90790.7060204@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-03-06 at 09:49 +0800, Jiang Liu wrote:
> On 2015/3/6 5:06, Alex Williamson wrote:
> > The IRQ resource for a device is established when pci_enabled_device()
> > is called on a fully disabled device (ie. enable_cnt == 0).  With
> > commit b4b55cda5874 ("x86/PCI: Refine the way to release PCI IRQ
> > resources") this same IRQ resource is released when the driver is
> > unbound from the device, regardless of the enable_cnt.  This presents
> > the situation that an ill-behaved driver can now make a device
> > unusable to subsequent drivers by an imbalance in their use of
> > pci_enable/disable_device().  It's one thing to break your own device
> > if you're one of these ill-behaved drivers, but it's a serious
> > regression for secondary drivers like vfio-pci, which are innocent
> > of the transgressions of the previous driver.
> > 
> > Resolve by pushing the device to a fully disabled state before
> > releasing the IRQ resource.
> > 
> > Fixes: b4b55cda5874 ("x86/PCI: Refine the way to release PCI IRQ resources")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Jiang Liu <jiang.liu@linux.intel.com>
> > ---
> >  arch/x86/pci/common.c |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> > index 3d2612b..4810194 100644
> > --- a/arch/x86/pci/common.c
> > +++ b/arch/x86/pci/common.c
> > @@ -527,8 +527,19 @@ static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,
> >  	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
> >  		return NOTIFY_DONE;
> >  
> > -	if (pcibios_disable_irq)
> > +	if (pcibios_disable_irq) {
> > +		/*
> > +		 * Broken drivers may allow a device to be .remove()'d while
> > +		 * still enabled.  pci_enable_device() will only re-establish
> > +		 * dev->irq if the devices is fully disabled.  So if we want
> > +		 * to release the IRQ, we need to make sure the next driver
> > +		 * can re-establish it using pci_enable_device().
> > +		 */
> > +		while (pci_is_enabled(dev))
> > +			pci_disable_device(dev);
> > +
> >  		pcibios_disable_irq(dev);
> > +	}
> Hi Alex,
> 	Thanks for debugging and fixing it.
> 	Will it be feasible to give a debug message to remind those
> driver authors to correctly disable PCI when unbinding?

I can certainly add a warning to the loop, it loses a bit of its teeth
here though since we can't specify which driver to blame at this point.
Maybe that warning and perhaps this enabling roll-back should happen in
drivers/pci/pci-driver.c:pci_device_remove().  Bjorn, would you prefer
it be done generically there?  Thanks,

Alex

