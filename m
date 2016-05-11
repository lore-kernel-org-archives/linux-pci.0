Return-Path: <prarit@redhat.com>
Return-Path: <prarit@redhat.com>
Message-ID: <57330489.3050603@redhat.com>
Date: Wed, 11 May 2016 06:08:09 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Myron Stowe <mstowe@redhat.com>,
        x86@kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/PCI: Fix Broadwell-EP Home Agent & PCU non-compliant
 BARs
References: <1462818195-6533-1-git-send-email-prarit@redhat.com> <20160509192030.GA18166@localhost> <5731DCD5.4030208@redhat.com> <20160510174518.GC29582@localhost>
In-Reply-To: <20160510174518.GC29582@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>



On 05/10/2016 01:45 PM, Bjorn Helgaas wrote:
> On Tue, May 10, 2016 at 09:06:29AM -0400, Prarit Bhargava wrote:

<snip output of lspci>

>>>>
>>>> which drives us to the second issue.  Since the PCI devices now
>>>> have unnassigned resources (BARs), pcibios_assign_resources()
>>>> call pci_assign_unassigned_root_bus_resources().  This results in the
>>>> messages above.  I have added a non_compliant_bars check in
>>>> pbus_assign_resources_sorted() to avoid the unassigned device's resources
>>>> from being added to the failed resources list for the bus.
>>>
>>> I don't understand this part yet.  If we mark a device with
>>> non_compliant_bars, __pci_read_base() will return without doing
>>> anything, so we should not fill in the struct resource at all.  It
>>> wouldn't have the "mem" or "pref" bits shown above, and it shouldn't
>>> participate in pcibios_assign_resources() at all.  All of these are
>>> for BAR 6 (the ROM BAR), so maybe there's something wrong with the way
>>> to handle that in particular.
>>
>> I did some additional debugging after reading your comment.  I dumped out the
>> contents of the resources for each bus's devices.  I concentrated on one
>> particular device, 7f:12.4 (the output of lspci is above).
>>
>> Before the call to pcibios_assign_resources(), 7f:12.4 has
>>
>> pci 0000:7f:12.4: PRARIT:    BAR 6: [mem 0x00000000 pref]
>>
>> so that means it the resource was not changed/modified in the call of
>> pcibios_assign_resources().
>>
>> I took a closer look at the code, and I think I know what the issue is.  In
>> pci_read_bases() the code does
>>
>>         if (rom) {
>>                 struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
>>                 dev->rom_base_reg = rom;
>>                 res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
>>                                 IORESOURCE_READONLY | IORESOURCE_CACHEABLE |
>>                                 IORESOURCE_SIZEALIGN;
>>                 __pci_read_base(dev, pci_bar_mem32, res, rom);
>>         }
>>
>> which initializes the res->flags field.  This field is later checked in
>> pcibios_allocate_dev_rom_resource() which is called from
>> pcibios_assign_resources(), and the resource is declared unassigned because it
>> has a res->flags field.
>>
>> Perhaps (sorry for the cut-and-paste) this is a more correct fix which would
>> avoid the setting of res->flags?  There is no point in setting
>> dev->rom_base_reg, etc., if this is a non-compliant device.
> 
> Right, thanks for the analysis.  I think this is a much better fix. We
> should not set any flags in this case.
> 
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 2384100..818731a 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -361,7 +361,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int
>>                 pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
>>         }
>>
>> -       if (rom) {
>> +       if (rom && !dev->non_compliant_bars) {
> 
> What if we just checked dev->non_compliant_bars as the very first
> thing in pci_read_bases()?  I think I originally put the check in
> __pci_read_base() because we considered doing this on a per-BAR basis.
> But I later decided that was overkill.

Okay -- FWIW, I found it odd that the field was plural when its action appeared
to be on a single BAR.

> 
> I could be convinced either way, but if we put the check in
> pci_read_bases(), I think we could probably drop the one in
> __pci_read_base().  We do call __pci_read_base() directly from
> sriov_init(), but we don't have any issues with BARs in SR-IOV
> capabilities yet, so we probably don't need to worry about that path.

I have tested on BDW-EP systems and will post new patches shortly.

P.
