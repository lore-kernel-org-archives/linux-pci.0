Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V6 03/13] x86, ia64: Include acpi_pci_{add|remove}_bus to
 the default pcibios_{add|remove}_bus implementation.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-4-git-send-email-tn@semihalf.com>
 <20160427023429.GE6789@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5720BC74.7050200@semihalf.com>
Date: Wed, 27 Apr 2016 15:19:48 +0200
MIME-Version: 1.0
In-Reply-To: <20160427023429.GE6789@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27.04.2016 04:34, Bjorn Helgaas wrote:
> On Fri, Apr 15, 2016 at 07:06:38PM +0200, Tomasz Nowicki wrote:
>> x86 and ia64 are the only arches that implement pcibios_{add|remove}_bus hooks
>> and implement them in the same way. Moreover ARM64 is going to do the same.
>> So it seems that acpi_pci_{add|remove}_bus is generic enough to be default
>> option for pcibios_{add|remove}_bus hooks. Also, it is always safe to run
>> acpi_pci_{add|remove}_bus as they have empty stubs for !ACPI case and
>> return if ACPI has been switched off in run time.
>>
>> After all we can remove x86 and ia64 pcibios_{add|remove}_bus
>> implementation.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Tested-by: Duc Dang <dhdang@apm.com>
>> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
>> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Tested-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   arch/ia64/pci/pci.c   | 10 ----------
>>   arch/x86/pci/common.c | 10 ----------
>>   drivers/pci/probe.c   |  3 +++
>>   3 files changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
>> index 978d6af..be4c9ef 100644
>> --- a/arch/ia64/pci/pci.c
>> +++ b/arch/ia64/pci/pci.c
>> @@ -358,16 +358,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
>>   	platform_pci_fixup_bus(b);
>>   }
>>
>> -void pcibios_add_bus(struct pci_bus *bus)
>> -{
>> -	acpi_pci_add_bus(bus);
>> -}
>> -
>> -void pcibios_remove_bus(struct pci_bus *bus)
>> -{
>> -	acpi_pci_remove_bus(bus);
>> -}
>> -
>>   void pcibios_set_master (struct pci_dev *dev)
>>   {
>>   	/* No special bus mastering setup handling */
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 381a43c..7763a84 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -170,16 +170,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
>>   		pcibios_fixup_device_resources(dev);
>>   }
>>
>> -void pcibios_add_bus(struct pci_bus *bus)
>> -{
>> -	acpi_pci_add_bus(bus);
>> -}
>> -
>> -void pcibios_remove_bus(struct pci_bus *bus)
>> -{
>> -	acpi_pci_remove_bus(bus);
>> -}
>> -
>>   /*
>>    * Only use DMI information to set this if nothing was passed
>>    * on the kernel command line (which was parsed earlier).
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 8087297..ef569e8 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>>   #include <linux/cpumask.h>
>> +#include <linux/pci-acpi.h>
>>   #include <linux/pci-aspm.h>
>>   #include <linux/aer.h>
>>   #include <linux/acpi.h>
>> @@ -2101,10 +2102,12 @@ int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>>
>>   void __weak pcibios_add_bus(struct pci_bus *bus)
>>   {
>> +	acpi_pci_add_bus(bus);
>>   }
>>
>>   void __weak pcibios_remove_bus(struct pci_bus *bus)
>>   {
>> +	acpi_pci_remove_bus(bus);
>>   }
>
> Is this buying us something more than just getting rid of these
> pcibios functions in the arches?  The arch-specific pcibios methods
> by themselves don't seem too onerous, and I don't really want to add
> #includes and calls to every firmware interface under the sun.
>
> I admit it's a net removal of 17 lines, but I'm not sure it's a net
> reduction in complexity for the reader, who now has to remember that
> this ACPI stuff is a no-op on most arches.
>
> As a tangent, some of the stuff in acpi_pci_add_bus() really belongs
> elsewhere anyway.  For example, the _DSM stuff should probably be in
> acpi_pci_root_create() since it's a one-per-host bridge kind of thing.
>

OK, I will add pcibios_add_bus to ARM64 arch code and call 
acpi_pci_remove_bus(bus) from there.

Thanks,
Tomasz
