Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:54616 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932618Ab3CNAFz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2013 20:05:55 -0400
Message-ID: <5141145E.4020300@fold.natur.cuni.cz>
Date: Thu, 14 Mar 2013 01:05:50 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <513FE7AD.2020408@huawei.com>
In-Reply-To: <513FE7AD.2020408@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yjing,

Yijing Wang wrote:
> Hi Martin,
>    From your diff info, maybe we can analyze this problem step by step.
> 1、According to your diff info about first eject and first hot add, the pci device 11:00.0 Mass storage
>    controller was removed and was added ok at pci device level;

I can't confirm that it it was removed fine but looks like hot re-inserting the
card somewhat returns us to the anticipated state. Would I have hot added completely
different card I believe lspci would report mixture of both both, the cold-plugged-one
and of the hot-plugged one. Please see the thread
3.8.2: stale pci device info for a previously inserted express card
for what I mean (different kernel and acpiphp while here we are talking 3.9-rc1 and
pciehp but still I believe same would happen.)

> 2、The main problem is 11:00.0 Mass storage controller can not bind its driver normally, right?

Yes, and you can squeeze out few words from the driver only if you rmmod it.
Therefore I conclude the sata_sil24 cannot unbind the device and only during
rmmod it realizes it is gone. What pci driver failed to report the card was
ejected I don't know but seems per point 1. above that we agree that PresDet
worked fine (cold boot with the card inserted). So is sata_sil24 at fault?
Nobody commented on those express slot status values: 0000, 0040, 0100, 0108, 0138, 0140, 0148.
What are they?

> 3、According to diff info about first hotadd and coldplug, the mainly diff is
>> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
>> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
>> +       Region 4: I/O ports at c000 [disabled] [size=128]
> 
> and
> MaxReadReq 4096 bytes ----> MaxReadReq 512 bytes
> 
> So maybe we can try to find why the memory range was disabled after hot add.
> 
> Martin, can you provide  /proc/iomem info when the system bootup, after first eject and
> first hot-add?

Not a single change, look:

# diff -u -w iomem.txt iomem_ejected.txt
# diff -u -w iomem_ejected.txt iomem_ejected_and_reinserted.txt

At this moment lspci reports:

# diff -u -w lspci_vvvxxx.txt lspci_vvvxxx_ejected_and_reinserted.txt
--- lspci_vvvxxx.txt    2013-03-14 00:23:25.000000000 +0100
+++ lspci_vvvxxx_ejected_and_reinserted.txt     2013-03-14 00:27:26.000000000 +0100
@@ -437,7 +437,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -457,7 +457,7 @@
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet- LinkState-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -476,11 +476,11 @@
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
-10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
+50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -795,14 +795,13 @@
 
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
@@ -813,29 +812,29 @@
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
-               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
+                       MaxPayload 128 bytes, MaxReadReq 512 bytes
+               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
+               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
+               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24
-00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
-10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
-20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
-30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
+00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
+10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
+20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
+30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-70: 10 00 11 00 03 00 00 00 00 50 0a 00 11 f4 03 00
+70: 10 00 11 00 03 00 00 00 00 20 00 00 11 f4 03 00
 80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
#


I had to rmmod the driver to trigger at least some change:

# diff -u -w iomem_ejected_and_reinserted.txt iomem_ejected_and_reinserted_rmmod_sata_sil24.txt
--- iomem_ejected_and_reinserted.txt    2013-03-14 00:27:38.000000000 +0100
+++ iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
@@ -44,9 +44,7 @@
   f6c00000-f7cfffff : PCI Bus 0000:11
     f6c00000-f6c7ffff : 0000:11:00.0
     f6c80000-f6c83fff : 0000:11:00.0
-      f6c80000-f6c83fff : sata_sil24
     f6c84000-f6c8407f : 0000:11:00.0
-      f6c84000-f6c8407f : sata_sil24
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
     f7d10000-f7d11fff : 0000:0b:00.0
# diff -u -w iomem_ejected_and_reinserted_rmmod_sata_sil24.txt iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt
--- iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
+++ iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt       2013-03-14 00:32:48.000000000 +0100
@@ -34,17 +34,12 @@
 dfa00000-feafffff : PCI Bus 0000:00
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
-  f0000000-f10fffff : PCI Bus 0000:11
   f1100000-f11fffff : PCI Bus 0000:05
     f1100000-f1103fff : 0000:05:00.0
       f1100000-f1103fff : r8169
     f1104000-f1104fff : 0000:05:00.0
       f1104000-f1104fff : r8169
   f6800000-f6bfffff : 0000:00:02.0
