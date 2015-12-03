Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	catalin.marinas@arm.com, linaro-acpi@lists.linaro.org,
	Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org,
	will.deacon@arm.com, wangyijing@huawei.com,
	wangzhou1@hisilicon.com, hanjun.guo@linaro.org,
	liudongdong3@huawei.com, tn@semihalf.com, bhelgaas@google.com,
	tglx@linutronix.de, xuwei5@hisilicon.com, liguozhu@hisilicon.com,
	jiang.liu@linux.intel.com
Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host Bridge Controllers
Date: Thu, 03 Dec 2015 21:58:14 +0100
Message-ID: <5018756.5lEEeJVMod@wuerfel>
In-Reply-To: <20151203175826.GB2935@red-moon>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com> <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com> <20151203175826.GB2935@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 03 December 2015 17:58:26 Lorenzo Pieralisi wrote:
> On Thu, Dec 03, 2015 at 11:19:58PM +0800, Gabriele Paoloni wrote:
> > +void acpi_arm64_quirks(void)
> > +{
> > +	int i = 0;
> > +
> > +	while (quirks_array[i]) {
> > +		acpi_scan_add_handler(quirks_array[i]);
> > +		i++;
> > +	}
> > +
> > +}
> 
> This code is not arm64 specific, and this is part of a wider complaint
> I have about this patchset and PCI/ACPI code I see in general.

Agreed. We certainly should try to reduce the number of architecture
specific hacks in arch/arm64/kernel/pci.c instead of adding to it.

Ideally we will remove that file soon after the existing align_resource,
enabled_device and add_device hacks can be removed.

> > @@ -253,6 +291,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >  		return NULL;
> >  	}
> >  
> > +	if (vendor_specific_ops)
> > +		acpi_pci_root_ops.pci_ops = vendor_specific_ops;
> 
> You are relying on the scan handlers calling ordering here, which as far
> as I know depends on the ACPI tables layout, this is not acceptable,
> we need to find a more robust implementation.
> 
> Let's first rewind a bit though, to summarize:
> 
> 1) we need a way to configure a "generic host controller" with host
>    controller specific config methods (ie ECAM, even though is a PCI
>    standard it is not standard enough for some designers)

That code already exists, see drivers/acpi/pci_*.c

> 2) we keep the generic "PNP0A03" matching to declare a host bridge and
>    related resources (?). Maybe we can have an HID matching the
>    "real" device (eg "HISI0081" and related DSD) and a CID set to "PNP0A03" ?
>    I do not want to end up with two device objects in the ACPI tables.
> 
> I think that all this code belongs in:
> 
> drivers/pci/host/pci-host-generic.c

I disagree:

> and the quirks scan should be done _within_ the pci_acpi_scan_root()
> that should be placed in drivers/pci/host/pci-host-generic.c (ACPI probe
> path, to be created) so that, if quirks for config space have to be applied
> they are applied there before calling acpi_pci_root_create() so that
> ordering is guaranteed.

pci-host-generic.c is just for standard PCI implementations, and it has
zero code that would be shared with ACPI: Most of the implementation
deals with parsing DT properties, and all that code is entirely differnet
for ACPI and already exists in drivers/acpi. The one thing that could be
shared is the ECAM config space access, but ACPI already needs something
else here because it requires access to the config space at early boot
time, way before we even load that driver, see raw_pci_read/raw_pci_write.

If there are parts missing in drivers/acpi to make it access PCI hosts,
they can be added there, possibly inside "#ifndef CONFIG_X86".

> I will put together a proposal to define the way we specify HID and
> related DSD properties for PCI host controllers and send it to
> the ACPI working group for review.

That also requires a change to SBSA, right? Today, SBSA assumes that
we have a standard PCI host that will work with any hardware independent
PCI implementation in an OS. We either have to give up on SBSA saying
much about how PCI hosts are implemented, or stop assuming that hardware
is SBSA compliant.

> Second, I am against merging _any_ ACPI/PCI code for arm64 before we
> define a way for the kernel to detect if resources should be reassigned
> or just claimed as they are, as set-up by BIOS.

Why would it ever reassign anything that has been set up by the BIOS?
We are still talking about server systems, right?

	Arnd
