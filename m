Return-Path: <SRS0=crXP=2P=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=crXP=2P=free.fr=slash.tmp@kernel.org>
Subject: Re: Using the generic host PCIe driver
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Rob Herring <robh@kernel.org>, Phuong Nguyen
 <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>
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
 <267ec246-c32a-e0e2-b708-304a3dfb7342@free.fr>
Message-ID: <32cb911d-6446-2514-59a5-99aac9fd0821@free.fr>
Date: Mon, 6 Mar 2017 17:57:03 +0100
MIME-Version: 1.0
In-Reply-To: <267ec246-c32a-e0e2-b708-304a3dfb7342@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2017 17:12, Mason wrote:

> On 03/03/2017 21:04, Bjorn Helgaas wrote:
> 
>> On Fri, Mar 03, 2017 at 06:18:02PM +0100, Mason wrote:
>>
>>> # /usr/sbin/lspci -v
>>> 00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
>>>         Flags: bus master, fast devsel, latency 0
>>>         Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
>>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>         I/O behind bridge: 00000000-00000fff
>>
>> Something's wrong with this.  You have no I/O windows through the host
>> bridge, which implies that you can't generic PCI I/O transactions, so
>> this I/O window should be disabled.  This might be an lspci issue;
>> what does "lspci -xxx" show?
>>
>>>         Memory behind bridge: 91000000-910fffff
>>>         Prefetchable memory behind bridge: 00000000-000fffff
>>
>> This prefetchable memory window is bogus, too.  It should probably be
>> disabled.  If the bridge doesn't support a prefetchable window, the
>> base and limit should be hardwired to zero.  If it supports a window
>> but it's disabled, the limit should be less than the base.  For
>> example, on my system I see this for a bridge with the window
>> disabled:
>>
>>   # setpci -s00:1c.0 PREF_MEMORY_BASE
>>   fff1
>>   # setpci -s00:1c.0 PREF_MEMORY_LIMIT
>>   0001
> 
> MAJOR UPDATE: As pointed out by Ard, my DT was hopelessly wrong for
> the non-prefetchable memory region (in the ranges prop).
> 
> In fact, my platform *multiplexes* config and MEM spaces.
> 
> In other words, there are *two* overlapping 256 MB windows at CPU
> address 0x50000000. A register in MMIO space allows software to
> select either config space or MEM space.

I artificially cut each window in half (to 128 MB).

		pcie@50000000 {
			compatible = "sigma,foo";
			reg = <0x50000000 0x8000000>;
			device_type = "pci";
			bus-range = <0x0 0x7f>;
			#size-cells = <2>;
			#address-cells = <3>;
			#interrupt-cells = <1>;
			ranges = <0x02000000 0x0 0x8000000  0x58000000  0x0 0x8000000>;
		};

And my config space accessors set/reset the config_space bit on entry/exit.

[    0.986807] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    0.992524] OF: PCI: Parsing ranges property...
[    0.997185] OF: PCI:   MEM 0x58000000..0x5fffffff -> 0x08000000
[    1.004774] pci_tango 50000000.pcie: ECAM at [mem 0x50000000-0x57ffffff] for [bus 00-7f]
[    1.013256] pci_tango 50000000.pcie: PCI host bridge to bus 0000:00
[    1.019668] pci_bus 0000:00: root bus resource [bus 00-7f]
[    1.025285] pci_bus 0000:00: root bus resource [mem 0x58000000-0x5fffffff] (bus address [0x08000000-0x0fffffff])
[    1.035613] pci_bus 0000:00: scanning bus
[    1.039766] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
[    1.045918] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
[    1.052506] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
[    1.059452] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.065800] pci 0000:00:00.0: supports D1 D2
[    1.070188] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.076322] pci 0000:00:00.0: PME# disabled
[    1.080834] pci_bus 0000:00: fixups for bus
[    1.085142] PCI: bus0: Fast back to back transfers disabled
[    1.090843] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    1.097676] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.105822] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    1.112772] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-7f] (conflicts with (null) [bus 00-7f])

	I don't understand the above warning.

[    1.123718] pci_bus 0000:01: scanning bus
[    1.127887] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.134066] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.141071] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.147496] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.153722] pci 0000:01:00.0: PME# disabled
[    1.158335] pci_bus 0000:01: fixups for bus
[    1.162643] PCI: bus1: Fast back to back transfers disabled
[    1.168341] pci_bus 0000:01: bus scan returning with max=01
[    1.174039] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.180786] pci_bus 0000:00: bus scan returning with max=01
[    1.186484] pci 0000:00:00.0: fixup irq: got 0
[    1.191045] pci 0000:00:00.0: assigning IRQ 00
[    1.195631] pci 0000:01:00.0: fixup irq: got 20
[    1.200279] pci 0000:01:00.0: assigning IRQ 20
[    1.204868] pci 0000:00:00.0: BAR 0: assigned [mem 0x58000000-0x58ffffff 64bit]
[    1.212321] pci 0000:00:00.0: BAR 8: assigned [mem 0x59000000-0x590fffff]
[    1.219245] pci 0000:01:00.0: BAR 0: assigned [mem 0x59000000-0x59001fff 64bit]
[    1.226702] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.231789] pci 0000:00:00.0:   bridge window [mem 0x59000000-0x590fffff]
[    1.238758] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    1.244989] pcieport 0000:00:00.0: enabling bus mastering
[    1.250672] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x7e0
[    1.257430] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    1.263226] quirk_usb_handoff_xhci: ioremap(0x59000000, 8192)
[    1.269109] xhci_find_next_ext_cap: offset=0x500
[    1.273844] val = 0x1000401

This looks like a non-random value for XHCI_HCC_EXT_CAPS, but I'll have
to check the code and the standard tomorrow.

# /usr/sbin/lspci -v
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at 58000000 (64-bit, non-prefetchable) [size=16M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 09000000-090fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Flags: fast devsel, IRQ 20
        Memory at 59000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting

Hmmm, I still get the I/O and prefetchable mem behind bridge lines...
(I thought they'd disappear once I fixed the mem space bug.)

# /usr/sbin/lspci -xxx
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01)
00: 05 11 24 00 46 01 10 00 01 00 80 04 10 00 01 00
10: 04 00 00 08 00 00 00 00 00 01 01 00 00 00 00 00
20: 00 09 00 09 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 00 01 00
40: 00 00 00 00 60 61 15 02 00 00 00 00 00 00 00 00
50: 05 78 84 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 11 78 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 80 03 7e 08 60 00 64
80: 10 00 42 06 01 80 00 00 10 28 20 00 12 5c 21 01
90: 08 00 12 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03)
00: 12 19 14 00 42 01 10 00 03 30 03 0c 10 00 00 00
10: 04 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 14 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 70 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
60: 30 20 00 00 00 00 00 00 00 00 00 00 09 18 20 00
70: 05 90 86 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 11 a0 07 00 00 10 00 00 80 10 00 00 00 00 00 00
a0: 10 00 02 00 c0 8f 00 00 10 28 10 00 12 ec 07 00
b0: 00 00 12 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 10 08 00 00 00 00 00 00 00 00 00 00
d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 55 00 00 00 01 05 10 22 c2 00
f0: 00 05 00 00 00 00 00 80 00 00 00 00 00 00 00 00

Regards.
