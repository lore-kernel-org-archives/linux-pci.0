Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbaGKO3l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Jul 2014 10:29:41 -0400
Message-ID: <1405088973.4098.71.camel@ul30vt.home>
Subject: Re: [PATCH 2/2] xen-pciback: provide a "reset" sysfs file to try
 harder at an SBR
From: Alex Williamson <alex.williamson@redhat.com>
To: David Vrabel <david.vrabel@citrix.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date: Fri, 11 Jul 2014 08:29:33 -0600
In-Reply-To: <53BFB41C.3030703@citrix.com>
References: <1404997394-15715-1-git-send-email-david.vrabel@citrix.com>
		 <1404997394-15715-3-git-send-email-david.vrabel@citrix.com>
	 <1405034054.4098.39.camel@ul30vt.home> <53BFB41C.3030703@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-07-11 at 10:53 +0100, David Vrabel wrote:
> On 11/07/14 00:14, Alex Williamson wrote:
> > On Thu, 2014-07-10 at 14:03 +0100, David Vrabel wrote:
> >> The standard implementation of pci_reset_function() does not try an
> >> SBR if there are other sibling devices.  This is a common
> >> configuration for multi-function devices (e.g., GPUs with a HDMI audio
> >> device function).
> >>
> >> If all the functions are co-assigned to the same domain at the same
> >> time, then it is safe to perform an SBR to reset all functions at the
> >> same time.
> >>
> >> Add a "reset" sysfs file with the same interface as the standard one
> >> (i.e., write 1 to reset) that will try an SBR if all sibling devices
> >> are unbound or bound to pciback.
> >>
> >> Note that this is weaker than the requirement for functions to be
> >> simultaneously co-assigned, but the toolstack is expected to ensure
> >> this.
> [...]
> >> +/*
> >> + * pci_reset_function() will only work if there is a mechanism to
> >> + * reset that single function (e.g., FLR or a D-state transition).
> >> + * For PCI hardware that has two or more functions but no per-function
> >> + * reset, we can do a bus reset iff all the functions are co-assigned
> >> + * to the same domain.
> >> + *
> >> + * If a function has no per-function reset mechanism the 'reset' sysfs
> >> + * file that the toolstack uses to reset a function prior to assigning
> >> + * the device will be missing.  In this case, pciback adds its own
> >> + * which will try a bus reset.
> >> + *
> >> + * Note: pciback does not check for co-assigment before doing a bus
> >> + * reset, only that the devices are bound to pciback.  The toolstack
> >> + * is assumed to have done the right thing.
> >> + */
> >> +static int __pcistub_reset_function(struct pci_dev *dev)
> >> +{
> >> +	struct pci_dev *pdev;
> >> +	int ret;
> >> +
> >> +	ret = __pci_reset_function_locked(dev);
> >> +	if (ret == 0)
> >> +		return 0;
> >> +
> >> +	if (pci_is_root_bus(dev->bus) || dev->subordinate || !dev->bus->self)
> >> +		return -ENOTTY;
> >> +
> >> +	list_for_each_entry(pdev, &dev->bus->devices, bus_list) {
> > 
> > What if there are buses below this one?
> 
> Good point.
> 
> >> +static int pcistub_try_create_reset_file(struct pci_dev *pci)
> >> +{
> >> +	struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(pci);
> >> +	struct device *dev = &pci->dev;
> >> +	int ret;
> >> +
> >> +	/* Already have a per-function reset? */
> >> +	if (pci_probe_reset_function(pci) == 0)
> >> +		return 0;
> >> +
> >> +	ret = device_create_file(dev, &dev_attr_reset);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +	dev_data->created_reset_file = true;
> >> +	return 0;
> >> +}
> > 
> > So the idea here is that if pci-sysfs did not create a sysfs reset file,
> > create one when it's bound to pciback that does a secondary bus reset
> > instead of a reset isolated to the PCI function, right?  It seems like a
> > lot to ask of userspace to know that the extent of the reset depends on
> > the driver that it's bound to.  How does userspace figure this out when
> > the device is bound to pciback and _does_ support a function level
> > reset?  Overloading "reset" seems like a bad idea.
> 
> The idea is that this "reset" file will only do an SBR if the
> side-effect of resetting siblings is harmless.

Let's say you have a graphics card with the GPU function assigned.  The
VM is running and now you want to hot-add the audio function.  Is it
harmless to do an SBR to get the audio function into a clean state prior
to hotplug?  Of course not.  How does userspace know that the reset file
under a device is going to do a SBR vs a function-local reset?  It
doesn't.  This is exactly why VFIO has separate interfaces for these.
An SBR is only useful on create or reset of the entire VM while a
function-local reset can be used elsewhere.  Thanks,

Alex

> An alternate interface would be to provide "bus_reset" knobs and have
> the toolstack understand the bus topology and issue the appropriate bus
> reset if it determines it is safe and per-function reset isn't
> available.  This seems like considerably more work both kernel and
> toolstack side.
> 
> David



