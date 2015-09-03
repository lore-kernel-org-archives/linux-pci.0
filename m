Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33670 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbICKal (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2015 06:30:41 -0400
Received: by paddd1 with SMTP id dd1so4193017pad.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 03:30:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAa04yGKMenAABLfqUu++OCsV+4eOxxnA6YJMjOokBCamy1t5w@mail.gmail.com>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
	<20150902174716.GA6305@red-moon>
	<20150902203250.GB829@google.com>
	<CAAa04yGKMenAABLfqUu++OCsV+4eOxxnA6YJMjOokBCamy1t5w@mail.gmail.com>
Date: Thu, 3 Sep 2015 12:30:40 +0200
Message-ID: <CAAa04yFa5aP1F+oykR_wMXFfwHDCm_JcMDN_bnOCqfB6hNgonA@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: oe5hpm <oe5hpm@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"CC: Ralf Baechle" <ralf@linux-mips.org>,
	"CC: James E.J. Bottomley" <jejb@parisc-linux.org>,
	"CC: Michael Ellerman" <mpe@ellerman.id.au>,
	"CC: Richard Henderson" <rth@twiddle.net>,
	"CC: Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"CC: David Howells" <dhowells@redhat.com>,
	"CC: Russell King" <linux@arm.linux.org.uk>,
	"CC: Tony Luck" <tony.luck@intel.com>,
	"CC: David S. Miller" <davem@davemloft.net>,
	"CC: Ingo Molnar" <mingo@redhat.com>,
	"CC: Guenter Roeck" <linux@roeck-us.net>,
	"CC: Michal Simek" <monstr@monstr.eu>,
	"CC: Chris Zankel" <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

i've tested the patch supplied by Lorenzo yesterday.
Everything works well now.

Here is my kernel-printout:

[    0.432211] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.432238] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    0.432258] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.432281] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.432302] pci_bus 0000:00: scanning bus
[    0.432443] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.432526] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.432573] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.432649] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x48
[    0.432789] pci 0000:00:00.0: supports D1
[    0.432806] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.432876] pci 0000:00:00.0: PME# disabled
[    0.433513] pci_bus 0000:00: fixups for bus
[    0.433547] PCI: bus0: Fast back to back transfers disabled
[    0.433570] pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
[    0.433604] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    0.433914] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.433942] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    0.433965] pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01ffffff]
[    0.433989] pci 0000:00:00.0:   bridge window [mem
0x00000000-0x000fffff pref]
[    0.434004] pci_bus 0000:01: scanning bus
[    0.434129] pci 0000:01:00.0: [1677:affe] type 00 class 0x088030
[    0.434326] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.434390] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x00003fff]
[    0.434450] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x001fffff]
[    0.434698] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x48
[    0.435397] pci_bus 0000:01: fixups for bus
[    0.435460] pci 0000:00:00.0: can't claim BAR 7 [io
0x0000-0x0fff]: no compatible bridge window
[    0.435479] pci 0000:00:00.0: can't claim BAR 8 [mem
0x01000000-0x01ffffff]: no compatible bridge window
[    0.435497] pci 0000:00:00.0: can't claim BAR 9 [mem
0x00000000-0x000fffff pref]: no compatible bridge window

[    0.436128] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.436153] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff]

don't worry about the increased size of
pci 0000:01:00.0: BAR 0: assigned [mem 0x01104000-0x01104fff]
in between I've changed my FPGA device.

best regards,
Hannes


