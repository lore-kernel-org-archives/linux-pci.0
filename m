Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34323 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933039AbbEMNZN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2015 09:25:13 -0400
Received: by pdbqa5 with SMTP id qa5so51749619pdb.1
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2015 06:25:12 -0700 (PDT)
Message-ID: <555350B2.8050301@linaro.org>
Date: Wed, 13 May 2015 21:25:06 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
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
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com> <1430793970-11159-6-git-send-email-jiang.liu@linux.intel.com> <55531967.70507@linaro.org> <55534275.2040404@linux.intel.com>
In-Reply-To: <55534275.2040404@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年05月13日 20:24, Jiang Liu wrote:
> On 2015/5/13 17:29, Hanjun Guo wrote:
>> Hi Jiang,
>>
>> On 2015年05月05日 10:46, Jiang Liu wrote:
>>> Introduce common interface acpi_pci_root_create() and related data
>>> structures to create PCI root bus for ACPI PCI host bridges. It will
>>> be used to kill duplicated arch specific code for IA64 and x86. It may
>>> also help ARM64 in future.
>>>
>> [...]
>>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>>> index a965efa52152..a292ee33d74b 100644
>>> --- a/include/linux/pci-acpi.h
>>> +++ b/include/linux/pci-acpi.h
>>> @@ -52,6 +52,30 @@ static inline acpi_handle
>>> acpi_pci_get_bridge_handle(struct pci_bus *pbus)
>>>        return ACPI_HANDLE(dev);
>>>    }
>>>
>>> +struct acpi_pci_root;
>>> +struct acpi_pci_root_ops;
>>> +
>>> +struct acpi_pci_root_info_common {
>>> +    struct pci_controller        controller;
>>
>> There is another problem that this patch will lead to
>> compile error on ARM64 since ARM64 has basic ACPI support
>> in 4.1.
>>
>> struct pci_controller        controller is not available
>> on ARM64, that's the reason why compile errors happens on ARM64.
>>
>> How about move struct pci_controller to this head file?
>>
>> because all the related file you changed in this patch set
>> are only compiled when CONFI_ACPI=y, so for x86,
>>
>> struct pci_controller {
>> #ifdef CONFIG_ACPI
>>          struct acpi_device *companion;  /* ACPI companion device */
>> #endif
>> #ifdef CONFIG_X86_64
>>          void            *iommu;         /* IOMMU private data */
>> #endif
>>          int             segment;        /* PCI domain */
>>          int             node;           /* NUMA node */
>> };
>>
>> I'm sure #ifdef CONFIG_ACPI .. #endif can be removed
>> with no harm, and for *iommu, we can remove the #ifdef CONFIG_X86_64
>> with introducing little more memory on x86_32, after
>> that, the struct pci_controller is almost the same as ia64:
>
> On x86, struct pci_controller may be used when CONFIG_ACPI is disabled.
> So we can't move it into pci-acpi.h

Ah, ok, I missed this part.

>
>>
>> struct pci_controller {
>>          struct acpi_device *companion;
>>          void *iommu;
>>          int segment;
>>          int node;               /* nearest node with memory or
>> NUMA_NO_NODE for global allocation */
>>
>>          void *platform_data;
>> };
>>
>> except void *platform_data;
>>
>> On ARM64, the structure is almost the same, so how about
>> introduce
>>
>> struct pci_controller {
>>          struct acpi_device *companion;  /* ACPI companion device */
>>          void            *iommu;         /* IOMMU private data */
>>          int             segment;        /* PCI domain */
>>          int             node;           /* NUMA node */
>> #ifdef CONFIG_IA64
>>      void *platform_data;
>> #endif
>> };
>>
>> in this file, then can be used for all architectures?
> Current mode is that architecture defines its own version of
> struct pci_controller. It would be better to keep this pattern.

OK, thanks for the clarify :) So how about add my basic
PCI support patch for ARM64 on top of you patch set to fix
this problem?

Thanks
Hanjun


