Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5524C13E.3060101@linux.intel.com>
Date: Wed, 08 Apr 2015 13:48:46 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix v3] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
References: <1427683243-14355-1-git-send-email-jiang.liu@linux.intel.com> <20150404030411.GG10892@google.com> <1832914.AK2bZGkVxq@vostro.rjw.lan>
In-Reply-To: <1832914.AK2bZGkVxq@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/4/7 8:28, Rafael J. Wysocki wrote:
> On Friday, April 03, 2015 10:04:11 PM Bjorn Helgaas wrote:
>> Hi Jiang,
<snip>
>>> Currently acpi_dev_filter_resource_type() is only used by ACPI pci
>>> host bridge and IOAPIC driver, so it shouldn't affect other drivers.
>>
>> We should assume it will eventually be used for all ACPI devices,
>> shouldn't we?
> 
> I'm not sure about that, really.  In fact, I'd restrict its use to devices
> types that actually can "produce" resources (ie. do not require the resources
> to be provided by their ancestors or to be available from a global pool).
> 
> Otherwise we're pretty much guaranteed to get into trouble.
> 
> And all of the above rules need to be documented in the kernel source tree
> or people will get confused.
Hi Rafael,
    How about following comments for acpi_dev_filter_resource_type()?
Thanks!
Gerry
--------------------------------------------------------------------
/**
 * According to ACPI specifications, Consumer/Producer flag in ACPI resource
 * descriptor means:
 *      1(CONSUMER): This device consumes this resource
 *      0(PRODUCER): This device produces and consumes this resource
 * But for ACPI PCI host bridge, it is interpreted in another way:
 *      1(CONSUMER): PCI host bridge itself consumes the resource, such as
 *                   IOPORT 0xCF8-0xCFF to access PCI configuraiton space.
 *      0(PRODUCER): PCI host bridge provides this resource to its child
 *                   bus and devices.
 *
 * So this is a specially designed helper function to support ACPI PCI host
 * bridge and ACPI IOAPIC, and its usage should be limited to those specific
 * scenarioso only. It filters ACPI resource descriptors as below:
 * 1) If flag IORESOURCE_WINDOW is not specified, it's querying resources
 *    consumed by device. That is to return:
 *      a) ACPI resources without producer_consumer flag
 *      b) ACPI resources with producer_consumer flag setting to CONSUMER.
 * 2) If flag IORESOURCE_WINDOW is specified, it's querying resources
provided
 *    by device. That is to return:
 *      a) ACPI resources with producer_consumer flag setting to PRODUCER.
 * 3) But there's an exception. Some platforms, such as PC Engines APU.1C,
 *    report PCI host bridge resource provision by Memory32Fixed().
 *    Please refer to https://bugzilla.kernel.org/show_bug.cgi?id=94221
 *    So a special flag IORESOURCE_MEM_8AND16BIT is used to work around this
 *    BIOS issue.
 */

