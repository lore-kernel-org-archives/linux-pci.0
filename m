Return-Path: <SRS0=WRx3=6K=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=WRx3=6K=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v9 0/3] Tango PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Mason <slash.tmp@free.fr>, Marc Zyngier <marc.zyngier@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, linux-pci <linux-pci@vger.kernel.org>, Linux
 ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
 <6256cab3-dd77-c0f6-66b8-be261695bbb1@free.fr>
 <20170705180359.GL13824@bhelgaas-glaptop.roam.corp.google.com>
 <5a1207cb-31fd-6b85-86af-8c37bd57ad4f@free.fr>
 <20170705213419.GD25063@bhelgaas-glaptop.roam.corp.google.com>
 <8dcab663-245b-880a-be3a-2965fd12d663@free.fr>
 <20170706033946.GO13824@bhelgaas-glaptop.roam.corp.google.com>
 <d04e1632-17b8-85f9-31c4-b789d55cc853@free.fr>
 <20170706194628.GQ13824@bhelgaas-glaptop.roam.corp.google.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <3a2e6791-006e-ce3f-f113-e7b0dc6dc2d9@sigmadesigns.com>
Date: Fri, 7 Jul 2017 11:55:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170706194628.GQ13824@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

On 06/07/2017 21:46, Bjorn Helgaas wrote:

> I'm a little queasy about the MSI stuff.  It doesn't feel very settled
> yet, and I don't want to keep tweaking it at this stage.
>=20
> How about we merge the base patch for v4.13 and deal with MSIs for
> v4.14?  I need confirmation that the base patch works ASAP.  Or if
> it's not really useful by itself, we can defer it all until v4.14.

For what it's worth, the base patch allows enumeration:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc1 (mgonzalez@misti.france.sdesigns.co=
m) (gcc version 6.3.1 20170109 (Linaro GCC 6.3-2017.02) ) #6 SMP PREEMPT Fr=
i Jul 7 11:43:24 CEST 2017
...
[    0.725488] pcie_tango 50000000.pcie: simultaneous PCI config and MMIO a=
ccesses may cause data corruption
[    0.743158] OF: PCI: host bridge /soc/pcie@2e000 ranges:
[    0.748519] OF: PCI:   MEM 0x50400000..0x53ffffff -> 0x00400000
[    0.754549] pcie_tango 50000000.pcie: ECAM at [mem 0x50000000-0x503fffff=
] for [bus 00-03]
[    0.762907] pcie_tango 50000000.pcie: PCI host bridge to bus 0000:00
[    0.769308] pci_bus 0000:00: root bus resource [bus 00-03]
[    0.774829] pci_bus 0000:00: root bus resource [mem 0x50400000-0x53fffff=
f] (bus address [0x00400000-0x03ffffff])
[    0.785303] PCI: bus0: Fast back to back transfers disabled
[    0.790916] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    0.807282] PCI: bus1: Fast back to back transfers disabled
[    0.812925] pci 0000:00:00.0: BAR 8: assigned [mem 0x50400000-0x504fffff=
]
[    0.819759] pci 0000:01:00.0: BAR 0: assigned [mem 0x50400000-0x50401fff=
 64bit]
[    0.827126] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.832121] pci 0000:00:00.0:   bridge window [mem 0x50400000-0x504fffff=
]
[    0.839004] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    0.845274] pci 0000:01:00.0: enabling device (0140 -> 0142)



# lspci -v =20
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [N=
ormal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at <ignored> (64-bit, non-prefetchable)
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00400000-004fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Con=
troller (rev 03) (prog-if 30 [XHCI])
        Flags: fast devsel
        Memory at 50400000 (64-bit, non-prefetchable) [size=3D8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable- Count=3D8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting



# lspci -vvv
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [N=
ormal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Region 0: Memory at <ignored> (64-bit, non-prefetchable)
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00400000-004fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D3 PME-
        Capabilities: [80] Express (v2) Root Port (Slot-), MSI 03
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tr=
ansPend+
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit L=
atency L0s <2us, L1 <4us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLAct=
ive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=
 CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range B, TimeoutDis-, LTR-, OB=
FF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTra=
ns-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR25=
6-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
                        Status: NegoPending- InProgress-
        Capabilities: [800 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- Ch=
kEn-
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Con=
troller (rev 03) (prog-if 30 [XHCI])
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 50400000 (64-bit, non-prefetchable) [size=3D8K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,=
D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [90] MSI-X: Enable- Count=3D8 Masked-
                Vector table: BAR=3D0 offset=3D00001000
                PBA: BAR=3D0 offset=3D00001080
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unli=
mited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- Slo=
tPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tr=
ansPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit L=
atency L0s <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLAct=
ive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LT=
R+, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP+ Rollover- Timeout- NonFatal=
Err-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- Ch=
kEn-
        Capabilities: [150 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
