Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 15 Mar 2017 16:23:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 1/4] arm64: enable pci resource mapping using sysfs
Message-ID: <20170315212322.GA31690@bhelgaas-glaptop.roam.corp.google.com>
References: <1489610540.86622.19.camel@infradead.org>
MIME-Version: 1.0
In-Reply-To: <1489610540.86622.19.camel@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Wed, Mar 15, 2017 at 08:42:20PM +0000, David Woodhouse wrote:
> From: Brijesh Singh <brijess@amazon.com>
> 
> To support PCI resource mapping from userspace, pci_mmap_page_range()
> must be implemented and HAVE_PCI_MMAP defined. This support was absent
> for arm64.
> 
> [dwmw2: Add WC support]
> Reviewed-by: Erik Quanstrom <quanstro@amazon.com>
> Reviewed-by: Anthony Liguori <aliguori@amazon.com>
> Signed-off-by: Brijesh Singh <brijess@amazon.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> v2: s/pgprot_uncached/pgprot_device/
> 
>  arch/arm64/include/asm/pci.h |  4 ++++
>  arch/arm64/kernel/pci.c      | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b9a7ba9..f73734f 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -37,5 +37,9 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  }
>  #endif  /* CONFIG_PCI */
>  
> +#define HAVE_PCI_MMAP
> +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +			       enum pci_mmap_state mmap_state, int write_combine);
> +
>  #endif  /* __KERNEL__ */
>  #endif  /* __ASM_PCI_H */
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4f0e3eb..9a87b2a 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -228,3 +228,22 @@ void pcibios_remove_bus(struct pci_bus *bus)
>  }
>  
>  #endif
> +
> +int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +			enum pci_mmap_state mmap_state, int write_combine)
> +{
> +	if (mmap_state == pci_mmap_io)
> +		return -EINVAL;
> +
> +	if (write_combine)
> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	else
> +		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
> +
> +	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +			     vma->vm_end - vma->vm_start,
> +			     vma->vm_page_prot))
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> -- 
> dwmw2



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
