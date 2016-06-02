Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Thu, 2 Jun 2016 17:50:18 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com,
	jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V8 3/9] pci: Add new function to unmap IO resources.
Message-ID: <20160602165018.GG13962@red-moon>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-4-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464621262-26770-4-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 05:14:16PM +0200, Tomasz Nowicki wrote:
> We need to release I/O resources so that the same I/O resources
> can be allocated again (pci_remap_iospace), like in PCI hotplug removal
> scenario. Therefore this patch implements new pci_unmap_iospace call which
> unmaps I/O space as the symmetry to pci_remap_iospace.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/pci/pci.c   | 18 ++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c8b4dbd..eb431b5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -25,6 +25,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/vmalloc.h>
>  #include <asm/setup.h>
>  #include <linux/aer.h>
>  #include "pci.h"
> @@ -3165,6 +3166,23 @@ int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  #endif
>  }
>  
> +/**
> + *	pci_unmap_iospace - Unmap the memory mapped I/O space
> + *	@res: resource to be unmapped
> + *
> + *	Unmap the CPU virtual address @res from virtual address space.
> + *	Only architectures that have memory mapped IO functions defined
> + *	(and the PCI_IOBASE value defined) should call this function.
> + */
> +void pci_unmap_iospace(struct resource *res)
> +{
> +#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
> +	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
> +
> +	unmap_kernel_range(vaddr, resource_size(res));
> +#endif
> +}

Rafael mentioned that, it would be cleaner to move the ifdef outside
the function and add an empty static inline (but that probably should
be done in one go along with pci_remap_iospace() and
pci_pio_to_address() and pci_address_to_pio()) it would be weird
to do it just for pci_unmap_iospace().

It is true that unmap_kernel_range() is not commonly used in generic
code, but to the best of my knowledge it does what's required here,
(ie clear page table entries and flush tlbs, given that it is used
in conjuction with ioremap_page_range() that maps a physical address
to a specific preallocated virtual address ie PCI_IOBASE), so:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +
>  static void __pci_set_master(struct pci_dev *dev, bool enable)
>  {
>  	u16 old_cmd, cmd;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b67e4df..12349de 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1167,6 +1167,7 @@ int pci_register_io_range(phys_addr_t addr, resource_size_t size);
>  unsigned long pci_address_to_pio(phys_addr_t addr);
>  phys_addr_t pci_pio_to_address(unsigned long pio);
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> +void pci_unmap_iospace(struct resource *res);
>  
>  static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
>  {
> -- 
> 1.9.1
> 
