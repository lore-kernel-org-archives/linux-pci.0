Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:46669 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934030AbdCVNdo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2017 09:33:44 -0400
Date: Wed, 22 Mar 2017 14:33:39 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] cris: Use generic pci_mmap_resource_range()
Message-ID: <20170322133339.GA29118@axis.com>
References: <cover.1490188942.git.dwmw2@infradead.org>
 <1e68573b4fe52b24d770a8582a7db59272862a52.1490188942.git.dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e68573b4fe52b24d770a8582a7db59272862a52.1490188942.git.dwmw2@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 01:25:25PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/cris/arch-v32/drivers/pci/bios.c | 23 -----------------------
>  arch/cris/include/asm/pci.h           |  1 +
>  2 files changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
> index a589686d..394c2a73 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -14,29 +14,6 @@ void pcibios_set_master(struct pci_dev *dev)
>  	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
>  }
>  
> -int pci_mmap_page_range(struct pci_dev *dev, int bar,
> -			struct vm_area_struct *vma,
> -			enum pci_mmap_state mmap_state, int write_combine)
> -{
> -	unsigned long prot;
> -
> -	/* Leave vm_pgoff as-is, the PCI space address is the physical
> -	 * address on this platform.
> -	 */
> -	prot = pgprot_val(vma->vm_page_prot);
> -	vma->vm_page_prot = __pgprot(prot);
> -
> -	/* Write-combine setting is ignored, it is changed via the mtrr
> -	 * interfaces on this platform.
> -	 */
> -	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> -			     vma->vm_end - vma->vm_start,
> -			     vma->vm_page_prot))
> -		return -EAGAIN;
> -
> -	return 0;
> -}
> -
>  resource_size_t
>  pcibios_align_resource(void *data, const struct resource *res,
>  		       resource_size_t size, resource_size_t align)
> diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
> index 65198cb..6e50533 100644
> --- a/arch/cris/include/asm/pci.h
> +++ b/arch/cris/include/asm/pci.h
> @@ -42,6 +42,7 @@ struct pci_dev;
>  #define PCI_DMA_BUS_IS_PHYS	(1)
>  
>  #define HAVE_PCI_MMAP
> +#define ARCH_GENERIC_PCI_MMAP_RESOURCE
>  
>  #endif /* __KERNEL__ */
>  
> -- 
> 2.9.3

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
