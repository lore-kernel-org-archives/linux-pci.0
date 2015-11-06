Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41814 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031759AbbKFMuS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Nov 2015 07:50:18 -0500
Date: Fri, 6 Nov 2015 12:51:07 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Message-ID: <20151106125107.GB5146@red-moon>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com>
 <20151105181959.GA352@red-moon>
 <563C6A5F.5030500@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563C6A5F.5030500@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 06, 2015 at 04:52:47PM +0800, Jiang Liu wrote:

[...]

> >>> +int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
> >>> +{
> >>> +	int ret;
> >>> +	struct list_head *list = &info->resources;
> >>> +	struct acpi_device *device = info->bridge;
> >>> +	struct resource_entry *entry, *tmp;
> >>> +	unsigned long flags;
> >>> +
> >>> +	flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT;
> >>> +	ret = acpi_dev_get_resources(device, list,
> >>> +				     acpi_dev_filter_resource_type_cb,
> >>> +				     (void *)flags);
> >>> +	if (ret < 0)
> >>> +		dev_warn(&device->dev,
> >>> +			 "failed to parse _CRS method, error code %d\n", ret);
> >>> +	else if (ret == 0)
> >>> +		dev_dbg(&device->dev,
> >>> +			"no IO and memory resources present in _CRS\n");
> >>> +	else {
> >>> +		resource_list_for_each_entry_safe(entry, tmp, list) {
> >>> +			if (entry->res->flags & IORESOURCE_DISABLED)
> >>> +				resource_list_destroy_entry(entry);
> >>> +			else
> >>> +				entry->res->name = info->name;
> >>> +		}
> >>> +		acpi_pci_root_validate_resources(&device->dev, list,
> >>> +						 IORESOURCE_MEM);
> >>> +		acpi_pci_root_validate_resources(&device->dev, list,
> >>> +						 IORESOURCE_IO);
> >>
> >> It is not clear to me why we need these two calls above ^^^. We are
> >> using pci_acpi_root_add_resources(info) later. Is it not enough?
> >>
> >> Also, I cannot use acpi_pci_probe_root_resources() in my ARM64 PCI
> >> driver. It is because acpi_dev_get_resources is adding
> >> translation_offset to IO ranges start address and then:
> >> acpi_pci_root_validate_resources(&device->dev, list,
> >> 				 IORESOURCE_IO);
> >> rejects that IO regions as it is out of my 0x0-SZ_16M window.
> >>
> >> Does acpi_pci_probe_root_resources meant to be x86 specific and I
> >> should avoid using it?
> > 
> > IIUC, you _have_ to have the proper translation_offset to map the bridge
> > window into the IO address space:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348708.html
> > 
> > Then, using the offset, you should do something ia64 does, namely,
> > retrieve the CPU address corresponding to IO space (see arch/ia64/pci/pci.c
> > - add_io_space()) and map it in the physical address space by using
> > pci_remap_iospace(), it is similar to what we have to do with DT.
> > 
> > It is extremely confusing and I am not sure I got it right myself,
> > I am still grokking ia64 code to understand what it really does.
> > 
> > So basically, the IO bridge window coming from acpi_dev_get_resource()
> > should represent the IO space in 0 - 16M, IIUC.
> > 
> > By using the offset (that was initialized using translation_offset) and
> > the resource->start, you can retrieve the cpu address that you need to
> > actually map the IO space, since that's what we do on ARM (ie the
> > IO resource is an offset into the virtual address space set aside
> > for IO).
> > 
> > Confusing, to say the least. Jiang, did I get it right ?
> Hi Lorenzo and Tomasz,
> 	With a cup of coffee, I got myself awake eventually:)
> Now we are going to talk about IO port on IA64, really a little
> complex:( Actually there are two types of translation.
> 1) A PCI domain has a 24-bit IO port address space, there may
> be multiple IO port address spaces in systems with multiple PCI
> domains. So the first type of translation is to translate domain
> specific IO port address into system global IO port address
> (iomem_resource) by
>   res->start = acpi_des->start + acpi_des->translation_offset

And that's what I do not understand, or better I do not understand
why the acpi_pci_root_validate_resources (for IO) does not fail on ia64,
since that should work as arm64, namely IO ports are mapped through
MMIO.

I think the check in acpi_pci_root_validate_resources() (for
IORESOURCE_IO) fails at present on ia64 too, correct ?

If not, how can it work ? res->start definitely contains the
CPU physical address mapping IO space after adding the
translation_offset, so the check in acpi_pci_root_validate_resources()
for IO can't succeed.

In add_io_space() ia64 does the same thing as Tomasz has to do,
namely overwriting the res->start and end with the offset into
the virtual address space allocated for IO, which is different from
the CPU physical address allocated to IO space.

Please correct me if I am wrong.

> 2) IA64 needs to map IO port address spaces into MMIO address
> space because it has no instructions to access IO ports directly.
> So IA64 has reserved a MMIO range to map IO port address spaces.
> This type of translation relies on architecture specific information
> instead of ACPI descriptors.

That's how ARM64 works too, the IO space resources are an offset into
a chunk of virtual address space allocated to PCI IO memory, so it
seems to me that arm64 and ia64 should work the same way, and that
at present acpi_pci_root_validate_resources() should fail on ia64 too.

Thanks,
Lorenzo

> 
> On the other hand, ACPI specification has defined  "I/O to Memory
> Translation" flag and "Memory to I/O Translation" flag in
> ACPI Extended Address Space Descriptor, but current implementation
> doesn't really support such a use case. So we need to find a way
> out here. Could you please help to provide more information about
> PCI host bridge resource descriptor implementation details on
> ARM64?
> 
> > 
> > Lorenzo
> > 
> 
