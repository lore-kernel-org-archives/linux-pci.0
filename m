Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5523DBE3.7000007@linux.intel.com>
Date: Tue, 07 Apr 2015 21:30:11 +0800
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
>>
>> Sorry for my delayed response.  I've been on vacation for a week and am
>> still trying to catch up.
>>
>> On Mon, Mar 30, 2015 at 10:40:43AM +0800, Jiang Liu wrote:
<snip>
>>> Then commit 63f1789ec716("Ignore resources consumed by host bridge
>>> itself") ignores resources consumed by host bridge itself by checking
>>> IORESOURCE_WINDOW flag, which accidently removed the workaround in 2)
>>> above for BIOS bug .
>>
>> This is probably partly my fault.
>>
>> I think the ACPI spec intention is that every _CRS resource descriptor
>> should be interpreted as "Consumer," i.e., as resources consumed by the
>> device itself, unless it's marked otherwise.  Only the following types can
>> be marked as "Producer":
>>
>>   - Word/DWord/QWord/Extended address space descriptors, 
>>   - Extended interrupt descriptors,
>>   - GPIO interrupt and I/O connections,
>>   - I2C/SPI/UART serial bus resource descriptors
> 
> So we're talking about the consumer/producer flag in those extended resource
> type descriptors, right?
> 
> My understanding of that flag is that it doesn't say whether or not the device
> is a producer of a resource in a general sense.  It only says whether the device
> consumes a resource provided by someone else (1) or it consumes a resources
> provided by itself (0).
Hi Rafael,
	I have read the ACPI spec again.
You are right, the spec states that:
Consumer/Producer:
1–This device consumes this resource
0–This device produces and consumes this resource

This is different from my previous understanding.
Previously I thought "CONSUMER" means the device consumes the resource
by itself and "PRODUCER" means the device provides resource to other
devices.

So seems PCI host bridge has different interpretation of
CONSUMER/PRODUCER flag from ACPI spec.

> 
>> With 66528fdd45b0 ("x86/PCI: parse additional host bridge window resource
>> types"), I made Linux treat Memory24, Memory32, and Memory32Fixed
>> descriptors in PCI host bridge _CRS as Producers.  I did it because Windows
>> apparently does that (there are details in
>> https://bugzilla.kernel.org/show_bug.cgi?id=15817),
> 
> It looks like it does that to indicate that those resources are provided
> by the host bridge itself (which is consistent with the consumer/producer
> flag interpretation above)
> 
>> but I wasn't aware of any machines that required it.  That was probably a
>> mistake because it didn't fix anything and it covered up ASL usage errors
>> like what PC Engines did.
> 
> I don't think it is required.  It only seems to allow Windows to consolidate
> the handling of host bridge resources.
> 
>>> It's really costed us much time to figure out this whole picture.
>>> So we refine interface acpi_dev_filter_resource_type as below,
>>> which should be easier for maintence:
>>> 1) Caller specifies IORESOURCE_WINDOW flag to explicitly query resource
>>>    for bridge(PRODUCER), otherwise it's querying resource for
>>>    device(CONSUMER).
>>
>> Sounds good to me.
>>
>>> 2) Ignore IO port resources defined by acpi_resource_io and
>>>    acpi_resource_fixed_io if IORESOURCE_WINDOW is specified.
>>
>> Sounds good to me.
>>
>>> 3) Accpet IOMEM resource defined by acpi_resource_memory24,
>>>    acpi_resource_memory32 and acpi_resource_fixed_memory32 for BIOS
>>>    bugs, with comment to state it's workaround for BIOS bug.
>>
>> I don't like the fact that this is the behavior for all ACPI devices.
>> Prior to 593669c2ac0f, we had this behavior for PCI host bridges only.
>> I don't think this is what the spec envisioned, so I don't really like
>> doing it for all devices.
> 
> Agreed.
> 
>>> 4) Accept IO port and IOMEM defined by acpi_resource_addressxx if
>>>    a) IORESOURCE_WINDOW is specified and ACPI_PRODUCER is true
>>>    b) IORESOURCE_WINDOW is not specified and ACPI_PRODUCER is false
>>
>> Sounds good to me.
>>
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
You are right, we should limit acpi_dev_filter_resource_type() usages
to PCI host bridges and IOAPIC only.

> 
>>> Another possible fix is to only ignore IO resource consumed by host
<snip>
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
Got it, will update comments.
Thanks!
Gerry
