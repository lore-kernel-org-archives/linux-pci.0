Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:33286 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813AbaBZRsD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 12:48:03 -0500
Date: Wed, 26 Feb 2014 17:46:59 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v4] PCI: ARM: add support for generic PCI host controller
Message-ID: <20140226174659.GF12882@mudshark.cambridge.arm.com>
References: <1393268359-17224-1-git-send-email-will.deacon@arm.com>
 <1721648.K4nYY7eS55@wuerfel>
 <20140225180111.GF23136@mudshark.cambridge.arm.com>
 <201402252330.34236.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201402252330.34236.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Tue, Feb 25, 2014 at 10:30:33PM +0000, Arnd Bergmann wrote:
> On Tuesday 25 February 2014, Will Deacon wrote:
> > I need the alignment code so I can handle being passed a CPU physical
> > address which isn't 64K aligned. In this case, pci_ioremap_io needs a 64K
> > aligned address so that the __io macro does the right thing.
> 
> I still don't see why pci_ioremap_io needs 64K alignment. For all I can tell,
> it just needs a page-aligned address.

I misread __io as an '|' rather than a '+'. You're right, we just need page
alignment for the mapping.

> > For example, I can tell kvmtool to place I/O space at CPU physical 0x16000,
> > bus address 0x6000 (so ports 0x0-0x5fff are unavailable). In that case, I
> > still need to map those lower ports for the __io macro to offset into the
> > window correctly.
>  
> I don't think so. pci_ioremap_io will still try to map 64K of address space,
> but you can map 0x16000-0x25fff to PCI_IO_VIRT_BASE. The io_offset in
> that case will be negative (-0x6000).

Yes, and that means that all this rounding is unnecessary; I can just fail
addresses that aren't page-aligned (which is much more reasonable).

> > 	of_pci_range_to_resource(range, dev->of_node, res);
> > 	res->start = window + range->pci_addr;
> > 	res->end = res->start + range->size - 1;
> > 	*offset = window - range->pci_addr;
> > 	return 0;
> > }
> 
> The offset is good now, but the start is not: res->start refers to
> the linux I/O space and should just be 'window' here. Adding up
> window and pci_addr makes no sense. Think of the case where you
> have two host bridges, one using bus address 0x0-0xffff and the other
> one using 0x10000-0x1ffff. You really want the first one to
> have res->start=0 and the second one res->start=0x10000, and
> using offset=0. Instead the second one get start=0x20000,
> which is wrong in both CPU and bus space.

Aha, so res->start is the offset into our virtual I/O space at which the
window starts? That's what I've been getting wrong -- I thought res->start
was a PCI bus address for some reason.

> The round_down() also still gets you into trouble here, because you
> don't adjust the start or the size.

I'll just get rid of the rounding.

> > If I do:
> > 
> > 	*offset = window;
> > 
> > then things work as expected (this is all referring back to the kvmtool example
> > I mentioned earlier in this mail).
> 
> Yes, but only only because you have two bugs that cancel each other out
> to some degree. It only works for the first bus though, as explained
> above: if offset is >0, the Linux I/O port number that gets assigned
> in the resource is no longer the one that maps to the one in your
> virtual address space pointing to the right physical address.

Ok, so taking all this on board I end up with the diff below (against v4).
It seems to work well with my kvmtool setup:

  pci_bus 0000:00: root bus resource [io  0x0000-0x9fff] (bus address [0x6000-0xffff])

Will

--->8

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 71b0960772ec..b761f3e64a6a 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -133,30 +133,25 @@ static int gen_pci_calc_io_offset(struct device *dev,
 {
        static atomic_t wins = ATOMIC_INIT(0);
        int err, idx, max_win;
-       unsigned int io_offset;
+       unsigned int window;
 
-       /* Ensure the CPU physical address is aligned to a 64K boundary */
-       range->size += range->cpu_addr & (SZ_64K - 1);
-       range->cpu_addr = round_down(range->cpu_addr, SZ_64K);
-       range->pci_addr = round_down(range->pci_addr, SZ_64K);
-
-       if (range->size > SZ_64K)
-               return -E2BIG;
+       if (!PAGE_ALIGNED(range->cpu_addr))
+               return -EINVAL;
 
-       max_win = IO_SPACE_LIMIT + 1 / SZ_64K;
+       max_win = (IO_SPACE_LIMIT + 1) / SZ_64K;
        idx = atomic_inc_return(&wins);
        if (idx >= max_win)
                return -ENOSPC;
 
-       io_offset = (idx - 1) * SZ_64K;
-       err = pci_ioremap_io(io_offset, range->cpu_addr);
+       window = (idx - 1) * SZ_64K;
+       err = pci_ioremap_io(window, range->cpu_addr);
        if (err)
                return err;
 
        of_pci_range_to_resource(range, dev->of_node, res);
-       res->start = io_offset + range->pci_addr;
+       res->start = window;
        res->end = res->start + range->size - 1;
-       *offset = io_offset;
+       *offset = window - range->pci_addr;
        return 0;
 }
