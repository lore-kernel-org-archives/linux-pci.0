Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbbELIaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 May 2015 04:30:10 -0400
Date: Tue, 12 May 2015 16:29:54 +0800
From: Dave Young <dyoung@redhat.com>
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com,
	joro@8bytes.org, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 04/10] iommu/vt-d: functions to copy data from old mem
Message-ID: <20150512082954.GD4561@localhost.localdomain>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-5-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431337974-545-5-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> Add some functions to copy the data from old kernel.
> These functions are used to copy context tables and page tables.
> 
> To avoid calling iounmap between spin_lock_irqsave and spin_unlock_irqrestore,
> use a link here, store the pointers , and then use iounmap to free them in
> another place.
> 
> Li, Zhen-hua:
>     The functions and logics.
> 
> Takao Indoh:
>     Check if pfn is ram:
>         if (page_is_ram(pfn))
> 
> Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
> ---
>  drivers/iommu/intel-iommu.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |   6 +++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 07e6118..0b97c15 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -371,6 +371,17 @@ static struct context_entry *device_to_existing_context_entry(
>  				struct intel_iommu *iommu,
>  				u8 bus, u8 devfn);
>  
> +/*
> + * A structure used to store the address allocated by ioremap();
> + * The we need to call iounmap() to free them out of spin_lock_irqsave/unlock;
> + */
> +struct iommu_remapped_entry {
> +	struct list_head list;
> +	void __iomem *mem;
> +};
> +static LIST_HEAD(__iommu_remapped_mem);
> +static DEFINE_MUTEX(__iommu_mem_list_lock);
> +
>  
>  /*
>   * This domain is a statically identity mapping domain.
> @@ -4833,3 +4844,94 @@ static struct context_entry *device_to_existing_context_entry(
>  	return ret;
>  }
>  
> +/*
> + * Copy memory from a physically-addressed area into a virtually-addressed area
> + */
> +int __iommu_load_from_oldmem(void *to, unsigned long from, unsigned long size)
> +{
> +	unsigned long pfn;		/* Page Frame Number */
> +	size_t csize = (size_t)size;	/* Num(bytes to copy) */
> +	unsigned long offset;		/* Lower 12 bits of to */

comment for above variable are unnecessary, they are clear enough.
BTW, use size_t size in function argument is better.

> +	void __iomem *virt_mem;
> +	struct iommu_remapped_entry *mapped;
> +
> +	pfn = from >> VTD_PAGE_SHIFT;
> +	offset = from & (~VTD_PAGE_MASK);
> +
> +	if (page_is_ram(pfn)) {
> +		memcpy(to, pfn_to_kaddr(pfn) + offset, csize);
> +	} else{
> +
> +		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
> +				GFP_KERNEL);
> +		if (!mapped)
> +			return -ENOMEM;
> +
> +		virt_mem = ioremap_cache((unsigned long)from, size);
> +		if (!virt_mem) {
> +			kfree(mapped);
> +			return -ENOMEM;
> +		}
> +		memcpy(to, virt_mem, size);

csize or size? as previous comment use size_t in argument it will be ok here.

> +
> +		mutex_lock(&__iommu_mem_list_lock);
> +		mapped->mem = virt_mem;
> +		list_add_tail(&mapped->list, &__iommu_remapped_mem);
> +		mutex_unlock(&__iommu_mem_list_lock);
> +	}
> +	return size;

type mismatch?

> +}
> +
> +/*
> + * Copy memory from a virtually-addressed area into a physically-addressed area
> + */
> +int __iommu_save_to_oldmem(unsigned long to, void *from, unsigned long size)
> +{
> +	unsigned long pfn;		/* Page Frame Number */
> +	size_t csize = (size_t)size;	/* Num(bytes to copy) */
> +	unsigned long offset;		/* Lower 12 bits of to */

Ditto about data type and comments..

> +	void __iomem *virt_mem;
> +	struct iommu_remapped_entry *mapped;
> +
> +	pfn = to >> VTD_PAGE_SHIFT;
> +	offset = to & (~VTD_PAGE_MASK);
> +
> +	if (page_is_ram(pfn)) {
> +		memcpy(pfn_to_kaddr(pfn) + offset, from, csize);
> +	} else{
> +		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
> +				GFP_KERNEL);
> +		if (!mapped)
> +			return -ENOMEM;
> +
> +		virt_mem = ioremap_cache((unsigned long)to, size);
> +		if (!virt_mem) {
> +			kfree(mapped);
> +			return -ENOMEM;
> +		}
> +		memcpy(virt_mem, from, size);
> +		mutex_lock(&__iommu_mem_list_lock);
> +		mapped->mem = virt_mem;
> +		list_add_tail(&mapped->list, &__iommu_remapped_mem);
> +		mutex_unlock(&__iommu_mem_list_lock);
> +	}
> +	return size;
> +}

Above two functions looks duplicate, can they be merged as one function and
add a argument about direction?

> +
> +/*
> + * Free the mapped memory for ioremap;
> + */
> +int __iommu_free_mapped_mem(void)
> +{
> +	struct iommu_remapped_entry *mem_entry, *tmp;
> +
> +	mutex_lock(&__iommu_mem_list_lock);
> +	list_for_each_entry_safe(mem_entry, tmp, &__iommu_remapped_mem, list) {
> +		iounmap(mem_entry->mem);
> +		list_del(&mem_entry->list);
> +		kfree(mem_entry);
> +	}
> +	mutex_unlock(&__iommu_mem_list_lock);
> +	return 0;
> +}
> +
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 796ef96..ced1fac 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -380,4 +380,10 @@ extern int dmar_ir_support(void);
>  
>  extern const struct attribute_group *intel_iommu_groups[];
>  
> +extern int __iommu_load_from_oldmem(void *to, unsigned long from,
> +					unsigned long size);
> +extern int __iommu_save_to_oldmem(unsigned long to, void *from,
> +					unsigned long size);
> +extern int __iommu_free_mapped_mem(void);
> +
>  #endif
> -- 
> 2.0.0-rc0
> 
