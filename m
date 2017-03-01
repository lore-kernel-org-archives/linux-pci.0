Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 1 Mar 2017 10:18:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Using the generic host PCIe driver
Message-ID: <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
MIME-Version: 1.0
In-Reply-To: <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 David Daney <david.daney@cavium.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Will Deacon <will.deacon@arm.com>, Thierry Reding <treding@nvidia.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Marc for MSI]

On Wed, Mar 01, 2017 at 04:18:51PM +0100, Mason wrote:
> On 27/02/2017 19:35, Bjorn Helgaas wrote:
> 
> > When I said the native drivers provide no real benefit, I meant that
> > they do not provide any value-add functionality beyond what a generic
> > driver like drivers/acpi/pci_root.c already does.
> > 
> > Obviously there are many different host bridges and they have
> > different programming models, so there has to be bridge-specific
> > support *somewhere*.  The question is whether that's in firmware, in
> > Linux, or both.  For ACPI systems, it's all in firmware.
> > 
> > Systems with well-behaved hardware, i.e., it supports PCIe and ECAM
> > without warts, firmware can initialize the bridge and tell the OS
> > about it via DT, and the drivers/pci/pci-host-generic.c driver can do
> > everything else.
> > 
> > For systems that aren't so well-behaved, we'll need either a full
> > native driver that knows how to program bridge window CSRs, set up
> > interrupts, etc., or a simpler native driver that papers over warts
> > like ECAM that doesn't work quite according to spec.
> > 
> > It sounds like your system falls into the latter category.
> 
> Hello Bjorn,
> 
> Having worked around 3 HW bugs, things are starting to look
> slightly more "normal". Here is my current boot log:
> (I've added a few questions inline.)

Sounds like you're making good progress!

> [    0.197669] PCI: CLS 0 bytes, default 64
> 
> Is it an error for Cache Line Size to be 0 here?

Not a problem.  I think your host bridge is to PCIe, and Cache Line
Size is not relevant for PCIe.  We should clean this up in the PCI
core someday.

> [    0.652356] OF: PCI: host bridge /soc/pcie@50000000 ranges:
> [    0.652380] OF: PCI:   No bus range found for /soc/pcie@50000000, using [bus 00-ff]
> [    0.652407] OF: PCI: Parsing ranges property...
> [    0.652494] OF: PCI:   MEM 0xa0000000..0xa03fffff -> 0xa0000000
> [    0.655744] pci-host-generic 50000000.pcie: ECAM at [mem 0x50000000-0x5fffffff] for [bus 00-ff]
> [    0.656097] pci-host-generic 50000000.pcie: PCI host bridge to bus 0000:00
> [    0.656145] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.656168] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xa03fffff]
> [    0.656191] pci_bus 0000:00: scanning bus
> [    0.656257] pci 0000:00:00.0: [1105:8758] type 01 class 0x048000
> [    0.656314] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
> [    0.656358] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
> [    0.656400] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
> [    0.656451] pci 0000:00:00.0: supports D1 D2
> [    0.656468] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
> [    0.656486] pci 0000:00:00.0: PME# disabled
> [    0.656657] pci_bus 0000:00: fixups for bus
> [    0.656686] PCI: bus0: Fast back to back transfers disabled

FWIW, back-to-back transfers is also irrelevant on PCIe.  Another
useless historical artifact.

> [    0.656707] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
> [    0.656725] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    0.656753] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> [    0.656845] pci_bus 0000:01: scanning bus
> [    0.656911] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
> [    0.656968] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> [    0.657065] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
> [    0.657192] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    0.657213] pci 0000:01:00.0: PME# disabled
> [    0.657495] pci_bus 0000:01: fixups for bus
> [    0.657521] PCI: bus1: Fast back to back transfers disabled
> [    0.657538] pci_bus 0000:01: bus scan returning with max=01
> [    0.657556] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    0.657575] pci_bus 0000:00: bus scan returning with max=01
> [    0.657593] pci 0000:00:00.0: fixup irq: got 0
> [    0.657608] pci 0000:00:00.0: assigning IRQ 00
> [    0.657651] pci 0000:01:00.0: fixup irq: got 20
> [    0.657667] pci 0000:01:00.0: assigning IRQ 20
> 
> This revision of the controller does not support legacy interrupt mode,
> only MSI. I looked at the bindings for MSI:
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-msi.txt
> https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/msi.txt
> 
> But it is not clear to me if I need to write a specific driver
> for the MSI controller, or if there is some kind of generic
> support? If the latter, what are the required properties?
> A "door-bell" address? Anything else?

