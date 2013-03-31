Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:33541 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753462Ab3CaKfc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2013 06:35:32 -0400
Message-ID: <51581170.30708@fold.natur.cuni.cz>
Date: Sun, 31 Mar 2013 12:35:28 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>   <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>   <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>   <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz>  <1364545211.1817.228.camel@yhuang-dev>  <5155A101.2090705@fold.natur.cuni.cz> <1364640886.5773.5.camel@yhuang-mobile.sh.intel.com>
In-Reply-To: <1364640886.5773.5.camel@yhuang-mobile.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ying,
  I have tested 4x your last patch. Somehow nothing gets logged to "dmesg"
when I hotremove or hotinsert the coldbooted eSATA card. Logging works so
enabling wifi via Fn+F2 is being logged. Also, eventual stacktraces
and kmemleaks.
  I removed the coldbooted card, inserted it and ejected it.


  In brief, lspci reports changes but there are no changes in /proc/interrupts
related to

  19:          0          0   IO-APIC-fasteoi   sata_sil24


and no changes at all in /proc/iomem which I expected to happen during
hotremoval and hotinsert (something broken in 3.9-rc1 with your patch).

All the runtime_status data were same after every tested step, so again,
no diffs to show but here are the values confirming laptop-mode-tools
enabled powersaving:

/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active


  So, the only diffs I could provide are from lspci -vvv. They show
sata_sil24 was loaded that is confirmed by lsmod at the end of all
tests.

--- lspci_vvv_initial.txt       2013-03-31 12:01:05.000000000 +0200
+++ lspci_vvv_ejected.txt       2013-03-31 12:01:24.000000000 +0200
@@ -293,7 +293,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -307,13 +307,13 @@
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet- LinkState-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -521,39 +521,7 @@
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [150 v1] Device Serial Number 08-00-28-00-00-20-00-00
 
-11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
-       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
-       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 64 bytes
-       Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
-       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
-       Region 4: I/O ports at c000 [size=128]
-       Expansion ROM at f6c00000 [disabled] [size=512K]
-       Capabilities: [54] Power Management version 2
-               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
-       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
-               Address: 0000000000000000  Data: 0000
-       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
-               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
-                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
-               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
-                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
-               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
-               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
-                       ClockPM- Surprise- LLActRep- BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
-                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
-       Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
-               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
+       !!! Unknown header type 7f
        Kernel driver in use: sata_sil24
 

The after a hotinsert I see:

--- lspci_vvv_ejected.txt       2013-03-31 12:01:24.000000000 +0200
+++ lspci_vvv_ejected_and_reinserted.txt        2013-03-31 12:02:24.000000000 +0200
@@ -307,12 +307,12 @@
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
@@ -521,7 +521,38 @@
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [150 v1] Device Serial Number 08-00-28-00-00-20-00-00
 
-11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
-       !!! Unknown header type 7f
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
+       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
+       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+       Interrupt: pin A routed to IRQ 19
+       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
+       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
+       Region 4: I/O ports at c000 [disabled] [size=128]
+       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
+       Capabilities: [54] Power Management version 2
+               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
+       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
+               Address: 0000000000000000  Data: 0000
+       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
+               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
+                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
+               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
+                       MaxPayload 128 bytes, MaxReadReq 512 bytes
+               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
+               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
+                       ClockPM- Surprise- LLActRep- BwNot-
+               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
+                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+       Capabilities: [100 v1] Advanced Error Reporting
+               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
+               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24
 


The last hotremoval caused:

--- lspci_vvv_ejected_and_reinserted.txt        2013-03-31 12:02:24.000000000 +0200
+++ lspci_vvv_ejected_and_reinserted_ejected.txt        2013-03-31 12:03:16.000000000 +0200
@@ -307,12 +307,12 @@
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
@@ -521,38 +521,7 @@
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [150 v1] Device Serial Number 08-00-28-00-00-20-00-00
 
-11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
-       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
-       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
-       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
-       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
-       Region 4: I/O ports at c000 [disabled] [size=128]
-       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
-       Capabilities: [54] Power Management version 2
-               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
-       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
-               Address: 0000000000000000  Data: 0000
-       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
-               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
-                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
-               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
-                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 512 bytes
-               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
-               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
-                       ClockPM- Surprise- LLActRep- BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
-                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
-       Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
-               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
+       !!! Unknown header type 7f
        Kernel driver in use: sata_sil24
 




