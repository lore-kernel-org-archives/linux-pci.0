Return-Path: <SRS0=nMQ4=ZF=synopsys.com=Joao.Pinto@kernel.org>
Return-Path: <SRS0=nMQ4=ZF=synopsys.com=Joao.Pinto@kernel.org>
Subject: Re: Help request
To: Bjorn Helgaas <helgaas@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <6c47f48a-ec0e-e0ff-bfd6-ae7adf4df828@synopsys.com>
 <8ea3f9ef-8927-003a-a778-bb9d8bda308d@synopsys.com>
 <20170120192752.GC6619@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <929a85f1-ce02-9b81-a015-3a34aac492da@synopsys.com>
Date: Mon, 23 Jan 2017 10:29:58 +0000
MIME-Version: 1.0
In-Reply-To: <20170120192752.GC6619@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Às 7:27 PM de 1/20/2017, Bjorn Helgaas escreveu:
> On Fri, Jan 20, 2017 at 06:01:26PM +0000, Joao Pinto wrote:
>>
>> Hello,
>> Just to say that the problem was in a commit that was not related with the PCI
>> subystem.
> 
> Does that mean you've figured out the problem and we don't need to do
> anything?

Yes, correct. PCI is fine, it was an ARC related commit that was causing the USB
Endpoint to fail initialization.
Thanks.

