Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 29 Feb 2016 11:38:04 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	'Mark Rutland' <mark.rutland@arm.com>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"'bhelgaas@google.com'" <bhelgaas@google.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
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
Message-ID: <20160229113804.GA3899@red-moon>
References: <20160210111234.GC2632@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1D30@lhreml503-mbs>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECC5F00@lhreml503-mbs>
 <20160224011418.GB13026@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECCAD6A@lhreml503-mbs>
 <20160224152538.GA19700@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECCD209@lhreml503-mbs>
 <20160225120750.GA32016@red-moon>
 <20160225195912.GA4818@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECE9C1C@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECE9C1C@lhreml503-mbs>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > > > > I think the relevant spec is the PCI Firmware Spec, r3.0, sec
> > 4.1.2.
> > > > > Note 2 in that section says the address range of an MMCFG region
> > > > > must be reserved by declaring a motherboard resource, i.e.,
> > included
> > > > > in the _CRS of a PNP0C02 or similar device.
> > > >
> > > > I had a look a this. So yes the specs says that we should use the
> > > > PNP0C02 device if MCFG is not supported.
> > >
> > > AFAIK, PNP0C02 is a resource reservation mechanism, the spec says
> > that
> > > MCFG regions must be reserved using PNP0C02, even though its
> > > current usage on x86 is a bit unfathomable to me, in particular
> > > in relation to MCFG resources retrieved for hotpluggable bridges (ie
> > > through _CBA, which I think consider the MCFG region as reserved
> > > by default, regardless of PNP0c02):
> > >
> > > see pci_mmcfg_check_reserved() arch/x86/pci/mmconfig-shared.c
> 
> Yes I checked this and it seems to check if an area of memory from
> MCFG is overlapping with any area of memory specified by PNP0C02 
> _CRS...
> 
> However (maybe I am wrong) it looks to me that this part works
> independently of the PNP0c02 driver. It seems that goes directly
> to walk the ACPI namespace and look for PNP0C02 HID; as it finds it,
> it checks the range of memory specified in the _CRS method and see
> if it overlaps with the MCFG resource...am I missing something? 

Well, if I understand the code correctly, the x86 MCFG code, for static
MCFG tables, check that the MCFG regions are part of motherboard
resources (by walking the ACPI namespace as you said). If that's the case,
it does not insert resources into the resource tree till a late_initcall,
(pci_mmcfg_late_insert_resources()) that should run after the PNP0C02 driver
was initialized (?) (I guess, that's a nightmare to understand these initcall
ordering unwritten rules dependencies, if they exist). If the MCFG region is
not part of motherboard resources it is discarded (ie pci_mmconfig_insert()
in arch/x86/pci/mmconfig-shared.c).

I really do not know why x86 code has been implemented like that
and whatever I say it is just speculation, honestly it is not easy
to understand.

> If my interpretation is correct, couldn't we just modify 
> pci_mmconfig_map_resource() in the latest Nowicki patchset and add
> a similar check before insert_resource_conflict() is called?

Yes, but I am not sure that would help much. We can prevent adding
MCFG resources to the resource tree if they are not declared as motherboard
resources, but if they do it is totally unclear to me what we should do.

Should we insert the MCFG region resources into the resource tree before
PNP0C02 driver has a chance to be probed ? Or do what x86 does (ie it does
not insert resources into the resource tree till late_initcall
pci_mmcfg_late_insert_resources()) ? I do not know. If the PNP0C02
driver stays as it is, whatever we do with PNP0C02 regions does not make
much sense to me, that's the gist of what I am saying, I don't know why
x86 code was implemented like that, I will go through the commits history
to find some light here.

Lorenzo

