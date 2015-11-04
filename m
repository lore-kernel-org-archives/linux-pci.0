Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34439 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbbKDKLU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 05:11:20 -0500
Received: by lbbwb3 with SMTP id wb3so12420308lbb.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2015 02:11:18 -0800 (PST)
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <20151103165555.GF3574@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <5639D9BC.8080706@linaro.org>
Date: Wed, 4 Nov 2015 11:11:08 +0100
MIME-Version: 1.0
In-Reply-To: <20151103165555.GF3574@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03.11.2015 17:55, Lorenzo Pieralisi wrote:
> On Tue, Oct 27, 2015 at 05:38:42PM +0100, Tomasz Nowicki wrote:
>
> [...]
>
>>   menu "Kernel Features"
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index b3d098b..66cc1ae 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -11,12 +11,15 @@
>>    */
>>
>>   #include <linux/acpi.h>
>> +#include <linux/ecam.h>
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mm.h>
>> +#include <linux/of_address.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/pci-acpi.h>
>>   #include <linux/slab.h>
>>
>>   #include <asm/pci-bridge.h>
>> @@ -52,35 +55,216 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>>   }
>>
>>   /*
>> - * Try to assign the IRQ number from DT when adding a new device
>> + * Try to assign the IRQ number from DT/ACPI when adding a new device
>>    */
>>   int pcibios_add_device(struct pci_dev *dev)
>>   {
>> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> +	if (acpi_disabled)
>> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> +#ifdef CONFIG_ACPI
>> +	else
>> +		acpi_pci_irq_enable(dev);
>> +#endif
>
> This series:
>
> http://www.spinics.net/lists/linux-pci/msg45950.html
>
> will allow us to initialize the irq mapping function according to
> the boot method, code above is getting cumbersome and it is already
> overriden when booting with DT, so we will remove it altogether.
>
>>
>>   	return 0;
>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>> +{
>> +	struct acpi_pci_root *root = bridge->bus->sysdata;
>> +
>> +	ACPI_COMPANION_SET(&bridge->dev, root->device);
>> +	return 0;
>
> This should be made part of core code IMO.
>
>> +}
>> +
>> +void pcibios_add_bus(struct pci_bus *bus)
>> +{
>> +	acpi_pci_add_bus(bus);
>> +}
>> +
>> +void pcibios_remove_bus(struct pci_bus *bus)
>> +{
>> +	acpi_pci_remove_bus(bus);
>> +}
>
> Two functions above are identical for arm64, ia64 and x86, I do
> not think they belong in arch code.
>
>> +static int __init pcibios_assign_resources(void)
>> +{
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	pci_assign_unassigned_resources();
>> +	return 0;
>
> Already commented on this.
>
>> +}
>>   /*
>> - * raw_pci_read/write - Platform-specific PCI config space access.
>> + * rootfs_initcall comes after subsys_initcall and fs_initcall_sync,
>> + * so we know acpi scan and PCI_FIXUP_FINAL quirks have both run.
>>    */
>> -int raw_pci_read(unsigned int domain, unsigned int bus,
>> -		  unsigned int devfn, int reg, int len, u32 *val)
>> +rootfs_initcall(pcibios_assign_resources);
>> +
>> +static void __iomem *
>> +pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
>>   {
>> -	return -ENXIO;
>> +	struct pci_mmcfg_region *cfg;
>> +
>> +	cfg = pci_mmconfig_lookup(pci_domain_nr(bus), bus->number);
>> +	if (cfg && cfg->virt)
>> +		return cfg->virt +
>> +			(PCI_MMCFG_BUS_OFFSET(bus->number) | (devfn << 12)) +
>> +			offset;
>> +	return NULL;
>
> Why is this code arm64 specific ?

It is not, I will move it out of here, probably to mcfg.c file where we 
can apply quirks.

Thanks,
Tomasz
