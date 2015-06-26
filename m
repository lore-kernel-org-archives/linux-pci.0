Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61057 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbbFZUfv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2015 16:35:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Duc Dang <dhdang@apm.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	patches <patches@apm.com>, linux-kernel@vger.kernel.org,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH 1/1] pci: xgene: Enable huge outbound bar support
Date: Fri, 26 Jun 2015 22:35:08 +0200
Message-ID: <46305464.n5SOjGAhJb@wuerfel>
In-Reply-To: <CADaLNDkck5TaG48sjF9y1wrXTzUeVkYOsXw7Dm8a629KqBafFg@mail.gmail.com>
References: <1435280756-24455-1-git-send-email-dhdang@apm.com> <1692416.bxUuWm82Pk@wuerfel> <CADaLNDkck5TaG48sjF9y1wrXTzUeVkYOsXw7Dm8a629KqBafFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 26 June 2015 11:56:47 Duc Dang wrote:
> Hi Arnd,
> 
> On Fri, Jun 26, 2015 at 12:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 25 June 2015 18:05:56 Duc Dang wrote:
> >> X-Gene PCIe controllers support huge outbound BARs (with size upto
> >> 64GB). This patch configures additional 1 outbound BAR for X-Gene
> >> PCIe controllers with size larger than 4GB. This is required to
> >> support devices that request huge outbound memory (nVidia K40 as an
> >> example)
> >>
> >> Signed-off-by: Duc Dang <dhdang@apm.com>
> >> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> >> ---
> >>  arch/arm64/boot/dts/apm/apm-storm.dtsi | 33 +++++++++++++++++++--------------
> >>  drivers/pci/host/pci-xgene.c           |  6 +++++-
> >>  2 files changed, 24 insertions(+), 15 deletions(-)
> >
> > It seems you do multiple things here:
> >
> > - add an entry in the ranges
> > - move the config space
> > - fix driver to handle multiple memory ranges
> >
> > but your description only mentions the first one. Please submit separate
> > patches for these and explain for each patch why it is required, so we can
> > pick them up into the arm-soc and pci git repositories separately, and make
> > sure that each patch works by itself to guarantee we don't get incompatible
> > binding changes.
> 
> Move config space can be in a separate patch. But it is not absolutely
> necessary to move the configuration space. The reason I change it is
> to have config space starting from the beginning of SoC PCIe physical
> address space. I will drop it in next patch.
> 
> But add 'an entry in the ranges' and 'fix driver to handle multiple
> memory ranges' should go together as single patch because the old
> driver will break when it sees multiple ranges.
> 
> >
> >> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> >> index d8f3a1c..039206b 100644
> >> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> >> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> >> @@ -404,10 +404,11 @@
> >>                       #size-cells = <2>;
> >>                       #address-cells = <3>;
> >>                       reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
> >> -                             0xe0 0xd0000000 0x0 0x00040000>; /* PCI config space */
> >> +                             0xe0 0x00000000 0x0 0x00040000>; /* PCI config space */
> >>                       reg-names = "csr", "cfg";
> >>                       ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000   /* io */
> >> -                               0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
> >> +                               0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000   /* mem */
> >> +                               0x02000000 0x10 0x00000000 0xf0 0x00000000 0x10 0x00000000>; /* mem */
> >>                       dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
> >>                                     0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
> >>                       interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> >
> > What is the reason for picking the 0x10.00000000 address? We normally try
> > to use an identity mapping (mem_offset=0) on the bus, or fall back to starting
> > at zero (mem_offset=cpu_offset), but you use seemingly random mem_offset values.
> >
> 
> I just randomly pick 0x10 00000000 as it is not used. I will change to
> use 0xf0 00000000:
> 0x02000000 0xf0 0x00000000 0xf0 0x00000000 0x10 0x00000000

Ok

> > Could you get the same effect by extending the 0x80000000 mapping to a length
> > of 58GB (just before the start of the second window)?
> 
> I don't think so. It will break with the PCIe device that requires 32-bit BAR.

Are you sure? If this is true, maybe this should be fixed in the PCI core.

> >
> > Can you configure one of the two windows as prefetchable for improved performance?
> >
> The new huge window will be prefetchable.

The DT marks it as non-prefetchable, so the kernel will now try to allocate
space for non-prefetchable BARs from this area, which is a bug. If the second
memory window is always prefetchable, you have to mark it accordingly in DT,
to prevent it from being used for normal 64 bit BARs.

> > I also notice that the 0x80000000-0xffffffff bus range is list both in
> > ranges and dma-ranges. Does that mean that devices on this host cannot
> > access MMIO ranges of other devices, or should you exclude this range from
> > the dma-ranges property?
> >
> 
> As I understand, the mem entries in 'ranges' are for controller to
> access remote PCIe devices (EP)  BAR; while the entries in
> 'dma-ranges'
> are for remote PCIe devices (EP) to access controller memory. So they
> are different. Or are you asking about something else?

Your understanding is correct, but from the perspective of a PCI device
the two are the same: when a device issues a bus master transaction,
the target can either be an MMIO BAR on the same PCI host, or it can
get turned into a DMA that ends up in RAM. The way you list the ranges,
it is a bit ambiguous about what happens when a transaction is targetted
at address 0x80000000: does your PCI host send that to a device with a
BAR at that address (CPU address 0xe1.80000000), or upstream to the
parent bus for CPU address 0x00.80000000?
> 
> > Style-wise, it would be nice to submit an extra patch that groups entries
> > in the ranges and reg lists like
> >
> >                         ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000>, /* io */
> >                                  <0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>, /* mem */
> >                                  <0x02000000 0x10 0x00000000 0xf0 0x00000000 0x10 0x00000000>; /* mem */
> >
> > but that is just a cosmetic change and should be kept separate.
> 
> Would you mind if I make this change as well and include in next patch?

It's normally better to keep cleanups and functional changes separate, so
better do two patches.

> >> @@ -321,8 +322,11 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
> >>                               return ret;
> >>                       break;
> >>               case IORESOURCE_MEM:
> >> -                     xgene_pcie_setup_ob_reg(port, res, OMR1BARL, res->start,
> >> +                     xgene_pcie_setup_ob_reg(port, res,
> >> +                                             OMR1BARL + (omr_idx * 0x18),
> >> +                                             res->start,
> >>                                               res->start - window->offset);
> >> +                     omr_idx++;
> >>                       break;
> >>               case IORESOURCE_BUS:
> >>                       break;
> >
> > Can you describe what happens when you boot an older kernel with the new
> > dt file, or vice versa? Will that simply ignore the first ranges entries
> > and use only the last one, or does it break in interesting ways?
> 
> Older kernel and new dtb: the new entry in 'ranges' will overwrite the
> old entry, so device that requires 32-bit BAR will break.
> New kernel and old dtb: works fine but without huge bar support.

Ok, so the patches cannot trivially get merged through separate trees,
but have to be ordered. Please split up the driver change from the
DT change anyway, and then we can decide whether to take both through
arm-soc or the PCI tree.

Regarding the functional change, I suppose you should take prefetchable/
non-prefetchable settings into account here. My guess is that the first
window is always non-prefetchable, while the second one is always
prefetchable. If that is the case, it would be more robust to replace
the counter with another conditional that looks at the IORESOURCE_PREFETCH
flag to decide which register to program.

If you have more than two windows, better do both and use a total of
four windows for all combinations of 32/64 bit addressing and prefetch.

	Arnd
