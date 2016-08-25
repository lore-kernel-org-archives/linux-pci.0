Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:54770 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760071AbcHYQDR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2016 12:03:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: Question about dma-ranges property for PCI host controllers
Date: Thu, 25 Aug 2016 18:03:07 +0200
Message-ID: <3869406.UKMxvRzqOg@wuerfel>
In-Reply-To: <HK2PR0601MB1393EA9F8117F8EC5A1E6520F51F0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <HK2PR0601MB1393CA771AB65556D4E2F0B9F51E0@HK2PR0601MB1393.apcprd06.prod.outlook.com> <2867793.PfGZpZFyEJ@wuerfel> <HK2PR0601MB1393EA9F8117F8EC5A1E6520F51F0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, August 12, 2016 9:43:44 AM CEST Phil Edworthy wrote:
> On 11 August 2016 16:09 Arnd Bergmann wrote:

> > In the past, we have said that the dma-ranges property should reflect
> > the address space that is used when programming the bridge registers
> > in the PCI host bridge itself.
> > 
> > I think we have also made the assumption that a PCI host bridge
> > with an IOMMU uses a flat 32-bit DMA address space that goes through
> > the IOMMU (possibly a separate address space per PCI function,
> > depending on the type of IOMMU).
> I saw Robin Murphy's patches for PCI IOMMU map bindings, though at the
> moment to get things going I'm ignoring it because it will require quite a lot
> of changes to the iommu/ipmmu-vmsa driver. Other IOMMU drivers will
> also have to change a fair bit to support this new binding.

Ok

> > One corner case that doesn't really fit in that model is a PCI host
> > bridge that requires the bridge register to be programmed in a special
> > way for the IOMMU to work (e.g. away from the RAM to the address that
> > is routed to the IOMMU).
> In our case, there is nothing special in programming the bridge registers
> for use with an IOMMU other than the range of addresses that is exposed.
> The PCI host has a HW limitation that the AXI bus addresses must be
> 32-bit. The HW will allow you to set up the bridge registers so that PCI
> bus addresses above 32-bits are mapped into the 32-bit AXI space. This
> isn't used though at the moment, the PCI:AXI mapping is simply 1:1.
> 
> Simply changing the dma-ranges prop to specify all of the 32-bit range is
> enough to get it to work with the IOMMU.

That is the problem I was referring to above: the dma-ranges property
contents depend on whether the IOMMU is used or not, and that
is not something you know in the DT, because it depends on the OS.

> Without IOMMU, the dma-ranges prop was:
> dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;

Ok, so you map the second 1GB of PCI space into the second 1GB of AXI
space, which presumably is also the first 1GB of the physical RAM
at CPU address 0x00000000, correct?

> Note that this does not cover all of DDR, as there is 3GiB above the 32-bit
> address space. Other restrictions in the way the bridge registers are
> programmed mean we cannot even map all DDR in the 32-bit space.
> 
> With the IOMMU, the dma-ranges prop is simply:
> dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;

Does this mean the IOMMU virtual address space covers the entire 4GB
of low addresses, or is it a subset of that space, e.g. the first
1GB, below where the PCI bus sees the RAM?

> > Another tricky case is a PCI host that uses the IOMMU only for 32-bit
> > DMA masters but that does have a dma-ranges property that can be
> > used for direct mapping of all RAM through a nonzero offset that
> > gets set up according to dma-ranges.
> I don't think that applies, though I'm struggling a bit to understand your
> comment.

It doesn't apply since the 32-bit limitation you see is part of the
PCI host bridge, not a limitation of some PCI devices.

	Arnd
