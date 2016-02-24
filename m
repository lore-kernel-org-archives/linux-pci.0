Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46078 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbcBXPZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 10:25:45 -0500
Date: Wed, 24 Feb 2016 09:25:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"'bhelgaas@google.com'" <bhelgaas@google.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'Lorenzo.Pieralisi@arm.com'" <Lorenzo.Pieralisi@arm.com>,
	"'tn@semihalf.com'" <tn@semihalf.com>,
	"'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
	"'jcm@redhat.com'" <jcm@redhat.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
 HiSilicon SoCs Host Controllers
Message-ID: <20160224152538.GA19700@localhost>
References: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
 <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
 <20160209182429.GD4348@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1591@lhreml503-mbs>
 <20160210111234.GC2632@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1D30@lhreml503-mbs>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECC5F00@lhreml503-mbs>
 <20160224011418.GB13026@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECCAD6A@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECCAD6A@lhreml503-mbs>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 06:46:09AM +0000, Gabriele Paoloni wrote:
> 
> Hi Bjorn, many thanks for replying
> 
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: 24 February 2016 09:14
> > To: Gabriele Paoloni
> > Cc: 'Mark Rutland'; Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong
> > (C); Linuxarm; qiujiang; 'bhelgaas@google.com'; 'arnd@arndb.de';
> > 'Lorenzo.Pieralisi@arm.com'; 'tn@semihalf.com'; 'linux-
> > pci@vger.kernel.org'; 'linux-kernel@vger.kernel.org'; xuwei (O);
> > 'linux-acpi@vger.kernel.org'; 'jcm@redhat.com'; zhangjukuo; Liguozhu
> > (Kenneth); 'linux-arm-kernel@lists.infradead.org'
> > Subject: Re: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
> > HiSilicon SoCs Host Controllers
> > 
> > On Tue, Feb 23, 2016 at 02:47:22AM +0000, Gabriele Paoloni wrote:
> > > > -----Original Message-----
> > > > From: Gabriele Paoloni
> > > > Sent: 10 February 2016 22:45
> > > > To: Mark Rutland
> > > > Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C); Linuxarm;
> > > > qiujiang; bhelgaas@google.com; arnd@arndb.de;
> > Lorenzo.Pieralisi@arm.com;
> > > > tn@semihalf.com; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; xuwei (O); linux-acpi@vger.kernel.org;
> > > > jcm@redhat.com; zhangjukuo; Liguozhu (Kenneth); linux-arm-
> > > > kernel@lists.infradead.org
> > > > Subject: RE: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support
> > for
> > > > HiSilicon SoCs Host Controllers
> > > >
> > > > > -----Original Message-----
> > > > > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > > > > owner@vger.kernel.org] On Behalf Of Mark Rutland
> > > > > Sent: 10 February 2016 11:13
> > > > > To: Gabriele Paoloni
> > > > > Cc: Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong (C);
> > Linuxarm;
> > > > > qiujiang; bhelgaas@google.com; arnd@arndb.de;
> > > > > Lorenzo.Pieralisi@arm.com; tn@semihalf.com; linux-
> > pci@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org; xuwei (O); linux-
> > acpi@vger.kernel.org;
> > > > > jcm@redhat.com; zhangjukuo; Liguozhu (Kenneth); linux-arm-
> > > > > kernel@lists.infradead.org
> > > > > Subject: Re: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support
> > for
> > > > > HiSilicon SoCs Host Controllers
> > > > >
> > > > > On Wed, Feb 10, 2016 at 09:52:36AM +0000, Gabriele Paoloni wrote:
> > > > > > Hi Mark
> > > > > >
> > > > > > > On Tue, Feb 09, 2016 at 05:34:20PM +0000, Gabriele Paoloni
> > wrote:
> > > > > > > > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> > > > > > > > +/*
> > > > > > > > + * Retrieve rc_dbi base and size from _DSD
> > > > > > > > + * Name (_DSD, Package () {
> > > > > > > > + *	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > > > > > > + *	Package () {
> > > > > > > > + *	Package () {"rc-dbi", Package () { 0x0, 0xb0080000,
> > 0x0,
> > > > > 0x10000
> > > > > > > }},
> > > > > > > > + *	}
> > > > > > > > + *	})
> > > > > > > > + */
> > > > > > >
> > > > > > > As above, this does not look right. ACPI has standard
> > mechanisms
> > > > > for
> > > > > > > describing addresses. Making something up like this is not a
> > good
> > > > > idea.
> > > > > >
> > > > > > I am quite new to ACPI, may I ask you to explain a bit?
> > > > >
> > > > > ACPI has standard mechanisms for describing certain resources,
> > and
> > > > > these
> > > > > should not be described in _DSD. Memory or IO address regions are
> > > > such
> > > > > resources (in _CRS, IIRC), and should not be described in _DSD.
> > > >
> > > > Hi Mark,
> > > >
> > > > In my case I think in need to look into the MCFG object as the
> > problem
> > > > I have is RC using a different range than the rest of the hierarchy.
> > > >
> > > > I'll investigate this and try to come with a solution in v4
> > >
> > > I have looked into this and in our case we cannot use the
> > > standard MCFG object to pass the RC config space addresses.
> > >
> > > The reason is that in our HW we have the config base addresses of the
> > > root complex ports that are less than 0x100000 byte distant one from
> > > the other as we only map the first 0x10000 bytes.
> > 
> > The ECAM spec requires 4096 bytes per function, 8 functions per
> > device, 32 devices per bus, which means you need 0x100000 bytes of
> > address space per bus.  If your device doesn't supply that, it doesn't
> > really implement ECAM, and you probably can't use the standard ways of
> > describing ECAM (MCFG, _CBA).
> 
> Correct, our host bridge is non ECAM only for the RC bus config space;
> for any other bus underneath the root bus we support ECAM access, so
> we need a quirk for the RC config rd/wr  