> 
> On the other side HiSilicon host bridge quirks could use the address
> retrieved by the _CRS method of PNP0C02 for our root complex config
> rd/wr...?
>  
> > 
> > I don't know how _CBA-related resources would be reserved.  I haven't
> > personally worked with any host bridges that supply _CBA, so I don't
> > know whether or how they handled it.
> > 
> > I think the spec intent was that the Consumer/Producer bit (Extended
> > Address Space Descriptor, General Flags Bit[0], see ACPI spec sec
> > 6.4.3.5.4) would be used.  Resources such as ECAM areas would be
> > marked "Consumer", meaning the bridge consumed that space itself, and
> > windows passed down to the PCI bus would be marked "Producer".
> > 
> > But BIOSes didn't use that bit consistently, so we couldn't rely on
> > it.  I verified experimentally that Windows didn't pay attention to
> > that bit either, at least for DWord descriptors:
> > https://bugzilla.kernel.org/show_bug.cgi?id=15701
> > 
> > It's conceivable that we could still use that bit in Extended Address
> > Space descriptors, or maybe some hack like pay attention if the bridge
> > has _CBA, or some such.  Or maybe a BIOS could add a PNP0C02 device
> > along with the PNP0A03 device that uses _CBA, with the PNP0C02 _CRS
> > describing the ECAM area referenced by _CBA.  Seeems hacky no matter
> > how we slice it.
> 
> Well about this I don't know much but, having looked at the bugzilla
> and considering the current mechanism used by pci_mmcfg_check_reserved()
> I have the feeling that this last one is easier to implement and it seems
> the one currently used (in mmconfig-shared.c )
> 
> Cheers
> 
> Gab
> 
> > 
> > > Have a look at drivers/pnp/system.c for PNP0c02
> > >
> > > > So probably I can use acpi_get_devices("PNP0C02",...) to retrieve
> > it
> > > > from the quirk match function, I will look into this...
> > > >
> > > > >
> > > > > > On the other side, since this is an exception only for the
> > config
> > > > > > space address of our host controller (as said before all the
> > buses
> > > > > > below the root one support ECAM), I think that it is right to
> > put
> > > > > > this address as a device specific data (in fact the rest of the
> > > > > > config space addresses will be parsed from MCFG).
> > > > >
> > > > > A kernel with no support for your host controller (and thus no
> > > > > knowledge of its _DSD) should still be able to operate the rest
> > of the
> > > > > system correctly.  That means we must have a generic way to learn
> > what
> > > > > address space is consumed by the host controller so we don't try
> > to
> > > > > assign it to other devices.
> > > >
> > > > This is something I don't understand much...
> > > > Are you talking about a scenario where we have a Kernel image
> > compiled
> > > > without our host controller support and running on our platform?
> > >
> > > I *think* the point here is that your host controller config space
> > should be
> > > reserved through PNP0c02 so that the kernel will reserve it through
> > the
> > > generic PNP0c02 driver even if your host controller driver (and
> > related
> > > _DSD) is not supported in the kernel.
> > 
> > Right.  Assume you have two top-level devices:
> > 
> >   PNP0A03  PCI host bridge
> >     _CRS     describes windows
> >     ????     describes ECAM space consumed
> >   PNPxxxx  another ACPI device, currently disabled
> >     _PRS     specifies possible resource settings, may specify no
> > restrictions
> >     _SRS     assign resources and enable device
> >     _CRS     empty until device enabled
> > 
> > When the OS enables PNPxxxx, it must first assign resources to it
> > using _PRS and _SRS.  We evaluate _PRS to find out what the addresses
> > PNPxxxx can support.  This tells us things like how wide the address
> > decoder is, the size of the region required, and any alignment
> > restrictions -- basically the same information we get by sizing a PCI
> > BAR.
> > 
> > Now, how do we assign space for PNPxxxx?  In a few cases, _PRS has
> > only a few specific possibilities, e.g., an x86 legacy serial port
> > that can be at 0x3f8 or 0x2f8.  But in general, _PRS need not impose
> > any restrictions.
> > 
> > So in general the OS can use any space that can be routed to PNPxxxx.
> > If there's an upstream bridge, it may define windows that restrict the
> > possibilities.  But in this case, there *is* no upstream bridge, so
> > the possible choices are the entire physical address space of the
> > platform, except for other things that are already allocated: RAM, the
> > _CRS settings for other ACPI devices, things reserved by the E820
> > table (at least on x86), etc.
> > 
> > If PNP0A03 consumes address space for ECAM, that space must be
> > reported *somewhere* so the OS knows not to place PNPxxxx there.  This
> > reporting must be generic (not device-specific like _DSD).  The ACPI
> > core (not drivers) is responsible for managing this address space
> > because:
> > 
> >   a) the OS is not guaranteed to have drivers for all devices, and
> > 
> >   b) even it *did* have drivers for all devices, the PNPxxxx space may
> >   be assigned before drivers are initialized.
> > 
> > > I do not understand how PNP0c02 works, currently, by the way.
> > >
> > > If I read x86 code correctly, the unassigned PCI bus resources are
> > > assigned in arch/x86/pci/i386.c (?)
> > fs_initcall(pcibios_assign_resources),
> > > with a comment:
> > >
> > > /**
> > >  * called in fs_initcall (one below subsys_initcall),
> > >  * give a chance for motherboard reserve resources
> > >  */
> > >
> > > Problem is, motherboard resources are requested through (?):
> > >
> > > drivers/pnp/system.c
> > >
> > > which is also initialized at fs_initcall, so it might be called after
> > > core x86 code reassign resources, defeating the purpose PNP0c02 was
> > > designed for, namely, request motherboard regions before resources
> > > are assigned, am I wrong ?
> > 
> > I think you're right.  This is a long-standing screwup in Linux.
> > IMHO, ACPI resources should be parsed and reserved by the ACPI core,
> > before any PCI resource management (since PCI host bridges are
> > represented in ACPI).  But historically PCI devices have enumerated
> > before ACPI got involved.  And the ACPI core doesn't really pay
> > attention to _CRS for most devices (with the exception of PNP0C02).
> > 
> > IMO the PNP0C02 code in drivers/pnp/system.c should really be done in
> > the ACPI core for all ACPI devices, similar to the way the PCI core
> > reserves BAR space for all PCI devices, even if we don't have drivers
> > for them.  I've tried to fix this in the past, but it is really a
> > nightmare to unravel everything.
> > 
> > Because the ACPI core doesn't reserve resources for the _CRS of all
> > ACPI devices, we're already vulnerable to the problem of placing a
> > device on top of another ACPI device.  We don't see problems because
> > on x86, at least, most ACPI devices are already configured by the BIOS
> > to be enabled and non-overlapping.  But x86 has the advantage of
> > having extensive test coverage courtesy of Windows, and as long as
> > _CRS has the right stuff in it, we at least have the potential of
> > fixing problems in Linux.
> > 
> > If the platform doesn't report resource usage correctly on ARM, we may
> > not find problems (because we don't have the Windows test suite) and
> > if we have resource assignment problems because _CRS is lacking, we'll
> > have no way to fix them.
> > 
> > > As per last Tomasz's patchset, we claim and assign unassigned PCI
> > > resources upon ACPI PCI host bridge probing (which happens at
> > > subsys_initcall time, courtesy of ACPI current code); at that time
> > the
> > > kernel did not even register the PNP0c02 driver
> > (drivers/pnp/system.c)
> > > (it does that at fs_initcall). On the other hand, we insert MCFG
> > > regions into the resource tree upon MCFG parsing, so I do not
> > > see why we need to rely on PNP0c02 to do that for us (granted, the
> > > mechanism is part of the PCI fw specs, which are x86 centric anyway
> > > ie we can't certainly rely on Int15 e820 to detect reserved memory
> > > on ARM :D)
> > >
> > > There is lots of legacy x86 here and Bjorn definitely has more
> > > visibility into that than I have, the ARM world must understand
> > > how this works to make sure we have an agreement.
> > 
> > As you say, there is lots of unpleasant x86 legacy here.  Possibly ARM
> > has a chance to clean this up and do it more sanely; I'm not sure
> > whether it's feasible to reverse the ACPI/PCI init order there or not.
> > 
> > Rafael, any thoughts on this whole thing?
> > 
> > Bjorn
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
