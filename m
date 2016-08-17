Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Wed, 17 Aug 2016 17:05:40 -0400
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 0/3] Limiting pci access requests
Message-ID: <20160817210539.GA25146@localhost.localdomain>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <20160809173633.GF27301@localhost>
 <20160809185654.GA32692@localhost.localdomain>
 <20160809185628.GA6729@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160809185628.GA6729@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 09, 2016 at 08:56:28PM +0200, Lukas Wunner wrote:
> On Tue, Aug 09, 2016 at 02:56:54PM -0400, Keith Busch wrote:
> > There are still more places that we can remove unnecessary config and
> > MMIO, though they're just micro-improvements compared to this series.
> > Even those just repeat the same pattern of looking for a -1 completion
> > or false return from "pci_device_is_present". So the "fixes" do look
> > tedious and piecemeal, but I didn't see how else we could do it. Any
> > thoughts or guidance is much appreciated.
> 
> FWIW, similar checks were added to pciehp with commit 1469d17dd341
> ("PCI: pciehp: Handle invalid data when reading from non-existent
> devices"). So the general idea to handle such faults is already
> present in the kernel, the only improvement I could see here would
> be to harmonize (i.e. make identical everywhere) the way this is
> coded (check for ~0) as well as the message logged with KERN_INFO
> (your patches do not log a message at all AFAICS).

AFAICT, the only thing we can do is have every caller of
pci_read_config_*, pci_bus_read_config_*, and pcie_capability_read_*
check for ~0 completion, and handle accordingly. Is that what you mean
by making this identical everywhere?  That is a lot of places to fix! :)

I could write a coccinelle pattern for that, but the actual handling
would need to be specific to where it's called, and it may accidently
treat a legit all 1's completion as an error.
