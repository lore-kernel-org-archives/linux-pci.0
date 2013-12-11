Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10104 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab3LKFY1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Dec 2013 00:24:27 -0500
Message-ID: <52A7F708.6070201@redhat.com>
Date: Wed, 11 Dec 2013 00:24:24 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: AER driver - doesn't attach to EP's MSI IRQ
References: <3E54258959B69E4282D79E01AB1F32B704656A53@DFLE11.ent.ti.com>
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704656A53@DFLE11.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/10/2013 06:42 PM, Karicheri, Muralidharan wrote:
> All,
>
> Trying to test AER driver on an ARM platform an RC driver. The EP is using MSI IRQ1. So based on a previous query on this, AER driver's IRQ handler should be attached to the MSI IRQ1 to listen to errors from this EP. But it is attached to MSI IRQ0. The EP has MSI IRQ capability. Any idea why this is not working as expected?
>
The AER comes from the upstream port, in this case, the RP, not from the EP.
This is what I'd expect to see...

> Cat /proc/interrupts shows
>
> 576:          0          0          0          0  PCIe-MSI  aerdrv
> 577:       1025          0          0          0  PCIe-MSI  ahci
>
> AHCI driver is attached to MSI iRQ1. AER driver to MSI IRQ0
>
>> lspci -vv
>
> 00:00.0 PCI bridge: Texas Instruments Device 8888 (rev 01) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
> 	Region 1: Memory at <ignored> (32-bit, prefetchable)
> 	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> 	I/O behind bridge: 00001000-00001fff
> 	Memory behind bridge: 50000000-501fffff
> 	Prefetchable memory behind bridge: 50200000-503fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> 	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 0000000021800054  Data: 0000
> 	Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 256 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L0s, Latency L0 <512ns, L1 <64us
> 			ClockPM- Surprise- LLActRep+ BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> 			ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> 		RootCap: CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP+ BadDLLP+ Rollover- Timeout+ NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn+
> 	Kernel driver in use: pcieport
>
> 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9125 PCIe SATA 6.0 Gb/s controller (rev 11) (prog-if 01 [AHCI 1.0])
> 	Subsystem: Marvell Technology Group Ltd. 88SE9125 PCIe SATA 6.0 Gb/s controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 577
> 	Region 0: I/O ports at 1010 [size=8]
> 	Region 1: I/O ports at 1020 [size=4]
> 	Region 2: I/O ports at 1018 [size=8]
> 	Region 3: I/O ports at 1024 [size=4]
> 	Region 4: I/O ports at 1000 [size=16]
> 	Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=2K]
> 	Expansion ROM at 50200000 [disabled] [size=64K]
> 	Capabilities: [40] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: 21800054  Data: 0001
> 	Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 256 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
> 			ClockPM- Surprise- LLActRep- BwNot-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance De-emphasis: -6dB
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
> 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> 	Kernel driver in use: ahci
>
> Murali Karicheri
> Linux Kernel, Software Development
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

