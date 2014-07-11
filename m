Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30259 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbaGKNqK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 09:46:10 -0400
Date: Fri, 11 Jul 2014 09:45:58 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: David Vrabel <david.vrabel@citrix.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 2/2] xen-pciback: provide a "reset" sysfs file to try
 harder at an SBR
Message-ID: <20140711134558.GB10250@laptop.dumpdata.com>
References: <1404997394-15715-1-git-send-email-david.vrabel@citrix.com>
 <1404997394-15715-3-git-send-email-david.vrabel@citrix.com>
 <1405034054.4098.39.camel@ul30vt.home>
 <53BFB41C.3030703@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53BFB41C.3030703@citrix.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 11, 2014 at 10:53:32AM +0100, David Vrabel wrote:
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

You could use an

pci_walk_bus(dev->bus, pcistub_pci_walk_wrapper, &arg);

to check that all of them belong to pciback (see 
https://lkml.org/lkml/2014/7/8/782)


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
> 
> An alternate interface would be to provide "bus_reset" knobs and have
> the toolstack understand the bus topology and issue the appropriate bus
> reset if it determines it is safe and per-function reset isn't
> available.  This seems like considerably more work both kernel and
> toolstack side.

In regards to alternative interface, I presume you are referring
to the 'do_flr' one I posted?


In that I thought it would be easier to implement this logic in the kernel
since it has a pretty good idea of the bus->device topology is and
better yet there is ton of good code in PCI API to use it. And it can
figure these sort of things out pretty easily - like do not do the bus reset
if say the devices are not all owned by pciback).

See https://lkml.org/lkml/2014/7/8/782

Now the one part I hadn't thought about is 'safe'?
The 'per-function reset isn't available' is certainy part of the patch.

FYI, I had a different piece of code (not posted) which would add per
device the 'do_flr' (so similar to 'reset') and would do the appropiate
checks and do the bus reset if all the conditions were meet. As in
instead of 'do_flr' in /sys/bus/pci/drivers/pciback/do_flr it would
be in /sys/bus/pci/devices/0000:04:00.0/do_flr (if 04:00.0 was owned
by pciback).

is ce


> 
> David
