Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5510CA69.30309@linux.intel.com>
Date: Tue, 24 Mar 2015 10:22:33 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
References: <1427095334-7430-1-git-send-email-jiang.liu@linux.intel.com> <20150323164809.GS26935@google.com>
In-Reply-To: <20150323164809.GS26935@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/24 0:48, Bjorn Helgaas wrote:
> On Mon, Mar 23, 2015 at 03:22:14PM +0800, Jiang Liu wrote:
>> Commit 63f1789ec716("Ignore resources consumed by host bridge itself")
>> tries to ignore resources consumed by PCI host bridge itself by
>> checking IORESOURCE_WINDOW flag, which causes regression on some
>> platforms.
> 
> "Do.  Or do not.  There is no try."
> [http://www.starwars.com/video/do-or-do-not]
> 
> That commit doesn't *try* to do something.  It *does* something.  Just
> explain what it does and what's wrong with what it does.
> 
>> For example, PC Engines APU.1C platform defines PCI MMIO resources with
>> ACPI Memory32Fixed operator as below:
>> Name (CRES, ResourceTemplate ()
>> {
>>     ...
>>     WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>>         0x0000,             // Granularity
>>         0x0D00,             // Range Minimum
>>         0xFFFF,             // Range Maximum
>>         0x0000,             // Translation Offset
>>         0xF300,             // Length
>>         ,, , TypeStatic)
>>     Memory32Fixed (ReadOnly,
>>         0x000A0000,         // Address Base
>>         0x00020000,         // Address Length
>>         )
>>     Memory32Fixed (ReadOnly,
>>         0x00000000,         // Address Base
>>         0x00000000,         // Address Length
>>         _Y00)
>> })
>>
>> Memory32Fixed operator doesn't support concept of "producer/consumer"
>> and it will be treated as "consumer" by the ACPI resource parsing
>> interface, thus cause regression. So the fix is only to check
>> "producer/consumer" flag for resources having "producer/consumer" flag.
> 
> Apparently the problem is with the Memory32Fixed resources above; it sounds
> like we ignore them after 63f1789ec716?  I don't quite understand how this
> fix works.  acpi_dev_filter_resource_type() has cases for both
> ACPI_RESOURCE_TYPE_FIXED_MEMORY32 and ACPI_RESOURCE_TYPE_ADDRESSxx, but 
> this patch only touches the latter, not the
> ACPI_RESOURCE_TYPE_FIXED_MEMORY32 case.
The idea is:
1) caller specifies IORESOURCE_WINDOW to query resources provided
   by the device, otherwise it's querying resources consumed by
   the device.
2) For resource descriptors having producer/consumer flag, such as
    ACPI_RESOURCE_TYPE_ADDRESSxx, we check the producer/consumer flag.
3) For resource descriptors not having producer/consumer flag, such
   as ACPI_RESOURCE_TYPE_FIXED_MEMORY32, we skip checking the
   producer/consumer flag.

> 
> Is it even legal to use Memory32Fixed for a bridge window?  Is this just a
> BIOS bug?  If so, how do we know this workaround won't break something
> else for BIOSes that use Memory32Fixed correctly?
> 
> Should this be a BIOS-specific quirk?
I have searched ACPI spec 5.0 and PCI firmware spec 3.1, but haven't
found any statement tells whether Memory32Fixed could be used for
PCI host bridge resources yet. So to be honest, I'm not sure it's
legal or illegal:(

> 
> Incidentally, I also noticed this change:
> 
>   --- dmesg_3.18.0-rc5.txt        2015-03-23 10:49:25.064682404 -0500
>   +++ dmesg_4.0.0-rc4.txt 2015-03-23 10:49:29.276630002 -0500
>   -ACPI: PCI Interrupt Link [INTA] (IRQs 3 4 5 7 10 11 12 15) *0, disabled.
>   +ACPI: PCI Interrupt Link [INTA] (IRQs 3 4 5 7 10 11 12 15) *0
> 
> Is it intentional that INTA was previously reported as disabled but isn't
> any more?
Thanks for reporting this, it's not intentional. Will check it.

> 
> And there's also this:
> 
>   acpi PNP0A03:00: [Firmware Bug]: no secondary bus range in _CRS
> 
> That isn't a change (it was there in 3.18, too), but that really is a
> pretty basic BIOS bug and indicates that we shouldn't be too surprised if
> it has other bugs.
> 
>> Another possible fix is to only ignore IO resource consumed by host
>> bridge and keep IOMEM resource consumed by host bridge, please refer to:
>> http://www.spinics.net/lists/linux-pci/msg39706.html
> 
> It'd be nice to have Bernhard's logs archived somewhere and referenced
> here.  This seems like a dusty corner of the code that might have to be
> revisited someday.
I have archived the acpidump at:
https://bugzilla.kernel.org/show_bug.cgi?id=94221

> 
>> Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
>> Reported-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>> Hi Bernhard,
>> 	Could you please also help to test whether this patch works for
>> you too?
>> Thanks!
>> Gerry
>> ---
>>  arch/x86/pci/acpi.c     |    5 ++---
>>  drivers/acpi/resource.c |    3 +++
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index e4695985f9de..8c4b1201f340 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -337,7 +337,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>  	info->bridge = device;
>>  	ret = acpi_dev_get_resources(device, list,
>>  				     acpi_dev_filter_resource_type_cb,
>> -				     (void *)(IORESOURCE_IO | IORESOURCE_MEM));
>> +				     (void *)(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_WINDOW));
> 
> Tangent: I'm disappointed that ia64 didn't get reworked to track the x86
> code here.  Is that coming soon?
I have checked IA64 when changing the resource parsing interface,
but there are obstacle to convert it to the new interface.
Will have another try.
Thanks!
Gerry
> 
>>  	if (ret < 0)
>>  		dev_warn(&device->dev,
>>  			 "failed to parse _CRS method, error code %d\n", ret);
>> @@ -346,8 +346,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>  			"no IO and memory resources present in _CRS\n");
>>  	else
>>  		resource_list_for_each_entry_safe(entry, tmp, list) {
>> -			if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
>> -			    (entry->res->flags & IORESOURCE_DISABLED))
>> +			if (entry->res->flags & IORESOURCE_DISABLED)
>>  				resource_list_destroy_entry(entry);
>>  			else
>>  				entry->res->name = info->name;
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 5589a6e2a023..b0d3f2ceef06 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -606,6 +606,9 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
>>  	case ACPI_RESOURCE_TYPE_ADDRESS32:
>>  	case ACPI_RESOURCE_TYPE_ADDRESS64:
>>  	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
>> +		if (((types & IORESOURCE_WINDOW) == 0) ^
>> +		    (ares->data.address.producer_consumer == ACPI_CONSUMER))
>> +			break;
>>  		if (ares->data.address.resource_type == ACPI_MEMORY_RANGE)
>>  			type = IORESOURCE_MEM;
>>  		else if (ares->data.address.resource_type == ACPI_IO_RANGE)
>> -- 
>> 1.7.10.4
>>