> 
>> Às 8:46 PM de 1/18/2017, Joao Pinto escreveu:
>>> Hi,
>>>
>>> I am testing my 4.80 Root Complex Reference design (PCIe Core 4.80 with iATU
>>> Unroll) and I am facing an issue in kernel v4.9.
>>>
>>> My setup is:
>>> ARC Board --- AXI --- HAPS (RC refrence Design) --- Backplane --- USB 3.0 Endpoint
>>>
>>> If I use 4.9-rc7 the USB Endpoint gets configured correctly, but when using
>>> 4.9-rc8 it does not. I have checked and no changes were made to USB between rc7
>>> and rc8, so there's something in the PCI.
>>>
>>> The PCI initialization log seems with more info in 4.9-rc8, so maybe some
>>> operation that causing some confusion in my setup. Could you please give me your
>>> opinion?
>>>
>>> Bellow I added the logs for 4.9-rc7 and 4.9-rc8. Thank you for your help!
>>>
>>> Joao
>>>
>>>
>>> ***** LOGS for 4.9-rc7:
>>>
>>> OF: PCI: host bridge /haps_tunnel/pcie@0xdfc00000 ranges:
>>> OF: PCI:   No bus range found for /haps_tunnel/pcie@0xdfc00000, using [bus 00-ff]
>>> OF: PCI:    IO 0xde000000..0xde00ffff -> 0x00000000
>>> OF: PCI:   MEM 0xd0400000..0xdd3fffff -> 0xd0400000
>>> dw-pcie dfc00000.pcie: link up
>>> dw-pcie dfc00000.pcie: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [bus 00-ff]
>>> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>>> pci_bus 0000:00: root bus resource [mem 0xd0400000-0xdd3fffff]
>>> pci 0000:00:00.0: BAR 8: assigned [mem 0xd0400000-0xd04fffff]
>>> pci 0000:00:00.0: BAR 6: assigned [mem 0xd0500000-0xd050ffff pref]
>>> pci 0000:01:00.0: BAR 0: assigned [mem 0xd0400000-0xd0401fff 64bit]
>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>> pci 0000:00:00.0:   bridge window [mem 0xd0400000-0xd04fffff]
>>> pci 0000:01:00.0: enabling device (0000 -> 0002)
>>> (...)
>>> xhci_hcd 0000:01:00.0: xHCI Host Controller
>>> xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 3
>>> xhci_hcd 0000:01:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x00000004
>>> hub 3-0:1.0: USB hub found
>>> hub 3-0:1.0: 2 ports detected
>>> xhci_hcd 0000:01:00.0: xHCI Host Controller
>>> xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 4
>>>
>>> # lspci -v
>>> 00:00.0 PCI bridge: Synopsys, Inc. Device eddc (rev 01) (prog-if 00 [Normal decode])
>>>         Flags: bus master, fast devsel, latency 0, IRQ 45
>>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>         Memory behind bridge: d0400000-d04fffff
>>>         [virtual] Expansion ROM at d0500000 [disabled] [size=64K]
>>>         Capabilities: [40] Power Management version 3
>>>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>         Capabilities: [70] Express Root Port (Slot-), MSI 00
>>>         Capabilities: [100] Advanced Error Reporting
>>>         Capabilities: [148] #19
>>>         Capabilities: [158] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
>>>         Kernel driver in use: pcieport
>>>
>>> 01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev
>>> 03) (prog-if 30 [XHCI])
>>>         Flags: bus master, fast devsel, latency 0, IRQ 46
>>>         Memory at d0400000 (64-bit, non-prefetchable) [size=8K]
>>>         Capabilities: [50] Power Management version 3
>>>         Capabilities: [70] MSI: Enable+ Count=1/8 Maskable- 64bit+
>>>         Capabilities: [90] MSI-X: Enable- Count=8 Masked-
>>>         Capabilities: [a0] Express Endpoint, MSI 00
>>>         Capabilities: [100] Advanced Error Reporting
>>>         Capabilities: [140] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
>>>         Capabilities: [150] Latency Tolerance Reporting
>>>         Kernel driver in use: xhci_hcd
>>>
>>> ****** LOGS for 4.9-rc8:
>>>
>>> OF: PCI: host bridge /haps_tunnel/pcie@0xdfc00000 ranges:
>>> OF: PCI:   No bus range found for /haps_tunnel/pcie@0xdfc00000, using [bus 00-ff]
>>> OF: PCI:    IO 0xde000000..0xde00ffff -> 0x00000000
>>> OF: PCI:   MEM 0xd0400000..0xdd3fffff -> 0xd0400000
>>> dw-pcie dfc00000.pcie: link up
>>> dw-pcie dfc00000.pcie: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [bus 00-ff]
>>> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>>> pci_bus 0000:00: root bus resource [mem 0xd0400000-0xdd3fffff]
>>> pci 0000:00:00.0: [16c3:eddc] type 01 class 0x060400
>>> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
>>> pci 0000:00:00.0: supports D1
>>> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
>>> pci 0000:01:00.0: [1033:0194] type 00 class 0x0c0330
>>> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>>> pci 0000:01:00.0: PME# supported from D0 D3hot
>>> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>>> pci 0000:00:00.0: BAR 8: assigned [mem 0xd0400000-0xd04fffff]
>>> pci 0000:00:00.0: BAR 6: assigned [mem 0xd0500000-0xd050ffff pref]
>>> pci 0000:01:00.0: BAR 0: assigned [mem 0xd0400000-0xd0401fff 64bit]
>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>> pci 0000:00:00.0:   bridge window [mem 0xd0400000-0xd04fffff]
>>> aer 0000:00:00.0:pcie002: service driver aer loaded
>>> pci 0000:01:00.0: enabling device (0000 -> 0002)
>>> (...)
>>> xhci_hcd 0000:01:00.0: xHCI Host Controller
>>> xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 3
>>> xhci_hcd 0000:01:00.0: can't setup: -110
>>> xhci_hcd 0000:01:00.0: USB bus 3 deregistered
>>> xhci_hcd 0000:01:00.0: init 0000:01:00.0 fail, -110
>>> xhci_hcd: probe of 0000:01:00.0 failed with error -110
>>>
>>> # lspci -v
>>> 00:00.0 PCI bridge: Synopsys, Inc. Device eddc (rev 01) (prog-if 00 [Normal decode])
>>>         Flags: bus master, fast devsel, latency 0, IRQ 45
>>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>         Memory behind bridge: d0400000-d04fffff
>>>         [virtual] Expansion ROM at d0500000 [disabled] [size=64K]
>>>         Capabilities: [40] Power Management version 3
>>>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>         Capabilities: [70] Express Root Port (Slot-), MSI 00
>>>         Capabilities: [100] Advanced Error Reporting
>>>         Capabilities: [148] #19
>>>         Capabilities: [158] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
>>>         Kernel driver in use: pcieport
>>>
>>> 01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev
>>> 03) (prog-if 30 [XHCI])
>>>         Flags: fast devsel
>>>         Memory at d0400000 (64-bit, non-prefetchable) [size=8K]
>>>         Capabilities: [50] Power Management version 3
>>>         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>>>         Capabilities: [90] MSI-X: Enable- Count=8 Masked-
>>>         Capabilities: [a0] Express Endpoint, MSI 00
>>>         Capabilities: [100] Advanced Error Reporting
>>>         Capabilities: [140] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
>>>         Capabilities: [150] Latency Tolerance Reporting
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwIDAw&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=FscJtPBcOmz2pVs8R6rs_3WdCM2qhVTgSH610SgafbU&s=CvWZsl_GD38RTJgCMI30Yr9EznhC1lUnBMyAJoo0UuQ&e= 
