Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58200 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbcALF6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 00:58:13 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>,
	"CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>,
	"Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>
Subject: Re: [PATCH v4 1/2] PCI support added to ARC
Date: Tue, 12 Jan 2016 05:58:10 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E84567@us01wembx1.internal.synopsys.com>
References: <cover.1452526707.git.jpinto@synopsys.com>
 <b46c0fbfe3d383ca527e8eb7cbf953e59d346577.1452526707.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 11 January 2016 10:54 PM, Joao Pinto wrote:
> This patch adds PCI support to ARC and updates drivers/pci Makefile enabling
> the ARC arch to use the generic PCI setup functions.
> ...
>  
> diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
> index 694ece8..2ec3cf4 100644
> --- a/arch/arc/include/asm/io.h
> +++ b/arch/arc/include/asm/io.h
> @@ -16,7 +16,17 @@
>  extern void __iomem *ioremap(unsigned long physaddr, unsigned long size);
>  extern void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
>  				  unsigned long flags);
> +static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
> +{
> +	return (void __iomem *)port;
> +}
> +
> +static inline void ioport_unmap(void __iomem *addr)
> +{
> +}
> +
>  extern void iounmap(const void __iomem *addr);
> +extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);

Can u just define the one liner here ?

>  #define ioremap_nocache(phy, sz)	ioremap(phy, sz)
>  #define ioremap_wc(phy, sz)		ioremap(phy, sz)
> diff --git a/arch/arc/include/asm/pci.h b/arch/arc/include/asm/pci.h
> new file mode 100644
> index 0000000..a0a0fa5
> --- /dev/null
> +++ b/arch/arc/include/asm/pci.h
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _ASM_ARC_PCI_H
> +#define _ASM_ARC_PCI_H
> +
> +#ifdef __KERNEL__
> +#include <asm-generic/pci-dma-compat.h>
> +#include <asm-generic/pci-bridge.h>
> +
> +#include <linux/ioport.h>
> +
> +extern unsigned long pcibios_min_io;
> +#define PCIBIOS_MIN_IO pcibios_min_io
> +extern unsigned long pcibios_min_mem;
> +#define PCIBIOS_MIN_MEM pcibios_min_mem
> +
> +#define pcibios_assign_all_busses()	1
> +/*
> + * The PCI address space does equal the physical memory address space.
> + * The networking and block device layers use this boolean for bounce
> + * buffer decisions.
> + */
> +#define PCI_DMA_BUS_IS_PHYS     (1)
> +
> +/*
> + * Setup early fixed I/O mapping.
> + */
> +#if defined(CONFIG_PCI)
> +extern void pci_map_io_early(unsigned long pfn);
> +#else
> +static inline void pci_map_io_early(unsigned long pfn) {}
> +#endif

I don't see this being used - leftover from ARM copy/paste ?

> +
> +#endif /* __KERNEL__ */
> +
> +#endif /* _ASM_ARC_PCI_H */
> +
> diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
> index e7f3625..1bc2036 100644
> --- a/arch/arc/kernel/Makefile
> +++ b/arch/arc/kernel/Makefile
> @@ -12,6 +12,7 @@ obj-y	:= arcksyms.o setup.o irq.o time.o reset.o ptrace.o process.o devtree.o
>  obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o clk.o
>  obj-$(CONFIG_ISA_ARCOMPACT)		+= entry-compact.o intc-compact.o
>  obj-$(CONFIG_ISA_ARCV2)			+= entry-arcv2.o intc-arcv2.o
> +obj-$(CONFIG_PCI)  			+= pcibios.o
>  
>  obj-$(CONFIG_MODULES)			+= arcksyms.o module.o
>  obj-$(CONFIG_SMP) 			+= smp.o
> diff --git a/arch/arc/kernel/pcibios.c b/arch/arc/kernel/pcibios.c
> new file mode 100644
> index 0000000..99ee329
> --- /dev/null
> +++ b/arch/arc/kernel/pcibios.c
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright (C) 2014-2015 Synopsys, Inc. (www.synopsys.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/errno.h>
> +#include <linux/bootmem.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>

I doubt if you really need all these includes ?

> +
> +#include <asm/pci.h>
> +
> +unsigned long pcibios_min_io = 0x100;
> +EXPORT_SYMBOL(pcibios_min_io);
> +
> +unsigned long pcibios_min_mem = 0x100000;
> +EXPORT_SYMBOL(pcibios_min_mem);

These numbers and their magic values again seem to be used in ARM code only.
Please get rid of them (here as well as in header above)

> +
> +/*
> + * We don't have to worry about legacy ISA devices, so nothing to do here
> + */
> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> +				resource_size_t size, resource_size_t align)
> +{
> +	return res->start;
> +}
> +
> +/*
> + * If the bus contains any of these devices, then we must not turn on
> + * parity checking of any kind.  Currently this is CyberPro 20x0 only.
> + */
> +static inline int pdev_bad_for_parity(struct pci_dev *dev)
> +{
> +	return ((dev->vendor == PCI_VENDOR_ID_INTERG &&
> +		 (dev->device == PCI_DEVICE_ID_INTERG_2000 ||
> +		  dev->device == PCI_DEVICE_ID_INTERG_2010)) ||
> +		(dev->vendor == PCI_VENDOR_ID_ITE &&
> +		 dev->device == PCI_DEVICE_ID_ITE_8152));
> +
> +}

static inline in a "C" file with no caller - please remove !

> +
> +void pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +}
> +EXPORT_SYMBOL(pcibios_fixup_bus);
> diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
> index 739e65f..fe807b0 100644
> --- a/arch/arc/mm/ioremap.c
> +++ b/arch/arc/mm/ioremap.c
> @@ -13,6 +13,7 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/cache.h>
> +#include <linux/sizes.h>
>  
>  void __iomem *ioremap(unsigned long paddr, unsigned long size)
>  {
> @@ -80,7 +81,6 @@ void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
>  }
>  EXPORT_SYMBOL(ioremap_prot);
>  
> -
>  void iounmap(const void __iomem *addr)
>  {
>  	if (addr >= (void __force __iomem *)ARC_UNCACHED_ADDR_SPACE)
> @@ -89,3 +89,11 @@ void iounmap(const void __iomem *addr)
>  	vfree((void *)(PAGE_MASK & (unsigned long __force)addr));
>  }
>  EXPORT_SYMBOL(iounmap);
> +
> +#ifdef CONFIG_PCI
> +int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
> +{
> +	return ioremap_nocache(phys_addr + offset,  SZ_64K);
> +}
> +EXPORT_SYMBOL_GPL(pci_ioremap_io);

can be moved to io.h w/o need for EXPORT_SYMBOL...

> +#endif
> diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
> index d475f9d..426ac4b 100644
> --- a/arch/arc/plat-axs10x/Kconfig
> +++ b/arch/arc/plat-axs10x/Kconfig
> @@ -11,6 +11,7 @@ menuconfig ARC_PLAT_AXS10X
>  	select DW_APB_ICTL
>  	select GPIO_DWAPB
>  	select OF_GPIO
> +	select MIGHT_HAVE_PCI
>  	select GENERIC_IRQ_CHIP
>  	select ARCH_REQUIRE_GPIOLIB
>  	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index be3f631..2154092 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
>  # Some architectures use the generic PCI setup functions
>  #
>  obj-$(CONFIG_ALPHA) += setup-irq.o
> +obj-$(CONFIG_ARC) += setup-irq.o
>  obj-$(CONFIG_ARM) += setup-irq.o
>  obj-$(CONFIG_ARM64) += setup-irq.o
>  obj-$(CONFIG_UNICORE32) += setup-irq.o