> 
>>> Another possible fix is to only ignore IO resource consumed by host
>>> bridge and keep IOMEM resource consumed by host bridge, please refer to:
>>> http://www.spinics.net/lists/linux-pci/msg39706.html
>>>
>>> Sample ACPI table are archived at:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=94221
>>>
>>> V2->V3:
>>> Refine function acpi_dev_match_producer_consumer() as suggested by Rafael
>>>
>>> Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
>>> Reported-and-Tested-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>> ---
>>>  arch/x86/pci/acpi.c     |    5 ++---
>>>  drivers/acpi/resource.c |   33 +++++++++++++++++++++++++++++----
>>>  2 files changed, 31 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>>> index e4695985f9de..8c4b1201f340 100644
>>> --- a/arch/x86/pci/acpi.c
>>> +++ b/arch/x86/pci/acpi.c
>>> @@ -337,7 +337,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>>  	info->bridge = device;
>>>  	ret = acpi_dev_get_resources(device, list,
>>>  				     acpi_dev_filter_resource_type_cb,
>>> -				     (void *)(IORESOURCE_IO | IORESOURCE_MEM));
>>> +				     (void *)(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_WINDOW));
>>>  	if (ret < 0)
>>>  		dev_warn(&device->dev,
>>>  			 "failed to parse _CRS method, error code %d\n", ret);
>>> @@ -346,8 +346,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>>  			"no IO and memory resources present in _CRS\n");
>>>  	else
>>>  		resource_list_for_each_entry_safe(entry, tmp, list) {
>>> -			if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
>>> -			    (entry->res->flags & IORESOURCE_DISABLED))
>>> +			if (entry->res->flags & IORESOURCE_DISABLED)
>>>  				resource_list_destroy_entry(entry);
>>>  			else
>>>  				entry->res->name = info->name;
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 5589a6e2a023..e761a868bdba 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -567,6 +567,12 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
>>>  }
>>>  EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
>>>  
>>> +static bool acpi_dev_match_producer_consumer(unsigned long types, int producer)
>>> +{
>>> +	return ((types & IORESOURCE_WINDOW) && producer == ACPI_PRODUCER) ||
>>> +		((types & IORESOURCE_WINDOW) == 0 && producer == ACPI_CONSUMER);
>>> +}
>>> +
>>>  /**
>>>   * acpi_dev_filter_resource_type - Filter ACPI resource according to resource
>>>   *				   types
>>> @@ -585,27 +591,46 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
>>>  	case ACPI_RESOURCE_TYPE_MEMORY24:
>>>  	case ACPI_RESOURCE_TYPE_MEMORY32:
>>>  	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
>>> +		/*
>>> +		 * These types of resource descriptor should be used to
>>> +		 * describe resource consumption instead of resource provision.
>>> +		 * But some platforms, such as PC Engines APU.1C, reports
>>> +		 * resource provision by Memory32Fixed(). Please refer to:
>>> +		 * https://bugzilla.kernel.org/show_bug.cgi?id=94221
>>> +		 * So accept it no matter IORESOURCE_WINDOW is specified or not.
>>> +		 */
>>>  		type = IORESOURCE_MEM;
>>
>> I think this means these resources will be accepted regardless of whether
>> the caller is looking for Consumer or Producer resources.  To preserve the
>> behavior I added with 66528fdd45b0, we might be forced to do that for PCI
>> host bridges (or maybe we could just add a quirk for the PC Engines BIOS).
>>
>> But I don't think it matches the ACPI spec intent, so I'm not sure it's
>> right to do it for all devices.
> 
> No, it isn't, which is why acpi_dev_filter_resource_type() should not be used
> for all devices.
> 
>>>  		break;
>>>  	case ACPI_RESOURCE_TYPE_IO:
>>>  	case ACPI_RESOURCE_TYPE_FIXED_IO:
>>> -		type = IORESOURCE_IO;
>>> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
>>> +			type = IORESOURCE_IO;
>>>  		break;
>>>  	case ACPI_RESOURCE_TYPE_IRQ:
>>> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
>>> +			type = IORESOURCE_IRQ;
>>> +		break;
>>>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>>> -		type = IORESOURCE_IRQ;
>>> +		if (acpi_dev_match_producer_consumer(types,
>>> +				ares->data.extended_irq.producer_consumer))
>>> +			type = IORESOURCE_IRQ;
>>>  		break;
>>>  	case ACPI_RESOURCE_TYPE_DMA:
>>>  	case ACPI_RESOURCE_TYPE_FIXED_DMA:
>>> -		type = IORESOURCE_DMA;
>>> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
>>> +			type = IORESOURCE_DMA;
>>>  		break;
>>>  	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
>>> -		type = IORESOURCE_REG;
>>> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
>>> +			type = IORESOURCE_REG;
>>>  		break;
>>>  	case ACPI_RESOURCE_TYPE_ADDRESS16:
>>>  	case ACPI_RESOURCE_TYPE_ADDRESS32:
>>>  	case ACPI_RESOURCE_TYPE_ADDRESS64:
>>>  	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
>>> +		if (!acpi_dev_match_producer_consumer(types,
>>> +				ares->data.address.producer_consumer))
>>> +			break;
>>>  		if (ares->data.address.resource_type == ACPI_MEMORY_RANGE)
>>>  			type = IORESOURCE_MEM;
>>>  		else if (ares->data.address.resource_type == ACPI_IO_RANGE)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
