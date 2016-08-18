Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Thu, 18 Aug 2016 18:59:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 0/3] Limiting pci access requests
Message-ID: <20160818165921.GA10737@wunner.de>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <20160809173633.GF27301@localhost>
 <20160809185654.GA32692@localhost.localdomain>
 <20160809185628.GA6729@wunner.de>
 <20160817210539.GA25146@localhost.localdomain>
 <20160818140213.GA10631@wunner.de>
 <20160818160516.GB27538@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818160516.GB27538@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 12:05:16PM -0400, Keith Busch wrote:
> On Thu, Aug 18, 2016 at 04:02:13PM +0200, Lukas Wunner wrote:
> > How is it possible that a device is accessed that no longer exists?
> 
> Surprise hot removal.
> 
> > Are these (native) pciehp ports and the attached pci_dev isn't torn
> > down quickly enough? Do we need some kind of locking or an atomic flag
> > that prevents accesses to devices until they're torn down completely?
> 
> Tearing down a device and unbinding it from a driver generates lots of
> additional accesses. Patch 2/3 removes MSI-x teardown which was one of
> the larger sources of config and MMIO access to a non-existent device.
> 
> There are others, too. Heck, even checking if the device is present
> (pci_device_is_present) generates config access to the removed device. :)
> 
> What do you think about adding a state to the pci_dev to say that it is
> removed? The state can be set by pciehp or pcie-dpc if either detects
> removal or link down, or on the first ~0 completion. Then have the
> teardown check for the removal state before doing orderly device removal.

Exactly.

Attribute names that come to mind: "removed", "hot_removed",
"surprise_removed", perhaps with an "is_" prefix.

In principle this could be checked at the lowest level when
accessing config space in drivers/pci/access.c, and immediately
return ~0. With the check wrapped in unlikely().

aerdrv is not the only driver that has trouble with surprise removal:
Unplugging the Thunderbolt Ethernet adapter on a Mac while the interface
is up currently causes a lockup in the tg3 driver. Same with nouveau,
which often queries a timer on the GPU and ends up in an infinite loop
if the timer readout returns with -1. If the drivers could sense hot
removal by querying a flag, they could react accordingly in their
->remove hook, so this would be a real improvement.

> > Since your patches pertain to aerdrv, do we need synchronization between
> > the pciehp and aer drivers so that aer doesn't touch a device for which
> > pciehp has sensed removal? (Is the interrupt shared between pciehp and
> > aerdrv?)
> 
> pciehp and aerdrv can share an interrupt on root ports, but that's it.
> The aer driver, though, does access every device in its sub-tree.
> There's also pciehp and pcie-dpc that could benifit from coordination.
> 
> I can look into these, but it's much less trivial than these incremental
> improvements. I'm hoping we can clean up these biggest offenders first
> before attempting a more risky synchronization among the different
> services.

There's no synchronization necessary if there's just a flag to be
checked. Of course if aerdrv/dpc or other drivers need to react
immediately on hot removal, we'd need a separate ->hot_remove hook.

Best regards,

Lukas
