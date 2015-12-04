Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 4 Dec 2015 12:04:04 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	catalin.marinas@arm.com, linaro-acpi@lists.linaro.org,
	Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org,
	will.deacon@arm.com, wangyijing@huawei.com,
	wangzhou1@hisilicon.com, hanjun.guo@linaro.org,
	liudongdong3@huawei.com, tn@semihalf.com, bhelgaas@google.com,
	tglx@linutronix.de, xuwei5@hisilicon.com, liguozhu@hisilicon.com,
	jiang.liu@linux.intel.com
Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
Message-ID: <20151204120404.GA3999@red-moon>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com>
 <20151203175826.GB2935@red-moon>
 <5018756.5lEEeJVMod@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5018756.5lEEeJVMod@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 03, 2015 at 09:58:14PM +0100, Arnd Bergmann wrote:

[...]

> > Let's first rewind a bit though, to summarize:
> > 
> > 1) we need a way to configure a "generic host controller" with host
> >    controller specific config methods (ie ECAM, even though is a PCI
> >    standard it is not standard enough for some designers)
> 
> That code already exists, see drivers/acpi/pci_*.c
> 
> > 2) we keep the generic "PNP0A03" matching to declare a host bridge and
> >    related resources (?). Maybe we can have an HID matching the
> >    "real" device (eg "HISI0081" and related DSD) and a CID set to "PNP0A03" ?
> >    I do not want to end up with two device objects in the ACPI tables.
> > 
> > I think that all this code belongs in:
> > 
> > drivers/pci/host/pci-host-generic.c
> 
> I disagree:
> 
> > and the quirks scan should be done _within_ the pci_acpi_scan_root()
> > that should be placed in drivers/pci/host/pci-host-generic.c (ACPI probe
> > path, to be created) so that, if quirks for config space have to be applied
> > they are applied there before calling acpi_pci_root_create() so that
> > ordering is guaranteed.
> 
> pci-host-generic.c is just for standard PCI implementations, and it has
> zero code that would be shared with ACPI: Most of the implementation
> deals with parsing DT properties, and all that code is entirely differnet
> for ACPI and already exists in drivers/acpi. The one thing that could be
> shared is the ECAM config space access, but ACPI already needs something
> else here because it requires access to the config space at early boot
> time, way before we even load that driver, see raw_pci_read/raw_pci_write.

Yes, I agree, basically ACPI has already a concept of "host generic"
layer, there is not much point in "merging" it with the pci-host-generic.c
driver. One thing is for certain: nothing in this and Tomasz patchsets is
arm64 specific, and should not live in arch/arm64.

Side note: for the time being raw_pci_read/write will stay empty on
arm64 till someone explains to me what they are used for, we are not
adding them just because they are there for x86, I enquired within
the ACPI spec working group and frankly I do not see a usage for those
on arm64.

> If there are parts missing in drivers/acpi to make it access PCI hosts,
> they can be added there, possibly inside "#ifndef CONFIG_X86".

Agreed.

> > I will put together a proposal to define the way we specify HID and
> > related DSD properties for PCI host controllers and send it to
> > the ACPI working group for review.
> 
> That also requires a change to SBSA, right? Today, SBSA assumes that
> we have a standard PCI host that will work with any hardware independent
> PCI implementation in an OS. We either have to give up on SBSA saying
> much about how PCI hosts are implemented, or stop assuming that hardware
> is SBSA compliant.

It is not even a SBSA change, ECAM is a PCIe standard. I am fine with
NAK'ing all code that is not ECAM compliant, problem is, we are dealing
with HW quirks here, it is not something we can fix in FW either.

I do not think SBSA can rule out HW bugs (call them quirks if you wish),
because that's what we are dealing with here, the line between HW bugs
and designs that deliberately deviate from ECAM is thin.

> > Second, I am against merging _any_ ACPI/PCI code for arm64 before we
> > define a way for the kernel to detect if resources should be reassigned
> > or just claimed as they are, as set-up by BIOS.
> 
> Why would it ever reassign anything that has been set up by the BIOS?
> We are still talking about server systems, right?

Do not ask me I agree 100% with you here :), but I can bet some systems
currently shipping with ACPI/PCI on ARM (not upstream) tend to be inherited
from DT where resources are _always_ reassigned and if we start claiming
them they till break in a spectacular way, someone has to update that
FW.

Does "booting with ACPI" implies "FW set-up resources - do not reassign" ?

That's an optimistic assumption IMHO. We either need a FW flag, or we just
force resource claiming on ACPI, and reassign the resources that could not
be claimed. We have to do it for ACPI only, on DT due to legacy we can't
do that anymore, we would break the world.

I am quite happy to force resource claiming when booting with ACPI,
since that will force FW developers to toe the line, what I am saying
is that it is not well defined, at all.

I rest my case: I am against merging _any_ ACPI/PCI code before we
define in stone when/if the kernel should reassign resources (answer
can be "never"), as soon as we merge a platform that requires resources
assignment to work we are stuck with it forever (see DT host controllers).

The early postings I reviewed they all reassign resources through initcalls,
for the records.

Thanks,
Lorenzo
