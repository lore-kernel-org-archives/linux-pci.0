Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:42950 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaDXXyL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 19:54:11 -0400
Received: by mail-vc0-f176.google.com with SMTP id lc6so3804998vcb.21
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 16:54:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140424232000.GN29593@google.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
	<1395960398-4238-2-git-send-email-robherring2@gmail.com>
	<20140424232000.GN29593@google.com>
Date: Thu, 24 Apr 2014 18:54:10 -0500
Message-ID: <CAL_JsqKCdLa8N6J-z7GpKw3ffOdugTwiz-bJn4SxyWp7F2V0Kw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: hackup pcibios support for commmon bridge code
From: Rob Herring <robherring2@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 24, 2014 at 6:20 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Mar 27, 2014 at 05:46:36PM -0500, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  arch/arm/kernel/bios32.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
>> index 317da88..31ec14a 100644
>> --- a/arch/arm/kernel/bios32.c
>> +++ b/arch/arm/kernel/bios32.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> +#include <linux/of_pci.h>
>>
>>  #include <asm/mach-types.h>
>>  #include <asm/mach/map.h>
>> @@ -337,6 +338,15 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>>       list_for_each_entry(dev, &bus->devices, bus_list) {
>>               u16 cmd;
>>
>> +             /* Ignore fully discovered devices */
>> +             if (dev->is_added)
>> +                     continue;
>> +
>> +             set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
>
> We already do this in pci_device_add(); why do we need it here, too?

Because it was in the arm64 code. I'm not really sure.

>> +             /* Read default IRQs and fixup if necessary */
>> +             dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>
> Could this be done in pcibios_enable_device() or some other per-device
> interface()?  I'd like to get rid of pcibios_fixup_bus() eventually.

Probably. This should return NO_IRQ in the !OF case. We'd need to make
sure that works.

I had a loop at pcibios_fixup_bus across architectures and could make
no sense of why things were done in here. It all seemed a bit random
and left me with questions like shouldn't something always be needed.
Probably a lot of pieces are redundant now that didn't use to be. It
needs someone that knows more about PCI than me to look at.

>>               pci_read_config_word(dev, PCI_COMMAND, &cmd);
>>               cmd |= features;
>>               pci_write_config_word(dev, PCI_COMMAND, cmd);
>> @@ -681,3 +691,56 @@ void __init pci_map_io_early(unsigned long pfn)
>>       pci_io_desc.pfn = pfn;
>>       iotable_init(&pci_io_desc, 1);
>>  }
>> +
>> +struct ioresource {
>> +     struct list_head list;
>> +     phys_addr_t start;
>> +     resource_size_t size;
>> +};
>> +
>> +static LIST_HEAD(io_list);
>> +
>> +int pci_register_io_range(phys_addr_t address, resource_size_t size)
>> +{
>> +     struct ioresource *res;
>> +     resource_size_t allocated_size = 0;
>> +
>> +     /* find if the range has not been already allocated */
>> +     list_for_each_entry(res, &io_list, list) {
>> +             if (address >= res->start &&
>> +                     address + size <= res->start + size)
>> +                     return 0;
>> +             allocated_size += res->size;
>> +     }
>> +
>> +     /* range not already registered, check for space */
>> +     if (allocated_size + size > IO_SPACE_LIMIT)
>> +             return -E2BIG;
>> +
>> +     /* add the range in the list */
>> +     res = kzalloc(sizeof(*res), GFP_KERNEL);
>> +     if (!res)
>> +             return -ENOMEM;
>> +     res->start = address;
>> +     res->size = size;
>> +
>> +     list_add_tail(&res->list, &io_list);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_register_io_range);
>> +
>> +unsigned long pci_address_to_pio(phys_addr_t address)
>> +{
>> +     struct ioresource *res;
>> +
>> +     list_for_each_entry(res, &io_list, list) {
>> +             if (address >= res->start &&
>> +                     address < res->start + res->size) {
>> +                     return res->start - address;
>> +             }
>> +     }
>> +
>> +     return (unsigned long)-1;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_address_to_pio);
>
> ISTR some discussion about this, so maybe this has already been addressed,
> but it doesn't seem right to export generically-named symbols like these
> from the ARM arch code.  And they don't look very ARM-specific.

Right, I expect these to go away with Liviu's the next version.

Rob
