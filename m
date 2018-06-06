Return-Path: <SRS0=kWo4=IY=huawei.com=xieyisheng1@kernel.org>
Return-Path: <SRS0=kWo4=IY=huawei.com=xieyisheng1@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Avoid panic when PCI IO resource's size is
 not page aligned
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1527596299-57567-1-git-send-email-xieyisheng1@huawei.com>
 <20180605235303.GE226399@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<guohanjun@huawei.com>, <jcm@redhat.com>, <toshi.kani@hpe.com>,
	<tanxiaojun@huawei.com>, <wangzhou1@hisilicon.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <f1e62ee9-cb19-1139-c9e4-e3a5c9f16b72@huawei.com>
Date: Wed, 6 Jun 2018 10:11:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180605235303.GE226399@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2018/6/6 7:53, Bjorn Helgaas wrote:
> On Tue, May 29, 2018 at 08:18:18PM +0800, Yisheng Xie wrote:
>> Zhou reported a bug on Hisilicon arm64 D06 platform with 64KB page size:
>>
>>  [    2.470908] kernel BUG at lib/ioremap.c:72!
>>  [    2.475079] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>  [    2.480551] Modules linked in:
>>  [    2.483594] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc7-00062-g0b41260-dirty #23
>>  [    2.491756] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI Nemo 2.0 RC0 - B120 03/23/2018
>>  [    2.500614] pstate: 80c00009 (Nzcv daif +PAN +UAO)
>>  [    2.505395] pc : ioremap_page_range+0x268/0x36c
>>  [    2.509912] lr : pci_remap_iospace+0xe4/0x100
>>  [...]
>>  [    2.603733] Call trace:
>>  [    2.606168]  ioremap_page_range+0x268/0x36c
>>  [    2.610337]  pci_remap_iospace+0xe4/0x100
>>  [    2.614334]  acpi_pci_probe_root_resources+0x1d4/0x214
>>  [    2.619460]  pci_acpi_root_prepare_resources+0x18/0xa8
>>  [    2.624585]  acpi_pci_root_create+0x98/0x214
>>  [    2.628843]  pci_acpi_scan_root+0x124/0x20c
>>  [    2.633013]  acpi_pci_root_add+0x224/0x494
>>  [    2.637096]  acpi_bus_attach+0xf8/0x200
>>  [    2.640918]  acpi_bus_attach+0x98/0x200
>>  [    2.644740]  acpi_bus_attach+0x98/0x200
>>  [    2.648562]  acpi_bus_scan+0x48/0x9c
>>  [    2.652125]  acpi_scan_init+0x104/0x268
>>  [    2.655948]  acpi_init+0x308/0x374
>>  [    2.659337]  do_one_initcall+0x48/0x14c
>>  [    2.663160]  kernel_init_freeable+0x19c/0x250
>>  [    2.667504]  kernel_init+0x10/0x100
>>  [    2.670979]  ret_from_fork+0x10/0x18
>>
>> The cause is the size of PCI IO resource is 32KB, which is 4K aligned but
>> not 64KB aligned, however, ioremap_page_range() request the range as page
>> aligned or it will trigger a BUG_ON() on ioremap_pte_range() it calls, as
>> ioremap_pte_range increase the addr by PAGE_SIZE, which makes addr != end
>> until trigger BUG_ON, if its incoming end is not page aligned. More detail
>> trace is as following:
>>
>>  ioremap_page_range
>>  -> ioremap_p4d_range
>>     -> ioremap_p4d_range
>>        -> ioremap_pud_range
>>           -> ioremap_pmd_range
>>              -> ioremap_pte_range
>>
>> This patch avoid panic by return -EINVAL if vaddr or resource size is not
>> page aligned.
>>
>> Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Tested-by: Xiaojun Tan <tanxiaojun@huawei.com>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>> v3:
>>  - pci_remap_iospace() sanitize its arguments instead - per Rafael
>>
>> v2:
>>  - Let the caller of ioremap_page_range() align the request by PAGE_SIZE - per Toshi
>>
>>  drivers/pci/pci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index dbfe7c4..0eb0381 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3544,6 +3544,9 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>>  	if (res->end > IO_SPACE_LIMIT)
>>  		return -EINVAL;
>>  
>> +	if (!PAGE_ALIGNED(vaddr) || !PAGE_ALIGNED(resource_size(res)))
>> +		return -EINVAL;
> 
> Most other callers of ioremap_page_range() are in the ioremap() path,
> and they align phys_addr themselves.  In some cases that results in a
> mapping that covers more than necessary.  For instance, see the
> function comment at the x86 version of __ioremap_caller().
> 
> Is there any reason we couldn't similarly align vaddr and phys_addr
> here?
> 
> The acpi_pci_probe_root_resources() path you mention above basically
> ignores the errors you're returning.  Your patches will avoid the
> panic, which is an improvement, but I/O port space will not work, and
> I don't see anything that gives the user a hint about why not.
> 
> If we could align vaddr and phys_addr (and possibly map more than
> necessary), I/O port space would still work.

Right, I will send another version, soon.

Thanks
Yisheng
> 
>>  	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
>>  				  pgprot_device(PAGE_KERNEL));
>>  #else
>> -- 
>> 1.7.12.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 
