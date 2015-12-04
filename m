Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	Wangyijing <wangyijing@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>
Subject: RE: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
Date: Fri, 4 Dec 2015 16:22:33 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EBE4494@lhreml503-mbs>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <5018756.5lEEeJVMod@wuerfel> <20151204120404.GA3999@red-moon>
 <724640317.IRruPaehsN@wuerfel>
In-Reply-To: <724640317.IRruPaehsN@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo, Arnd (thanks to you both for looking at this)

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 04 December 2015 13:57
> To: Lorenzo Pieralisi
> Cc: linux-arm-kernel@lists.infradead.org; Gabriele Paoloni; linux-
> acpi@vger.kernel.org; linux-pci@vger.kernel.org;
> catalin.marinas@arm.com; linaro-acpi@lists.linaro.org;
> Liviu.Dudau@arm.com; linux-kernel@vger.kernel.org; will.deacon@arm.com;
> Wangyijing; Wangzhou (B); hanjun.guo@linaro.org; liudongdong (C);
> tn@semihalf.com; bhelgaas@google.com; tglx@linutronix.de; xuwei (O);
> Liguozhu (Kenneth); jiang.liu@linux.intel.com
> Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM
> Host Bridge Controllers
> 
> On Friday 04 December 2015 12:04:04 Lorenzo Pieralisi wrote:
> > On Thu, Dec 03, 2015 at 09:58:14PM +0100, Arnd Bergmann wrote:
> 
> > > pci-host-generic.c is just for standard PCI implementations, and it
> > > has zero code that would be shared with ACPI: Most of the
> > > implementation deals with parsing DT properties, and all that code
> > > is entirely differnet for ACPI and already exists in drivers/acpi.
> > > The one thing that could be shared is the ECAM config space access,
> > > but ACPI already needs something else here because it requires
> > > access to the config space at early boot time, way before we even
> load that driver, see raw_pci_read/raw_pci_write.
> >
> > Yes, I agree, basically ACPI has already a concept of "host generic"
> > layer, there is not much point in "merging" it with the
> > pci-host-generic.c driver. One thing is for certain: nothing in this
> > and Tomasz patchsets is
> > arm64 specific, and should not live in arch/arm64.

Ok so now I guess Tomasz is aware of this and probably he is reworking 
his patchset to move his code into "drivers/acpi/pci_*",
Tomasz can you confirm this?

If this is the case I'll wait for his new patchset to come out and
rebase mine on top of his new one. Otherwise I should directly rework
his patchset but it's pointless if he's already doing it...
 
> >
> > Side note: for the time being raw_pci_read/write will stay empty on
> > arm64 till someone explains to me what they are used for, we are not
> > adding them just because they are there for x86, I enquired within
> the
> > ACPI spec working group and frankly I do not see a usage for those on
> > arm64.
> 
> I think this is mainly so AML can poke into PCI config space to
> reconfigure things even during early boot, if necessary. You can have
> PCI devices that are owned by ACPI and not to be touched by the OS.
> 
> > > > I will put together a proposal to define the way we specify HID
> > > > and related DSD properties for PCI host controllers and send it
> to
> > > > the ACPI working group for review.

About this, rather than modifying the ACPI specs, I would consider
using dmi_decode() to know which HW we got underneath...what about?

> > >
> > > That also requires a change to SBSA, right? Today, SBSA assumes
> that
> > > we have a standard PCI host that will work with any hardware
> > > independent PCI implementation in an OS. We either have to give up
> > > on SBSA saying much about how PCI hosts are implemented, or stop
> > > assuming that hardware is SBSA compliant.
> >
> > It is not even a SBSA change, ECAM is a PCIe standard. I am fine with
> > NAK'ing all code that is not ECAM compliant, problem is, we are
> > dealing with HW quirks here, it is not something we can fix in FW
> either.
> >
> > I do not think SBSA can rule out HW bugs (call them quirks if you
> > wish), because that's what we are dealing with here, the line between
> > HW bugs and designs that deliberately deviate from ECAM is thin.
> 
> Right, and some are further away from the standard than others.
> 
> > > > Second, I am against merging _any_ ACPI/PCI code for arm64 before
> > > > we define a way for the kernel to detect if resources should be
> > > > reassigned or just claimed as they are, as set-up by BIOS.
> > >
> > > Why would it ever reassign anything that has been set up by the
> BIOS?
> > > We are still talking about server systems, right?
> >
> > Do not ask me I agree 100% with you here :), but I can bet some
> > systems currently shipping with ACPI/PCI on ARM (not upstream) tend
> to
> > be inherited from DT where resources are _always_ reassigned and if
> we
> > start claiming them they till break in a spectacular way, someone has
> > to update that FW.
> >
> > Does "booting with ACPI" implies "FW set-up resources - do not
> reassign" ?
> 
> I think that should be true on any server regardless of ACPI: if we
> have a BIOS, we can expect it to do the job right. The reason we tend
> to completely ignore any PCI setup on most embedded systems is that we
> don't trust u-boot to do that right (or at all).
> 
> > That's an optimistic assumption IMHO. We either need a FW flag, or we
> > just force resource claiming on ACPI, and reassign the resources that
> > could not be claimed. We have to do it for ACPI only, on DT due to
> > legacy we can't do that anymore, we would break the world.
> 
> Hmm, but having a flag in the ACPI tables for "BIOS is broken" won't
> work if we require the BIOS to set that flag. In that case, we could
> just fix the BIOS. ;-)
> 
> > I am quite happy to force resource claiming when booting with ACPI,
> > since that will force FW developers to toe the line, what I am saying
> > is that it is not well defined, at all.
> >
> > I rest my case: I am against merging _any_ ACPI/PCI code before we
> > define in stone when/if the kernel should reassign resources (answer
> > can be "never"), as soon as we merge a platform that requires
> > resources assignment to work we are stuck with it forever (see DT
> host controllers).
> 
> Fair enough.

Ok fine

> 
> 	Arnd
