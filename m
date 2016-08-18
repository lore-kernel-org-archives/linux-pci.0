Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Thu, 18 Aug 2016 16:02:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 0/3] Limiting pci access requests
Message-ID: <20160818140213.GA10631@wunner.de>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <20160809173633.GF27301@localhost>
 <20160809185654.GA32692@localhost.localdomain>
 <20160809185628.GA6729@wunner.de>
 <20160817210539.GA25146@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160817210539.GA25146@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 17, 2016 at 05:05:40PM -0400, Keith Busch wrote:
> On Tue, Aug 09, 2016 at 08:56:28PM +0200, Lukas Wunner wrote:
> > On Tue, Aug 09, 2016 at 02:56:54PM -0400, Keith Busch wrote:
> > > There are still more places that we can remove unnecessary config and
> > > MMIO, though they're just micro-improvements compared to this series.
> > > Even those just repeat the same pattern of looking for a -1 completion
> > > or false return from "pci_device_is_present". So the "fixes" do look
> > > tedious and piecemeal, but I didn't see how else we could do it. Any
> > > thoughts or guidance is much appreciated.
> > 
> > FWIW, similar checks were added to pciehp with commit 1469d17dd341
> > ("PCI: pciehp: Handle invalid data when reading from non-existent
> > devices"). So the general idea to handle such faults is already
> > present in the kernel, the only improvement I could see here would
> > be to harmonize (i.e. make identical everywhere) the way this is
> > coded (check for ~0) as well as the message logged with KERN_INFO
> > (your patches do not log a message at all AFAICS).
> 
> AFAICT, the only thing we can do is have every caller of
> pci_read_config_*, pci_bus_read_config_*, and pcie_capability_read_*
> check for ~0 completion, and handle accordingly. Is that what you mean
> by making this identical everywhere?  That is a lot of places to fix! :)

Littering the code with such checks won't improve its readability
so we ought to put that where it's really needed. I just meant that
the way the check is written in the code and the accompanying log
message should probably be made identical to improve readability
and clarity.

TBH I don't understand exactly how you trigger these errors. Re-reading
patch [1/3], I can only guess that pci_find_next_ext_capability() might
be called from aerdrv via pci_find_ext_capability(). The other patches
concern aerdrv, so that guess seems plausible. Explaining the call stack
would be helpful.

How is it possible that a device is accessed that no longer exists?
Are these (native) pciehp ports and the attached pci_dev isn't torn
down quickly enough? Do we need some kind of locking or an atomic flag
that prevents accesses to devices until they're torn down completely?

Since your patches pertain to aerdrv, do we need synchronization between
the pciehp and aer drivers so that aer doesn't touch a device for which
pciehp has sensed removal? (Is the interrupt shared between pciehp and
aerdrv?)

Thanks,

Lukas
