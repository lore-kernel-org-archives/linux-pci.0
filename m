Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33268 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbbJTQqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Oct 2015 12:46:00 -0400
Date: Tue, 20 Oct 2015 11:45:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/60] sparc/PCI: Use correct bus address to resource
 offset
Message-ID: <20151020164554.GG8224@localhost>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
 <1444340359-8011-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444340359-8011-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 08, 2015 at 02:38:21PM -0700, Yinghai Lu wrote:
> After we add 64bit mmio parsing, we got some "no compatible bridge window"
> warning on anther new model that support 64bit resource.
> 
> It turns out that we can not use mem_space.start as 64bit mem space
> offset, aka mem_space.start != offset.
> 
> Use child_phys_addr to calculate exact offset and recorder offset in
> pbm.  Still assume all mem have same offset, otherwise panic early.
> 
> After patch we get correct offset.
> 
> /pci@305: PCI IO [io  0x2007e00000000-0x2007e0fffffff] offset 2007e00000000
> /pci@305: PCI MEM [mem 0x2000000100000-0x200007effffff] offset 2000000000000
> /pci@305: PCI MEM64 [mem 0x2000100000000-0x2000dffffffff] offset 2000000000000
> ...
> pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x2000000100000-0x200007effffff] (bus address [0x00100000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x2000dffffffff] (bus address [0x100000000-0xdffffffff])
> 
> 
> -v2: to make is simple, do not add mem64_offset, and assume
>      mem64_offset == mem_offset, otherwise would make
>      pci_mmap_resource() path too complicated.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/sparc/kernel/pci.c        | 14 +++++++-------
>  arch/sparc/kernel/pci_common.c | 36 +++++++++++++++++++++++++++---------
>  arch/sparc/kernel/pci_impl.h   |  3 +++
>  3 files changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index badf095..451792e 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -654,12 +654,12 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
>  	printk("PCI: Scanning PBM %s\n", node->full_name);
>  
>  	pci_add_resource_offset(&resources, &pbm->io_space,
> -				pbm->io_space.start);
> +				pbm->io_offset);
>  	pci_add_resource_offset(&resources, &pbm->mem_space,
> -				pbm->mem_space.start);
> +				pbm->mem_offset);
>  	if (pbm->mem64_space.flags)
>  		pci_add_resource_offset(&resources, &pbm->mem64_space,
> -					pbm->mem_space.start);
> +					pbm->mem_offset);
>  	pbm->busn.start = pbm->pci_first_busno;
>  	pbm->busn.end	= pbm->pci_last_busno;
>  	pbm->busn.flags	= IORESOURCE_BUS;
> @@ -751,10 +751,10 @@ static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struc
>  		return -EINVAL;
>  
>  	if (mmap_state == pci_mmap_io) {
> -		vma->vm_pgoff = (pbm->io_space.start +
> +		vma->vm_pgoff = (pbm->io_offset +
>  				 user_offset) >> PAGE_SHIFT;
>  	} else {
> -		vma->vm_pgoff = (pbm->mem_space.start +
> +		vma->vm_pgoff = (pbm->mem_offset +
>  				 user_offset) >> PAGE_SHIFT;
>  	}
>  
> @@ -981,9 +981,9 @@ void pci_resource_to_user(const struct pci_dev *pdev, int bar,
>  	unsigned long offset;
>  
>  	if (rp->flags & IORESOURCE_IO)
> -		offset = pbm->io_space.start;
> +		offset = pbm->io_offset;
>  	else
> -		offset = pbm->mem_space.start;
> +		offset = pbm->mem_offset;
>  
>  	*start = rp->start - offset;
>  	*end = rp->end - offset;
> diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
> index 33524c1..28e976a 100644
> --- a/arch/sparc/kernel/pci_common.c
> +++ b/arch/sparc/kernel/pci_common.c
> @@ -393,6 +393,7 @@ static void pci_register_iommu_region(struct pci_pbm_info *pbm)
>  void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  {
>  	const struct linux_prom_pci_ranges *pbm_ranges;
> +	resource_size_t mem64_offset = 0;
>  	int i, saw_mem, saw_io;
>  	int num_pbm_ranges;
>  
> @@ -410,13 +411,16 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  
>  	for (i = 0; i < num_pbm_ranges; i++) {
>  		const struct linux_prom_pci_ranges *pr = &pbm_ranges[i];
> -		unsigned long a, size;
> +		unsigned long a, size, region_a;
>  		u32 parent_phys_hi, parent_phys_lo;
> +		u32 child_phys_mid, child_phys_lo;
>  		u32 size_hi, size_lo;
>  		int type;
>  
>  		parent_phys_hi = pr->parent_phys_hi;
>  		parent_phys_lo = pr->parent_phys_lo;
> +		child_phys_mid = pr->child_phys_mid;
> +		child_phys_lo = pr->child_phys_lo;
>  		if (tlb_type == hypervisor)
>  			parent_phys_hi &= 0x0fffffff;
>  
> @@ -426,6 +430,8 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  		type = (pr->child_phys_hi >> 24) & 0x3;
>  		a = (((unsigned long)parent_phys_hi << 32UL) |
>  		     ((unsigned long)parent_phys_lo  <<  0UL));
> +		region_a = (((unsigned long)child_phys_mid << 32UL) |
> +		     ((unsigned long)child_phys_lo  <<  0UL));
>  		size = (((unsigned long)size_hi << 32UL) |
>  			((unsigned long)size_lo  <<  0UL));
>  
> @@ -440,6 +446,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  			pbm->io_space.start = a;
>  			pbm->io_space.end = a + size - 1UL;
>  			pbm->io_space.flags = IORESOURCE_IO;
> +			pbm->io_offset = a - region_a;
>  			saw_io = 1;
>  			break;
>  
> @@ -448,6 +455,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  			pbm->mem_space.start = a;
>  			pbm->mem_space.end = a + size - 1UL;
>  			pbm->mem_space.flags = IORESOURCE_MEM;
> +			pbm->mem_offset = a - region_a;
>  			saw_mem = 1;
>  			break;
>  
> @@ -456,6 +464,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  			pbm->mem64_space.start = a;
>  			pbm->mem64_space.end = a + size - 1UL;
>  			pbm->mem64_space.flags = IORESOURCE_MEM;
> +			mem64_offset = a - region_a;
>  			saw_mem = 1;
>  			break;
>  
> @@ -471,14 +480,23 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  		prom_halt();
>  	}
>  
> -	printk("%s: PCI IO[%llx] MEM[%llx]",
> -	       pbm->name,
> -	       pbm->io_space.start,
> -	       pbm->mem_space.start);
> -	if (pbm->mem64_space.flags)
> -		printk(" MEM64[%llx]",
> -		       pbm->mem64_space.start);
> -	printk("\n");
> +	if (pbm->io_space.flags)
> +		printk("%s: PCI IO %pR offset %llx\n",
> +		       pbm->name, &pbm->io_space, pbm->io_offset);
> +	if (pbm->mem_space.flags)
> +		printk("%s: PCI MEM %pR offset %llx\n",
> +		       pbm->name, &pbm->mem_space, pbm->mem_offset);
> +	if (pbm->mem64_space.flags) {
> +		if (pbm->mem_space.flags) {
> +			if (mem64_offset != pbm->mem_offset)
> +				panic("mem offset %llx != mem64 offset %llx\n",
> +					pbm->mem_offset, mem64_offset);

Why do you panic rather than just handling the mem64 offset?  As far
as I know, there's no PCI reason why the mem64 offset has to be the
same as the mem one.

> +		} else
> +			pbm->mem_offset = mem64_offset;
> +
> +		printk("%s: PCI MEM64 %pR offset %llx\n",
> +		       pbm->name, &pbm->mem64_space, pbm->mem_offset);
> +	}
>  
>  	pbm->io_space.name = pbm->mem_space.name = pbm->name;
>  	pbm->mem64_space.name = pbm->name;
> diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
> index 37222ca..08b74af 100644
> --- a/arch/sparc/kernel/pci_impl.h
> +++ b/arch/sparc/kernel/pci_impl.h
> @@ -99,6 +99,9 @@ struct pci_pbm_info {
>  	struct resource			mem_space;
>  	struct resource			mem64_space;
>  	struct resource			busn;
> +	/* offset */
> +	resource_size_t			io_offset;
> +	resource_size_t			mem_offset;
>  
>  	/* Base of PCI Config space, can be per-PBM or shared. */
>  	unsigned long			config_space;
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
