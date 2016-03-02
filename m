Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 2 Mar 2016 09:51:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
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
Message-ID: <20160302155117.GB24024@localhost>
References: <20160210111234.GC2632@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1D30@lhreml503-mbs>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECC5F00@lhreml503-mbs>
 <20160224011418.GB13026@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECCAD6A@lhreml503-mbs>
 <20160224152538.GA19700@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECCD209@lhreml503-mbs>
 <20160225120750.GA32016@red-moon>
 <20160225195912.GA4818@localhost>
 <20160301192247.GA21324@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160301192247.GA21324@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 01, 2016 at 07:22:47PM +0000, Lorenzo Pieralisi wrote:
> Hi Bjorn,
> 
> On Thu, Feb 25, 2016 at 01:59:12PM -0600, Bjorn Helgaas wrote:
> > On Thu, Feb 25, 2016 at 12:07:50PM +0000, Lorenzo Pieralisi wrote:
> > > On Thu, Feb 25, 2016 at 03:01:19AM +0000, Gabriele Paoloni wrote:
> 
> [...]
> 
> > > I do not understand how PNP0c02 works, currently, by the way.
> > > 
> > > If I read x86 code correctly, the unassigned PCI bus resources are
> > > assigned in arch/x86/pci/i386.c (?) fs_initcall(pcibios_assign_resources),
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
> 
> ...
> By "fixing problems in Linux" above, you mean that, given that we
> do have a validated _CRS space, we can request/reserve the region the _CRS
> reports to prevent assigning those resources to other devices, correct ?

Yes.

I think part of what makes this difficult in Linux is that the
resource tree is too strict about overlapping resources.  We get
address space information from E820 (on x86), static ACPI tables like
MCFG, and dynamic things like ACPI _CRS.  There's no real requirement
that the BIOS should make all these consistent, but yet we try to jam
it all into the same resource tree.

For example, E820 might tell us that range A is reserved and
unavailable to Linux.  We stick it in the resource tree.  Then we
might have a _CRS that tells us about range B.  We *want* to put range
B in the resource tree, but if B overlaps part of A, the insert will
fail.

All we really need from E820 is the information that "you can't put
devices in A".  We don't need to enforce any relationship between A
and B, but the current resource tree imposes unnecessary hierarchical
requirements.

I think issues like this are the biggest reason why the ACPI core
doesn't reserve all _CRS space early on (Rafael may correct me here).

> > If the platform doesn't report resource usage correctly on ARM, we may
> > not find problems (because we don't have the Windows test suite) and
> > if we have resource assignment problems because _CRS is lacking, we'll
> > have no way to fix them.
> 
> And I think here you mean we can't prevent assigning resource space to
> devices that do not necessarily own it because since some devices _CRS
> are borked/missing we have no way to detect the address space allocated
> to them and we may end up with resources conflicts.

The ACPI core currently doesn't reserve the space consumed by ACPI
devices.  Some drivers, e.g., for PNP0C02 (motherboard) and PNP0A03
(PCI host bridge), do reserve their space, but the core itself does
not.  

If we have drivers for all the ACPI devices, those drivers will
probably use _CRS and reserve the space, and we'll probably notice any
_CRS errors.  But if we don't have drivers, e.g., for performance
monitors or other non-essential things, nothing will use _CRS, and
nothing will reserve the space used by the device, and it's hard to
find errors.

If we ever assign top-level resources, there's nothing to prevent us
from creating a conflict.  The only reason we don't trip over this is
that we usually don't assign top-level resources because firmware does
it for us.

> > > As per last Tomasz's patchset, we claim and assign unassigned PCI
> > > resources upon ACPI PCI host bridge probing (which happens at
> > > subsys_initcall time, courtesy of ACPI current code); at that time the
> > > kernel did not even register the PNP0c02 driver (drivers/pnp/system.c)
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
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
