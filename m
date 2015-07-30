Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dfwrgout.huawei.com ([206.16.17.72]:4162 "EHLO
	dfwrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbbG3Icq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 04:32:46 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "arnd@arndb.de" <arnd@arndb.de>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	Andrew Murray <amurray@embedded-bits.co.uk>
Subject: RE: [PATCH v6] PCI: Store PCIe bus address in struct of_pci_range
Date: Thu, 30 Jul 2015 08:30:41 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D6F6F8@lhreml503-mbs>
References: <1438010223-124422-1-git-send-email-gabriele.paoloni@huawei.com>
 <20150729172053.GE31170@google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6F350@lhreml503-mbs>
 <20150729214710.GE9640@google.com>
In-Reply-To: <20150729214710.GE9640@google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, July 29, 2015 10:47 PM
> To: Gabriele Paoloni
> Cc: arnd@arndb.de; lorenzo.pieralisi@arm.com; Wangzhou (B);
> robh+dt@kernel.org; james.morse@arm.com; Liviu.Dudau@arm.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> qiuzhenfa; Liguozhu (Kenneth); Andrew Murray
> Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
> of_pci_range
> 
> [+cc Andrew]
> 
> On Wed, Jul 29, 2015 at 07:44:18PM +0000, Gabriele Paoloni wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> > > Sent: Wednesday, July 29, 2015 6:21 PM
> > > To: Gabriele Paoloni
> 
> > > On Mon, Jul 27, 2015 at 11:17:03PM +0800, Gabriele Paoloni wrote:
> > > > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> > > >     This patch adds a new field in "struct of_pci_range" to store
> the
> > > >     pci bus start address; it fills the field in
> > > of_pci_range_parser_one();
> > > >     in of_pci_get_host_bridge_resources() it retrieves the
> resource
> > > entry
> > > >     after it is created and added to the resource list and uses
> > > >     entry->__res.start to store the pci controller address
> > >
> > > struct of_pci_range is starting to get confusing to non-OF folks
> like
> > > me.
> > > It now contains:
> > >
> > >   u32 pci_space;
> > >   u64 pci_addr;
> > >   u64 cpu_addr;
> > >   u64 bus_addr;
> > >
> > > Can you explain what all these things mean, and maybe even add one-
> line
> > > comments to the structure?
> 
> > > pci_space: The only uses I see are to determine whether to print
> > > "Prefetch".  I don't see any real functionality that uses this.
> >
> > Looking at the code I agree. it's seems to be used only in powerpc
> > and microblaze to print out.
> > However from my understanding pci_space is the phys.hi field of the
> > ranges property: it defines the properties of the address space
> associated
> > to the PCI address. if you're curious you can find a nice and quick
> to read
> > "guide" in http://devicetree.org/MPC5200:PCI
> 
> I think pci_space should be removed and the users should test
> "range.flags & IORESOURCE_PREFETCH" instead.  That's already set by
> of_bus_pci_get_flags().  This is separate from your current patch, of
> course.

Ok so I'll do nothing in my patch about this; maybe I can propose a separate
patch for this, but I cannot test it (I've got no microblaze and powerpc 
neither....)

> 
> 29b635c00f3e ("of/pci: Provide support for parsing PCI DT ranges
> property") added struct of_pci_range, and even at the time,
> of_bus_pci_get_flags() set IORESOURCE_PREFETCH in of_pci_range.flags.
> 
> 654837e8fe8d ("powerpc/pci: Use of_pci_range_parser helper in
> pci_process_bridge_OF_ranges") converted powerpc to use
> of_pci_range_parser() instead of parsing manually.  It converted other
> references to look at struct of_pci_range.flags; I'm not sure why it
> didn't do that for the prefetch bit.
> 
> I copied Andrew in case there's some subtlety here.
> 
> > > pci_addr: I assume this is a PCI bus address, like what you would
> see
> > > if
> > > you put an analyzer on the bus/link.  This address could go in a
> BAR.
> >
> > Yes, this is the PCI start address of the range: phys.mid + phys.low
> in the
> > guide mentioned above
> >
> > > cpu_addr: I assume this is a CPU physical address, like what you
> would
> > > see
> > > in /proc/iomem and what you would pass to ioremap().
> >
> > Yes correct
> >
> > > bus_addr: ?
> >
> > According to the guide above, this is the address into which the
> pci_address
> > get translated to and that is passed to the root complex. Between the
> root
> > complex and the CPU there can be intermediate translation layers:
> 
> I can't quite parse this, but I do understand how a host bridge can
> translate CPU physical addresses to a different range of PCI bus
> addresses.  What I don't understand is the difference between
> "pci_addr"
> and the "bus_addr" you're adding.

For example see:
http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6qdl.dtsi#L148

ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000   /* configuration space */
          0x81000000 0 0          0x01f80000 0 0x00010000   /* downstream I/O */
          0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory *
               /\          /\          /\
           pci_space    pci_addr     bus_addr            


The host bridge performs the first translation from pci_addr to bus_addr.
If there are other ranges in the parents nodes in the DT bus_addr gets 
translated further till you get the cpu_addr.

Hope it is a bit clearer now....

> 
> > see that to
> > get pci_address we call "of_translate_address"; this will apply all
> the
> > translation layers (ranges in the DT) that it finds till it comes to
> the root
> > node of the DT (thus retrieving the CPU address).
> > Now said that, for designware we need the first translated PCI
> address, that we call
> > here bus_addr after Rob Herring suggested the name...honestly I
> cannot think of a
> > different name
> >
> >
> >
> > > I'm trying to imagine how this might be expressed in ACPI.  A host
> > > bridge
> > > ACPI _CRS contains a CPU physical address and applying a _TRA
> > > (translation
> > > offset) to the CPU address gives you a PCI bus address.  I know
> this
> > > code
> > > is OF, not ACPI, but I assume that it should be possible to
> describe
> > > your
> > > hardware via ACPI as well as by OF.
> 
> > > > diff --git a/include/linux/of_address.h
> b/include/linux/of_address.h
> > > > index d88e81b..865f96e 100644
> > > > --- a/include/linux/of_address.h
> > > > +++ b/include/linux/of_address.h
> > > > @@ -16,6 +16,7 @@ struct of_pci_range {
> > > >  	u32 pci_space;
> > > >  	u64 pci_addr;
> > > >  	u64 cpu_addr;
> > > > +	u64 bus_addr;
> > > >  	u64 size;
> > > >  	u32 flags;
> > > >  };
