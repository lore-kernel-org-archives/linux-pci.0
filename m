Return-Path: <SRS0=6Mcr=2M=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=6Mcr=2M=free.fr=slash.tmp@kernel.org>
Subject: Re: Using the generic host PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>, David Daney <david.daney@cavium.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
 <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
 <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
 <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
 <8e1a0b5d-8dfb-4be1-a049-b16892a6c0d0@free.fr>
 <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <5c899946-4220-a63e-fe98-6a103200c2ad@free.fr>
Date: Sat, 4 Mar 2017 00:23:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 03/03/2017 21:04, Bjorn Helgaas wrote:
> On Fri, Mar 03, 2017 at 06:18:02PM +0100, Mason wrote:
>> On 03/03/2017 16:46, Bjorn Helgaas wrote:
>>> On Fri, Mar 03, 2017 at 01:44:54PM +0100, Mason wrote:
>>>
>>>> For now, I have "hidden" the root's BAR0 from the system with:
>>>>
>>>> 	if (bus->number == 0 && where == PCI_BASE_ADDRESS_0) {
>>>> 		*val = 0;
>>>> 		return PCIBIOS_SUCCESSFUL;
>>>> 	}
>>>
>>> I'm scratching my head about this a little.  Here's what your dmesg
>>> log contained originally:
>>>
>>>   pci 0000:00:00.0: [1105:8758] type 01 class 0x048000
>>>   pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
>>>   pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
>>>   pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
>>>   pci 0000:00:00.0: PCI bridge to [bus 01]
>>>   pcieport 0000:00:00.0: enabling device (0140 -> 0142)
>>>
>>> This device is a bridge (a Root Port, per your lspci output).  With a
>>> BAR, which is legal but unusual.  We couldn't assign space for the
>>> BAR, which means we can't use whatever vendor-specific functionality
>>> it provides.
>>
>> I had several chats with the HW designer. I'll try to explain, only as
>> far as I could understand ;-)
>>
>> We used to make devices, before implementing a root. Since at least
>> one BAR is required (?) for a device, it was decided to have one BAR
>> for the root, for symmetry.
> 
> I'm not aware of a spec requirement for any BARs.  It's conceivable
> that one could build a device that only uses config space.  And of
> course, most bridges have windows but no BARs.  But that doesn't
> matter; the hardware is what it is and we have to deal with it.

I appreciate the compassion. RMK considered the DMA HW too screwy
to bother supporting ;-)

>> In fact, I thought I could ignore that BAR, but it is apparently NOT
>> the case, as MSIs are supposed to be sent *within* the BAR of the root.
> 
> I don't know much about this piece of the MSI puzzle, but maybe Marc
> can enlighten us.  If this Root Port is the target of MSIs and the
> Root Port turns them into some sort of interrupt on the CPU side, I
> can see how this might make sense.
> 
> I think it's unusual for the PCI core to assign the MSI target using a
> BAR, though.  I think this means you'll have to implement your
> arch_setup_msi_irq() or .irq_compose_msi_msg() method such that it 
> looks up that BAR value, since you won't know it at build-time.

I'll hack the Altera driver to fit my purpose.

>> The weird twist is that the BAR advertizes a 64-bit memory zone,
>> but we will, in fact, map MMIO registers behind it. So all the
>> RAM Linux assigns to the area is wasted, IIUC.
> 
> I'm not sure what this means.  You have this:
> 
>> OF: PCI:   MEM 0x90000000..0x9fffffff -> 0x90000000

This means I've put 256 MB of system RAM aside for PCIe devices.
This memory is no longer available for Linux "stuff".

>> pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]

I suppose this is the PCI bus address. As we've discussed,
I used the identity to map bus <-> CPU addresses.

> This [mem 0x90000000-0x9fffffff] host bridge window means there can't
> be RAM in that region.  CPU accesses to 0x90000000-0x9fffffff have to
> be claimed by the host bridge and forwarded to PCI.
> 
> Linux doesn't "assign system RAM" anywhere; we just learn somehow
> where that RAM is.  Linux *does* assign BARs of PCI devices, and they
> have to be inside the host bridge windows(s).

