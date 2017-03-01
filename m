Return-Path: <SRS0=gIuH=2K=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=gIuH=2K=free.fr=slash.tmp@kernel.org>
Subject: Re: Using the generic host PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>, David Daney <david.daney@cavium.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
Date: Wed, 1 Mar 2017 16:18:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 27/02/2017 19:35, Bjorn Helgaas wrote:

> When I said the native drivers provide no real benefit, I meant that
> they do not provide any value-add functionality beyond what a generic
> driver like drivers/acpi/pci_root.c already does.
> 
> Obviously there are many different host bridges and they have
> different programming models, so there has to be bridge-specific
> support *somewhere*.  The question is whether that's in firmware, in
> Linux, or both.  For ACPI systems, it's all in firmware.
> 
> Systems with well-behaved hardware, i.e., it supports PCIe and ECAM
> without warts, firmware can initialize the bridge and tell the OS
> about it via DT, and the drivers/pci/pci-host-generic.c driver can do
> everything else.
> 
> For systems that aren't so well-behaved, we'll need either a full
> native driver that knows how to program bridge window CSRs, set up
> interrupts, etc., or a simpler native driver that papers over warts
> like ECAM that doesn't work quite according to spec.
> 
> It sounds like your system falls into the latter category.

Hello Bjorn,

Having worked around 3 HW bugs, things are starting to look
slightly more "normal". Here is my current boot log:
(I've added a few questions inline.)

[    0.197669] PCI: CLS 0 bytes, default 64

Is it an error for Cache Line Size to be 0 here?

[    0.652356] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    0.652380] OF: PCI:   No bus range found for /soc/pcie@50000000, using [bus 00-ff]
[    0.652407] OF: PCI: Parsing ranges property...
[    0.652494] OF: PCI:   MEM 0xa0000000..0xa03fffff -> 0xa0000000
[    0.655744] pci-host-generic 50000000.pcie: ECAM at [mem 0x50000000-0x5fffffff] for [bus 00-ff]
[    0.656097] pci-host-generic 50000000.pcie: PCI host bridge to bus 0000:00
[    0.656145] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.656168] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xa03fffff]
[    0.656191] pci_bus 0000:00: scanning bus
[    0.656257] pci 0000:00:00.0: [1105:8758] type 01 class 0x048000
[    0.656314] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
[    0.656358] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
[    0.656400] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    0.656451] pci 0000:00:00.0: supports D1 D2
[    0.656468] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    0.656486] pci 0000:00:00.0: PME# disabled
[    0.656657] pci_bus 0000:00: fixups for bus
[    0.656686] PCI: bus0: Fast back to back transfers disabled
[    0.656707] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    0.656725] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.656753] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    0.656845] pci_bus 0000:01: scanning bus
[    0.656911] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    0.656968] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    0.657065] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    0.657192] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.657213] pci 0000:01:00.0: PME# disabled
[    0.657495] pci_bus 0000:01: fixups for bus
[    0.657521] PCI: bus1: Fast back to back transfers disabled
[    0.657538] pci_bus 0000:01: bus scan returning with max=01
[    0.657556] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.657575] pci_bus 0000:00: bus scan returning with max=01
[    0.657593] pci 0000:00:00.0: fixup irq: got 0
[    0.657608] pci 0000:00:00.0: assigning IRQ 00
[    0.657651] pci 0000:01:00.0: fixup irq: got 20
[    0.657667] pci 0000:01:00.0: assigning IRQ 20

This revision of the controller does not support legacy interrupt mode,
only MSI. I looked at the bindings for MSI:

https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-msi.txt
https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/msi.txt

But it is not clear to me if I need to write a specific driver
for the MSI controller, or if there is some kind of generic
support? If the latter, what are the required properties?
A "door-bell" address? Anything else?

[    0.657711] pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
[    0.657731] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
[    0.657755] pci 0000:00:00.0: BAR 8: assigned [mem 0xa0000000-0xa00fffff]
[    0.657776] pci 0000:01:00.0: BAR 0: assigned [mem 0xa0000000-0xa0001fff 64bit]

These 4 statements sound fishy.

[    0.657813] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.657831] pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa00fffff]
[    0.657904] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    0.657931] pcieport 0000:00:00.0: enabling bus mastering
[    0.658058] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
[    0.658088] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    0.663235] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?) status = 0x1e7fffd0
[    0.679283] pci 0000:01:00.0: xHCI HW did not halt within 16000 usec status = 0x1e7fffd0

The PCIe card is a USB3 adapter. I suppose it's not working
because MSI is not properly configured.

# /usr/sbin/lspci -v
00:00.0 PCI bridge: Sigma Designs, Inc. Device 8758 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at <unassigned> (64-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: a0000000-a00fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Flags: fast devsel, IRQ 20
        Memory at a0000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting


What does "Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+" mean?

http://man7.org/linux/man-pages/man8/lspci.8.html



For reference only, below is the extra verbose output.

# /usr/sbin/lspci -vvv
00:00.0 PCI bridge: Sigma Designs, Inc. Device 8758 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Region 0: Memory at <unassigned> (64-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: a0000000-a00fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=3 PME-
        Capabilities: [80] Express (v2) Root Port (Slot-), MSI 03
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend+
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <4us
                        ClockPM- Surprise- LLActRep- BwNot+
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range B, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [800 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Kernel driver in use: pcieport


01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at a0000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
                Vector table: BAR=0 offset=00001000
                PBA: BAR=0 offset=00001080
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [150 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns



Regards.
