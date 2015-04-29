Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5540DD9C.9030707@linux.intel.com>
Date: Wed, 29 Apr 2015 21:33:16 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Len Brown <lenb@kernel.org>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [Bugfix v5] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
References: <1429499338-16967-1-git-send-email-jiang.liu@linux.intel.com> <3492366.RzMG5dcPfN@vostro.rjw.lan> <CAErSpo4zBFUBwSJjF1CuB8w06CDwYx+ZZaL1X71Joi0uMCObbg@mail.gmail.com>
In-Reply-To: <CAErSpo4zBFUBwSJjF1CuB8w06CDwYx+ZZaL1X71Joi0uMCObbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/4/29 21:20, Bjorn Helgaas wrote:
> On Tue, Apr 28, 2015 at 7:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Monday, April 20, 2015 11:08:58 AM Jiang Liu wrote:
>>> An IO port or MMIO resource assigned to a PCI host bridge may be
>>> consumed by the host bridge itself or available to its child
>>> bus/devices. On x86 and IA64 platforms, all IO port and MMIO
>>> resources are assumed to be available to child bus/devices
>>> except one special case:
>>>     IO port [0xCF8-0xCFF] is consumed by the host bridge itself
>>>     to access PCI configuration space.
>>>
>>> But the ACPI and PCI Firmware specifications haven't provided a method
>>> to tell whether a resource is consumed by the host bridge itself.
>>> So before commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource
>>> interfaces to simplify implementation"), arch/x86/pci/acpi.c ignored
>>> all IO port resources defined by acpi_resource_io and
>>> acpi_resource_fixed_io to filter out IO ports consumed by the host
>>> bridge itself.
>>>
>>> Commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces
>>> to simplify implementation")started accepting all IO port and MMIO
>>> resources, which caused a regression that IO port resources consumed
>>> by the host bridge itself became available to its child devices.
>>>
>>> Then commit 63f1789ec716 ("x86/PCI/ACPI: Ignore resources consumed by
>>> host bridge itself") ignored resources consumed by the host bridge
>>> itself by checking the IORESOURCE_WINDOW flag, which accidently removed
>>> MMIO resources defined by acpi_resource_memory24, acpi_resource_memory32
>>> and acpi_resource_fixed_memory32.
>>>
>>> So revert to the behavior before v3.19 to fix the regression.
>>>
>>> There is also a discussion about ignoring the Producer/Consumer flag on
>>> IA64 platforms at:
>>> http://patchwork.ozlabs.org/patch/461633/
>>>
>>> Related ACPI table are archived at:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=94221
>>>
>>> Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
>>> Reported-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>
>> Bjorn, Ingo, is anyone looking at this?  We're still having a regression in
>> this area ...
> 
>>> ---
>>>  arch/x86/pci/acpi.c     |   25 ++++++++++++++++++++++---
>>>  drivers/acpi/resource.c |    6 +++++-
>>>  2 files changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>>> index e4695985f9de..fc2da98985c3 100644
>>> --- a/arch/x86/pci/acpi.c
>>> +++ b/arch/x86/pci/acpi.c
>>> @@ -332,12 +332,32 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>>  {
>>>       int ret;
>>>       struct resource_entry *entry, *tmp;
>>> +     unsigned long res_flags;
>>>
>>>       sprintf(info->name, "PCI Bus %04x:%02x", domain, busnum);
>>>       info->bridge = device;
>>> +
>>> +     /*
>>> +      * An IO or MMIO resource assigned to PCI host bridge may be consumed
>>> +      * by the host bridge itself or available to its child bus/devices.
>>> +      * On x86 and IA64 platforms, all IO and MMIO resources are assumed to
>>> +      * be available to child bus/devices except one special case:
>>> +      *      IO port [0xCF8-0xCFF] is consumed by host bridge itself to
>>> +      *      access PCI configuration space.
>>> +      *
>>> +      * Due to lack of specification to define resources consumed by host
>>> +      * bridge itself, all IO port resources defined by acpi_resource_io
>>> +      * and acpi_resource_fixed_io are ignored to filter out IO
>>> +      * port[0xCF8-0xCFF]. Seems this solution works with all BIOSes, though
>>> +      * it's not perfect.
> 
> 1) I think it's misleading to say "the specs haven't provided a
> method."  As far as I can tell, the Producer/Consumer bit is intended
> precisely to distinguish resources consumed by a bridge from those
> forwarded to downstream devices.  It would be more accurate to say
> "the spec defines a bit, but firmware hasn't used that bit
> consistently, so we can't rely on it."

Hi Bjorn,
	Thanks for review, I will refine the words as suggested by you.

> If you want to say "it's not perfect," it would be useful to mention
> the ways in which it is not perfect.  This code is still a candidate
> for unification with ia64 and arm64, so we should avoid x86-specific
> things here as much as possible.

Yes, I have another pending patch set to consolidate IA64 and x86 code
for ACPI PCI root.

> 
>>> +      *
>>> +      * Another possible solution is to explicitly filter out IO
>>> +      * port[0xCF8-0xCFF].
>>> +      */
>>> +     res_flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_IO_FIXED;
> 
> 2) The usage of IORESOURCE_IO_FIXED here seems like a hack.  It's not
> related to other existing use of IORESOURCE_IO_FIXED, and it's not
> intuitive that supplying IORESOURCE_MEM means "I want all the
> memory-type resources," but supplying IORESOURCE_IO_FIXED means "I
> *don't* want the fixed I/O-type resources."

Yes, the IORESOURCE_IO_FIXED is a hack here. Then how about explicitly
filtering IOPORT [0xCF8-0xCFF] so we could avoid such a hack.

> 
> A struct resource is not as expressive as a struct acpi_resource.
> We're going through a lot of contortions to pass nuances of
> acpi_resource through to code that only knows about struct resource.
> I'm not sure that's a good long-term strategy, but I don't have a
> better suggestion.
> 
>>>       ret = acpi_dev_get_resources(device, list,
>>>                                    acpi_dev_filter_resource_type_cb,
>>> -                                  (void *)(IORESOURCE_IO | IORESOURCE_MEM));
>>> +                                  (void *)res_flags);
>>>       if (ret < 0)
>>>               dev_warn(&device->dev,
>>>                        "failed to parse _CRS method, error code %d\n", ret);
>>> @@ -346,8 +366,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>>>                       "no IO and memory resources present in _CRS\n");
>>>       else
>>>               resource_list_for_each_entry_safe(entry, tmp, list) {
>>> -                     if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
>>> -                         (entry->res->flags & IORESOURCE_DISABLED))
>>> +                     if (entry->res->flags & IORESOURCE_DISABLED)
>>>                               resource_list_destroy_entry(entry);
>>>                       else
>>>                               entry->res->name = info->name;
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 5589a6e2a023..79b6d3b5ffd2 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -575,6 +575,9 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
>>>   *
>>>   * This is a hepler function to support acpi_dev_get_resources(), which filters
>>>   * ACPI resource objects according to resource types.
> 
> 3)  Since you're touching this comment anyway, can you fix the
> "hepler" typo above, too?

Sure.
Thanks!
Gerry

> 
>>> + *
>>> + * Flag IORESOURCE_IO_FIXED is used to opt out io and fixed_io resource
>>> + * descriptors for ACPI host bridges on x86 and IA64 platforms.
>>>   */
>>>  int acpi_dev_filter_resource_type(struct acpi_resource *ares,
>>>                                 unsigned long types)
>>> @@ -589,7 +592,8 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
>>>               break;
>>>       case ACPI_RESOURCE_TYPE_IO:
>>>       case ACPI_RESOURCE_TYPE_FIXED_IO:
>>> -             type = IORESOURCE_IO;
>>> +             if ((types & IORESOURCE_IO_FIXED) == 0)
>>> +                     type = IORESOURCE_IO;
>>>               break;
>>>       case ACPI_RESOURCE_TYPE_IRQ:
>>>       case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>>>
>>
>> --
>> I speak only for myself.
>> Rafael J. Wysocki, Intel Open Source Technology Center.
