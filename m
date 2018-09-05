Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeIEHOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 03:14:46 -0400
Date: Tue, 4 Sep 2018 20:46:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: RFC on PCI Device Lock
Message-ID: <20180904204649.415491f8@t450s.home>
In-Reply-To: <17720f56-2caa-2d2e-b655-867debf55934@kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
        <20180904165202.4e5bb59d@t450s.home>
        <17720f56-2caa-2d2e-b655-867debf55934@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 4 Sep 2018 18:12:16 -0700
Sinan Kaya <okaya@kernel.org> wrote:

> On 9/4/2018 3:52 PM, Alex Williamson wrote:
> > I won't deny that we're getting a little sloppy with some of the reset
> > interfaces and I'd love to solve the device lock issue more generally,
> > but trying to abstract slot vs bus and hide the lower level interfaces
> > from drivers doesn't seem like it's really working here.  Thanks,  
> 
> Counter argument is that drivers need to know about bus/slot distinction
> and call two different API for hotplug capable systems. I think that's
> too much to ask.
> 
> The motivation for original patch was that hotplug information was leaking
> and we could do a better job about it. But, you are right; I partially
> covered VFIO needs as it seemed to be doing more work than a simple
> reset due to ownership dependencies.

Maybe let's clarify what is the actual leak of the hotplug API to the
driver.  I think vfio assumes full responsibility here, it needs to
know the scope of the reset in order to determine whether the user has
ownership of all the devices affected by the reset.  In that case it's
even preferable that we have control of specifying which type of reset
is performed or else we open ourselves for the possibility that vfio-pci
and PCI-core could diverge and we don't get the reset we expect.  I
think that's a point against this sort of blind, unified reset
interface.

The hfi1 driver previously didn't care about hotplug slots, but the
case I see where they should have is if the slot enabled surprise
hotplug.  In that case their direct call to
pci_reset_bridge_secondary_bus might have triggered such an event;
surprise!  They also go to the trouble to manually save and restore
config space around the reset and make sure they're the only device
affected by the reset, so this really starts to sound like a place
where we should use a pci_reset_function type interface (though they
have quite a bit of setup working towards the SBR, so it may not be
trivial to convert).  In fact, we've even got and exported
__pci_reset_function_locked() which can already handle the device_lock
being held, but it will prefer function level resets before it gets to
the bus/slot resets that this driver wants.

It seems a common theme here is that the driver wants some degree of
control of the type of reset used, vfio specifically wants to specify a
bus or slot reset while hfi1 just wants to specify that the link is
reset and doesn't care if it's a bus or slot reset that accomplishes
that.  So maybe the right "unified" interface is one that takes a
parameter allowing the caller to specify the scope or type of reset
with aliases so drivers can ignore the hotplug interface if they wish.
An ugly version of that might be based around something like:

#define PCI_RESET_DEV_SPECIFIC	(1 << 0)
#define PCI_RESET_FLR		(1 << 1)
#define PCI_RESET_PM		(1 << 2)
#define PCI_RESET_SLOT		(1 << 3)
#define PCI_RESET_BUS		(1 << 4)

#define PCI_RESET_ANY		(~0)
#define PCI_RESET_FUNC		(PCI_RESET_DEV_SPECIFIC | \
				 PCI_RESET_FLR | PCI_RESET_PM)
#define PCI_RESET_LINK		(PCI_RESET_SLOT | PCI_RESET_BUS)

Thanks,
Alex
