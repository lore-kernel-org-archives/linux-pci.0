Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <554B2352.4080906@hp.com>
Date: Thu, 07 May 2015 16:33:22 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
To: Baoquan He <bhe@redhat.com>
CC: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v10 04/10] iommu/vt-d: functions to copy data from old
 mem
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com> <1428655333-19504-5-git-send-email-zhen-hual@hp.com> <20150507074916.GA16815@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150507074916.GA16815@dhcp-16-116.nay.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is called in
static int copy_root_entry_table(struct intel_iommu *iommu);


On 05/07/2015 03:49 PM, Baoquan He wrote:
> On 04/10/15 at 04:42pm, Li, Zhen-Hua wrote:
>> Add some functions to copy the data from old kernel.
>> These functions are used to copy context tables and page tables.
>>
>> To avoid calling iounmap between spin_lock_irqsave and spin_unlock_irqrestore,
>> use a link here, store the pointers , and then use iounmap to free them in
>> another place.
>>
>> Li, Zhen-hua:
>>      The functions and logics.
>>
>> Takao Indoh:
>>      Check if pfn is ram:
>>          if (page_is_ram(pfn))
>>
>> Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
>> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/intel-iommu.h |   6 +++
>>   2 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index ff5ac04..5ba403a 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -373,6 +373,17 @@ static struct context_entry *device_to_existing_context_entry(
>>   				struct intel_iommu *iommu,
>>   				u8 bus, u8 devfn);
>>
>> +/*
>> + * A structure used to store the address allocated by ioremap();
>> + * The we need to call iounmap() to free them out of spin_lock_irqsave/unlock;
>> + */
>> +struct iommu_remapped_entry {
>> +	struct list_head list;
>> +	void __iomem *mem;
>> +};
>> +static LIST_HEAD(__iommu_remapped_mem);
>> +static DEFINE_MUTEX(__iommu_mem_list_lock);
>> +
>>
>>   /*
>>    * This domain is a statically identity mapping domain.
>> @@ -4817,3 +4828,94 @@ static struct context_entry *device_to_existing_context_entry(
>>   	return ret;
>>   }
>>
>> +/*
>> + * Copy memory from a physically-addressed area into a virtually-addressed area
>> + */
>
> I don't find where __iommu_load_from_oldmem is called. Obsolete code of
> this patch?
>
>> +int __iommu_load_from_oldmem(void *to, unsigned long from, unsigned long size)
>> +{
>> +	unsigned long pfn;		/* Page Frame Number */
>> +	size_t csize = (size_t)size;	/* Num(bytes to copy) */
>> +	unsigned long offset;		/* Lower 12 bits of to */
>> +	void __iomem *virt_mem;
>> +	struct iommu_remapped_entry *mapped;
>> +
>> +	pfn = from >> VTD_PAGE_SHIFT;
>> +	offset = from & (~VTD_PAGE_MASK);
>> +
>> +	if (page_is_ram(pfn)) {
>> +		memcpy(to, pfn_to_kaddr(pfn) + offset, csize);
>> +	} else{
>> +
>> +		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
>> +				GFP_KERNEL);
>> +		if (!mapped)
>> +			return -ENOMEM;
>> +
>> +		virt_mem = ioremap_cache((unsigned long)from, size);
>> +		if (!virt_mem) {
>> +			kfree(mapped);
>> +			return -ENOMEM;
>> +		}
>> +		memcpy(to, virt_mem, size);
>> +
>> +		mutex_lock(&__iommu_mem_list_lock);
>> +		mapped->mem = virt_mem;
>> +		list_add_tail(&mapped->list, &__iommu_remapped_mem);
>> +		mutex_unlock(&__iommu_mem_list_lock);
>> +	}
>> +	return size;
>> +}
>> +
>> +/*
>> + * Copy memory from a virtually-addressed area into a physically-addressed area
>> + */
>> +int __iommu_save_to_oldmem(unsigned long to, void *from, unsigned long size)
>> +{
>> +	unsigned long pfn;		/* Page Frame Number */
>> +	size_t csize = (size_t)size;	/* Num(bytes to copy) */
>> +	unsigned long offset;		/* Lower 12 bits of to */
>> +	void __iomem *virt_mem;
>> +	struct iommu_remapped_entry *mapped;
>> +
>> +	pfn = to >> VTD_PAGE_SHIFT;
>> +	offset = to & (~VTD_PAGE_MASK);
>> +
>> +	if (page_is_ram(pfn)) {
>> +		memcpy(pfn_to_kaddr(pfn) + offset, from, csize);
>> +	} else{
>> +		mapped = kzalloc(sizeof(struct iommu_remapped_entry),
>> +				GFP_KERNEL);
>> +		if (!mapped)
>> +			return -ENOMEM;
>> +
>> +		virt_mem = ioremap_cache((unsigned long)to, size);
>> +		if (!virt_mem) {
>> +			kfree(mapped);
>> +			return -ENOMEM;
>> +		}
>> +		memcpy(virt_mem, from, size);
>> +		mutex_lock(&__iommu_mem_list_lock);
>> +		mapped->mem = virt_mem;
>> +		list_add_tail(&mapped->list, &__iommu_remapped_mem);
>> +		mutex_unlock(&__iommu_mem_list_lock);
>> +	}
>> +	return size;
>> +}
>> +
>> +/*
>> + * Free the mapped memory for ioremap;
>> + */
>> +int __iommu_free_mapped_mem(void)
>> +{
>> +	struct iommu_remapped_entry *mem_entry, *tmp;
>> +
>> +	mutex_lock(&__iommu_mem_list_lock);
>> +	list_for_each_entry_safe(mem_entry, tmp, &__iommu_remapped_mem, list) {
>> +		iounmap(mem_entry->mem);
>> +		list_del(&mem_entry->list);
>> +		kfree(mem_entry);
>> +	}
>> +	mutex_unlock(&__iommu_mem_list_lock);
>> +	return 0;
>> +}
>> +
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index a65208a..4bca7b5 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -368,4 +368,10 @@ extern int dmar_ir_support(void);
>>
>>   extern const struct attribute_group *intel_iommu_groups[];
>>
>> +extern int __iommu_load_from_oldmem(void *to, unsigned long from,
>> +					unsigned long size);
>> +extern int __iommu_save_to_oldmem(unsigned long to, void *from,
>> +					unsigned long size);
>> +extern int __iommu_free_mapped_mem(void);
>> +
>>   #endif
>> --
>> 2.0.0-rc0
>>

