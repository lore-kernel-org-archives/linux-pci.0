Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34687 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174AbcDLXgP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 19:36:15 -0400
MIME-Version: 1.0
In-Reply-To: <20160410221743.GC5852@localhost>
References: <1455827823254.98505@Dell.com>
	<20160410221743.GC5852@localhost>
Date: Tue, 12 Apr 2016 18:36:14 -0500
Message-ID: <CAC1AzdcBH7wLz+tAE4R00q6YQ7KRRzBDyP5w8wJQueJgT2agnQ@mail.gmail.com>
Subject: Re: [PATCH v3] Create pci slot files for SMBIOS Type 9 entries
From: Jordan Hargrave <jharg93@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	x86@kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 10, 2016 at 5:17 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Jordan,
>
> On Thu, Feb 18, 2016 at 08:40:32PM +0000, Jordan_Hargrave@Dell.com wrote:
>> The following diff builds on the "[PATCHv3] Save SMBIOS Type 9 System Slots"
>>
>> This will create a /sys/bus/pci/slots/XXX file for each Type 9 entry.  This will be \
>> used for systemd enumeration of NICs.
>>
>> Only build if CONFIG_DMI is set
>>
>> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
>> ---
>>  arch/x86/pci/common.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index eccd4d9..bfa3c85 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -173,6 +173,27 @@ void pcibios_fixup_bus(struct pci_bus *b)
>>
>>  void pcibios_add_bus(struct pci_bus *bus)
>>  {
>> +#ifdef CONFIG_DMI
>> +     const struct dmi_device *dmi;
>> +     struct dmi_dev_onboard *dslot;
>> +     char sname[128];
>> +
>> +     dmi = NULL;
>> +     while ((dmi = dmi_find_device(DMI_DEV_TYPE_DEV_SLOT,
>> +                                   NULL, dmi)) != NULL) {
>> +             dslot = dmi->device_data;
>> +             if (dslot->segment == pci_domain_nr(bus) &&
>> +                 dslot->bus == bus->number) {
>> +                     dev_info(&bus->dev, "Found SMBIOS Slot %s\n",
>> +                              dslot->dev.name);
>> +                     snprintf(sname, sizeof(sname), "%s-%d",
>> +                              dslot->dev.name,
>> +                              dslot->instance);
>> +                     pci_create_slot(bus, dslot->devfn,
>> +                                     sname, NULL);
>> +             }
>> +     }
>> +#endif
>
> arm64, ia64, and x86 all support CONFIG_DMI, so this would have to be
> a bit more generic.

The SMBIOS tables for DMI_DEV_TYPE_DEV_SLOT are scanned in
firmware/dmi_scan.c which requires CONFIG_DMI

>
> Is there a spec that describes this SMBIOS entry?  It seems to have
> segment/bus/devfn, so maybe this should be done on a per-device basis,
> not a per-bus basis?
>

Yes, the SMBIOS specification for Type 9 System Slots.  The fields for
PCI mapping were added in SMBIOS 2.6

https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.0.0.pdf


> Does this do the same thing ctrl_slot_setup() does with
> get_SMBIOS_entry()?  (This is in the cpqphp hotplug driver; I have no
> idea if anybody still uses that.)

Looks like cpqphp driver is looking for SMBIOS Type 9, but < 2.5 table
structure. It's looking for the slot ID number (this number is
equivalent to dslot->instance).


>
> There's quite a collection of pci_create_slot() callers, and I'd like
> to know how this new addition would coexist with the others.  In
> particular, what about the one in pciehp?  I think we only expose a
> slot name in sysfs if pciehp claims a downstream port, but I'm not
> sure that's the right thing.  The slot number might be useful even if
> the slot doesn't support hotplug or if hotplug is disabled for some
> reason.
>

pciehp requires the BIOS has setup the slot number in PCI properly....
I've seen systems with two PCIE 'slots' which had the same slot
number.  Of course the SMBIOS table requires the BIOS got it right
too....

>>       acpi_pci_add_bus(bus);
>>  }
>>
>> --
>> 2.5.0
>>
>>
>>
>>
>>
>>
>>
>> --jordan hargrave
>>  Dell Enterprise Linux Engineering  --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