I'm confused, I thought I had understood that part...
I thought the binding required me to specify (in the "ranges"
property) a non-prefetchable zone of system RAM, and this
memory is then "handed out" by Linux to different devices.
Or do I just need to specify some address range that's not
necessarily backed with actual RAM?

> The BARs may contain registers, RAM, frame buffers, etc., that live
> on the PCI device.  It's totally up to the device what it is.
> 
>> OF: PCI: host bridge /soc/pcie@50000000 ranges:
>> OF: PCI:   No bus range found for /soc/pcie@50000000, using [bus 00-ff]
> 
> Tangent: the lack of a bus range is a defect in your DTS.

What range should I specify? 0-1? 0-2? 0-255?

>> [    1.042737] pci_bus 0000:00: scanning bus
>> [    1.046895] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
>> [    1.053050] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
>> [    1.059639] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
>> [    1.066583] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
>> [    1.072929] pci 0000:00:00.0: supports D1 D2
>> [    1.077318] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
>> [    1.083452] pci 0000:00:00.0: PME# disabled
>> [    1.087901] pci_bus 0000:00: fixups for bus
>> [    1.092212] PCI: bus0: Fast back to back transfers disabled
>> [    1.097913] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
>> [    1.104746] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    1.112893] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
>> [    1.119800] pci_bus 0000:01: scanning bus
>> [    1.123972] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
>> [    1.130144] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>> [    1.137147] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
>> [    1.143577] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [    1.149801] pci 0000:01:00.0: PME# disabled
>> [    1.154364] pci_bus 0000:01: fixups for bus
>> [    1.158671] PCI: bus1: Fast back to back transfers disabled
>> [    1.164368] pci_bus 0000:01: bus scan returning with max=01
>> [    1.170067] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> [    1.176814] pci_bus 0000:00: bus scan returning with max=01
>> [    1.182511] pci 0000:00:00.0: fixup irq: got 0
>> [    1.187072] pci 0000:00:00.0: assigning IRQ 00
>> [    1.191658] pci 0000:01:00.0: fixup irq: got 20
>> [    1.196307] pci 0000:01:00.0: assigning IRQ 20
>> [    1.200892] pci 0000:00:00.0: BAR 0: assigned [mem 0x90000000-0x90ffffff 64bit]
>> [    1.208344] pci 0000:00:00.0: BAR 8: assigned [mem 0x91000000-0x910fffff]
>> [    1.215267] pci 0000:01:00.0: BAR 0: assigned [mem 0x91000000-0x91001fff 64bit]
>> [    1.222726] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    1.227812] pci 0000:00:00.0:   bridge window [mem 0x91000000-0x910fffff]
>> [    1.234781] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
>> [    1.241013] pcieport 0000:00:00.0: enabling bus mastering
>> [    1.246634] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
>> [    1.253389] pci 0000:01:00.0: enabling device (0140 -> 0142)
>> [    1.275215] pci 0000:01:00.0: xHCI HW did not halt within 16000 usec status = 0xd2f4167e
>>
>> # /usr/sbin/lspci -v
>> 00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
>>         Flags: bus master, fast devsel, latency 0
>>         Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>         I/O behind bridge: 00000000-00000fff
> 
> Something's wrong with this.  You have no I/O windows through the host
> bridge, which implies that you can't generic PCI I/O transactions, so
> this I/O window should be disabled.  This might be an lspci issue;
> what does "lspci -xxx" show?

I'll look on Monday. But I know that this revision of the controller
does not support any I/O areas. I don't know why Linux sees this.
Might be a bug in the controller, or a missing init in my code.

>>         Memory behind bridge: 91000000-910fffff
>>         Prefetchable memory behind bridge: 00000000-000fffff
> 
> This prefetchable memory window is bogus, too.  It should probably be
> disabled.  If the bridge doesn't support a prefetchable window, the
> base and limit should be hardwired to zero.  If it supports a window
> but it's disabled, the limit should be less than the base.  For
> example, on my system I see this for a bridge with the window
> disabled:
> 
>   # setpci -s00:1c.0 PREF_MEMORY_BASE
>   fff1
>   # setpci -s00:1c.0 PREF_MEMORY_LIMIT
>   0001

OK, one more thing for me to check. Thanks for your thoroughness.

Regards.