-  f6c00000-f7cfffff : PCI Bus 0000:11
-    f6c00000-f6c7ffff : 0000:11:00.0
-    f6c80000-f6c83fff : 0000:11:00.0
-    f6c84000-f6c8407f : 0000:11:00.0
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
     f7d10000-f7d11fff : 0000:0b:00.0
#

accompanied lspci output showing what happened during rmmod sata_sil24:

# diff -u -w lspci_vvvxxx_ejected_and_reinserted.txt lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt 
--- lspci_vvvxxx_ejected_and_reinserted.txt     2013-03-14 00:27:26.000000000 +0100
+++ lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt    2013-03-14 00:30:06.000000000 +0100
@@ -451,12 +451,12 @@
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
@@ -473,19 +473,19 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
+50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
@@ -793,54 +793,22 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
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
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
-               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
-                       ClockPM- Surprise- LLActRep- BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
-                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
-       Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
-       Kernel driver in use: sata_sil24
-00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
-10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
-20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
-30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
-40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
-60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-70: 10 00 11 00 03 00 00 00 00 20 00 00 11 f4 03 00
-80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
-90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
+       !!! Unknown header type 7f
+00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 

Please note the funny broken:

+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
+       !!! Unknown header type 7f
+00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Who is still thinking the card is in the system? Didn't we agree above that PresDet
worked fine in this particular setup?

The rmmod sata_sil24 causes that in dmesg is every second repeatedly this, until forever:

--- dmesg_ejected.txt   2013-03-14 00:25:59.000000000 +0100
+++ dmesg_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:47.000000000 +0100
@@ -819,3 +819,277 @@
 [   37.426390] r8169 0000:05:00.0 eth0: link up
 [   38.686210] r8169 0000:05:00.0 eth0: link down
 [   42.551461] r8169 0000:05:00.0 eth0: link up
+[  432.686232] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  432.695763] pcieport 0000:00:1c.7: PME# enabled
+[  432.956104] pcieport 0000:00:1c.7: PME# disabled
+[  432.965896] pcieport 0000:00:1c.7: PME# enabled
+[  433.006119] pcieport 0000:00:1c.7: PME# disabled
+[  433.016047] pcieport 0000:00:1c.7: PME# enabled
+[  434.037451] pcieport 0000:00:1c.7: PME# disabled
+[  434.047152] pcieport 0000:00:1c.7: PME# enabled
+[  434.087516] pcieport 0000:00:1c.7: PME# disabled
[cut]



I should have tried below to remove 11.0 instead of 1.c7 but it demonstrates
that one can get rid of the partial eSATA card entry from lspci output:

# echo 1 > /sys/bus/pci/devices/0000\:00\:1c.7/remove

That stops the PME# storm:

+[  611.843285] pcieport 0000:00:1c.7: PME# disabled
+[  611.853086] pcieport 0000:00:1c.7: PME# enabled
+[  611.893364] pcieport 0000:00:1c.7: PME# disabled
+[  611.903283] pcieport 0000:00:1c.7: PME# enabled
+[  612.183893] pci 0000:11:00.0: PME# disabled
+[  612.184789] pcieport 0000:00:1c.7: PME# disabled
+[  612.203753] pcieport 0000:00:1c.7: PME# disabled
+[  612.205521] pci_bus 0000:11: busn_res: [bus 11-16] is released

and releases the iomem's:

# diff -u -w iomem_ejected_and_reinserted_rmmod_sata_sil24.txt iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt 
--- iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
+++ iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt       2013-03-14 00:32:48.000000000 +0100
@@ -34,17 +34,12 @@
 dfa00000-feafffff : PCI Bus 0000:00
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
-  f0000000-f10fffff : PCI Bus 0000:11
   f1100000-f11fffff : PCI Bus 0000:05
     f1100000-f1103fff : 0000:05:00.0
       f1100000-f1103fff : r8169
     f1104000-f1104fff : 0000:05:00.0
       f1104000-f1104fff : r8169
   f6800000-f6bfffff : 0000:00:02.0
-  f6c00000-f7cfffff : PCI Bus 0000:11
-    f6c00000-f6c7ffff : 0000:11:00.0
-    f6c80000-f6c83fff : 0000:11:00.0
-    f6c84000-f6c8407f : 0000:11:00.0
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
     f7d10000-f7d11fff : 0000:0b:00.0
#

