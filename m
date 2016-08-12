Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:20810 "EHLO
	relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751148AbcHLJnu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2016 05:43:50 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: Question about dma-ranges property for PCI host controllers
Date: Fri, 12 Aug 2016 09:43:44 +0000
Message-ID: <HK2PR0601MB1393EA9F8117F8EC5A1E6520F51F0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <HK2PR0601MB1393CA771AB65556D4E2F0B9F51E0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
 <2867793.PfGZpZFyEJ@wuerfel>
In-Reply-To: <2867793.PfGZpZFyEJ@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 11 August 2016 16:09 Arnd Bergmann wrote:
> On Thursday, August 11, 2016 3:00:42 PM CEST Phil Edworthy wrote:
> > Hi,
> >
> > A few PCI host controllers use the "dma-ranges" property to specify the
> > mapping from PCI bus addresses to physical addresses.
> >
> > In the case of R-Car PCIe Host controllers, the intention was to set this
> > property as a 1 to 1 mapping for all DDR that could be addressed by the
> > device. However, there are some limitations for the R-Car controller which
> > meant that we could only map a subset of the DDR range - this limitation
> > has prompted us to work on enabling the IOMMU behind the PCI controller.
> >
> > When there is an IOMMU behind the PCI controller, the "dma-ranges"
> > property specifies the mapping from PCI bus addresses to an IOVA address.
> > So should the property map all address space?
> >
> > Note that this is not actually possible with the R-Car hardware, but I
> > found that the IOVA address space is outside of the DDR address space
> > that we were using so had change it.
> 
> It's a bit tricky: the dma-ranges properties are walked recursively,
> and a PCI bus may be behind a few other bridges that each have a
> nontrivial mapping, and the IOMMU may not be on the address space that
> the PCI host sees.
Luckily the mapping for R-Car is pretty simple, I can imagine it can get very
tricky!

> In the past, we have said that the dma-ranges property should reflect
> the address space that is used when programming the bridge registers
> in the PCI host bridge itself.
> 
> I think we have also made the assumption that a PCI host bridge
> with an IOMMU uses a flat 32-bit DMA address space that goes through
> the IOMMU (possibly a separate address space per PCI function,
> depending on the type of IOMMU).
I saw Robin Murphy's patches for PCI IOMMU map bindings, though at the
moment to get things going I'm ignoring it because it will require quite a lot
of changes to the iommu/ipmmu-vmsa driver. Other IOMMU drivers will
also have to change a fair bit to support this new binding.

> One corner case that doesn't really fit in that model is a PCI host
> bridge that requires the bridge register to be programmed in a special
> way for the IOMMU to work (e.g. away from the RAM to the address that
> is routed to the IOMMU).
In our case, there is nothing special in programming the bridge registers
for use with an IOMMU other than the range of addresses that is exposed.
The PCI host has a HW limitation that the AXI bus addresses must be
32-bit. The HW will allow you to set up the bridge registers so that PCI
bus addresses above 32-bits are mapped into the 32-bit AXI space. This
isn't used though at the moment, the PCI:AXI mapping is simply 1:1.

Simply changing the dma-ranges prop to specify all of the 32-bit range is
enough to get it to work with the IOMMU.

Without IOMMU, the dma-ranges prop was:
dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
Note that this does not cover all of DDR, as there is 3GiB above the 32-bit
address space. Other restrictions in the way the bridge registers are
programmed mean we cannot even map all DDR in the 32-bit space.

With the IOMMU, the dma-ranges prop is simply:
dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;

> Another tricky case is a PCI host that uses the IOMMU only for 32-bit
> DMA masters but that does have a dma-ranges property that can be
> used for direct mapping of all RAM through a nonzero offset that
> gets set up according to dma-ranges.
I don't think that applies, though I'm struggling a bit to understand your
comment.

> Can you be more specific which of those cases you actually have here?
Hopefully I have explained it above.

Many thanks
Phil
