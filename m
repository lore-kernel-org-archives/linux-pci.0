Return-Path: <SRS0=uAeL=2K=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=uAeL=2K=arm.com=marc.zyngier@kernel.org>
Subject: Re: Using the generic host PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>, Mason <slash.tmp@free.fr>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>, David Daney <david.daney@cavium.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <01f41dd8-e8e6-f880-cad8-5cb83bf0a167@arm.com>
Date: Wed, 1 Mar 2017 16:36:41 +0000
MIME-Version: 1.0
In-Reply-To: <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 01/03/17 16:18, Bjorn Helgaas wrote:
> [+cc Marc for MSI]
> 
> On Wed, Mar 01, 2017 at 04:18:51PM +0100, Mason wrote:
>> On 27/02/2017 19:35, Bjorn Helgaas wrote:
>>
>>> When I said the native drivers provide no real benefit, I meant that
>>> they do not provide any value-add functionality beyond what a generic
>>> driver like drivers/acpi/pci_root.c already does.
>>>
>>> Obviously there are many different host bridges and they have
>>> different programming models, so there has to be bridge-specific
>>> support *somewhere*.  The question is whether that's in firmware, in
>>> Linux, or both.  For ACPI systems, it's all in firmware.
>>>
>>> Systems with well-behaved hardware, i.e., it supports PCIe and ECAM
>>> without warts, firmware can initialize the bridge and tell the OS
>>> about it via DT, and the drivers/pci/pci-host-generic.c driver can do
>>> everything else.
>>>
>>> For systems that aren't so well-behaved, we'll need either a full
>>> native driver that knows how to program bridge window CSRs, set up
>>> interrupts, etc., or a simpler native driver that papers over warts
>>> like ECAM that doesn't work quite according to spec.
>>>
>>> It sounds like your system falls into the latter category.
>>
>> Hello Bjorn,
>>
>> Having worked around 3 HW bugs, things are starting to look
>> slightly more "normal". Here is my current boot log:
>> (I've added a few questions inline.)
> 
> Sounds like you're making good progress!
> 
>> [    0.197669] PCI: CLS 0 bytes, default 64
>>
>> Is it an error for Cache Line Size to be 0 here?
> 
> Not a problem.  I think your host bridge is to PCIe, and Cache Line
> Size is not relevant for PCIe.  We should clean this up in the PCI
> core someday.
> 
>> [    0.652356] OF: PCI: host bridge /soc/pcie@50000000 ranges:
>> [    0.652380] OF: PCI:   No bus range found for /soc/pcie@50000000, using [bus 00-ff]
>> [    0.652407] OF: PCI: Parsing ranges property...
>> [    0.652494] OF: PCI:   MEM 0xa0000000..0xa03fffff -> 0xa0000000
>> [    0.655744] pci-host-generic 50000000.pcie: ECAM at [mem 0x50000000-0x5fffffff] for [bus 00-ff]
>> [    0.656097] pci-host-generic 50000000.pcie: PCI host bridge to bus 0000:00
>> [    0.656145] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.656168] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xa03fffff]
>> [    0.656191] pci_bus 0000:00: scanning bus
>> [    0.656257] pci 0000:00:00.0: [1105:8758] type 01 class 0x048000
>> [    0.656314] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
>> [    0.656358] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
>> [    0.656400] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
>> [    0.656451] pci 0000:00:00.0: supports D1 D2
>> [    0.656468] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
>> [    0.656486] pci 0000:00:00.0: PME# disabled
>> [    0.656657] pci_bus 0000:00: fixups for bus
>> [    0.656686] PCI: bus0: Fast back to back transfers disabled
> 
> FWIW, back-to-back transfers is also irrelevant on PCIe.  Another
> useless historical artifact.
> 
>> [    0.656707] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
>> [    0.656725] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.656753] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
>> [    0.656845] pci_bus 0000:01: scanning bus
>> [    0.656911] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
>> [    0.656968] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>> [    0.657065] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
>> [    0.657192] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [    0.657213] pci 0000:01:00.0: PME# disabled
>> [    0.657495] pci_bus 0000:01: fixups for bus
>> [    0.657521] PCI: bus1: Fast back to back transfers disabled
>> [    0.657538] pci_bus 0000:01: bus scan returning with max=01
>> [    0.657556] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> [    0.657575] pci_bus 0000:00: bus scan returning with max=01
>> [    0.657593] pci 0000:00:00.0: fixup irq: got 0
>> [    0.657608] pci 0000:00:00.0: assigning IRQ 00
>> [    0.657651] pci 0000:01:00.0: fixup irq: got 20
>> [    0.657667] pci 0000:01:00.0: assigning IRQ 20
>>
>> This revision of the controller does not support legacy interrupt mode,
>> only MSI. I looked at the bindings for MSI:
>>
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-msi.txt
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/msi.txt
>>
>> But it is not clear to me if I need to write a specific driver
>> for the MSI controller, or if there is some kind of generic
>> support? If the latter, what are the required properties?
>> A "door-bell" address? Anything else?
> 
> I added Marc in case he has advice here.  My only advice would be to look
> at other drivers and see how they did it.  I'm pretty sure MSI isn't
> going to work unless your platform has some way to set the MSI
> addresses, whether this is some arch-specific thing or something in
> the host bridge.

Thanks Bjorn.

Mason: while the kernel has generic support for dealing with MSI, there
is not standardization at the interrupt controller level, so you do have
to write your own driver, and wire it in the rest of the framework.

I suggest you look at things like drivers/pci/host/pcie-altera-msi.c,
which has an extremely simple implementation. You can use this as a
starting point for your own driver.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
