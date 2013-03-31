Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42284 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057Ab3CaONM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 31 Mar 2013 10:13:12 -0400
Message-ID: <1364739160.5947.5.camel@yhuang-mobile.sh.intel.com>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
From: Huang Ying <ying.huang@intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Date: Sun, 31 Mar 2013 22:12:40 +0800
In-Reply-To: <51581170.30708@fold.natur.cuni.cz>
References: <513E7E1E.80508@fold.natur.cuni.cz>
	   <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>
	   <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>
	   <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz>
	  <1364545211.1817.228.camel@yhuang-dev>
	  <5155A101.2090705@fold.natur.cuni.cz>
	 <1364640886.5773.5.camel@yhuang-mobile.sh.intel.com>
	 <51581170.30708@fold.natur.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Martin,

Thanks for your testing!

On Sun, 2013-03-31 at 12:35 +0200, Martin Mokrejs wrote:
> Hi Ying,
>   I have tested 4x your last patch. Somehow nothing gets logged to "dmesg"
> when I hotremove or hotinsert the coldbooted eSATA card. Logging works so
> enabling wifi via Fn+F2 is being logged. Also, eventual stacktraces
> and kmemleaks.
>   I removed the coldbooted card, inserted it and ejected it.
> 
> 
>   In brief, lspci reports changes but there are no changes in /proc/interrupts
> related to
> 
>   19:          0          0   IO-APIC-fasteoi   sata_sil24
> 
> 
> and no changes at all in /proc/iomem which I expected to happen during
> hotremoval and hotinsert (something broken in 3.9-rc1 with your patch).
> 
> All the runtime_status data were same after every tested step, so again,
> no diffs to show but here are the values confirming laptop-mode-tools
> enabled powersaving:
> 
> /sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
> /sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
> /sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:suspended
> /sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
> /sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active

It appears that 1c.7 is identified successfully as an hotplug-able PCIe
port, and never put into suspended state.

And from your description below, it appears that hot-add and hot-remove
of the eSATA card works for you, doesn't it?

> /sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:suspended
> /sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
> /sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
> /sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
> /sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended
> /sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active
> 
> 
>   So, the only diffs I could provide are from lspci -vvv. They show
> sata_sil24 was loaded that is confirmed by lsmod at the end of all
> tests.
> 
> --- lspci_vvv_initial.txt       2013-03-31 12:01:05.000000000 +0200
> +++ lspci_vvv_ejected.txt       2013-03-31 12:01:24.000000000 +0200
> @@ -293,7 +293,7 @@
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> @@ -307,13 +307,13 @@
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> -                       Changed: MRL- PresDet- LinkState-
> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> +                       Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> @@ -521,39 +521,7 @@
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Capabilities: [150 v1] Device Serial Number 08-00-28-00-00-20-00-00
>  
> -11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
> -       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
> -       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> -       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -       Latency: 0, Cache Line Size: 64 bytes
> -       Interrupt: pin A routed to IRQ 19
> -       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
> -       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
> -       Region 4: I/O ports at c000 [size=128]
> -       Expansion ROM at f6c00000 [disabled] [size=512K]
> -       Capabilities: [54] Power Management version 2
> -               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
> -       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
> -               Address: 0000000000000000  Data: 0000
> -       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
> -               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> -                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
> -               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> -                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> -                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
> -               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
> -               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
> -                       ClockPM- Surprise- LLActRep- BwNot-
> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> -                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> -       Capabilities: [100 v1] Advanced Error Reporting
> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> -               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> -               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> -               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> -               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> -               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
> +       !!! Unknown header type 7f
>         Kernel driver in use: sata_sil24
>  
> 
> The after a hotinsert I see:
> 
> --- lspci_vvv_ejected.txt       2013-03-31 12:01:24.000000000 +0200
> +++ lspci_vvv_ejected_and_reinserted.txt        2013-03-31 12:02:24.000000000 +0200
> @@ -307,12 +307,12 @@
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>                         Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
> @@ -521,7 +521,38 @@
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Capabilities: [150 v1] Device Serial Number 08-00-28-00-00-20-00-00
>  
> -11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
> -       !!! Unknown header type 7f
> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
> +       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
> +       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> +       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> +       Interrupt: pin A routed to IRQ 19
> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
> +       Region 4: I/O ports at c000 [disabled] [size=128]
> +       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
> +       Capabilities: [54] Power Management version 2
> +               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> +               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
> +       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
> +               Address: 0000000000000000  Data: 0000
> +       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
> +               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> +                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
> +               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> +                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> +                       MaxPayload 128 bytes, MaxReadReq 512 bytes
> +               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
> +               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
> +                       ClockPM- Surprise- LLActRep- BwNot-
> +               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> +       Capabilities: [100 v1] Advanced Error Reporting
> +               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> +               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> +               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> +               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> +               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> +               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Kernel driver in use: sata_sil24
>  
> 
> 
> The last hotremoval caused:
> 
> --- lspci_vvv_ejected_and_reinserted.txt        2013-03-31 12:02:24.000000000 +0200
> +++ lspci_vvv_ejected_and_reinserted_ejected.txt        2013-03-31 12:03:16.000000000 +0200
> @@ -307,12 +307,12 @@
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>                         Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
> @@ -521,38 +521,7 @@
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Capabilities: [150 v1] Device Serial Number 08-00-28-00-00-20-00-00
>  
> -11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
> -       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
> -       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> -       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -       Interrupt: pin A routed to IRQ 19
> -       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
> -       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
> -       Region 4: I/O ports at c000 [disabled] [size=128]
> -       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
> -       Capabilities: [54] Power Management version 2
> -               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
> -       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
> -               Address: 0000000000000000  Data: 0000
> -       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
> -               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> -                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
> -               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> -                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> -                       MaxPayload 128 bytes, MaxReadReq 512 bytes
> -               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
> -               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
> -                       ClockPM- Surprise- LLActRep- BwNot-
> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> -                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> -       Capabilities: [100 v1] Advanced Error Reporting
> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> -               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> -               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> -               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> -               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> -               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
> +       !!! Unknown header type 7f
>         Kernel driver in use: sata_sil24
>  
> 
> 
> 
> 
> Maybe I should, unlike in most previous reports, show a diff between a colplugged state
> and the hotinserted states:
> 
> --- lspci_vvv_initial.txt       2013-03-31 12:01:05.000000000 +0200
> +++ lspci_vvv_ejected_and_reinserted.txt        2013-03-31 12:02:24.000000000 +0200
> @@ -293,7 +293,7 @@
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> @@ -313,7 +313,7 @@
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> -                       Changed: MRL- PresDet- LinkState-
> +                       Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> @@ -523,14 +523,13 @@
>  
>  11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
>         Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
> -       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> +       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -       Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 19
> -       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
> -       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
> -       Region 4: I/O ports at c000 [size=128]
> -       Expansion ROM at f6c00000 [disabled] [size=512K]
> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
> +       Region 4: I/O ports at c000 [disabled] [size=128]
> +       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
>         Capabilities: [54] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
> @@ -541,7 +540,7 @@
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> -                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
> +                       MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>                         ClockPM- Surprise- LLActRep- BwNot-
> 
> 
> 
> The comparison of the two hotremovals shows no diff.
> 
> I will provide the dmesg in a follow-up email.

Thanks!

> The acpidump you should have already received yesteday.

Yes.

Best Regards,
Huang Ying


