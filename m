Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35650 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbbE0Dz4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 23:55:56 -0400
Received: by pdea3 with SMTP id a3so107130576pde.2
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 20:55:55 -0700 (PDT)
Message-ID: <55654041.2040902@linaro.org>
Date: Wed, 27 May 2015 11:55:45 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
Subject: Re: [PATCH 10/11] XEN / PCI: Remove the dependence on arch x86 when
 PCI_MMCONFIG=y
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-11-git-send-email-hanjun.guo@linaro.org> <55647B22.3010801@oracle.com> <55647C94.9080606@oracle.com> <5564893B.2070102@linaro.org> <556494D9.9090007@oracle.com>
In-Reply-To: <556494D9.9090007@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年05月26日 23:44, Boris Ostrovsky wrote:
> On 05/26/2015 10:54 AM, Tomasz Nowicki wrote:
>> On 26.05.2015 16:00, Boris Ostrovsky wrote:
>>> On 05/26/2015 09:54 AM, Boris Ostrovsky wrote:
>>>> On 05/26/2015 08:49 AM, Hanjun Guo wrote:
>>>>> In drivers/xen/pci.c, there are arch x86 dependent codes when
>>>>> CONFIG_PCI_MMCONFIG is enabled, since CONFIG_PCI_MMCONFIG
>>>>> depends on ACPI, so this will prevent XEN PCI running on other
>>>>> architectures using ACPI with PCI_MMCONFIG enabled (such as ARM64).
>>>>>
>>>>> Fortunatly, it can be sloved in a simple way. In drivers/xen/pci.c,
>>>>> the only x86 dependent code is if ((pci_probe & PCI_PROBE_MMCONF) ==
>>>>> 0),
>>>>> and it's defined in asm/pci_x86.h, the code means that
>>>>> if the PCI resource is not probed in PCI_PROBE_MMCONF way, just
>>>>> ingnore the xen mcfg init. Actually this is duplicate, because
>>>>> if PCI resource is not probed in PCI_PROBE_MMCONF way, the
>>>>> pci_mmconfig_list will be empty, and the if (list_empty())
>>>>> after it will do the same job.
>>>>>
>>>>> So just remove the arch related code and the head file, this
>>>>> will be no functional change for x86, and also makes xen/pci.c
>>>>> usable for other architectures.
>>>>>
>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>> ---
>>>>>   drivers/xen/pci.c | 6 ------
>>>>>   1 file changed, 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
>>>>> index 6785ebb..9a8dbe3 100644
>>>>> --- a/drivers/xen/pci.c
>>>>> +++ b/drivers/xen/pci.c
>>>>> @@ -28,9 +28,6 @@
>>>>>   #include <asm/xen/hypervisor.h>
>>>>>   #include <asm/xen/hypercall.h>
>>>>>   #include "../pci/pci.h"
>>>>> -#ifdef CONFIG_PCI_MMCONFIG
>>>>> -#include <asm/pci_x86.h>
>>>>> -#endif
>>>>>
>>>>>   static bool __read_mostly pci_seg_supported = true;
>>>>>
>>>>> @@ -222,9 +219,6 @@ static int __init xen_mcfg_late(void)
>>>>>       if (!xen_initial_domain())
>>>>>           return 0;
>>>>>
>>>>> -    if ((pci_probe & PCI_PROBE_MMCONF) == 0)
>>>>> -        return 0;
>>>>> -
>>>>>       if (list_empty(&pci_mmcfg_list))
>>>>>           return 0;
>>>>>
>>>>
>>>> (+Stefano who is Xen ARM maintainer)
>>>>
>>>> This will not build on x86 since pci_mmcfg_list since, for example,
>>>> pci_mmcfg_list is declared in pci_x86.h.
>>>
>>>
>>> And now really with Stefano and with parsable first sentence, sorry:
>>>
>>>
>>> This will not build on x86 since pci_mmcfg_list, for example, is
>>> declared in pci_x86.h.
>>
>> With this patch set, not any more. Please see preceding patches.
>
>
> OK, I didn't notice this was part of a series.

Sorry, I didn't cc you all of those patches.

>
> Then if not having PCI_PROBE_MMCONF bit set is indeed equivalent to
> list_empty(&pci_mmcfg_list), is there any reason for this flag to
> (continue to) exist? (and also for pci_mmcfg_arch_init_failed.)

I think PCI_PROBE_MMCONF bit is needed for early init of pci mmconfig in
the x86 arch related code, but for xen_mcfg_late(), it's called after
acpi_init() which the mmconfig is ready for use if it's available (the
pci_mmcfg_list is empty or not), so not having PCI_PROBE_MMCONF bit set
is equivalent list_empty(&pci_mmcfg_list) is not suitable for all cases,
but I think it will be ok after mmconfig is initialized.

I think my change log is misleading and needs updating :)

Thanks
Hanjun
