Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Apr 2016 11:00:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
	agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: add pci_unmap_iospace function for PCI_IOBASE
Message-ID: <20160407160004.GA8780@localhost>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Mon, Mar 07, 2016 at 05:21:49PM -0500, Sinan Kaya wrote:
> The PCI_IOBASE needs to be released after hotplug removal so that it can be
> re-added back by the pci_remap_iospace function during insertion.
> 
> Adding unmap function to follow IO remap function.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c   | 25 +++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3a516c0..f5faed2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -26,6 +26,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/vmalloc.h>
>  #include <asm-generic/pci-bridge.h>
>  #include <asm/setup.h>
>  #include <linux/aer.h>
> @@ -3169,6 +3170,30 @@ int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  #endif
>  }
>  
> +/**
> + *	pci_unmap_iospace - Unmap the memory mapped I/O space
> + *	@virt_addr: virtual address to be unmapped
> + *	@size: size of the physical address to be unmapped
> + *
> + *	Unmap the CPU virtual address @virt_addr from virtual address space.
> + *	Only architectures that have memory mapped IO functions defined
> + *	(and the PCI_IOBASE value defined) should call this function.
> + */
> +void  __weak pci_unmap_iospace(struct resource *res)

Why is this weak?  I assume probably because pci_remap_iospace() is
weak, but I don't see any reason why *that* needs to be weak.  There's
only one implementation.  I think neither one should be weak unless we
have an actual need for that.

> +{
> +#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
> +	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
> +
> +	unmap_kernel_range(vaddr, resource_size(res));

There really aren't any other generic uses of unmap_kernel_range().
This isn't an unusual scenario, so I would expect this code to use a
pattern that's used elsewhere.

> +#else
> +	/*
> +	 * This architecture does not have memory mapped I/O space,
> +	 * so this function should never be called.
> +	 */
> +	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
> +#endif
> +}
> +
>  static void __pci_set_master(struct pci_dev *dev, bool enable)
>  {
>  	u16 old_cmd, cmd;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 398ae7e..c6e3f0e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1172,6 +1172,7 @@ int pci_register_io_range(phys_addr_t addr, resource_size_t size);
>  unsigned long pci_address_to_pio(phys_addr_t addr);
>  phys_addr_t pci_pio_to_address(unsigned long pio);
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> +void pci_unmap_iospace(struct resource *res);
>  
>  static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
>  {
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