The accompanying diff in lspci:

# diff -u -w lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt 
--- lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt    2013-03-14 00:30:06.000000000 +0100
+++ lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt        2013-03-14 00:32:20.000000000 +0100
@@ -429,69 +429,6 @@
 e0: 00 3f 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
 
-00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
-       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 64 bytes
-       Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
-       I/O behind bridge: 0000c000-0000dfff
-       Memory behind bridge: f6c00000-f7cfffff
-       Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
-       BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
-               PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
-       Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
-               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
-                       ExtTag- RBE+ FLReset-
-               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
-                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
-               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
-                       ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
-                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
-               SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
-                       Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
-               SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
-                       Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
-                       Changed: MRL- PresDet- LinkState+
-               RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
-               RootCap: CRSVisible-
-               RootSta: PME ReqID 0000, PMEStatus- PMEPending-
-               DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
-               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
-               LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
-                        Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
-                        Compliance De-emphasis: -6dB
-               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
-                        EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
-       Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
-               Address: 00000000  Data: 0000
-       Capabilities: [90] Subsystem: Dell Device 04b3
-       Capabilities: [a0] Power Management version 2
-               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
-       Kernel driver in use: pcieport
-00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
-10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
-20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
-30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
-40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
-60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
-70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
-80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
-b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
-e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
-f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
-
 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
        Subsystem: Dell Device 04b3
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
@@ -793,22 +730,3 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
-11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
-       !!! Unknown header type 7f
-00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
-
#

> 
> I suspect the driver release its MMIO successfully after first eject.

I did not think so and hope I convinced you that this is NOT the case. ;-)

Thanks for you time on this, we will find it! ;)
Martin

