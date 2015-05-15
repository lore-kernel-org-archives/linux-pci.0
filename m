Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934752AbbEORJc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 May 2015 13:09:32 -0400
Message-ID: <1431709768.11375.15.camel@redhat.com>
Subject: Re: Crash at vfio_intx_handler for PCI device
From: Alex Williamson <alex.williamson@redhat.com>
To: Bhushan Bharat <Bharat.Bhushan@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bansal Ayushi <Ayushi.Bansal@freescale.com>
Date: Fri, 15 May 2015 11:09:28 -0600
In-Reply-To: <CY1PR0301MB12761E3A28E4D4F1F72B2EFB90C70@CY1PR0301MB1276.namprd03.prod.outlook.com>
References: <BY2PR03MB1606C055D54CC65D00DE8EAFBC70@BY2PR03MB160.namprd03.prod.outlook.com>
	 <CY1PR0301MB12761E3A28E4D4F1F72B2EFB90C70@CY1PR0301MB1276.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-05-15 at 17:00 +0000, Bhushan Bharat wrote:
> Hi All,
> 
> We are direct assigning the intel ixgbe device on Freescale T4240QDS-2 using VFIO. We are getting below crash when running QEMU.
> When we set the flag 'nointxmask', the issue resolved. 

What's the crash?  There's only lspci info below.  PCI INTx masking
ought to be arch independent, but is it reproducible on x86?  Thanks,

Alex

> Here is the info of lspci -vvvxxx for that PCI device:
> 
> 0001:01:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
>                 Subsystem: Intel Corporation Ethernet Server Adapter X520-2
>                 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>                 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>                 Latency: 0, Cache Line Size: 32 bytes
>                 Interrupt: pin B routed to IRQ 17
>                 Region 0: Memory at c40100000 (64-bit, non-prefetchable) [size=512K]
>                 Region 2: I/O ports at 1020 [disabled] [size=32]
>                 Region 4: Memory at c40180000 (64-bit, non-prefetchable) [size=16K]
>                 [virtual] Expansion ROM at c40280000 [disabled] [size=512K]
>                 Capabilities: [40] Power Management version 3
>                                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
>                                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>                 Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>                                 Address: 0000000000000000  Data: 0000
>                                 Masking: 00000000  Pending: 00000000
>                 Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
>                                 Vector table: BAR=4 offset=00000000
>                                 PBA: BAR=4 offset=00002000
>                 Capabilities: [a0] Express (v2) Endpoint, MSI 00
>                                 DevCap:               MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>                                                 ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>                                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                                                 RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
>                                                 MaxPayload 128 bytes, MaxReadReq 512 bytes
>                                 DevSta:                CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                                 LnkCap:                Port #4, Speed 5GT/s, Width x8, ASPM L0s, Exit Latency L0s <512ns, L1 <4us
>                                                 ClockPM- Surprise- LLActRep- BwNot-
>                                 LnkCtl:  ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                                                 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
>                                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                                                 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>                 Capabilities: [e0] Vital Product Data
>                                 Unknown small resource type 00, will not decode more.
>                 Capabilities: [100 v1] Advanced Error Reporting
>                                 UESta:   DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                                 UEMsk:                DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                                 CESta:   RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                                 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                                 AERCap:               First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>                 Capabilities: [140 v1] Device Serial Number 00-1b-21-ff-ff-89-81-88
>                 Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
>                                 ARICap:                MFVC- ACS-, Next Function: 0
>                                 ARICtl:  MFVC- ACS-, Function Group: 0
>                 Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
>                                 IOVCap:               Migration-, Interrupt Message Number: 000
>                                 IOVCtl:  Enable- Migration- Interrupt- MSE- ARIHierarchy-
>                                 IOVSta: Migration-
>                                 Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function Dependency Link: 01
>                                 VF offset: 384, stride: 2, Device ID: 10ed
>                                 Supported Page Size: 00000553, System Page Size: 00000001
>                                 Region 0: Memory at 00000000e0500000 (64-bit, non-prefetchable)
>                                 Region 3: Memory at 00000000e0600000 (64-bit, non-prefetchable)
>                                 VF Migration: offset: 00000000, BIR: 0
>                 Kernel driver in use: vfio-pci
> 00: 86 80 fb 10 06 04 10 00 01 00 00 02 08 00 80 00
> 10: 04 00 10 e0 00 00 00 00 21 10 00 00 00 00 00 00
> 20: 04 00 18 e0 00 00 00 00 00 00 00 00 86 80 11 7a
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 02 00 00
> 40: 01 50 23 48 00 20 00 2b 00 00 00 00 00 00 00 00
> 50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 11 a0 3f 80 04 00 00 00 04 20 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 10 e0 02 00 c2 8c 00 10 10 28 00 00 82 34 01 04
> b0: 40 00 41 10 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 03 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> Thanks
> -Bharat



