Return-Path: <prarit@redhat.com>
Return-Path: <prarit@redhat.com>
Message-ID: <5731DCD5.4030208@redhat.com>
Date: Tue, 10 May 2016 09:06:29 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Myron Stowe <mstowe@redhat.com>,
        x86@kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/PCI: Fix Broadwell-EP Home Agent & PCU non-compliant
 BARs
References: <1462818195-6533-1-git-send-email-prarit@redhat.com> <20160509192030.GA18166@localhost>
In-Reply-To: <20160509192030.GA18166@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>



On 05/09/2016 03:20 PM, Bjorn Helgaas wrote:
> [+cc Andi]
> 
> Hi Prarit,
> 
> On Mon, May 09, 2016 at 02:23:15PM -0400, Prarit Bhargava wrote:
>> commit b894157 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having
>> non-compliant BARs") marks Home Agent 0 & PCU has having non-compliant
>> BARs.
> 
> By convention, I use 12-char SHA1 ("[core] abbrev=12" in .git/config)
> when citing commits.
> 
>> Before commit b894157,
>>
>> pci 0000:ff:12.0: BAR 2: failed to assign [mem size 0x00000040]
>> pci 0000:ff:12.0: BAR 4: failed to assign [mem size 0x00000040]
>> pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
>> pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
>> pci 0000:ff:12.0: BAR 1: failed to assign [mem size 0x00000010]
>> pci 0000:ff:12.0: BAR 3: failed to assign [mem size 0x00000010]
>> pci 0000:ff:12.0: BAR 5: failed to assign [mem size 0x00000010]
>> pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
>> pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
>> pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
>> pci 0000:7f:12.0: BAR 2: failed to assign [mem size 0x00000040]
>> pci 0000:7f:12.0: BAR 4: failed to assign [mem size 0x00000040]
>> pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
>> pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
>> pci 0000:7f:12.0: BAR 1: failed to assign [mem size 0x00000010]
>> pci 0000:7f:12.0: BAR 3: failed to assign [mem size 0x00000010]
>> pci 0000:7f:12.0: BAR 5: failed to assign [mem size 0x00000010]
>> pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
>> pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
>> pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]
>>
>> After commit b894157, there are still "failed to assign" messages,
>> as well as new "failed to assign" messages for ff:12.0, ff:1e.3,
>> 7f:12.0, and 7f:1e.3.
>>
>>  pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
>>  pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
>>  pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
>>  pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
>>  pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
>>  pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>>  pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
>>  pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
>>  pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
>>  pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
>>  pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
>>  pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]
>>  pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>>  pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
>>
>> There are two issues with commit b894157.
>>
>> The first is that there is another device, Home Agent 1 & PCU, that must
>> also be quirked in the same way.
>>
>> \# lspci -n -s 7f:12.4
>> 7f:12.4 0880: 8086:6f60 (rev 01)
> 
> I think we should split this into two patches: one to add quirks for
> the Home Agent 1 & PCU, and a second for the resource assignment
> issue.
> 
> Can you dig up a spec for these devices?  I should have asked Andi for
> that the first time around, but I didn't.  Maybe there's something
> we're not interpreting correctly.  I still have a hard time believing
> that Intel would produce a PCI device with non-BAR registers where the
> BARs are supposed to be.  Maybe there's supposed to be an EA
> capability or something that tells us to ignore these registers.

It looks like Andi has provided this information in his reply.  I will add some
of that info in my next post.

> 
> Can you collect "lspci -vvxxx" output for one of these devices?

# lspci -xxxvv -s 7f:12.4
7f:12.4 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3
v4/Xeon D Home Agent 1 (rev 01)
        Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D
Home Agent 1
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
00: 86 80 60 6f 00 00 00 00 01 00 80 08 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 60 6f
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 04 f5 01 00 04 f5 21 00 00 f0 21 00 00 f0 21 00
50: 00 f0 21 00 00 f0 21 00 00 f0 21 00 00 f0 21 00
60: 00 f0 21 00 00 f0 21 00 00 f0 21 00 00 f0 21 00
70: 00 00 02 00 00 00 00 00 00 00 88 44 04 00 00 00
80: 02 82 30 03 88 4a 61 40 00 00 00 00 00 00 00 00
90: 00 00 02 00 00 00 01 00 5c 00 00 00 18 00 00 00
a0: 00 00 00 00 93 97 15 00 0d 34 90 00 00 30 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 0c 00 00 00
c0: 00 00 00 00 00 00 00 00 2d 2d 00 00 f8 e3 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


> 
>> After applying the quirk patch, we end up with:
>>
>> pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>> pci 0000:ff:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
>> pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
>> pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>> pci 0000:7f:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
>> pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
>>
>> which drives us to the second issue.  Since the PCI devices now
>> have unnassigned resources (BARs), pcibios_assign_resources()
>> call pci_assign_unassigned_root_bus_resources().  This results in the
>> messages above.  I have added a non_compliant_bars check in
>> pbus_assign_resources_sorted() to avoid the unassigned device's resources
>> from being added to the failed resources list for the bus.
> 
> I don't understand this part yet.  If we mark a device with
> non_compliant_bars, __pci_read_base() will return without doing
> anything, so we should not fill in the struct resource at all.  It
> wouldn't have the "mem" or "pref" bits shown above, and it shouldn't
> participate in pcibios_assign_resources() at all.  All of these are
> for BAR 6 (the ROM BAR), so maybe there's something wrong with the way
> to handle that in particular.

I did some additional debugging after reading your comment.  I dumped out the
contents of the resources for each bus's devices.  I concentrated on one
particular device, 7f:12.4 (the output of lspci is above).

Before the call to pcibios_assign_resources(), 7f:12.4 has

pci 0000:7f:12.4: PRARIT:    BAR 6: [mem 0x00000000 pref]

so that means it the resource was not changed/modified in the call of
pcibios_assign_resources().

I took a closer look at the code, and I think I know what the issue is.  In
pci_read_bases() the code does

        if (rom) {
                struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
                dev->rom_base_reg = rom;
                res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
                                IORESOURCE_READONLY | IORESOURCE_CACHEABLE |
                                IORESOURCE_SIZEALIGN;
                __pci_read_base(dev, pci_bar_mem32, res, rom);
        }

which initializes the res->flags field.  This field is later checked in
pcibios_allocate_dev_rom_resource() which is called from
pcibios_assign_resources(), and the resource is declared unassigned because it
has a res->flags field.

Perhaps (sorry for the cut-and-paste) this is a more correct fix which would
avoid the setting of res->flags?  There is no point in setting
dev->rom_base_reg, etc., if this is a non-compliant device.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2384100..818731a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -361,7 +361,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int
                pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
        }

-       if (rom) {
+       if (rom && !dev->non_compliant_bars) {
                struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
                dev->rom_base_reg = rom;
                res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |

P.