On Thu, Sep 3, 2015 at 12:03 PM, oe5hpm <oe5hpm@gmail.com> wrote:
> hi bjorn, Lorenzo,
>
> should i do some testing with patch from yesterday?
> please let me know if can test anything.
>
> best regards,
> Hannes
>
>
> On Wed, Sep 2, 2015 at 10:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Hi Lorenzo, thanks for jumping on this!
>>
>> On Wed, Sep 02, 2015 at 06:47:16PM +0100, Lorenzo Pieralisi wrote:
>>> Hi Hannes,
>>>
>>> On Wed, Sep 02, 2015 at 10:51:18AM +0100, oe5hpm wrote:
>>> > Hi Lorenzo,
>>> >
>>> > today i tried to boot up the most recent vanilla kernel on my
>>> > Freescale i.mx6 board.
>>> > I ran into trouble regarding PCI enumeration.
>>> >
>>> > [    0.431949] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>>> > [    0.431976] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>>> > [    0.431996] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
>>> > [    0.432022] pci_bus 0000:00: root bus resource [bus 00-ff]
>>> > [    0.433271] PCI: bus0: Fast back to back transfers disabled
>>> > [    0.433629] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>>> > [    0.435181] PCI: bus1: Fast back to back transfers disabled
>>> > [    0.435564] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
>>> > [    0.435593] pci 0000:00:00.0: BAR 8: no space for [mem size 0x01000000]
>>> > [    0.435613] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x01000000]
>>> > [    0.435635] pci 0000:00:00.0: BAR 9: assigned [mem
>>> > 0x01100000-0x011fffff pref]
>>> > [    0.435655] pci 0000:00:00.0: BAR 6: assigned [mem
>>> > 0x01200000-0x0120ffff pref]
>>> > [    0.435676] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
>>> > [    0.435705] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00200000]
>>> > [    0.435722] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
>>> > [    0.435739] pci 0000:01:00.0: BAR 1: no space for [mem size 0x00004000]
>>> > [    0.435754] pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
>>> > [    0.435770] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00000100]
>>> > [    0.435786] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
>>> > [    0.435804] pci 0000:00:00.0: PCI bridge to [bus 01]
>>> > [    0.435826] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>>> > [    0.435855] pci 0000:00:00.0:   bridge window [mem
>>> > 0x01100000-0x011fffff pref]
>>> >
>>> > there are several fails assigning memory ressources to pci-devices.
>>> >
>>> > i bisect down this trouble to commit id:
>>> > dff22d2054b5dbb1889f20c03959dd0c494fab8c : PCI: Call
>>> > pci_read_bridge_bases() from core instead of arch code
>>> >
>>> > For testing purpose i've reverted this commit on a local branch and
>>> > everythings works fine, as before.
>>> >
>>> > [    0.431976] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>>> > [    0.432004] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>>> > [    0.432023] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
>>> > [    0.432047] pci_bus 0000:00: root bus resource [bus 00-ff]
>>> > [    0.433302] PCI: bus0: Fast back to back transfers disabled
>>> > [    0.435122] PCI: bus1: Fast back to back transfers disabled
>>> > [    0.435504] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
>>> > [    0.435535] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff]
>>> > [    0.435557] pci 0000:00:00.0: BAR 6: assigned [mem
>>> > 0x01400000-0x0140ffff pref]
>>> > [    0.435585] pci 0000:01:00.0: BAR 2: assigned [mem 0x01200000-0x013fffff]
>>> > [    0.435626] pci 0000:01:00.0: BAR 1: assigned [mem 0x01100000-0x01103fff]
>>> > [    0.435665] pci 0000:01:00.0: BAR 0: assigned [mem 0x01104000-0x011040ff]
>>> > [    0.435703] pci 0000:00:00.0: PCI bridge to [bus 01]
>>> > [    0.435728] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff]
>>> >
>>> > Further i can break down the failure to "drivers/pci/probe.c" line #924.
>>> > If i comment out the "pci_read_bridge_bases(child);" also everything works well.
>>> >
>>> > I have to confess, that my knowledge about the whole PCI thing in the
>>> > kernel is not very deep, so it is not possible for me to figure out
>>> > what is going wrong.
>>>
>>> It looks like a bogus bridge aperture size is causing this to happen,
>>> and this prevents reassignment on arm (bridge aperture is too big),
>>> which proves that reading the bridge bases without vetting the corresponding
>>> resources may break (on platforms that were not reading them before).
>>>
>>> arm was the only platform not reading the bridge bases, here is an
>>> answer why. So, to prevent reverting the commit I put together this
>>> patch (to be reworked if we deem it reasonable), subject to discussion
>>> (I fear it may end up breaking other arm platforms, I do not have all
>>> ARM boards and required host controllers to test, I managed to test it on
>>> an iMX6 Sabrelite though).
>>>
>>> Here, please let me know if it works for you, I will keep on thinking
>>> to find the best solution.
>>>
>>> I will have to do this for arm64 too, comments very welcome.
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>> -- >8 --
>>> Subject: [PATCH] arm: kernel: pci: fixup erroneous PCI bridge apertures
>>>
>>> Bridge apertures read by core PCI code through pci_read_bridge_bases()
>>> might be erroneous (bogus platform setup). If the arch code does not vet
>>> the bridge resources (ie by trying to claim them), we can end up in a
>>> situation where wrong bridge apertures can prevent resources assignment
>>> for downstream devices causing enumeration failures (eg a bridge
>>> aperture does not fit in the respective host controller resource window,
>>> so it can't be assigned).
>>>
>>> This patch adds arm arch code that vets bridge resources by trying
>>> to claim them, and reset them on claiming failure so that they can
>>> be properly reassigned.
>>
>> We definitely should not depend on the platform to set up the bridge
>> windows.  Do we know what the platform left in the 00:00.0 window
>> registers?
>>
>> I see that bus 01 requires 0x204100 of mem space, which must be
>> rounded up to a megabyte boundary, so the window must be at least 3M
>> (0x00300000):
>>
>>   pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
>>   pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
>>   pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
>>
>> I don't understand the connection with dff22d2054b5 yet.  If we don't
>> call pci_read_bridge_bases(), apparently some assign-resources path
>> figures out the required size and assigns a 3M window.
>>
>> If we *do* call pci_read_bridge_bases(), do we read a bogus 16M window
>> size, fail to assign that because the host controller window isn't big
>> enough, and then the assign-resources path just gives up?  I assume
>> clearing r->flags in your patch is the critical thing?  Is there
>> something in assign-resources that checks for r->flags == 0?
>>
>> I think it would be ideal if we could someday claim the resource
>> immediately, as soon as we read it from a BAR or bridge window, and
>> mark it as IORESOURCE_UNSET if claiming it fails.  Then if the
>> platform set up reasonable windows, we could use them; if it didn't,
>> we could just assign our own.
>>
>> I'd like to avoid adding things to pcibios_fixup_bus() if possible
>> because most of what is done there is arch-independent, and I'd like
>> to get the arch-independent stuff into the PCI core.
>>
>> Bjorn
>>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> ---
>>>  arch/arm/kernel/bios32.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
>>> index 874e182..ebbe052 100644
>>> --- a/arch/arm/kernel/bios32.c
>>> +++ b/arch/arm/kernel/bios32.c
>>> @@ -282,6 +282,27 @@ static inline int pdev_bad_for_parity(struct pci_dev *dev)
>>>
>>>  }
>>>
>>> +static void pcibios_fixup_bridge_resources(struct pci_dev *dev)
>>> +{
>>> +     int idx;
>>> +
>>> +     if (!dev->bus)
>>> +             return;
>>> +
>>> +     for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
>>> +             struct resource *r = &dev->resource[idx];
>>> +
>>> +             if (!r->flags || r->parent)
>>> +                     continue;
>>> +
>>> +             if (pci_claim_resource(dev, idx)) {
>>> +                     r->flags = 0;
>>> +                     r->start = 0;
>>> +                     r->end = -1;
>>> +             }
>>> +     }
>>> +}
>>> +
>>>  /*
>>>   * pcibios_fixup_bus - Called after each bus is probed,
>>>   * but before its children are examined.
>>> @@ -352,6 +373,9 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>>>                       bus->bridge_ctl |= PCI_BRIDGE_CTL_PARITY;
>>>       }
>>>
>>> +     if (bus->self)
>>> +             pcibios_fixup_bridge_resources(bus->self);
>>> +
>>>       /*
>>>        * Report what we did for this bus
>>>        */
>>> --
>>> 1.9.1
>>>
>>>
