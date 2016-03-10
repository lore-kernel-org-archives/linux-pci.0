Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41056 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbcCJSYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Mar 2016 13:24:45 -0500
Date: Thu, 10 Mar 2016 12:24:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/59] sparc/PCI: Use correct bus address to resource
 offset
Message-ID: <20160310182440.GC14873@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
 <1456366370-28995-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456366370-28995-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,

On Wed, Feb 24, 2016 at 06:11:53PM -0800, Yinghai Lu wrote:
> After we add 64bit mmio parsing, we got some "no compatible bridge window"
> warning on anther new model that support 64bit resource.
> 
> It turns out that we can not use mem_space.start as 64bit mem space
> offset, aka there is mem_space.start != offset.
> 
> Use child_phys_addr to calculate exact offset and record offset in
> pbm.
> 
> After patch we get correct offset.
> 
> /pci@305: PCI IO [io  0x2007e00000000-0x2007e0fffffff] offset 2007e00000000
> /pci@305: PCI MEM [mem 0x2000000100000-0x200007effffff] offset 2000000000000
> /pci@305: PCI MEM64 [mem 0x2000100000000-0x2000dffffffff] offset 2000000000000
> ...
> pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])

Just double-checking that your ioport space really contains 256M ports.
It's fine if it does; it's just a little unusual.

> pci_bus 0000:00: root bus resource [mem 0x2000000100000-0x200007effffff] (bus address [0x00100000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x2000dffffffff] (bus address [0x100000000-0xdffffffff])
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  arch/sparc/kernel/pci.c        | 50 +++++++++++++++++++-----------------------
>  arch/sparc/kernel/pci_common.c | 32 ++++++++++++++++++++-------
>  arch/sparc/kernel/pci_impl.h   |  4 ++++
>  3 files changed, 50 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index badf095..269630a 100644
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
> +					pbm->mem64_offset);
>  	pbm->busn.start = pbm->pci_first_busno;
>  	pbm->busn.end	= pbm->pci_last_busno;
>  	pbm->busn.flags	= IORESOURCE_BUS;
> @@ -733,30 +733,28 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struct *vma,
>  				      enum pci_mmap_state mmap_state)
>  {
> -	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
> -	unsigned long space_size, user_offset, user_size;
> -
> -	if (mmap_state == pci_mmap_io) {
> -		space_size = resource_size(&pbm->io_space);
> -	} else {
> -		space_size = resource_size(&pbm->mem_space);
> -	}
> +	unsigned long user_offset, user_size;
> +	struct resource res, *root_bus_res;
> +	struct pci_bus_region region;
>  
>  	/* Make sure the request is in range. */
>  	user_offset = vma->vm_pgoff << PAGE_SHIFT;
>  	user_size = vma->vm_end - vma->vm_start;
>  
> -	if (user_offset >= space_size ||
> -	    (user_offset + user_size) > space_size)
> +	region.start = user_offset;
> +	region.end = user_offset + user_size - 1;
> +	memset(&res, 0, sizeof(res));
> +	if (mmap_state == pci_mmap_io)
> +		res.flags = IORESOURCE_IO;
> +	else
> +		res.flags = IORESOURCE_MEM;
> +
> +	pcibios_bus_to_resource(pdev->bus, &res, &region);
> +	root_bus_res = pci_find_root_bus_resource(pdev->bus, &res);
> +	if (!root_bus_res)
>  		return -EINVAL;
>  
> -	if (mmap_state == pci_mmap_io) {
> -		vma->vm_pgoff = (pbm->io_space.start +
> -				 user_offset) >> PAGE_SHIFT;
> -	} else {
> -		vma->vm_pgoff = (pbm->mem_space.start +
> -				 user_offset) >> PAGE_SHIFT;
> -	}
> +	vma->vm_pgoff = res.start >> PAGE_SHIFT;
>  
>  	return 0;

This needs to explain what's unique about sparc that means it needs
pci_find_root_bus_resource() when no other arch does.

This is used in the pci_mmap_resource() path.  I don't understand how
that path works on sparc.  I tried to work through the simple case of
a user mapping the first 4096 bytes of a BAR.  Assume the BAR is 4096
bytes in size:

  # User does something like this:
  #   mmap(NULL, 4096, ..., "/sys/.../resourceN", 0);

  pci_mmap_resource

    # At entry, "vma->vm_pgoff" is the offset into the BAR (in pages).
    # In this case, the user wants the first page of the BAR, so
    # vma->vm_pgoff == 0.

    # "res" is the the pdev->resource[n], which contains the CPU
    # physical address of the BAR.

    pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)
      start = vma->vm_pgoff           # == 0
      size = 4096
      pci_start = 0                   # offset into BAR (PCI_MMAP_SYSFS case)

      # we return 1 because [0x0000-0x0fff] is a valid area in this
      # BAR

    pci_resource_to_user(pdev, i, res, &start, &end);

    # On most platforms: pci_resource_to_user() copies res->start to
    # *start, so "start" is the CPU physical address of the
    # BAR.
    
    # On sparc: pci_resource_to_user() calls pcibios_resource_to_bus()
    # (see below), so "start" is the PCI bus address of the BAR.

    vma->vm_pgoff += start >> PAGE_SHIFT;

    # On most platforms: "vma->vm_pgoff" is now the CPU physical page
    # number of the part of the BAR we're mapping.

    # On sparc: "vma->vm_pgoff" is the PCI bus page number of the part
    # of the BAR we're mapping.  This seems wrong: doesn't the VM
    # system assume vm_pgoff is a CPU physical page number?

    if (... && iomem_is_exclusive(start))

    # On most platforms, "start" is a CPU physical address, and
    # iomem_is_exclusive() looks it up in the iomem_resource tree,
    # which contains resources of CPU physical addresses.

    # On sparc, "start" is a PCI bus address.  How can this work in
    # iomem_is_exclusive()?  I assume the resources in iomem_resource
    # still contain CPU physical addresses, not PCI bus addresses,
    # don't they?

