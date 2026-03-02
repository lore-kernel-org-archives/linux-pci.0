Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CE282F02
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495461; cv=none; b=JNK2KubrHPx5ycM7Q/sjmiVyKCA89pMplcQ4LKTtOMNqOYf32TcFRQ2BQScR4vEGYYUPA2dGXLJgJwEiiJxfH0T7QPsl10OaMi5CpxDRg3jUqQOczHgplu2Q22NiDuytwrOxd3kR3naYXFyhm+uiyNdTmdTO6i9IaGnjqhlpwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495461; c=relaxed/simple;
	bh=mOtoPJpJJuSIhVdgMHdrGP4VOs5y3hMbYMFlfDlMMKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ol5hqvdxDBZEv0IW7o2YB0RWMQcAXN423HCbaDKs0E+vnSKUtRZ66yYHNBQDocubkFkxIcN6HgOtLRtLtbMYm4QKdZRuG/SMN/ykIRMX/V+OaMsENRcpT/x9EpDcmuI0NIvey/FKWz8wAZAcJTWnxB5WrIHZQZa67BOACjr+jXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+oG4pEL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+oG4pEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703CCC19423;
	Mon,  2 Mar 2026 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772495461;
	bh=mOtoPJpJJuSIhVdgMHdrGP4VOs5y3hMbYMFlfDlMMKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o+oG4pELOZZyw2wqCE0nEvCyi8BRgqqz/pBtFfwVyvPx/5WEgCwWROyvxpL9Zy8gr
	 MlTf9hlSFCnoPew1uBQDjeGqwhC/jHrreyl4R1FMyPy0ahyHWXgKM4DW2plT8kE92a
	 ym+EeRinJqkCCcVSKRMNFVeZAqjb8Je4f10hHZ2OexPKrHBAagrNZsxUUdB3QKV1y7
	 wUVx0pa35pa1NeB0zYNYj3Ip/gonzf0aawj8TEmZyR4QqTj3XU02xfdrft+V0NFkRu
	 CkLMCiPTj3dB1FZNoZFYplaifyZDdwfSgQv/Kgufnb4mxC/DnZvZZ7huaD9v1POsA5
	 wPWXByXeytf1w==
Date: Mon, 2 Mar 2026 17:51:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sune Brian <briansune@gmail.com>, Joyce Ooi <joyce.ooi@intel.com>
Cc: linux-pci@vger.kernel.org, ley.foon.tan@intel.com,
	mathias.nyman@intel.com
Subject: Re: [BUG] PCIe Stall on USB_PCI=y with SoCFPGA Root Port
Message-ID: <20260302235100.GA4037767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN7C2SC_2k6+dvBTRoV1_trpPEF5h+k9KDOapTwcb90+=BUatw@mail.gmail.com>

[+to Joyce, pcie-altera.c maintainer]

On Sat, Feb 28, 2026 at 11:05:17PM +0800, Sune Brian wrote:
> Dear PCI maintainers,
> 
> Root Port: Cyclone V HPS Root Port PCIe
> Endpoint: uPD720202 Card
> Kernel version: 6.12.33-g3234b1ed8956-dirty

v6.12 is fairly old; can you reproduce a problem with v6.19 or
v7.0-rc1?

> Sanity confirmation of PCIe RP:
> Both NVMe and Realtek WIFI cards are tested
> and show no major issue with MSI/MSI-X enabled.
> 
> Repeatable Result:
> When uPD720202 card is applied onto the PCIe slot.
> Either module or included driver could stall during kernel boot.
> The stall can be resolved by setting USB_PCI=n and
> after boot under distro lspci -vvv can disable the card info [2].
> All nosmi noaspm etc are tested and state the same stall.
> 
> The root port info is shown in [1].
> Based on the above behavior we had also tried to reflash the
> ROM of the uPD720202 card and no difference was shown
> on the stall issue.
> The uPD720202 card is tested on another ARM 64 board and
> shows no stall issue.

Do you have any details about what the actual issue is?  I guess it's
some kind of hang, but you don't know exactly where in the code it
happens?