Maybe I should, unlike in most previous reports, show a diff between a colplugged state
and the hotinserted states:

--- lspci_vvv_initial.txt       2013-03-31 12:01:05.000000000 +0200
+++ lspci_vvv_ejected_and_reinserted.txt        2013-03-31 12:02:24.000000000 +0200
@@ -293,7 +293,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -313,7 +313,7 @@
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet- LinkState-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -523,14 +523,13 @@
 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
-       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
-       Region 4: I/O ports at c000 [size=128]
-       Expansion ROM at f6c00000 [disabled] [size=512K]
+       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
+       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
+       Region 4: I/O ports at c000 [disabled] [size=128]
+       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
@@ -541,7 +540,7 @@
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
+                       MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-



The comparison of the two hotremovals shows no diff.

I will provide the dmesg in a follow-up email. The acpidump you should have
already received yesteday.

Thank you,
Martin

Huang Ying wrote:
> On Fri, 2013-03-29 at 15:11 +0100, Martin Mokrejs wrote:
>> Hi Ying,
>>   thank you for the patch. Here are the results.
> 
> Thanks for your help! It appears my previous patch does not help
> much :(.  Can you try below patch?  I think this is mainly for hotplug
> but may be helpful for xhci dead port bug too.
> 
> Please test this patch with laptop-mode-tool installed and enabled.  And
> before/after test, please get PCI devices runtime status with:
> 
> grep . /sys/bus/pci/devices/*/power/runtime_status
> 
> And please give me the full dmesg for boot and incremental dmesg for
> operations.  Could you give me the ACPI dump for your machine?
> 
> Best Regards,
> Huang Ying
> 
>>From c0179956fb396fe68f2a237713c7592feea87d16 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Fri, 8 Mar 2013 16:13:54 +0800
> Subject: [PATCH] pcie_hp_disable_rtpm
> 
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c |    8 ++++++++
>  drivers/pci/pci-acpi.c                 |   15 +++++++++++++++
>  drivers/pci/pci.c                      |    1 +
>  drivers/pci/pcie/portdrv_pci.c         |   12 +++++++++---
>  drivers/pci/slot.c                     |   18 ++++++++++++++++++
>  include/acpi/acpi_bus.h                |    1 +
>  include/linux/pci.h                    |    1 +
>  7 files changed, 53 insertions(+), 3 deletions(-)
> 
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -39,6 +39,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> +#include <linux/pm_runtime.h>
>  #include <asm/uaccess.h>
>  #include "../pci.h"
>  
> @@ -473,6 +474,9 @@ int __pci_hp_register(struct hotplug_slo
>  	dbg("Added slot %s to the list\n", name);
>  out:
>  	mutex_unlock(&pci_hp_mutex);
> +	/* Bridge runtime PM state may be influenced by hotplug */
> +	pm_runtime_resume(&bus->self->dev);
> +	dev_info(&bus->self->dev, "hotplug slot added!\n");
>  	return result;
>  }
>  
> @@ -489,6 +493,7 @@ int pci_hp_deregister(struct hotplug_slo
>  {
>  	struct hotplug_slot *temp;
>  	struct pci_slot *slot;
> +	struct pci_bus *bus;
>  
>  	if (!hotplug)
>  		return -ENODEV;
> @@ -508,8 +513,11 @@ int pci_hp_deregister(struct hotplug_slo
>  
>  	hotplug->release(hotplug);
>  	slot->hotplug = NULL;
> +	bus = slot->bus;
>  	pci_destroy_slot(slot);
>  	mutex_unlock(&pci_hp_mutex);
> +	pm_runtime_resume(&bus->self->dev);
> +	dev_info(&bus->self->dev, "hotplug slot removed!\n");
>  
>  	return 0;
>  }
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -154,9 +154,15 @@ static int pcie_port_runtime_idle(struct
>  	 */
>  	pci_walk_bus(pdev->subordinate, pci_dev_pme_poll, &pme_poll);
>  	/* Delay for a short while to prevent too frequent suspend/resume */
> -	if (!pme_poll)
> -		pm_schedule_suspend(dev, 10);
> -	return -EBUSY;
> +	if (pme_poll)
> +		return -EBUSY;
> +	if (pci_bus_has_hotplug_slots(pdev->subordinate)) {
> +		dev_info(&pdev->dev, "ppri: has hotplug slots, do not suspend!\n");
> +		return -EBUSY;
> +	}
> +	dev_info(&pdev->dev, "ppri: will go suspend, is_hotplug_bridge: %d.\n",
> +		 pdev->is_hotplug_bridge);
> +	return pm_schedule_suspend(dev, 10);
>  }
>  #else
>  #define pcie_port_runtime_suspend	NULL
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -345,6 +345,24 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(pci_renumber_slot);
>  
> +bool pci_bus_has_hotplug_slots(struct pci_bus *bus)
> +{
> +	struct pci_slot *slot;
> +	bool has_hotplug_slots = false;
> +
> +	down_read(&pci_bus_sem);
> +	list_for_each_entry(slot, &bus->slots, list) {
> +		if (slot->hotplug) {
> +			has_hotplug_slots = true;
> +			break;
> +		}
> +	}
> +	up_read(&pci_bus_sem);
> +
> +	return has_hotplug_slots;
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_has_hotplug_slots);
> +
>  /**
>   * pci_destroy_slot - decrement refcount for physical PCI slot
>   * @slot: struct pci_slot to decrement
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -722,6 +722,7 @@ struct pci_slot *pci_create_slot(struct
>  void pci_destroy_slot(struct pci_slot *slot);
>  void pci_renumber_slot(struct pci_slot *slot, int slot_nr);
>  int pci_scan_slot(struct pci_bus *bus, int devfn);
> +bool pci_bus_has_hotplug_slots(struct pci_bus *bus);
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>  unsigned int pci_scan_child_bus(struct pci_bus *bus);
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -43,10 +43,16 @@ static void pci_acpi_wake_bus(acpi_handl
>  static void pci_acpi_wake_dev(acpi_handle handle, u32 event, void *context)
>  {
>  	struct pci_dev *pci_dev = context;
> +	struct acpi_device *adev;
>  
>  	if (event != ACPI_NOTIFY_DEVICE_WAKE || !pci_dev)
>  		return;
>  
> +	if (!acpi_bus_get_device(handle, &adev)) {
> +		adev->wakeup.flags.run_wake_works = true;
> +		dev_info(&pci_dev->dev, "run wake works!\n");
> +	}
> +
>  	if (pci_dev->current_state == PCI_D3cold) {
>  		pci_wakeup_event(pci_dev);
>  		pm_runtime_resume(&pci_dev->dev);
> @@ -146,6 +152,15 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(
>  static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	int acpi_state, d_max;
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(&pdev->dev);
> +	struct acpi_device *adev;
> +
> +	if (pci_is_bridge(pdev) && !acpi_bus_get_device(handle, &adev)) {
> +		if (!adev->wakeup.flags.run_wake_works) {
> +			dev_info(&pdev->dev, "choose state, run wake not verified\n");
> +			return PCI_D0;
> +		}
> +	}
>  
>  	if (pdev->no_d3cold)
>  		d_max = ACPI_STATE_D3_HOT;
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -245,6 +245,7 @@ struct acpi_device_perf {
>  struct acpi_device_wakeup_flags {
>  	u8 valid:1;		/* Can successfully enable wakeup? */
>  	u8 run_wake:1;		/* Run-Wake GPE devices */
> +	u8 run_wake_works:1;	/* Run-Wake works for the device */
>  	u8 notifier_present:1;  /* Wake-up notify handler has been installed */
>  };
>  
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1832,6 +1832,7 @@ int pci_finish_runtime_suspend(struct pc
>  	__pci_enable_wake(dev, target_state, true, pci_dev_run_wake(dev));
>  
>  	error = pci_set_power_state(dev, target_state);
> +	dev_info(&dev->dev, "pfrs: target: %d, %d\n", target_state, error);
>  
>  	if (error) {
>  		__pci_enable_wake(dev, target_state, true, false);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
