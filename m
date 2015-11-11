Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Date: Wed, 11 Nov 2015 21:55:37 +0100
Message-ID: <4357616.eloqZ4oI6r@wuerfel>
In-Reply-To: <20151111174647.GA30051@red-moon>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com> <564185B6.8040006@linux.intel.com> <20151111174647.GA30051@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 11 November 2015 17:46:47 Lorenzo Pieralisi wrote:
> On Tue, Nov 10, 2015 at 01:50:46PM +0800, Jiang Liu wrote:
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

Sinan Kaya pointed out that SBSA mandates a 1:1 mapping for memory space.

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

Right, the ioport_resource uses the same space as the CPU virtual address,
with an offset of PCI_IOBASE that is defined as

#define PCI_IOBASE            ((void __iomem *)PCI_IO_VIRT_BASE)
#define PCI_IO_START            (PCI_IO_END - PCI_IO_SIZE)
#define PCI_IO_END              (MODULES_VADDR - SZ_2M)
#define PCI_IO_SIZE             SZ_16M

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

The easiest way would be to assume that nobody is building a server
system that has multiple I/O spaces. SBSA explicitly makes I/O space
optional, and really the only reason anyone includes that feature these
days is for initializing GPUs through the BIOS POST method, so that
is not relevant for servers. Even when you do have multiple PCIe
host controllers that all support I/O space, the most logical implementation
would be to share one common space.

If that fails, there are still two cases you have to care about, and
it really depends on what hardware makers decide to use here (and whether
we have any influence over them). The easier way for us to do this is
if every hardware sets up the mapping between CPU physical and PCI I/O
in a way that the I/O space numbers are non-overlapping between the
host controllers. That way we can still make Linux ioport_resource
addresses the same as PCI I/O space addresses (using io_offset=0),
with the downside being that only the first PCIe host (as enumerated
by the bootloader) can have I/O space addresses below 1024 that may
be required for ISA compatibility on some hardware.

	Arnd
