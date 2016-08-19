Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 19 Aug 2016 13:11:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 2/3] pci/msix: Skip disabling removed devices
Message-ID: <20160819171145.GB28276@localhost.localdomain>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <1470683667-28418-3-git-send-email-keith.busch@intel.com>
 <20160818232941.GT27353@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818232941.GT27353@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 06:29:41PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 08, 2016 at 01:14:26PM -0600, Keith Busch wrote:
> > @@ -999,6 +999,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
> >  	if (!pci_msi_enable || !dev || !dev->msix_enabled)
> >  		return;
> >  
> > +	if (!pci_device_is_present(dev)) {
> 
> It doesn't really make sense to me to use pci_device_is_present()
> (which calls pci_bus_read_dev_vendor_id()) for this purpose.

Roger that.

Based of some feedback from Lukas, it sounds like we could add a new
state to pci_dev for "is_removed" that can be set by pciehp or pcie-dpc.
Does that sound reasonable? If so, I think we can use that criteria
instead.
 
> Adding a new config read and checking for failure seems like just
> narrowing the window -- a device that stops responding between this
> point and the next required config read could still cause a problem.

That's true, but it's not a window that concerns us in real life. It just
doesn't really occur that a driver is unbinding from a device right as you
hot remove it. The driver is unbinding from the device _because_ it was
hot removed, so presence is down long before we release the MSI vectors.

But if we want to close that gab, it should be trivial if we can add the
is_removed state to pci_dev.

> Is this fixing a performance problem?  What's the specific motivation
> for this?

When you hot remove a device, a non-posted command to that device must be
handled by something. This is what I meant by "completion synthesis",
though I must have pulled that terminology from PCI DPC.

This series plus some additional enhancements we've made sense the
initial posting significantly reduces total teardown time. We've seen
transactions to non-existent devices go from ~1000 down to just 1. These
take on the order of milliseconds for hardware to produce the completion
that allows software to proceed, so the many unnecessary commands add
up very quickly and noticeably degrades user experience.

Also, considering Linux PCI enumeration is serialized with a single mutex,
this becomes a very big deal when hot plugging entire trays of devices.

If you would like, I would be happy setup a conference call to discuss
this further. We have protocol traces showing timings that I think make
a very compelling case for reducing our software overhead.

> And you also mention "instability with hardware" -- what exactly is
> that?  I understand some slowdown if we do config accesses to
> non-existent devices, but I don't understand hardware instability.

I should have left that description out. I'm just a software engineer, and
the root causes you may be looking for are at a lower level than I grok.

But since I already went there, I'll just say occasionally completion
timeout doesn't quite work on time. That's not supposed to happen,
but we don't always get perfection out of devices. After millions of
non-posted commands to devices that don't exist, rare cases of too many
completion timeouts result in machine checking NMI.

I can only say empirically, Linux just works better if we don't
gratuitously rely on hardware to cleanup software's unnecessary
transactions. That observation alone doesn't justify a change, so I hope
the improved hot plug teardown can carry this patch concept forward.
