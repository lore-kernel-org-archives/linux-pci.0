Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964867AbeB1XHt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 18:07:49 -0500
Date: Wed, 28 Feb 2018 17:07:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] xtensa: Use generic pci_mmap_resource_range()
Message-ID: <20180228230747.GQ127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519045353-22496-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519045353-22496-1-git-send-email-dwmw@amazon.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 19, 2018 at 01:02:33PM +0000, David Woodhouse wrote:
> Commit f719582435 ("PCI: Add pci_mmap_resource_range() and use it for
> ARM64") added this generic function with the intent of using it
> everywhere and ultimately killing the old arch-specific implementations.
> 
> Let's get on with that eradication...
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Applied to pci/resource-mmap for v4.17, thanks!

Xtensa folks, let me know if you have applied this or would like to, and
I'll drop it.

> ---
>  arch/xtensa/include/asm/pci.h |  7 ++--
>  arch/xtensa/kernel/pci.c      | 94 ++++---------------------------------------
>  2 files changed, 12 insertions(+), 89 deletions(-)
> 
> diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
> index 5c83798..d5a8215 100644
> --- a/arch/xtensa/include/asm/pci.h
> +++ b/arch/xtensa/include/asm/pci.h
> @@ -44,9 +44,10 @@ extern struct pci_controller* pcibios_alloc_controller(void);
>  
>  #define PCI_DMA_BUS_IS_PHYS	(1)
>  
> -/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
> -#define HAVE_PCI_MMAP		1
> -#define arch_can_pci_mmap_io()	1
> +/* Tell PCI code what kind of PCI resource mappings we support */
> +#define HAVE_PCI_MMAP			1
> +#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
> +#define arch_can_pci_mmap_io()		1
>  
>  #endif /* __KERNEL__ */
>  
> diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
> index d981f01..b7c7a60 100644
> --- a/arch/xtensa/kernel/pci.c
> +++ b/arch/xtensa/kernel/pci.c
> @@ -39,7 +39,6 @@
>   * pcibios_align_resource
>   * pcibios_fixup_bus
>   * pci_bus_add_device
> - * pci_mmap_page_range
>   */
>  
>  struct pci_controller* pci_ctrl_head;
> @@ -258,98 +257,21 @@ pci_controller_num(struct pci_dev *dev)
>  #endif /* CONFIG_PROC_FS */
>  
>  /*
> - * Platform support for /proc/bus/pci/X/Y mmap()s,
> - * modelled on the sparc64 implementation by Dave Miller.
> + * Platform support for /proc/bus/pci/X/Y mmap()s.
>   *  -- paulus.
>   */
>  
> -/*
> - * Adjust vm_pgoff of VMA such that it is the physical page offset
> - * corresponding to the 32-bit pci bus offset for DEV requested by the user.
> - *
> - * Basically, the user finds the base address for his device which he wishes
> - * to mmap.  They read the 32-bit value from the config space base register,
> - * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
> - * offset parameter of mmap on /proc/bus/pci/XXX for that device.
> - *
> - * Returns negative error code on failure, zero on success.
> - */
> -static __inline__ int
> -__pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
> -		       enum pci_mmap_state mmap_state)
> +int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
>  {
> -	struct pci_controller *pci_ctrl = (struct pci_controller*) dev->sysdata;
> -	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
> -	unsigned long io_offset = 0;
> -	int i, res_bit;
> +	struct pci_controller *pci_ctrl = (struct pci_controller*) pdev->sysdata;
> +	resource_size_t ioaddr = pci_resource_start(pdev, bar);
>  
>  	if (pci_ctrl == 0)
>  		return -EINVAL;		/* should never happen */
>  
> -	/* If memory, add on the PCI bridge address offset */
> -	if (mmap_state == pci_mmap_mem) {
> -		res_bit = IORESOURCE_MEM;
> -	} else {
> -		io_offset = (unsigned long)pci_ctrl->io_space.base;
> -		offset += io_offset;
> -		res_bit = IORESOURCE_IO;
> -	}
> -
> -	/*
> -	 * Check that the offset requested corresponds to one of the
> -	 * resources of the device.
> -	 */
> -	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> -		struct resource *rp = &dev->resource[i];
> -		int flags = rp->flags;
> -
> -		/* treat ROM as memory (should be already) */
> -		if (i == PCI_ROM_RESOURCE)
> -			flags |= IORESOURCE_MEM;
> -
> -		/* Active and same type? */
> -		if ((flags & res_bit) == 0)
> -			continue;
> -
> -		/* In the range of this resource? */
> -		if (offset < (rp->start & PAGE_MASK) || offset > rp->end)
> -			continue;
> -
> -		/* found it! construct the final physical address */
> -		if (mmap_state == pci_mmap_io)
> -			offset += pci_ctrl->io_space.start - io_offset;
> -		vma->vm_pgoff = offset >> PAGE_SHIFT;
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> +	/* Convert to an offset within this PCI controller */
> +	ioaddr -= (unsigned long)pci_ctrl->io_space.base;
>  
> -/*
> - * Perform the actual remap of the pages for a PCI device mapping, as
> - * appropriate for this architecture.  The region in the process to map
> - * is described by vm_start and vm_end members of VMA, the base physical
> - * address is found in vm_pgoff.
> - * The pci device structure is provided so that architectures may make mapping
> - * decisions on a per-device or per-bus basis.
> - *
> - * Returns a negative error code on failure, zero on success.
> - */
> -int pci_mmap_page_range(struct pci_dev *dev, int bar,
> -			struct vm_area_struct *vma,
> -			enum pci_mmap_state mmap_state,
> -			int write_combine)
> -{
> -	int ret;
> -
> -	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
> -	if (ret < 0)
> -		return ret;
> -
> -	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
> -
> -	ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> -			         vma->vm_end - vma->vm_start,vma->vm_page_prot);
> -
> -	return ret;
> +	vma->vm_pgoff += (ioaddr + pci_ctrl->io_space.start) >> PAGE_SHIFT;
> +	return 0;
>  }
> -- 
> 2.7.4
> 
