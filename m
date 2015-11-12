Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17959 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbbKLInS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Nov 2015 03:43:18 -0500
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <5640A8AA.4000806@semihalf.com> <20151109171042.GA11909@red-moon>
 <6488357.xJV65iBRHq@wuerfel> <564185B6.8040006@linux.intel.com>
 <20151111174647.GA30051@red-moon>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <56445117.8090307@linux.intel.com>
Date: Thu, 12 Nov 2015 16:43:03 +0800
MIME-Version: 1.0
In-Reply-To: <20151111174647.GA30051@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/11/12 1:46, Lorenzo Pieralisi wrote:
> On Tue, Nov 10, 2015 at 01:50:46PM +0800, Jiang Liu wrote:
> 
> [...]
> 
>>>> In particular, I would like to understand, for an eg DWordIO descriptor,
>>>> what Range Minimum, Range Maximum and Translation Offset represent,
>>>> they can't mean different things depending on the SW parsing them,
>>>> this totally defeats the purpose.
>>>
>>> I have no clue about what those mean in ACPI though.
>>>
>>> Generally speaking, each PCI domain is expected to have a (normally 64KB)
>>> range of CPU addresses that gets translated into PCI I/O space the same
>>> way that config space and memory space are handled.
>>> This is true for almost every architecture except for x86, which uses
>>> different CPU instructions for I/O space compared to the other spaces.
>>>
>>>> By the way, ia64 ioremaps the translation_offset (ie new_space()), so
>>>> basically that's the CPU physical address at which the PCI host bridge
>>>> map the IO space transactions), I do not think ia64 is any different from
>>>> arm64 in this respect, if it is please provide an HW description here from
>>>> the PCI bus perspective here (also an example of ia64 ACPI PCI host bridge
>>>> tables would help).
>>>
>>> The main difference between ia64 and a lot of the other architectures (e.g.
>>> sparc is different again) is that ia64 defines a logical address range
>>> in terms of having a small number for each I/O space followed by the
>>> offset within that space as a 'port number' and uses a mapping function
>>> that is defined as
>>>
>>> static inline void *__ia64_mk_io_addr (unsigned long port)
>>> {
>>>         struct io_space *space = &io_space[IO_SPACE_NR(port)];
>>>         return (space->mmio_base | IO_SPACE_PORT(port););
>>> }
>>> static inline unsigned int inl(unsigned long port)
>>> {
>>>         return *__ia64_mk_io_addr(port);
>>> }
>>>
>>> Most architectures allow only one I/O port range and put it at a fixed
>>> virtual address so that inl() simply becomes 
>>>
>>> static inline u32 inl(unsigned long addr)
>>> {
>>>         return readl(PCI_IOBASE + addr);
>>> }
>>>
>>> which noticeably reduces code size.
>>>
>>> On some architectures (powerpc, arm, arm64), we then get the same simplified
>>> definition with a fixed virtual address, and use pci_ioremap_io() or
>>> something like that to to map a physical address range into this virtual
>>> address window at the correct io_offset;
>> Hi all,
>> 	Thanks for explanation, I found a way to make the ACPI resource
>> parsing interface arch neutral, it should help to address Lorenzo's
>> concern. Please refer to the attached patch. (It's still RFC, not tested
>> yet).
> 
> If we go with this approach though, you are not adding the offset to
> the resource when parsing the memory spaces in acpi_decode_space(), are we
> sure that's what we really want ?
> 
> In DT, a host bridge range has a:
> 
> - CPU physical address
> - PCI bus address
> 
> We use that to compute the offset between primary bus (ie CPU physical
> address) and secondary bus (ie PCI bus address).
> 
> The value ending up in the PCI resource struct (for memory space) is
> the CPU physical address, if you do not add the offset in acpi_decode_space
> that does not hold true on platforms where CPU<->PCI offset != 0 on ACPI,
> am I wrong ?
Hi Lorenzo,
	I may have found the divergence between us about the design here. You
treat it as a one-stage translation but I treat it as a
two-stage translation as below:
stage 1: map(translate) per-PCI-domain IO port address[0, 16M) into
system global IO port address. Here system global IO port address is
ioport_resource[0, IO_SPACE_LIMIT).
stage 2: map system IO port address into system memory address.

We need two objects of struct resource_win to support above two-stage
translation. One object, type of IORESOURCE_IO, is used to support
stage one, and it will also used to allocate IO port resources
for PCI devices. Another object, type of IORESOURCE_MMIO, is used
to allocate resource from iomem_resource and setup MMIO mapping
to actually access IO ports.

For ARM64, it doesn't support multiple per-PCI-domain(bus local)
IO port address space yet, so stage one seems to be optional
becomes the offset between bus local IO port address and system
IO port address is always 0. But we still need two objects of
struct resource_win. The first object is
	{
		offset:0,
		start:AddressMinimum,
		end:AddressMaximum,
		flags:IORESOURCE_IO
	}
Here it's type of IORESOURCE_IO and offset must be zero because
pcibios_resource_to_bus() will access it translate system IO
port address into bus local IO port address. With my patch,
the struct resource_win object created by the ACPI core will
be reused for this.

The second object is:
	{
		offset:Translation_Offset,
		start:AddressMinimum + Translation_Offset,
		end:AddressMaximum + Translation_Offset,
		flags:IORESOURCE_MMIO
	}
Arch code need to create the second struct resource_win object
and actually setup the MMIO mapping.

But there's really another bug need to get fixed, funciton
acpi_dev_ioresource_flags() assumes bus local IO port address
space is size of 64K, which is wrong for IA64 and ARM64.

Thanks,
Gerry

> 
> Overall I think the point is related to ioport_resource and its check
> in acpi_pci_root_validate_resources() which basically that's the
> problem that started this thread.
> 
> On arm64, IO_SPACE_LIMIT is 16M, which, AFAIK is a kernel limit, not
> a HW one. Comparing the resources parsed from the PCI bridge _CRS against
> the range 0..IO_SPACE_LIMIT is not necessarily meaningful (or at least
> not meaningful in its current form), on ia64 it works because IO_SPACE_LIMIT
> is bumped up to 4G, that's the reason why adding the offset to the ACPI IO
> resources work on ia64 as far as I understand.
> 
> And that's why I pulled Arnd in this discussion since he knows better
> than me: what does ioport_resource _really_ represent on ARM64 ? It seems
> to me that it is a range of IO ports values (ie a window that defines
> the allowed offset in the virtual address space allocated to PCI IO) that
> has _nothing_ to do with the CPU physical address at which the IO space is
> actually mapped.
> 
> To sum it up for a, say, DWordIo/Memory descriptor:
> 
> - AddressMinimum, AddressMaximum represent the PCI bus addresses defining
>   the resource start..end
> - AddressTranslation is the offset that has to be added to AddressMinimum
>   and AddressMaximum to get the window in CPU physical address space
> 
> So:
> 
> - Either we go with the patch attached (but please check my comment on
>   the memory spaces)
> - Or we patch acpi_pci_root_validate_resources() to amend the way
>   IORESOURCE_IO is currently checked against ioport_resource, it can't
>   work on arm64 at present, I described why above
> 
> Thoughts appreciated it is time we got this sorted and thanks for
> the patch.
> 
> Thanks,
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
