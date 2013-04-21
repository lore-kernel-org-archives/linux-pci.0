Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:32795 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab3DUCVr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Apr 2013 22:21:47 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so92836pde.18
        for <linux-pci@vger.kernel.org>; Sat, 20 Apr 2013 19:21:46 -0700 (PDT)
Message-ID: <51734D36.4000802@gmail.com>
Date: Sun, 21 Apr 2013 10:21:42 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Frank Rizzo <thefrankrizzo@hotmail.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Rescan PCIE bus to find recently powered on device.
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl> <5170B9BD.6040408@huawei.com> <CAErSpo43xWdYE8MT9Y4Hdi0bkNh3D4Su6zThAVs72+nYiUD5qg@mail.gmail.com> <BLU0-SMTP305A7D1308063E03F4C5CE9B2C90@phx.gbl> <5171F610.80001@huawei.com> <BLU0-SMTP185893DF37F0C811FA0BCB7B2C90@phx.gbl> <517204AE.9030907@huawei.com> <BLU0-SMTP106EAAAE910BEDD2F047B19B2C90@phx.gbl> <5172BF84.9090307@gmail.com> <BLU0-SMTP461505AE1FB450731CCD2B2B2C90@phx.gbl>
In-Reply-To: <BLU0-SMTP461505AE1FB450731CCD2B2B2C90@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/21/2013 04:52 AM, Frank Rizzo wrote:
>> Hi Frank,
>>     Message from "sudo lspci -vvv" gives more information, including PCIe capabilities,
>> so please help to send out "sudo lspci -vvv" instead of "lspci -v".
>>     Thanks!
> 
> Here's the info:
> 
> root@frank-System-Product-Name:~# lspci -vvv
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] RS780 Host Bridge
>         Subsystem: ASUSTeK Computer Inc. M3A78-EH Motherboard
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
>         Latency: 0
>         Capabilities: [c4] HyperTransport: Slave or Primary Interface
>                 Command: BaseUnitID=0 UnitCnt=12 MastHost- DefDir- DUL-
>                 Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
>                 Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
>                 Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
>                 Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
>                 Revision ID: 3.00
>                 Link Frequency 0: [b]
>                 Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
>                 Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
>                 Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
>                 Link Frequency 1: 200MHz
>                 Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
>                 Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
>                 Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE+ PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
>                 Prefetchable memory behind bridge Upper: 00-00
>                 Bus Number: 00
>         Capabilities: [54] HyperTransport: UnitID Clumping
>         Capabilities: [40] HyperTransport: Retry Mode
>         Capabilities: [9c] HyperTransport: #1a
>         Capabilities: [f8] HyperTransport: #1c
> 
> 00:01.0 PCI bridge: ASUSTeK Computer Inc. RS880 PCI to PCI bridge (int gfx) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: fb900000-fbafffff
>         Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
>         Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [44] HyperTransport: MSI Mapping Enable+ Fixed+
>         Capabilities: [b0] Subsystem: ASUSTeK Computer Inc. Device 82f1
>         Kernel modules: shpchp
> 
> 00:02.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (ext gfx port 0) (prog-if 00 [Normal decode])
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: fbb00000-fbdfffff
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [50] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag+ RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep+ BwNot+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>                         Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
Hi Frank,
	According to "Hotplug-" flag above, the slot for 00:02.0 doesn't support hotplug.
Actually no slot in this system supports PCI devic hotplug at all. So simply powering on
the device connected to the adapter after booting won't work. Please find another system
with PCIe device hotplug capability for your tests. You may confirm PCIe hotplug capability
by scanning "hotplug+" flag and also insmod pciehp.
	Regards!
	Gerry

