Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
To: Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jon Derrick <jonathan.derrick@intel.com>,
 Keith Busch <keith.busch@intel.com>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
 <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <48fcf483-3bab-8ab3-4bfa-e81ca8ee8353@free.fr>
Date: Wed, 23 Aug 2017 12:19:49 +0200
MIME-Version: 1.0
In-Reply-To: <599D3410.9050504@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 23/08/2017 09:51, Mathias Nyman wrote:

> very likely cause is the more aggressive detection of pci removed xhci hosts
> 
> See commit d9f11ba9f107aa335091ab8d7ba5eea714e46e8b
>      xhci: Rework how we handle unresponsive or hoptlug removed hosts
> 
> It checks if a xhci register reads returns 0xffffffff and assumes xhci
> died in that case.

I've just tested 4.11.12 + a few local patches to back-port
PCIe host bridge support.

It "works" as well as 4.9
(i.e. modulo the "AER: Uncorrected (Non-Fatal) error received")

[    0.508533] pcie_tango 50000000.pcie: simultaneous PCI config and MMIO accesses may cause data corruption
[    0.519622] OF: PCI: host bridge /soc/pcie@2e000 ranges:
[    0.519645] OF: PCI:   MEM 0x50400000..0x53ffffff -> 0x00400000
[    0.519725] pcie_tango 50000000.pcie: ECAM at [mem 0x50000000-0x503fffff] for [bus 00-03]
[    0.519872] pcie_tango 50000000.pcie: PCI host bridge to bus 0000:00
[    0.519886] pci_bus 0000:00: root bus resource [bus 00-03]
[    0.519898] pci_bus 0000:00: root bus resource [mem 0x50400000-0x53ffffff] (bus address [0x00400000-0x03ffffff])
[    0.520201] PCI: bus0: Fast back to back transfers disabled
[    0.520213] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.520922] PCI: bus1: Fast back to back transfers disabled
[    0.520964] pci 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[    0.520993] pci 0000:00:00.0: BAR 8: assigned [mem 0x50400000-0x504fffff]
[    0.521004] pci 0000:01:00.0: BAR 0: assigned [mem 0x50400000-0x50401fff 64bit]
[    0.521025] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.521033] pci 0000:00:00.0:   bridge window [mem 0x50400000-0x504fffff]
[    0.521085] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    0.521282] pcieport 0000:00:00.0: Signaling PME with IRQ 30
[    0.521402] pcieport 0000:00:00.0: AER enabled with IRQ 30
[    0.521526] pci 0000:01:00.0: enabling device (0140 -> 0142)
...
[    1.239706] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.244998] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.258048] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    1.267467] hub 1-0:1.0: USB hub found
[    1.271287] hub 1-0:1.0: 4 ports detected
[    1.275761] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.281048] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    1.288578] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.297234] hub 2-0:1.0: USB hub found
[    1.301042] hub 2-0:1.0: 4 ports detected
[    1.305681] usbcore: registered new interface driver usb-storage


PLUG #1
[   26.104607] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[   26.143799] usb-storage 2-2:1.0: USB Mass Storage device detected
[   26.150253] scsi host0: usb-storage 2-2:1.0
[   27.177298] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   27.187586] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   27.199000] sd 0:0:0:0: [sda] Write Protect is off
[   27.204186] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   27.216322]  sda: sda1
[   27.220584] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   27.252046] random: fast init done

UNPLUG #1
[   37.334040] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   37.342135] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   37.353970] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   37.362589] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   37.369485] pcieport 0000:00:00.0: AER: Device recovery failed
[   38.066538] xhci_hcd 0000:01:00.0: Cannot set link state.
[   38.072039] usb usb2-port2: cannot disable (err = -32)
[   38.077348] usb 2-2: USB disconnect, device number 2
[   38.082711] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   38.094279] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   38.108006] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   38.116878] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   38.123954] pcieport 0000:00:00.0: AER: Device recovery failed

PLUG #2
[   55.097922] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
[   55.137590] usb-storage 2-2:1.0: USB Mass Storage device detected
[   55.144016] scsi host0: usb-storage 2-2:1.0
[   56.163907] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   56.174851] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   56.184218] sd 0:0:0:0: [sda] Write Protect is off
[   56.190162] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   56.202117]  sda: sda1
[   56.207112] sd 0:0:0:0: [sda] Attached SCSI removable disk

UNPLUG #2
[   63.228310] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   63.236403] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   63.248220] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   63.256653] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   63.263523] pcieport 0000:00:00.0: AER: Device recovery failed
[   63.959768] xhci_hcd 0000:01:00.0: Cannot set link state.
[   63.965227] usb usb2-port2: cannot disable (err = -32)
[   63.970409] usb 2-2: USB disconnect, device number 3
[   63.975664] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   63.987356] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   64.000021] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   64.008655] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   64.015553] pcieport 0000:00:00.0: AER: Device recovery failed
[   64.021449] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   64.029580] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   64.041410] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   64.049818] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   64.056658] pcieport 0000:00:00.0: AER: Device recovery failed


Bjorn,

What do you make of the AER logs?
What can I do to debug this issue?

Regards.



FWIW, verbose lspci output below.

# lspci -vv
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin ? routed to IRQ 30
        Region 0: Memory at <ignored> (64-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00400000-004fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable+ Count=1/4 Maskable- 64bit+
                Address: 00000000a002e07c  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=3 PME-
        Capabilities: [80] Express (v2) Root Port (Slot-), MSI 03
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq- AuxPwr- TransPend+
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <4us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
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
                UESta:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 0e, GenCap- CGenEn- ChkCap- ChkEn-
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 50400000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
                Vector table: BAR=0 offset=00001000
                PBA: BAR=0 offset=00001080
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
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
        Kernel driver in use: xhci_hcd
