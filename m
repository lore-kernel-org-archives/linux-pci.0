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
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
 <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
 <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
 <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <8e1a0b5d-8dfb-4be1-a049-b16892a6c0d0@free.fr>
Date: Fri, 3 Mar 2017 18:18:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 03/03/2017 16:46, Bjorn Helgaas wrote:

> On Fri, Mar 03, 2017 at 01:44:54PM +0100, Mason wrote:
>
>> For now, I have "hidden" the root's BAR0 from the system with:
>>
>> 	if (bus->number == 0 && where == PCI_BASE_ADDRESS_0) {
>> 		*val = 0;
>> 		return PCIBIOS_SUCCESSFUL;
>> 	}
> 
> I'm scratching my head about this a little.  Here's what your dmesg
> log contained originally:
> 
>   pci 0000:00:00.0: [1105:8758] type 01 class 0x048000
>   pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
>   pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
>   pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
>   pci 0000:00:00.0: PCI bridge to [bus 01]
>   pcieport 0000:00:00.0: enabling device (0140 -> 0142)
> 
> This device is a bridge (a Root Port, per your lspci output).  With a
> BAR, which is legal but unusual.  We couldn't assign space for the
> BAR, which means we can't use whatever vendor-specific functionality
> it provides.

I had several chats with the HW designer. I'll try to explain, only as
far as I could understand ;-)

We used to make devices, before implementing a root. Since at least
one BAR is required (?) for a device, it was decided to have one BAR
for the root, for symmetry.

In fact, I thought I could ignore that BAR, but it is apparently NOT
the case, as MSIs are supposed to be sent *within* the BAR of the root.
So I have removed my kludge hiding the BAR.

The weird twist is that the BAR advertizes a 64-bit memory zone,
but we will, in fact, map MMIO registers behind it. So all the
RAM Linux assigns to the area is wasted, IIUC.

Did the above make sense?

[    0.986762] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    0.992478] OF: PCI:   No bus range found for /soc/pcie@50000000, using [bus 00-ff]
[    1.000279] OF: PCI: Parsing ranges property...
[    1.004938] OF: PCI:   MEM 0x90000000..0x9fffffff -> 0x90000000
[    1.014047] pci-host-generic 50000000.pcie: ECAM at [mem 0x50000000-0x5fffffff] for [bus 00-ff]
[    1.023088] pci-host-generic 50000000.pcie: PCI host bridge to bus 0000:00
[    1.030112] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.035729] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]
[    1.042737] pci_bus 0000:00: scanning bus
[    1.046895] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
[    1.053050] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
[    1.059639] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
[    1.066583] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.072929] pci 0000:00:00.0: supports D1 D2
[    1.077318] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.083452] pci 0000:00:00.0: PME# disabled
[    1.087901] pci_bus 0000:00: fixups for bus
[    1.092212] PCI: bus0: Fast back to back transfers disabled
[    1.097913] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    1.104746] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.112893] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    1.119800] pci_bus 0000:01: scanning bus
[    1.123972] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.130144] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.137147] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.143577] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.149801] pci 0000:01:00.0: PME# disabled
[    1.154364] pci_bus 0000:01: fixups for bus
[    1.158671] PCI: bus1: Fast back to back transfers disabled
[    1.164368] pci_bus 0000:01: bus scan returning with max=01
[    1.170067] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.176814] pci_bus 0000:00: bus scan returning with max=01
[    1.182511] pci 0000:00:00.0: fixup irq: got 0
[    1.187072] pci 0000:00:00.0: assigning IRQ 00
[    1.191658] pci 0000:01:00.0: fixup irq: got 20
[    1.196307] pci 0000:01:00.0: assigning IRQ 20
[    1.200892] pci 0000:00:00.0: BAR 0: assigned [mem 0x90000000-0x90ffffff 64bit]
[    1.208344] pci 0000:00:00.0: BAR 8: assigned [mem 0x91000000-0x910fffff]
[    1.215267] pci 0000:01:00.0: BAR 0: assigned [mem 0x91000000-0x91001fff 64bit]
[    1.222726] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.227812] pci 0000:00:00.0:   bridge window [mem 0x91000000-0x910fffff]
[    1.234781] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    1.241013] pcieport 0000:00:00.0: enabling bus mastering
[    1.246634] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
[    1.253389] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    1.275215] pci 0000:01:00.0: xHCI HW did not halt within 16000 usec status = 0xd2f4167e

# /usr/sbin/lspci -v
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 91000000-910fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Flags: fast devsel, IRQ 20
        Memory at 91000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting


> What's puzzling me is that pcieport was able to enable the device and
> turn on PCI_COMMAND_MEMORY (the 0x2 bit).  It seems like this should
> have failed because pci_enable_resources() checks to see that all the
> BARs have been assigned.
> 
> Since this is a bridge, we really *have* to turn on PCI_COMMAND_MEMORY
> in order for the bridge to forward memory transactions to its
> secondary bus (bus 01).  But we can't safely enable PCI_COMMAND_MEMORY
> unless all its memory BARs are assigned.
> 
> So it's not safe to hide BAR0 from the PCI core.  That makes Linux
> think the BAR doesn't exist, but of course it still exists in the
> hardware itself, and it will respond at whatever address it happens to
> contain.  In this case, that address happens to be zero, and the host
> bridge does not advertise a window that maps to bus address zero, so
> you probably won't see a conflict right away, but it's a latent issue
> that may come back to bite you some day.

OK, no more hiding! :-)

> The easiest fix would be for you to increase the host bridge memory
> window size.  It's currently [mem 0xa0000000-0xa03fffff], which is
> only 4MB, which is *tiny*.  You need 16MB just to contain the bridge
> BAR, plus at least 8K for the USB controller.
> 
> If you can't make space for a bigger window, it's possible the Root
> Port has some device-specific way to disable BAR0 in hardware, e.g.,
> some register your firmware or an early Linux quirk could write.  That
> would be much safer than enabling an unassigned BAR.

Apparently, disabling BAR0 is not an option.

Regards.