> With USB_PCI=n it is sure this is driver issue between
> pcie-altera.c & pcie-altera-msi.c
> 
> Additional boot log [3] with USB_PCI=n
> 
> Thanks,
> Brian
> 
> [1]
> 00:00.0 PCI bridge: Altera Corporation Device e000 (rev 01) (prog-if
> 00 [Normal decode])
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         Memory behind bridge: c0000000-c00fffff [size=1M] [32-bit]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [50] MSI: Enable- Count=1/16 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [68] MSI-X: Enable- Count=64 Masked-
>                 Vector table: BAR=0 offset=000fe000
>                 PBA: BAR=0 offset=000ff000
>         Capabilities: [78] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [80] Express (v2) Root Port (Slot-), IntMsgNum 0
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                         ExtTag- RBE+ TEE-IO-
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> AuxPwr- TransPend-
>                 LnkCap: Port #1, Speed 2.5GT/s, Width x2, ASPM L0s,
> Exit Latency L0s <4us
>                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> FltModeDis-
>                 LnkSta: Speed 2.5GT/s, Width x1
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 RootCap: CRSVisible-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> PMEIntEna- CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> NROPrPrP- LTR-
>                          10BitTagComp- 10BitTagReq- OBFF Not
> Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>                          FRS- LN System CLS Not Supported, TPHComp-
> ExtTPHComp- ARIFwd-
>                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>                          AtomicOpsCtl: ReqEn- EgressBlck-
>                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB
> de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
>         Capabilities: [100 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                         Status: NegoPending- InProgress-
>         Capabilities: [200 v1] Vendor Specific Information: ID=a000
> Rev=0 Len=044 <?>
> 
> 
> [2]
> 01:00.0 USB controller: Renesas Electronics Corp. uPD720202 USB 3.0
> Host Controller (rev 02) (prog-if 30 [XHCI])
>         Subsystem: Renesas Electronics Corp. uPD720202 USB 3.0 Host Controller
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 0
>         Region 0: Memory at c0000000 (64-bit, non-prefetchable)
> [disabled] [size=8K]
>         Capabilities: [50] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [90] MSI-X: Enable- Count=8 Masked-
>                 Vector table: BAR=0 offset=00001000
>                 PBA: BAR=0 offset=00001080
>         Capabilities: [a0] Express (v2) Endpoint, IntMsgNum 0
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> FLReset- SlotPowerLimit 0W TEE-IO-
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1,
> Exit Latency L0s <4us, L1 unlimited
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> FltModeDis-
>                 LnkSta: Speed 2.5GT/s (downgraded), Width x1
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported,
> TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Not
> Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                          AtomicOpsCtl: ReqEn-
>                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB
> de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3-
> LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr- CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+ CorrIntErr- HeaderOF-
>                 AERCap: First Error Pointer: 00, ECRCGenCap-
> ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [150 v1] Latency Tolerance Reporting
>                 Max snoop latency: 0ns
>                 Max no snoop latency: 0ns
> 
> 
> [3]
> [    0.415557] altera-pcie c0000000.pcie: host bridge /pcie@c0000000 ranges:
> [    0.415617] altera-pcie c0000000.pcie:      MEM
> 0x00c0000000..0x00dfffffff -> 0x0000000000
> [    0.416057] altera-pcie c0000000.pcie: PCI host bridge to bus 0000:00
> [    0.416097] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.416127] pci_bus 0000:00: root bus resource [mem
> 0xc0000000-0xdfffffff] (bus address [0x00000000-0x1fffffff])
> [    0.416370] pci 0000:00:00.0: config space:
> [    0.417315] 00000000: 72 11 00 e0 00 00 10 00 01 00 04 06 00 00 01 00
> [    0.417339] 00000010: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417361] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417382] 00000030: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
> [    0.417403] 00000040: 00 00 00 00 60 61 00 02 00 00 00 00 00 00 00 00
> [    0.417424] 00000050: 05 68 88 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417444] 00000060: 00 00 00 00 00 00 00 00 11 78 3f 00 00 e0 0f 00
> [    0.417465] 00000070: 00 f0 0f 00 00 00 00 00 01 80 03 00 00 00 00 00
> [    0.417486] 00000080: 10 00 42 00 01 80 00 00 10 28 00 00 21 64 60 01
> [    0.417506] 00000090: 00 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417527] 000000a0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
> [    0.417547] 000000b0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417568] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417588] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417609] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417629] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.417701] pci 0000:00:00.0: [1172:e000] type 01 class 0x060400
> PCIe Root Port
> [    0.417965] pci 0000:00:00.0: PCI bridge to [bus 00]
> [    0.418067] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xc00fffff]
> [    0.421292] PCI: bus0: Fast back to back transfers disabled
> [    0.421343] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    0.422195] pci 0000:01:00.0: config space:
> [    0.423561] 00000000: 12 19 15 00 00 00 10 00 02 30 03 0c 00 00 00 00
> [    0.423584] 00000010: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.423606] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 12 19 15 00
> [    0.423628] 00000030: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
> [    0.423649] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.423670] 00000050: 01 70 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
> [    0.423691] 00000060: 30 20 00 00 00 00 00 00 00 00 00 00 0b 28 20 00
> [    0.423711] 00000070: 05 90 86 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.423732] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.423753] 00000090: 11 a0 07 00 00 10 00 00 80 10 00 00 00 00 00 00
> [    0.423774] 000000a0: 10 00 02 00 c0 8f 00 00 10 28 10 00 12 ec 07 00
> [    0.423794] 000000b0: 00 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.423814] 000000c0: 00 00 00 00 10 08 00 00 00 00 00 00 00 00 00 00
> [    0.423835] 000000d0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.423856] 000000e0: 00 00 00 00 00 00 03 00 00 00 01 0d 13 31 1c 00
> [    0.423877] 000000f0: 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00 00
> [    0.423967] pci 0000:01:00.0: [1912:0015] type 00 class 0x0c0330
> PCIe Endpoint
> [    0.424280] pci 0000:01:00.0: BAR 0 [mem 0xc0000000-0xc0001fff 64bit]
> [    0.425940] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    0.426316] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000
> Gb/s with 5.0 GT/s PCIe x1 link)
> [    0.427067] PCI: bus1: Fast back to back transfers disabled
> [    0.427098] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    0.427159] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
> [    0.427197] pci 0000:00:00.0: bridge window [mem
> 0xc0000000-0xc00fffff]: assigned
> [    0.427234] pci 0000:01:00.0: BAR 0 [mem 0xc0000000-0xc0001fff
> 64bit]: assigned
> [    0.427389] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.427439] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xc00fffff]
> [    0.427516] pci_bus 0000:00: resource 4 [mem 0xc0000000-0xdfffffff]
> [    0.427543] pci_bus 0000:01: resource 1 [mem 0xc0000000-0xc00fffff]