I added Marc in case he has advice here.  My only advice would be to look
at other drivers and see how they did it.  I'm pretty sure MSI isn't
going to work unless your platform has some way to set the MSI
addresses, whether this is some arch-specific thing or something in
the host bridge.

> [    0.657711] pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
> [    0.657731] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
> [    0.657755] pci 0000:00:00.0: BAR 8: assigned [mem 0xa0000000-0xa00fffff]
> [    0.657776] pci 0000:01:00.0: BAR 0: assigned [mem 0xa0000000-0xa0001fff 64bit]
> 
> These 4 statements sound fishy.

00:00.0 is a PCI-to-PCI bridge.  "BAR 8" is its memory window (as shown
below).  01:00.0 is below the bridge and is using part of the window.  That
part is normal.

00:00.0 also has a BAR of its own.  That's perfectly legal but slightly
unusual.  The device will still work fine as a generic PCI-to-PCI bridge
even though we didn't assign the BAR.

The BAR would contain device-specific stuff: maybe performance monitoring
or management interfaces.  Those things won't work because we didn't assign
space.  But even if we did assign space, they would require a special
driver to make them work, since they're device-specific and the PCI core
knows nothing about them.

Bottom line is that you can ignore the 00:00.0 BAR 0 assignment
failure.  It has nothing to do with getting other devices below the
bridge to work.

> [    0.657813] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.657831] pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa00fffff]
> [    0.657904] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
> [    0.657931] pcieport 0000:00:00.0: enabling bus mastering
> [    0.658058] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
> [    0.658088] pci 0000:01:00.0: enabling device (0140 -> 0142)
> [    0.663235] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) status = 0x1e7fffd0
> [    0.679283] pci 0000:01:00.0: xHCI HW did not halt within 16000 usec status = 0x1e7fffd0
> 
> The PCIe card is a USB3 adapter. I suppose it's not working
> because MSI is not properly configured.

Probably *some* sort of IRQ problem, whether it's INTx or MSI, I don't
know.

> # /usr/sbin/lspci -v
> 00:00.0 PCI bridge: Sigma Designs, Inc. Device 8758 (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Memory at <unassigned> (64-bit, non-prefetchable)
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00000000-00000fff
>         Memory behind bridge: a0000000-a00fffff
>         Prefetchable memory behind bridge: 00000000-000fffff
>         Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
>         Capabilities: [78] Power Management version 3
>         Capabilities: [80] Express Root Port (Slot-), MSI 03
>         Capabilities: [100] Virtual Channel
>         Capabilities: [800] Advanced Error Reporting
>         Kernel driver in use: pcieport
> 
> 01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
>         Flags: fast devsel, IRQ 20
>         Memory at a0000000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Capabilities: [90] MSI-X: Enable- Count=8 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [150] Latency Tolerance Reporting
> 
> 
> What does "Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+" mean?

If you have a copy of the PCI spec, you can match these up with bits
in the MSI Capability (PCI r3.0, sec 6.8.1.3).  Otherwise, take a look
at include/uapi/linux/pci_regs.h, where PCI_MSI_FLAGS_ENABLE, etc.,
are for the same bits.

The "[50]" part is the offset in config space of the capability
structure.  Since this is for the bridge (a Root Port in this case),
it's for PCIe interrupts like AER, power management, hotplug, etc.
This is unrelated to interrupts from devices below the bridge.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
