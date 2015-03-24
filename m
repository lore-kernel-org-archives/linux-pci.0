Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5510CA69.30309@linux.intel.com>
References: <1427095334-7430-1-git-send-email-jiang.liu@linux.intel.com>
 <20150323164809.GS26935@google.com> <5510CA69.30309@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Mar 2015 21:42:44 -0500
Message-ID: <CAErSpo72DoOu1XR8jYW_VsEKfnhcL9ydqtkjwBTUSm-mN-Rn2A@mail.gmail.com>
Subject: Re: [Bugfix] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Len Brown <lenb@kernel.org>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 23, 2015 at 9:22 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> On 2015/3/24 0:48, Bjorn Helgaas wrote:
>> On Mon, Mar 23, 2015 at 03:22:14PM +0800, Jiang Liu wrote:
>>> Commit 63f1789ec716("Ignore resources consumed by host bridge itself")
>>> tries to ignore resources consumed by PCI host bridge itself by
>>> checking IORESOURCE_WINDOW flag, which causes regression on some
>>> platforms.
>>
>> "Do.  Or do not.  There is no try."
>> [http://www.starwars.com/video/do-or-do-not]
>>
>> That commit doesn't *try* to do something.  It *does* something.  Just
>> explain what it does and what's wrong with what it does.
>>
>>> For example, PC Engines APU.1C platform defines PCI MMIO resources with
>>> ACPI Memory32Fixed operator as below:
>>> Name (CRES, ResourceTemplate ()
>>> {
>>>     ...
>>>     WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>>>         0x0000,             // Granularity
>>>         0x0D00,             // Range Minimum
>>>         0xFFFF,             // Range Maximum
>>>         0x0000,             // Translation Offset
>>>         0xF300,             // Length
>>>         ,, , TypeStatic)
>>>     Memory32Fixed (ReadOnly,
>>>         0x000A0000,         // Address Base
>>>         0x00020000,         // Address Length
>>>         )
>>>     Memory32Fixed (ReadOnly,
>>>         0x00000000,         // Address Base
>>>         0x00000000,         // Address Length
>>>         _Y00)
>>> })
>>>
>>> Memory32Fixed operator doesn't support concept of "producer/consumer"
>>> and it will be treated as "consumer" by the ACPI resource parsing
>>> interface, thus cause regression. So the fix is only to check
>>> "producer/consumer" flag for resources having "producer/consumer" flag.
>>
>> Apparently the problem is with the Memory32Fixed resources above; it sounds
>> like we ignore them after 63f1789ec716?  I don't quite understand how this
>> fix works.  acpi_dev_filter_resource_type() has cases for both
>> ACPI_RESOURCE_TYPE_FIXED_MEMORY32 and ACPI_RESOURCE_TYPE_ADDRESSxx, but
>> this patch only touches the latter, not the
>> ACPI_RESOURCE_TYPE_FIXED_MEMORY32 case.
> The idea is:
> 1) caller specifies IORESOURCE_WINDOW to query resources provided
>    by the device, otherwise it's querying resources consumed by
>    the device.
> 2) For resource descriptors having producer/consumer flag, such as
>     ACPI_RESOURCE_TYPE_ADDRESSxx, we check the producer/consumer flag.
> 3) For resource descriptors not having producer/consumer flag, such
>    as ACPI_RESOURCE_TYPE_FIXED_MEMORY32, we skip checking the
>    producer/consumer flag.

I figured out that much by reading the code.  But I think the code is
very hard to read, and I still don't really understand how it works.

Before this fix, we ignore Memory32Fixed resources.  After this fix,
we use Memory32Fixed as a window.  I think that's an incorrect
interpretation of Memory32Fixed.

>> Is it even legal to use Memory32Fixed for a bridge window?  Is this just a
>> BIOS bug?  If so, how do we know this workaround won't break something
>> else for BIOSes that use Memory32Fixed correctly?
>>
>> Should this be a BIOS-specific quirk?
> I have searched ACPI spec 5.0 and PCI firmware spec 3.1, but haven't
> found any statement tells whether Memory32Fixed could be used for
> PCI host bridge resources yet. So to be honest, I'm not sure it's
> legal or illegal:(

I think it could certainly be used for host bridge register space, if
the bridge supplied a _HID that a device-specific driver could claim.
But I think a generic driver like pci_root.c has to rely on the
producer/consumer bit to differentiate windows ("produced" space) from
device registers ("consumed" space), so I think Memory32Fixed for a
window makes no sense.

>> It'd be nice to have Bernhard's logs archived somewhere and referenced
>> here.  This seems like a dusty corner of the code that might have to be
>> revisited someday.
> I have archived the acpidump at:
> https://bugzilla.kernel.org/show_bug.cgi?id=94221

Yes, I noticed that.  Unfortunately, there is no link to the bugzilla
in your changelog.

>>> --- a/arch/x86/pci/acpi.c
>>> +++ b/arch/x86/pci/acpi.c
>>> @@ -337,7 +337,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>>      info->bridge = device;
>>>      ret = acpi_dev_get_resources(device, list,
>>>                                   acpi_dev_filter_resource_type_cb,
>>> -                                 (void *)(IORESOURCE_IO | IORESOURCE_MEM));
>>> +                                 (void *)(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_WINDOW));
>>
>> Tangent: I'm disappointed that ia64 didn't get reworked to track the x86
>> code here.  Is that coming soon?
> I have checked IA64 when changing the resource parsing interface,
> but there are obstacle to convert it to the new interface.
> Will have another try.

Please do.  I think it's extremely important to keep these arches
aligned.  And arm64, when similar code gets added to it.  Most of the
code in pci_acpi_scan_root() is actually arch-independent, and it
should be pulled up into pci_root.c someday.

Bjorn