> 
> Thanks!
> Yijing.
> 
> 
> On 2013/3/12 9:00, Martin Mokrejs wrote:
>> Hi,
>>   I cold-booted a computer with the card inserted before power-on and collected
>> lspci output and express card slot status every second. Then I tried eject and
>> hotplug inserts and it appearts the card is not detected, actually maybe pciehp
>> is not even suppoosed to work in this case as the slot was occupied during boot.
>> But let me come to it later.
>>
>> I noted the following on the very first eject of the so far cold-plugged card
>> that lspci properly reports PresDet change on the Changed: line. The only time
>> I ever saw it. ;-)
>> However, for any following inserts and ejects the value is not updated but slot
>> status bits are updated. I had BIOS defaults loaded and additionally, disabled
>> MediaCardReader.
>>
>> The slot status bits read by setpci were changing in this path:
>> card in slot and cold boot 0040 -> eject 0100 hotplug insert -> 0140 eject -> 0100 hotplug insert -> 0140 eject -> 0100
>>
>>
>>
>> --- lspci_loop.23:58:50 2013-03-11 23:58:50.000000000 +0100
>> +++ lspci_loop.23:58:51 2013-03-11 23:58:51.000000000 +0100
>> @@ -439,7 +439,7 @@
>>         I/O behind bridge: 0000c000-0000dfff
>>         Memory behind bridge: f6c00000-f7cfffff
>>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
>> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>> @@ -453,13 +453,13 @@
>>                         ClockPM- Surprise- LLActRep+ BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
>>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>> -                       Changed: MRL- PresDet- LinkState-
>> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>> +                       Changed: MRL- PresDet+ LinkState+
>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>                 RootCap: CRSVisible-
>>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> @@ -478,11 +478,11 @@
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Kernel driver in use: pcieport
>>  00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>> -10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
>> +10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
>>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
>> -50: 40 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
>> +50: 40 00 11 50 60 b2 3c 00 00 00 08 01 00 00 00 00
>>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> @@ -490,7 +490,7 @@
>>  a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
>> +d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
>>  e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>>  f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
>>  
>> @@ -797,55 +797,23 @@
>>  e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
>>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  
>> -11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
>> -       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
>> -       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> -       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> -       Latency: 0, Cache Line Size: 64 bytes
>> -       Interrupt: pin A routed to IRQ 19
>> -       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
>> -       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
>> -       Region 4: I/O ports at c000 [size=128]
>> -       Expansion ROM at f6c00000 [disabled] [size=512K]
>> -       Capabilities: [54] Power Management version 2
>> -               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>> -       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>> -               Address: 0000000000000000  Data: 0000
>> -       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
>> -               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>> -                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>> -               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> -                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> -                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
>> -               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>> -               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>> -                       ClockPM- Surprise- LLActRep- BwNot-
>> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>> -                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>> -       Capabilities: [100 v1] Advanced Error Reporting
>> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>> -               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>> -               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>> -               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> -               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> -               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
>> +       !!! Unknown header type 7f
>>         Kernel driver in use: sata_sil24
>> -00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
>> -10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
>> -20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
>> -30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
>> -40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
>> -60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -70: 10 00 11 00 03 00 00 00 00 50 0a 00 11 f4 03 00
>> -80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
>> -90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> --- lspci_loop.23:58:51 2013-03-11 23:58:51.000000000 +0100
>> +++ lspci_loop.23:58:52 2013-03-11 23:58:52.000000000 +0100
>> @@ -459,7 +459,7 @@
>>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>> -                       Changed: MRL- PresDet+ LinkState+
>> +                       Changed: MRL- PresDet- LinkState+
>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>                 RootCap: CRSVisible-
>>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> @@ -482,7 +482,7 @@
>>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
>> -50: 40 00 11 50 60 b2 3c 00 00 00 08 01 00 00 00 00
>> +50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
>>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> @@ -490,7 +490,7 @@
>>  a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
>> +d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
>>  e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>>  f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
>> --- lspci_loop.23:58:58 2013-03-11 23:58:58.000000000 +0100
>> +++ lspci_loop.23:58:59 2013-03-11 23:58:59.000000000 +0100
>> @@ -101,7 +101,7 @@
>>         Capabilities: [98] PCI Advanced Features
>>                 AFCap: TP+ FLR+
>>                 AFCtrl: FLR-
>> -               AFStatus: TP-
>> +               AFStatus: TP+
>>         Kernel driver in use: ehci-pci
>>  00: 86 80 2d 1c 06 00 90 02 05 20 03 0c 00 00 00 00
>>  10: 00 80 f0 f7 00 00 00 00 00 00 00 00 00 00 00 00
>> --- lspci_loop.23:58:59 2013-03-11 23:58:59.000000000 +0100
>> +++ lspci_loop.23:59:00 2013-03-11 23:59:00.000000000 +0100
>> @@ -101,7 +101,7 @@
>>         Capabilities: [98] PCI Advanced Features
>>                 AFCap: TP+ FLR+
>>                 AFCtrl: FLR-
>> -               AFStatus: TP+
>> +               AFStatus: TP-
>>         Kernel driver in use: ehci-pci
>>  00: 86 80 2d 1c 06 00 90 02 05 20 03 0c 00 00 00 00
>>  10: 00 80 f0 f7 00 00 00 00 00 00 00 00 00 00 00 00
>>
>>
>>
>> Below is the first hotplug of the card.
>>
>> --- lspci_loop.23:59:09 2013-03-11 23:59:09.000000000 +0100
>> +++ lspci_loop.23:59:10 2013-03-11 23:59:10.000000000 +0100
>> @@ -453,12 +453,12 @@
>>                         ClockPM- Surprise- LLActRep+ BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
>> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>>                         Changed: MRL- PresDet- LinkState+
>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>                 RootCap: CRSVisible-
>> @@ -482,7 +482,7 @@
>>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
>> -50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
>> +50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
>>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> @@ -797,23 +797,54 @@
>>  e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
>>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  
>> -11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
>> -       !!! Unknown header type 7f
>> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
>> +       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
>> +       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> +       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> +       Interrupt: pin A routed to IRQ 19
>> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
>> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
>> +       Region 4: I/O ports at c000 [disabled] [size=128]
>> +       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
>> +       Capabilities: [54] Power Management version 2
>> +               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>> +               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>> +       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>> +               Address: 0000000000000000  Data: 0000
>> +       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
>> +               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>> +                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>> +               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> +                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> +                       MaxPayload 128 bytes, MaxReadReq 512 bytes
>> +               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>> +               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>> +                       ClockPM- Surprise- LLActRep- BwNot-
>> +               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>> +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>> +       Capabilities: [100 v1] Advanced Error Reporting
>> +               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>> +               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>> +               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>> +               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> +               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> +               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>>         Kernel driver in use: sata_sil24
>> -00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> -f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
>> +10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
>> +20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
>> +30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
>> +40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
>> +60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +70: 10 00 11 00 03 00 00 00 00 20 0a 00 11 f4 03 00
>> +80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
>> +90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> --- lspci_loop.23:59:15 2013-03-11 23:59:15.000000000 +0100
>> +++ lspci_loop.23:59:16 2013-03-11 23:59:16.000000000 +0100
>> @@ -519,7 +519,7 @@
>>  60: 20 20 ff 07 00 00 00 00 01 00 00 01 00 00 08 40
>>  70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 00 00 80 00 11 88 0c 93 30 0d 00 24 00 00 00 00
>> -90: 00 00 00 00 00 00 00 00 13 00 06 03 00 00 00 00
>> +90: 00 00 00 00 00 00 00 00 13 00 06 03 00 01 00 00
>>  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> --- lspci_loop.23:59:16 2013-03-11 23:59:16.000000000 +0100
>> +++ lspci_loop.23:59:17 2013-03-11 23:59:17.000000000 +0100
>> @@ -519,7 +519,7 @@
>>  60: 20 20 ff 07 00 00 00 00 01 00 00 01 00 00 08 40
>>  70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 00 00 80 00 11 88 0c 93 30 0d 00 24 00 00 00 00
>> -90: 00 00 00 00 00 00 00 00 13 00 06 03 00 01 00 00
>> +90: 00 00 00 00 00 00 00 00 13 00 06 03 00 00 00 00
>>  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>>
>> And later unplug of the hotplugged device:
>>
>> --- lspci_loop.23:59:18 2013-03-11 23:59:18.000000000 +0100
>> +++ lspci_loop.23:59:19 2013-03-11 23:59:19.000000000 +0100
>> @@ -453,12 +453,12 @@
>>                         ClockPM- Surprise- LLActRep+ BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
>>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>>                         Changed: MRL- PresDet- LinkState+
>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>                 RootCap: CRSVisible-
>> @@ -482,7 +482,7 @@
>>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
>> -50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
>> +50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
>>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> @@ -797,54 +797,23 @@
>>  e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
>>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  
>> -11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
>> -       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
>> -       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> -       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> -       Interrupt: pin A routed to IRQ 19
>> -       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
>> -       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
>> -       Region 4: I/O ports at c000 [disabled] [size=128]
>> -       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
>> -       Capabilities: [54] Power Management version 2
>> -               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>> -       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
>> -               Address: 0000000000000000  Data: 0000
>> -       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
>> -               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>> -                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>> -               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> -                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> -                       MaxPayload 128 bytes, MaxReadReq 512 bytes
>> -               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>> -               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>> -                       ClockPM- Surprise- LLActRep- BwNot-
>> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>> -                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>> -       Capabilities: [100 v1] Advanced Error Reporting
>> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>> -               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>> -               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>> -               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> -               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> -               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
>> +       !!! Unknown header type 7f
>>         Kernel driver in use: sata_sil24
>> -00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
>> -10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
>> -20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
>> -30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
>> -40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
>> -60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -70: 10 00 11 00 03 00 00 00 00 20 0a 00 11 f4 03 00
>> -80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
>> -90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> +f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>
>>
>>
>>
>>
>> Already from other tests I realized a hotplugged eSATA has some "[virtual]
>> Expansion ROM". Here is a reasonably complete diff between a coldplugged
>> state of the same card and after a hotplug. In dmesg pciehp complained
>> upon its loading that Cache Line Size 64 is not supported so maybe the below
>> difference is a direct result of that? Similarly, MaxReadReq is different
>> and I bet the lines
>>
>> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
>> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
>> +       Region 4: I/O ports at c000 [disabled] [size=128]
>>
>> actually mean the card is left disabled. Then, I am not surprised nothing
>> is shown upon its hotplug insert/eject in dmesg. ;-) In this particular setup
>> I don't think we are facing a PresDet issue. Either, the value is overwritten
>> by some other process, or the bug is somewhere else.
>>
>>
>> --- lspci_loop.23:58:26 2013-03-11 23:58:26.000000000 +0100
>> +++ lspci_loop.23:59:10 2013-03-11 23:59:10.000000000 +0100
>> @@ -439,7 +439,7 @@
>>         I/O behind bridge: 0000c000-0000dfff
>>         Memory behind bridge: f6c00000-f7cfffff
>>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
>> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>> @@ -459,7 +459,7 @@
>>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>> -                       Changed: MRL- PresDet- LinkState-
>> +                       Changed: MRL- PresDet- LinkState+
>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>                 RootCap: CRSVisible-
>>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> @@ -478,11 +478,11 @@
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Kernel driver in use: pcieport
>>  00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>> -10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
>> +10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
>>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
>> -50: 40 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
>> +50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
>>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> @@ -799,14 +799,13 @@
>>  
>>  11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
>>         Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
>> -       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> +       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> -       Latency: 0, Cache Line Size: 64 bytes
>>         Interrupt: pin A routed to IRQ 19
>> -       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
>> -       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
>> -       Region 4: I/O ports at c000 [size=128]
>> -       Expansion ROM at f6c00000 [disabled] [size=512K]
>> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
>> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
>> +       Region 4: I/O ports at c000 [disabled] [size=128]
>> +       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
>>         Capabilities: [54] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>> @@ -817,7 +816,7 @@
>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> -                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
>> +                       MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>>                         ClockPM- Surprise- LLActRep- BwNot-
>> @@ -832,14 +831,14 @@
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>                 AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>>         Kernel driver in use: sata_sil24
>> -00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
>> -10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
>> -20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
>> -30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
>> +00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
>> +10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
>> +20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
>> +30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
>>  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
>>  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -70: 10 00 11 00 03 00 00 00 00 50 0a 00 11 f4 03 00
>> +70: 10 00 11 00 03 00 00 00 00 20 0a 00 11 f4 03 00
>>  80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
>>  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>>
>>
>> Sadly, although the very first eject was notified the sata_sila24 neither
>> did "release" the device nor did it complain that it suddenly disappeared.
>> That was so far always in dmesg output (like for example):
>>
>> [  251.632928] sata_sil24 0000:11:00.0: PME# disabled
>> [  251.636498] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
>>
>>
>> I re-plugged the card and ejected several times while the while loops
>> collecting lspci and slot_status via the setpci shell command harvested
>> data. Still, in dmesg there was nothing logged regarding card insert/eject.
>> Eventually, I tried rmmod sata_sil24 (did NOT need 'rmmod -f') and that
>> did log something new.
>>
>> [  529.571040] ata8.00: disabled
>> [  529.576365] sd 7:0:0:0: [sdb] Synchronizing SCSI cache
>> [  529.577202] sd 7:0:0:0: [sdb]  
>> [  529.577204] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>> [  529.577205] sd 7:0:0:0: [sdb] Stopping disk
>> [  529.577251] sd 7:0:0:0: [sdb] START_STOP FAILED
>> [  529.577253] sd 7:0:0:0: [sdb]  
>> [  529.577254] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>> [  529.578309] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
>> [  605.818905] sata_sil24 0000:11:00.0: version 1.1
>> [  605.818923] sata_sil24 0000:11:00.0: enabling device (0000 -> 0003)
>> [  605.914722] sata_sil24 0000:11:00.0: failed to clear port RST
>> [  606.014860] sata_sil24 0000:11:00.0: failed to clear port RST
>> [  606.014882] sata_sil24 0000:11:00.0: enabling bus mastering
>> [  606.017741] scsi8 : sata_sil24
>> [  606.019388] scsi9 : sata_sil24
>> [  606.019898] ata9: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
>> [  606.019902] ata10: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
>> [  606.115003] ata9: controller in dubious state, performing PORT_RST
>> [  608.327747] ata9: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
>> [  608.427847] ata10: controller in dubious state, performing PORT_RST
>> [  610.640619] ata10: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
>>
>>
>>
>>
>> Finally, I am tempted to say that pciehp does not work at all under 3.9-rc1
>> if the slot was occupied during boot. It does NOT contain the usual debug
>> info spanning several lines and it only said:
>>
>> [    2.109629] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> [    2.110225] pciehp: pcie_port_service_register = 0
>> [    2.110226] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
>>
>> If that is intentional the driver should complain loudly. Please educate me
>> what those "[virtual] Expansion ROM's" were in lspci above and whether those
>> "[disabled]" memory ranges relate to that as well. If the card is not thought
>> to be present or just not recognized ... why is that printed in lspci at all?
>> Similarly, what can you tell me if lspci output shows only:
>>
>> Latency: 0
>>
>> or even lacks the whole "Latency" line altoghether, is that also a disabled device?
>>
>> I believe in working cases there is "Latency: 0, Cache Line Size: 64 bytes" instead.
>>
>>
>>
>> Details and raw files at: http://195.113.57.32/~mmokrejs/tmp/3.9-rc1_disabled_MediaCard_reader_eSATA_coldplugged.tar.bz2
>>
>> To inspect the incremental diffs of lspci output I used:
>>
>> prev='/dev/null'; ls -latr lspci_* | awk '{print $9}' | while read cur; do diff -u -w $prev $cur | less; prev=$cur; done
>>
>> Thank you,
>> Martin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> .
>>
> 
> 
