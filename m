Return-Path: <SRS0=q9Qe=ED=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=q9Qe=ED=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 8 Jan 2018 11:00:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] imx6: fix pcie enumeration
Message-ID: <20180108110015.GA32027@red-moon>
References: <20180104202430.GC189897@bhelgaas-glaptop.roam.corp.google.com>
 <a2d7afee-7a41-6da6-e5a4-a36a6fcde55d@ncentric.com>
 <20180105123206.GA24511@e107981-ln.cambridge.arm.com>
 <ebf30c78-b772-6214-f441-c86ae7fdba7e@ncentric.com>
 <20180105171828.GC24933@red-moon>
 <5bc70c34-45b2-5aed-eb06-f8ecfe859fd0@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5bc70c34-45b2-5aed-eb06-f8ecfe859fd0@ncentric.com>
List-ID: <linux-pci.vger.kernel.org>

[+cc Joao, Jingoo]

On Mon, Jan 08, 2018 at 09:51:37AM +0100, Koen Vandeputte wrote:

[...]

> [ Node 4 | node-4 ] lspci -v
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 298
>     Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
                                     ^^^^^^^^^^^^^^

So basically, the subordinate number in the root port does not
affect config space forwarding from what I see and it has always
been like that for dwc.

You are forced to update it to 0xff because otherwise the kernel
stops enumerating bus numbers > 1 but that's a software issue
not HW - the subordinate bus number does not seem to affect anything
here.

Sigh.

Another option would consist in forcing the kernel to reassign
all bus numbers by setting the PCI_REASSIGN_ALL_BUS flag but
that's not a good idea given how inconsistent that flag usage is.

I think that updating the subordinate bus numbers in the DWC
config register is the correct solution to make sure the kernel
won't get confused anymore by what seems to be a fake root port,
I need input from DWC maintainers to confirm my understanding.

Thanks,
Lorenzo

>     I/O behind bridge: None
>     Memory behind bridge: 01100000-012fffff [size=2M]
>     Prefetchable memory behind bridge: None
>     [virtual] Expansion ROM at 01300000 [disabled] [size=64K]
>     Capabilities: [40] Power Management version 3
>     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>     Capabilities: [70] Express Root Port (Slot-), MSI 00
>     Capabilities: [100] Advanced Error Reporting
>     Capabilities: [140] Virtual Channel
>     Kernel driver in use: pcieport
> lspci: Unable to load libkmod resources: error -12
> 
> 01:00.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal
> decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 298
>     Memory at 01200000 (32-bit, non-prefetchable) [size=128K]
>     Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
>     I/O behind bridge: None
>     Memory behind bridge: 01100000-011fffff [size=1M]
>     Prefetchable memory behind bridge: None
>     Capabilities: [40] Power Management version 3
>     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
>     Capabilities: [68] Express Upstream Port, MSI 00
>     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604
> 4-lane, 4-Port PCI Express Gen 2 (5.0 GT/s) Switch
>     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
>     Capabilities: [fb4] Advanced Error Reporting
>     Capabilities: [138] Power Budgeting <?>
>     Capabilities: [148] Virtual Channel
>     Capabilities: [448] Vendor Specific Information: ID=0000 Rev=0
> Len=0cc <?>
>     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
> Len=010 <?>
>     Kernel driver in use: pcieport
> 
> 02:01.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal
> decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 299
>     Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
>     I/O behind bridge: None
>     Memory behind bridge: None
>     Prefetchable memory behind bridge: None
>     Capabilities: [40] Power Management version 3
>     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
>     Capabilities: [68] Express Downstream Port (Slot+), MSI 00
>     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604
> 4-lane, 4-Port PCI Express Gen 2 (5.0 GT/s) Switch
>     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
>     Capabilities: [fb4] Advanced Error Reporting
>     Capabilities: [148] Virtual Channel
>     Capabilities: [520] Access Control Services
>     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
> Len=010 <?>
>     Kernel driver in use: pcieport
> 
> 02:04.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal
> decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 298
>     Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
>     I/O behind bridge: None
>     Memory behind bridge: None
>     Prefetchable memory behind bridge: None
>     Capabilities: [40] Power Management version 3
>     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
>     Capabilities: [68] Express Downstream Port (Slot+), MSI 00
>     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604
> 4-lane, 4-Port PCI Express Gen 2 (5.0 GT/s) Switch
>     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
>     Capabilities: [fb4] Advanced Error Reporting
>     Capabilities: [148] Virtual Channel
>     Capabilities: [520] Access Control Services
>     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
> Len=010 <?>
>     Kernel driver in use: pcieport
> 
> 02:05.0 PCI bridge: PLX Technology, Inc. PEX 8604 4-lane, 4-Port PCI
> Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal
> decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 299
>     Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
>     I/O behind bridge: None
>     Memory behind bridge: 01100000-011fffff [size=1M]
>     Prefetchable memory behind bridge: None
>     Capabilities: [40] Power Management version 3
>     Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
>     Capabilities: [68] Express Downstream Port (Slot+), MSI 00
>     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8604
> 4-lane, 4-Port PCI Express Gen 2 (5.0 GT/s) Switch
>     Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
>     Capabilities: [fb4] Advanced Error Reporting
>     Capabilities: [148] Virtual Channel
>     Capabilities: [520] Access Control Services
>     Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
> Len=010 <?>
>     Kernel driver in use: pcieport
> 
> 05:00.0 Network controller: Qualcomm Atheros AR958x 802.11abgn
> Wireless Network Adapter (rev 01)
>     Subsystem: Device 19b6:d016
>     Flags: bus master, fast devsel, latency 0, IRQ 299
>     Memory at 01100000 (64-bit, non-prefetchable) [size=128K]
>     [virtual] Expansion ROM at 01120000 [disabled] [size=64K]
>     Capabilities: [40] Power Management version 3
>     Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
>     Capabilities: [70] Express Endpoint, MSI 00
>     Capabilities: [100] Advanced Error Reporting
>     Capabilities: [140] Virtual Channel
>     Capabilities: [300] Device Serial Number 00-00-00-00-00-00-00-00
>     Kernel driver in use: ath9k
> 
