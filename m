Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52506 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbcEKOxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 10:53:11 -0400
Date: Wed, 11 May 2016 09:53:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Engraf <david.engraf@sysgo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] Re: Exception due to PCI: Use pci_is_root_bus() to check
 for root bus
Message-ID: <20160511145306.GA21753@localhost>
References: <5704F85B.4080501@sysgo.com>
 <20160406133502.GB4976@localhost>
 <570516CB.7080406@sysgo.com>
 <571E15EF.9080507@sysgo.com>
 <20160425165956.GA1759@localhost>
 <5732D98C.9030702@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5732D98C.9030702@sysgo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Wed, May 11, 2016 at 09:04:44AM +0200, David Engraf wrote:
> Hi Bjorn,
> 
> Am 25.04.2016 um 18:59 schrieb Bjorn Helgaas:
> >Hi David,
> >
> >On Mon, Apr 25, 2016 at 03:04:47PM +0200, David Engraf wrote:
> >>Hi Bjorn,
> >>
> >>Am 06.04.2016 um 16:01 schrieb David Engraf:
> >>>Hi Bjorn,
> >>>
> >>>Am 06.04.2016 um 15:35 schrieb Bjorn Helgaas:
> >>>>Hi David,
> >>>>
> >>>>On Wed, Apr 06, 2016 at 01:51:55PM +0200, David Engraf wrote:
> >>>>>Hi,
> >>>>>
> >>>>>I have an exception in __pci_bus_size_bridges() when pci_is_root_bus
> >>>>>returns false but bus->self == NULL. My driver registers a virtual
> >>>>>bus, like virtfn_add_bus(). pci_add_new_bus() is called with a
> >>>>>parent but without a pci_dev. Thus bus->parent is set but bus->self
> >>>>>is NULL. When __pci_bus_size_bridges() is called I get an exception
> >>>>>at:
> >>>>>
> >>>>>switch (bus->self->class >> 8)
> >>>>>
> >>>>>The previous version of the code, checking for bus->self != NULL
> >>>>>worked for me. I think an additional check is required to make sure
> >>>>>we're not accessing a NULL pointer.
> >>>>
> >>>>When you say "previous version of the code," do you mean a previous
> >>>>version of Linux worked correctly but a newer version does not?  What
> >>>>versions are they?  Did you identify a commit that changed the
> >>>>behavior?  I assume you're talking about an out-of-tree driver that
> >>>>registers a virtual bus?  Can you point us to the code?  Can you share
> >>>>the dmesg log, including the backtrace?
> >>>
> >>>With previous version, I mean reverting commit
> >>>2ba29e270e977b213a7d58ae1152c23a1c3074a3. This will check for bus->self
> >>>instead of using pci_is_root_bus().
> >>>I'm working on a driver which is basically based on drivers/pci/iov.c.
> >>>
> >>>The code looks like this:
> >>>
> >>>child = pci_add_new_bus(parent, NULL, busnr);
> >>>
> >>>This will create child with child->parent = parent and child->self =
> >>>NULL. When the kernel calls __pci_bus_size_bridges(), accessing
> >>>bus->self->class crashes:
> >>>
> >>>/* The root bus? */
> >>>if (pci_is_root_bus(bus))
> >>>     return;
> >>>
> >>>switch (bus->self->class >> 8) { <- crash here because of bus->self == NULL
> >>
> >>With this patch the system no longer crashes and the virtual PCI bus
> >>works. It returns on bus->self == NULL, thus the switch instruction
> >>does not access a NULL pointer.
> >
> >This would need a changelog and Signed-off-by before I could apply it;
> >see
> >https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches
> >
> >The changelog should explain why this is the correct fix.  It's easy
> >to fix any NULL pointer dereference by adding a check for the NULL
> >pointer, but that's not always the correct fix.
> >
> >This particular case is in the resource assignment path, so we need to
> >think about how resource assignment works for your virtual PCI bus.
> >What exactly is your PCI topology?  Apparently you have a virtual PCI
> >bus without a standard PCI-PCI bridge leading to it?  That sounds
> >similar in some ways to the virtual bus for SR-IOV VFs, and in some
> >ways to the virtual root bus constructed for drivers like
> >drivers/pci/host/pci-hyperv.c and arch/x86/pci/vmd.c.
> 
> Please have a look at drivers/pci/iov.c:virtfn_add_bus(). This is
> the code I'm using for adding a virtual PCI bus. It calls
> pci_add_new_bus() with dev = NULL, thus the new child sets the
> member "self" to NULL. We could also forbid using NULL for the
> second parameter of pci_add_new_bus() but I have no idea how a
> virtual PCI bus without a real device will work in this case. If you
> agree I will resend my patch with a description.

Just send the patch and description.  If I don't agree or think it
needs tweaking, we can iterate on it.  There's not much point in me
trying to evaluate a prose argument by itself: I might agree with the
argument but still disagree with the implementation.  Or, as often
happens, I might agree with the implementation, but try to refine the
description.

> >There are already several special cases for the SR-IOV virtual buses
> >and for root buses, so I'd like to understand better how your bus fits
> >into the landscape.  Your driver apparently isn't part of the kernel
> >source, so if we add special cases for it, they're hard to maintain
> >because we can't see the code that relies on them.

I'd still like to see this part addressed so I can get a sense of how
to integrate this into the SR-IOV, VMD, and Hyper-V landscape.

> >>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> >>index 55641a3..ddb3381 100644
> >>--- a/drivers/pci/setup-bus.c
> >>+++ b/drivers/pci/setup-bus.c
> >>@@ -1245,6 +1245,10 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >>  	if (pci_is_root_bus(bus))
> >>  		return;
> >>
> >>+	/* bridge device available? */
> >>+	if (!bus->self)
> >>+		return;
> >>+
> >>  	switch (bus->self->class >> 8) {
> >>  	case PCI_CLASS_BRIDGE_CARDBUS:
> >>  		/* don't size cardbuses yet. */
> >
> 
