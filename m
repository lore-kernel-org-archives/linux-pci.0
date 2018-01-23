Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeAWSHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 13:07:42 -0500
Date: Tue, 23 Jan 2018 12:07:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ron Yuan <ron.yuan@memblaze.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bo Chen <bo.chen@memblaze.com>,
        William Huang <william.huang@memblaze.com>,
        Fengming Wu <fengming.wu@memblaze.com>,
        Jason Jiang <jason.jiang@microsemi.com>,
        Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
        Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
        William Cheng <william.cheng@microsemi.com>,
        "Kim Helper (khelper)" <khelper@micron.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
Message-ID: <20180123180740.GG5317@bhelgaas-glaptop.roam.corp.google.com>
References: <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
 <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
 <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org>
 <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
 <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org>
 <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <SHAPR01MB173D186666EBAFEC5367AACFEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <20180123174821.GF5317@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123174821.GF5317@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 11:48:21AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 23, 2018 at 02:01:27PM +0000, Ron Yuan wrote:
> > Just got the log, see attachment. Kernel is under "perf" mode.
> > SSD and Ethernet controller are both set to 256B MRRS. 
> 
> Here's what I see from lspci:
> 
>   3a:00.0 Root Port to 3b     MPS_cap=256 MPS=256 MRRS=128
>   3b:00.0 NIC Endpoint        MPS_cap=512 MPS=256 MRRS=256
>   3b:00.1 NIC Endpoint        MPS_cap=512 MPS=256 MRRS=256
> 
> Here, the NICs support up to MPS=512 but the Root Port only supports
> MPS=256.  We must set MPS=256 for the NICs.  Otherwise, the NICs could
> do 512-byte DMA writes to system memory, and the Root Port would treat
> those TLPs as malformed.
> 
> There is no need to limit MRRS because there are no other devices
> under this Root Port.  We can't tell from lspci what the maximum MRRS
> is, but if the NICs support MRRS=4096, we could use that.
> 
>   ae:00.0 Root Port to af     MPS_cap=256 MPS=256 MRRS=128
>   ae:01.0 Root Port to b0     MPS_cap=256 MPS=256 MRRS=128
>   af:00.0 SSD Endpoint        MPS_cap=256 MPS=256 MRRS=256
>   b0:00.0 SSD Endpoint        MPS_cap=256 MPS=256 MRRS=256
> 
> Everything here supports MPS=256, so that's what we should use.
> 
> As with the NICs, there's no need to limit MRRS here.  We don't know
> what MRRS the endpoints support, but PERFORMANCE mode is being
> unnecessarily conservative when it limits MRRS to the MPS (256 in this
> case).
> 
> It's not as simple as just removing the "set MRRS=MPS" part because we
> do rely on that in some topologies.  There are interesting topologies
> where we *don't* need it, like both of the ones above, and we need to
> make Linux smart enough to recognize them.

