Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48624 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933242AbbEMMYl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 May 2015 08:24:41 -0400
Message-ID: <55534275.2040404@linux.intel.com>
Date: Wed, 13 May 2015 20:24:21 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	"x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v2 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com> <1430793970-11159-6-git-send-email-jiang.liu@linux.intel.com> <55531967.70507@linaro.org>
In-Reply-To: <55531967.70507@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/13 17:29, Hanjun Guo wrote:
> Hi Jiang,
> 
> On 2015年05月05日 10:46, Jiang Liu wrote:
>> Introduce common interface acpi_pci_root_create() and related data
>> structures to create PCI root bus for ACPI PCI host bridges. It will
>> be used to kill duplicated arch specific code for IA64 and x86. It may
>> also help ARM64 in future.
>>
> [...]
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index a965efa52152..a292ee33d74b 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -52,6 +52,30 @@ static inline acpi_handle
>> acpi_pci_get_bridge_handle(struct pci_bus *pbus)
>>       return ACPI_HANDLE(dev);
>>   }
>>
>> +struct acpi_pci_root;
>> +struct acpi_pci_root_ops;
>> +
>> +struct acpi_pci_root_info_common {
>> +    struct pci_controller        controller;
> 
> There is another problem that this patch will lead to
> compile error on ARM64 since ARM64 has basic ACPI support
> in 4.1.
> 
> struct pci_controller        controller is not available
> on ARM64, that's the reason why compile errors happens on ARM64.
> 
> How about move struct pci_controller to this head file?
> 
> because all the related file you changed in this patch set
> are only compiled when CONFI_ACPI=y, so for x86,
> 
> struct pci_controller {
> #ifdef CONFIG_ACPI
>         struct acpi_device *companion;  /* ACPI companion device */
> #endif
> #ifdef CONFIG_X86_64
>         void            *iommu;         /* IOMMU private data */
> #endif
>         int             segment;        /* PCI domain */
>         int             node;           /* NUMA node */
> };
> 
> I'm sure #ifdef CONFIG_ACPI .. #endif can be removed
> with no harm, and for *iommu, we can remove the #ifdef CONFIG_X86_64
> with introducing little more memory on x86_32, after
> that, the struct pci_controller is almost the same as ia64:

On x86, struct pci_controller may be used when CONFIG_ACPI is disabled.
So we can't move it into pci-acpi.h

> 
> struct pci_controller {
>         struct acpi_device *companion;
>         void *iommu;
>         int segment;
>         int node;               /* nearest node with memory or
> NUMA_NO_NODE for global allocation */
> 
>         void *platform_data;
> };
> 
> except void *platform_data;
> 
> On ARM64, the structure is almost the same, so how about
> introduce
> 
> struct pci_controller {
>         struct acpi_device *companion;  /* ACPI companion device */
>         void            *iommu;         /* IOMMU private data */
>         int             segment;        /* PCI domain */
>         int             node;           /* NUMA node */
> #ifdef CONFIG_IA64   
>     void *platform_data;
> #endif
> };
> 
> in this file, then can be used for all architectures?
Current mode is that architecture defines its own version of
struct pci_controller. It would be better to keep this pattern.
Thanks!
Gerry

> 
> Thanks
> Hanjun
