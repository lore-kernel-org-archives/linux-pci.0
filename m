Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V9 09/11] ARM64/PCI: ACPI support for legacy IRQs parsing
 and consolidation with DT code
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <1465588519-11334-10-git-send-email-tn@semihalf.com>
 <20160610233612.GB7671@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
 rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
 okaya@codeaurora.org, jchandra@broadcom.com,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com,
 Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com,
 cov@codeaurora.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <575E8431.9000104@semihalf.com>
Date: Mon, 13 Jun 2016 12:00:17 +0200
MIME-Version: 1.0
In-Reply-To: <20160610233612.GB7671@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 11.06.2016 01:36, Bjorn Helgaas wrote:
> On Fri, Jun 10, 2016 at 09:55:17PM +0200, Tomasz Nowicki wrote:
>> To enable PCI legacy IRQs on platforms booting with ACPI, arch code
>> should include ACPI specific callbacks that parse and set-up the
>> device IRQ number, equivalent to the DT boot path. Owing to the current
>> ACPI core scan handlers implementation, ACPI PCI legacy IRQs bindings
>> cannot be parsed at device add time, since that would trigger ACPI scan
>> handlers ordering issues depending on how the ACPI tables are defined.
>
> Uh, OK :)  I can't figure out exactly what the problem is here -- I
> don't know where to look if I wanted to fix the scan handler ordering
> issues, and I don't know how I could tell if it would ever be safe to
> move this from driver probe-time back to device add-time.
>
> I also notice that x86 and ia64 call acpi_pci_irq_enable() even later,
> when the driver *enables* the device.  Is there a reason you didn't do
> it at the same time as x86 and ia64?  This is another of those pcibios
> hooks that really don't do anything arch-specific, so I can imagine
> refactoring this somehow, someday.
>
> Did we have this conversation before?  It seems vaguely familiar, so I
> apologize if you already explained this once.

It stared with a scan handler ordering issue, please see:
https://lists.linaro.org/pipermail/linaro-acpi/2015-October/005944.html
hence we decided to postpone ACPI legacy IRQs parsing. We also decided 
to keep ACPI and DT legacy IRQs parsing all together as the candidate 
for further PCI legacy IRQs consolidation, please see [1].
This will allow us to remove it from here (as you pointed out is is not 
arch-specific at all).

I share Lorenzo's option. We could put this to pcibios_enable_device 
instead of pcibios_alloc_irq but since ACPI and DT code is in one call 
we wanted to avoid regressions on PCI host controllers that do not call 
pci_fixup_irqs(), but rely on the legacy IRQ routing to be done in arm64
pcibios_add_device().

[1] http://www.spinics.net/lists/linux-pci/msg45950.html

Thanks,
Tomasz

>
>> To solve this problem and consolidate FW PCI legacy IRQs parsing in
>> one single pcibios callback (pending final removal), this patch moves
>> DT PCI IRQ parsing to the pcibios_alloc_irq() callback (called by
>> PCI core code at device probe time) and adds ACPI PCI legacy IRQs
>> parsing to the same callback too, so that FW PCI legacy IRQs parsing
>> is confined in one single arch callback that can be easily removed
>> when code parsing PCI legacy IRQs is consolidated and moved to core
>> PCI code.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> ---
>>   arch/arm64/kernel/pci.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index d5d3d26..b3b8a2c 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -51,11 +51,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>>   }
>>
>>   /*
>> - * Try to assign the IRQ number from DT when adding a new device
>> + * Try to assign the IRQ number when probing a new device
>>    */
>> -int pcibios_add_device(struct pci_dev *dev)
>> +int pcibios_alloc_irq(struct pci_dev *dev)
>>   {
>> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> +	if (acpi_disabled)
>> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> +#ifdef CONFIG_ACPI
>> +	else
>> +		return acpi_pci_irq_enable(dev);
>> +#endif
>>
>>   	return 0;
>>   }
>> --
>> 1.9.1
>>