MCFG can specify a bus number range, so you might be able to use it
to describe the ECAM space for buses below the root bus, e.g.,
[bus 01-ff].

> > > Now the MCFG acpi framework always fix the MCFG resource size to
> > 0x100000
> > > for each bus; therefore if we pass our RC addresses through MCFG we
> > end
> > > up with a resource conflict.
> > >
> > > To give you a practical example we are in a situation where we have:
> > >
> > > port0: [0x00000000b0080000 - 0x00000000b0080000 + 0x10000]
> > > port1: [0x00000000b0090000 - 0x00000000b0090000 + 0x10000]
> > > port2: [0x00000000b00A0000 - 0x00000000b00A0000 + 0x10000]
> > > port3: [0x00000000b00B0000 - 0x00000000b00B0000 + 0x10000]
> > >
> > > So if we pass the base addresses through MCFG the resources
> > > will overlap as MCFG will consider 0x100000 size for each base
> > > address of the root complex (only the RC bus uses that address)
> > >
> > > So far I do not see many option other than using _DSD to pass
> > > these RC config base addresses.
> > 
> > I don't want to take over Mark's discussion, but I really do not think
> > _DSD is the correct way to fix this.  _CRS is like a generalized PCI
> > BAR.  A PCI device is only allowed to respond to address space
> > reported via a BAR.  An ACPI device is only allowed to respond to
> > address space reported via _CRS.  Those are important rules because
> > they mean we can manage address space with generic code instead of
> > device-specific code.
> 
> From what I see in 
> http://lxr.free-electrons.com/source/drivers/acpi/pci_root.c#L723
> acpi_pci_probe_root_resources() parses the _CRS method and
> it only works for MEM and IO resources, so I don't think it is 
> right to pass a config space address by _CRS or to modify the 
> current ACPI framework to support this.

Config space addresses are made up of [bus, device, function, register
offset], and you're right that _CRS doesn't contain those addresses
directly; _CRS only describes memory, I/O, and bus number ranges.

But part of the function of a host bridge is to convert memory or I/O
accesses on the primary (CPU) side to PCI config accesses on the
secondary (PCI) side, and this CPU-side memory or I/O region should be
reported via _CRS.

I think the relevant spec is the PCI Firmware Spec, r3.0, sec 4.1.2.
Note 2 in that section says the address range of an MMCFG region
must be reserved by declaring a motherboard resource, i.e., included
in the _CRS of a PNP0C02 or similar device.

> On the other side, since this is an exception only for the config
> space address of our host controller (as said before all the buses
> below the root one support ECAM), I think that it is right to put
> this address as a device specific data (in fact the rest of the
> config space addresses will be parsed from MCFG).

A kernel with no support for your host controller (and thus no
knowledge of its _DSD) should still be able to operate the rest of the
system correctly.  That means we must have a generic way to learn what
address space is consumed by the host controller so we don't try to
assign it to other devices.

Bjorn
