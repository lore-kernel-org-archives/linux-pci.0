Return-Path: <SRS0=h9nn=2R=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=h9nn=2R=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
From: Mason <slash.tmp@free.fr>
To: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
Message-ID: <0cd311b9-b621-432d-f95f-fafc5016bce0@free.fr>
Date: Wed, 8 Mar 2017 14:39:09 +0100
MIME-Version: 1.0
In-Reply-To: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 07/03/2017 23:45, Mason wrote:

> 3) What happens if a device requires more than 256 MB of
> mem space? (Is that common? What kind of device? GPUs?)
> Our controller supports a remapping "facility" to add an
> offset to the bus address. Is such a feature supported
> by Linux at all?  The problem is that this creates
> another race condition, as setting the offset register
> before an access may occur concurrently on two cores.
> Perhaps 256 MB is plenty on a 32-bit embedded device?

I was told that Linux does not support this kind of "dynamic remapping",
because access to PCI memory region is not handled through a call-back;
the driver just calls readl/writel directly on the pointer.

"We expect that any device we map into the address space is reachable
through static page table entries set up by ioremap() or pci_iomap()."


On a related subject, I asked about the max size of I/O space.

/**
 *	pci_remap_iospace - Remap the memory mapped I/O space
 *	@res: Resource describing the I/O space
 *	@phys_addr: physical address of range to be mapped
 *
 *	Remap the memory mapped I/O space described by the @res
 *	and the CPU physical address @phys_addr into virtual address space.
 *	Only architectures that have memory mapped IO functions defined
 *	(and the PCI_IOBASE value defined) should call this function.
 */
int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
{
#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;

	if (!(res->flags & IORESOURCE_IO))
		return -EINVAL;

	if (res->end > IO_SPACE_LIMIT)
		return -EINVAL;

	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
				  pgprot_device(PAGE_KERNEL));
#else
	/* this architecture does not have memory mapped I/O space,
	   so this function should never be called */
	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
	return -ENODEV;
#endif
}

/* PCI fixed i/o mapping */
#define PCI_IO_VIRT_BASE	0xfee00000
#define PCI_IOBASE		((void __iomem *)PCI_IO_VIRT_BASE)

http://lxr.free-electrons.com/source/arch/arm/include/asm/io.h?v=4.9#L188

#ifdef CONFIG_NEED_MACH_IO_H
#include <mach/io.h>
#elif defined(CONFIG_PCI)
#define IO_SPACE_LIMIT	((resource_size_t)0xfffff)
#define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
#else
#define __io(a)		__typesafe_io((a) & IO_SPACE_LIMIT)
#endif

So the default seems to be 1 MB on arm32. But the platform seems allowed
to define a larger or a smaller space.

Regards.
