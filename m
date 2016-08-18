Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Thu, 18 Aug 2016 12:05:16 -0400
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 0/3] Limiting pci access requests
Message-ID: <20160818160516.GB27538@localhost.localdomain>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <20160809173633.GF27301@localhost>
 <20160809185654.GA32692@localhost.localdomain>
 <20160809185628.GA6729@wunner.de>
 <20160817210539.GA25146@localhost.localdomain>
 <20160818140213.GA10631@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818140213.GA10631@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 04:02:13PM +0200, Lukas Wunner wrote:
> TBH I don't understand exactly how you trigger these errors. Re-reading
> patch [1/3], I can only guess that pci_find_next_ext_capability() might
> be called from aerdrv via pci_find_ext_capability(). The other patches
> concern aerdrv, so that guess seems plausible. Explaining the call stack
> would be helpful.

Yes, I believe the majority of what we observed in protocol traces did
originate from the aer driver.

pci_find_capability already breaks early on an all 1's, so patch 1/3
just provides the same benefit to searching the extended capabilities.

Caching the AER capability may obviate the immediate benefit of 1/3,
but I think it's still a good change.
 
> How is it possible that a device is accessed that no longer exists?

Surprise hot removal.

> Are these (native) pciehp ports and the attached pci_dev isn't torn
> down quickly enough? Do we need some kind of locking or an atomic flag
> that prevents accesses to devices until they're torn down completely?

Tearing down a device and unbinding it from a driver generates lots of
additional accesses. Patch 2/3 removes MSI-x teardown which was one of
the larger sources of config and MMIO access to a non-existent device.

There are others, too. Heck, even checking if the device is present
(pci_device_is_present) generates config access to the removed device. :)

What do you think about adding a state to the pci_dev to say that it is
removed? The state can be set by pciehp or pcie-dpc if either detects
removal or link down, or on the first ~0 completion. Then have the
teardown check for the removal state before doing orderly device removal.

> Since your patches pertain to aerdrv, do we need synchronization between
> the pciehp and aer drivers so that aer doesn't touch a device for which
> pciehp has sensed removal? (Is the interrupt shared between pciehp and
> aerdrv?)

pciehp and aerdrv can share an interrupt on root ports, but that's it.
The aer driver, though, does access every device in its sub-tree.
There's also pciehp and pcie-dpc that could benifit from coordination.

I can look into these, but it's much less trivial than these incremental
improvements. I'm hoping we can clean up these biggest offenders first
before attempting a more risky synchronization among the different
services.

I have a v2 series ready that addresses Bjorn's comment on caching AER cap
position, but that's the only difference I've accumulated so far from v1.

Thanks,
 Keith