>  }
> @@ -977,16 +975,12 @@ void pci_resource_to_user(const struct pci_dev *pdev, int bar,
>  			  const struct resource *rp, resource_size_t *start,
>  			  resource_size_t *end)
>  {
> -	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
> -	unsigned long offset;
> +	struct pci_bus_region region;
>  
> -	if (rp->flags & IORESOURCE_IO)
> -		offset = pbm->io_space.start;
> -	else
> -		offset = pbm->mem_space.start;
> +	pcibios_resource_to_bus(pdev->bus, &region, (struct resource *)rp);
>  
> -	*start = rp->start - offset;
> -	*end = rp->end - offset;
> +	*start = region.start;
> +	*end = region.end;
>  }
>  
>  void pcibios_set_master(struct pci_dev *dev)
> diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
> index 33524c1..76998f8 100644
> --- a/arch/sparc/kernel/pci_common.c
> +++ b/arch/sparc/kernel/pci_common.c
> @@ -410,13 +410,16 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
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
> @@ -426,6 +429,8 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  		type = (pr->child_phys_hi >> 24) & 0x3;
>  		a = (((unsigned long)parent_phys_hi << 32UL) |
>  		     ((unsigned long)parent_phys_lo  <<  0UL));
> +		region_a = (((unsigned long)child_phys_mid << 32UL) |
> +		     ((unsigned long)child_phys_lo  <<  0UL));
>  		size = (((unsigned long)size_hi << 32UL) |
>  			((unsigned long)size_lo  <<  0UL));
>  
> @@ -440,6 +445,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  			pbm->io_space.start = a;
>  			pbm->io_space.end = a + size - 1UL;
>  			pbm->io_space.flags = IORESOURCE_IO;
> +			pbm->io_offset = a - region_a;
>  			saw_io = 1;
>  			break;
>  
> @@ -448,6 +454,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  			pbm->mem_space.start = a;
>  			pbm->mem_space.end = a + size - 1UL;
>  			pbm->mem_space.flags = IORESOURCE_MEM;
> +			pbm->mem_offset = a - region_a;
>  			saw_mem = 1;
>  			break;
>  
> @@ -456,6 +463,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  			pbm->mem64_space.start = a;
>  			pbm->mem64_space.end = a + size - 1UL;
>  			pbm->mem64_space.flags = IORESOURCE_MEM;
> +			pbm->mem64_offset = a - region_a;
>  			saw_mem = 1;
>  			break;
>  
> @@ -471,14 +479,22 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  		prom_halt();
>  	}
>  
> -	printk("%s: PCI IO[%llx] MEM[%llx]",
> -	       pbm->name,
> -	       pbm->io_space.start,
> -	       pbm->mem_space.start);
> +	if (pbm->io_space.flags)
> +		printk("%s: PCI IO %pR offset %llx\n",
> +		       pbm->name, &pbm->io_space, pbm->io_offset);
> +	if (pbm->mem_space.flags)
> +		printk("%s: PCI MEM %pR offset %llx\n",
> +		       pbm->name, &pbm->mem_space, pbm->mem_offset);
> +	if (pbm->mem64_space.flags && pbm->mem_space.flags) {
> +		if (pbm->mem64_space.start <= pbm->mem_space.end)
> +			pbm->mem64_space.start = pbm->mem_space.end + 1;
> +		if (pbm->mem64_space.start > pbm->mem64_space.end)
> +			pbm->mem64_space.flags = 0;
> +	}
> +
>  	if (pbm->mem64_space.flags)
> -		printk(" MEM64[%llx]",
> -		       pbm->mem64_space.start);
> -	printk("\n");
> +		printk("%s: PCI MEM64 %pR offset %llx\n",
> +		       pbm->name, &pbm->mem64_space, pbm->mem64_offset);
>  
>  	pbm->io_space.name = pbm->mem_space.name = pbm->name;
>  	pbm->mem64_space.name = pbm->name;
> diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
> index 37222ca..2853af7 100644
> --- a/arch/sparc/kernel/pci_impl.h
> +++ b/arch/sparc/kernel/pci_impl.h
> @@ -99,6 +99,10 @@ struct pci_pbm_info {
>  	struct resource			mem_space;
>  	struct resource			mem64_space;
>  	struct resource			busn;
> +	/* offset */
> +	resource_size_t			io_offset;
> +	resource_size_t			mem_offset;
> +	resource_size_t			mem64_offset;
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
