Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55647C94.9080606@oracle.com>
Date: Tue, 26 May 2015 10:00:52 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>,
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
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
Subject: Re: [PATCH 10/11] XEN / PCI: Remove the dependence on arch x86 when
 PCI_MMCONFIG=y
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-11-git-send-email-hanjun.guo@linaro.org> <55647B22.3010801@oracle.com>
In-Reply-To: <55647B22.3010801@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/26/2015 09:54 AM, Boris Ostrovsky wrote:
> On 05/26/2015 08:49 AM, Hanjun Guo wrote:
>> In drivers/xen/pci.c, there are arch x86 dependent codes when
>> CONFIG_PCI_MMCONFIG is enabled, since CONFIG_PCI_MMCONFIG
>> depends on ACPI, so this will prevent XEN PCI running on other
>> architectures using ACPI with PCI_MMCONFIG enabled (such as ARM64).
>>
>> Fortunatly, it can be sloved in a simple way. In drivers/xen/pci.c,
>> the only x86 dependent code is if ((pci_probe & PCI_PROBE_MMCONF) == 0),
>> and it's defined in asm/pci_x86.h, the code means that
>> if the PCI resource is not probed in PCI_PROBE_MMCONF way, just
>> ingnore the xen mcfg init. Actually this is duplicate, because
>> if PCI resource is not probed in PCI_PROBE_MMCONF way, the
>> pci_mmconfig_list will be empty, and the if (list_empty())
>> after it will do the same job.
>>
>> So just remove the arch related code and the head file, this
>> will be no functional change for x86, and also makes xen/pci.c
>> usable for other architectures.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> ---
>>   drivers/xen/pci.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
>> index 6785ebb..9a8dbe3 100644
>> --- a/drivers/xen/pci.c
>> +++ b/drivers/xen/pci.c
>> @@ -28,9 +28,6 @@
>>   #include <asm/xen/hypervisor.h>
>>   #include <asm/xen/hypercall.h>
>>   #include "../pci/pci.h"
>> -#ifdef CONFIG_PCI_MMCONFIG
>> -#include <asm/pci_x86.h>
>> -#endif
>>
>>   static bool __read_mostly pci_seg_supported = true;
>>
>> @@ -222,9 +219,6 @@ static int __init xen_mcfg_late(void)
>>       if (!xen_initial_domain())
>>           return 0;
>>
>> -    if ((pci_probe & PCI_PROBE_MMCONF) == 0)
>> -        return 0;
>> -
>>       if (list_empty(&pci_mmcfg_list))
>>           return 0;
>>
>
> (+Stefano who is Xen ARM maintainer)
>
> This will not build on x86 since pci_mmcfg_list since, for example, 
> pci_mmcfg_list is declared in pci_x86.h.


And now really with Stefano and with parsable first sentence, sorry:


This will not build on x86 since pci_mmcfg_list, for example, is 
declared in pci_x86.h.


>
> And I am not sure I understand why you are trying to do this since 
> AFAIK CONFIG_PCI_MMCONFIG is only defined on x86 so neither pci_x86.h 
> will be included nor xen_mcfg_late() will be defined on ARM.
>
>
> -boris
>
>
>