The mailing list dropped Ron's email with the lspci log because it was
a multipart base64-encoded message.  The lists accept plain text only
(see http://vger.kernel.org/majordomo-info.html).  

Here's Ron's message:

> Just got the log, see attachment. Kernel is under "perf" mode.
> SSD and Ethernet controller are both set to 256B MRRS.

And here are the relevant parts of the lspci.log that he attached (I
didn't include it all because it's over 100K and the mailing list
wouldn't accept that either):

3a:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port 1A (rev 04) (prog-if 00 [Normal decode])
	Physical Slot: 2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=3a, secondary=3b, subordinate=3b, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: b8500000-b86fffff
	Prefetchable memory behind bridge: 000038bffa000000-000038bffeffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Intel Corporation Device 0000
	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
		Address: fee00038  Data: 0000
		Masking: 00000002  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #5, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #2, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
	Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
	Kernel driver in use: pcieport

3b:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
	Subsystem: Mellanox Technologies Device 0021
	Physical Slot: 2-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 51
	Region 0: Memory at 38bffc000000 (64-bit, prefetchable) [size=32M]
	Expansion ROM at b8600000 [disabled] [size=1M]
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 256 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM not supported, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [48] Vital Product Data
		Product Name: CX4421A- ConnectX-4 LX SFP28
		Read-only fields:
			[PN] Part number: MCX4421A-ACQN        
			[EC] Engineering changes: A6
			[SN] Serial number: MT1719X02671            
			[V0] Vendor specific: PCIeGen3 x8     
			[RV] Reserved: checksum good, 0 byte(s) reserved
		End
	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 04, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 2, stride: 1, Device ID: 1016
		Supported Page Size: 000007ff, System Page Size: 00000001
		Region 0: Memory at 000038bffe800000 (64-bit, prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1c0 v1] #19
	Capabilities: [230 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: mlx5_core

3b:00.1 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
	Subsystem: Mellanox Technologies Device 0021
	Physical Slot: 2-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 168
	Region 0: Memory at 38bffa000000 (64-bit, prefetchable) [size=32M]
	Expansion ROM at b8500000 [disabled] [size=1M]
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 256 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM not supported, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [48] Vital Product Data
		Product Name: CX4421A- ConnectX-4 LX SFP28
		Read-only fields:
			[PN] Part number: MCX4421A-ACQN        
			[EC] Engineering changes: A6
			[SN] Serial number: MT1719X02671            
			[V0] Vendor specific: PCIeGen3 x8     
			[RV] Reserved: checksum good, 0 byte(s) reserved
		End
	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 04, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 9, stride: 1, Device ID: 1016
		Supported Page Size: 000007ff, System Page Size: 00000001
		Region 0: Memory at 000038bffe000000 (64-bit, prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [230 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: mlx5_core

ae:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port 1A (rev 04) (prog-if 00 [Normal decode])
	Physical Slot: 12
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=ae, secondary=af, subordinate=af, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ee600000-ee6fffff
	Prefetchable memory behind bridge: 0000398000000000-00003980001fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Intel Corporation Device 0000
	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
		Address: fee00038  Data: 0000
		Masking: 00000002  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #5, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+
			Slot #12, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
	Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
	Kernel driver in use: pcieport

ae:01.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port 1B (rev 04) (prog-if 00 [Normal decode])
	Physical Slot: 13
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=ae, secondary=b0, subordinate=b0, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ee500000-ee5fffff
	Prefetchable memory behind bridge: 0000398000200000-00003980003fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Intel Corporation Device 0000
	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
		Address: fee00058  Data: 0000
		Masking: 00000002  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #6, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM- Surprise+ LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+
			Slot #13, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [110 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [148 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
	Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
	Kernel driver in use: pcieport

af:00.0 Non-Volatile memory controller: Device 1c5f:0550 (rev 02) (prog-if 02 [NVM Express])
	Subsystem: Device 1c5f:0552
	Physical Slot: 12-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at ee610000 (64-bit, non-prefetchable) [size=16K]
	Expansion ROM at ee600000 [disabled] [size=64K]
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [c8] MSI: Enable- Count=1/32 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000001
	Capabilities: [e0] MSI-X: Enable+ Count=129 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 256 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM not supported, Exit Latency L0s <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [40] Vendor Specific Information: Len=24 <?>
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [190 v1] #19
	Capabilities: [150 v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
	Kernel driver in use: nvme

b0:00.0 Non-Volatile memory controller: Device 1c5f:0550 (rev 02) (prog-if 02 [NVM Express])
	Subsystem: Device 1c5f:0552
	Physical Slot: 13-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 50
	Region 0: Memory at ee510000 (64-bit, non-prefetchable) [size=16K]
	Expansion ROM at ee500000 [disabled] [size=64K]
	Capabilities: [c0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [c8] MSI: Enable- Count=1/32 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000001
	Capabilities: [e0] MSI-X: Enable+ Count=129 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 256 bytes, MaxReadReq 256 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM not supported, Exit Latency L0s <4us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [40] Vendor Specific Information: Len=24 <?>
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [190 v1] #19
	Capabilities: [150 v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
	Kernel driver in use: nvme
