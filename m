Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:44809 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752761Ab3CaSsu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2013 14:48:50 -0400
Message-ID: <5158850E.2080102@fold.natur.cuni.cz>
Date: Sun, 31 Mar 2013 20:48:46 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>  <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>  <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>  <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz> <1364545211.1817.228.camel@yhuang-dev>
In-Reply-To: <1364545211.1817.228.camel@yhuang-dev>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ying,
  I have re-tested your "second" patch from your email sent on 03/29/13 09:20.
Just to be sure. I returned back to the habit of doing 'rmmod sata_sil24' sometimes
in addition to the usual physical eject/insert of the eSATA card. It happened
to me that I got a new type of messages from the sata_sil24 ... which are interesting
and that is why I am writing this email. The last one, for the next days I wish.

I "complained" already that commonly to all your three patches, no messages
are logged by the kernel during hotinsert/hotremoval. Something just broke logging
in pci/pcieport.


At the pci level hot insert/eject looks working at least as PresDet says
in lspci. However, from dmesg(1) perspective removals and inserts seem
"unnoticed". Now, after I do rmmod sata_sil24 I got finally some messages
from the kernel:

# diff -u -w dmesg_initial.txt dmesg_ejected_inserted_ejected_rmmod_sata_sil24.txt 
--- dmesg_initial.txt   2013-03-31 15:58:08.000000000 +0200
+++ dmesg_ejected_inserted_ejected_rmmod_sata_sil24.txt 2013-03-31 16:00:57.000000000 +0200
@@ -818,3 +818,7 @@
 [   31.689134] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x1b
 [   31.689397] microcode: CPU1 updated to revision 0x28, date = 2012-04-24
 [   31.689400] perf_event_intel: PEBS enabled due to microcode update
+[  237.198970] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  237.199120] pcieport 0000:00:1c.7: PME# enabled
+[  246.330463] pcieport 0000:00:1c.7: PME# disabled
+[  246.330587] pcieport 0000:00:1c.7: PME# enabled
#

To see the PME values add to the above lines bootup status:

# grep PME dmesg_initial.txt
[    1.569697] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.569722] pci 0000:00:16.0: PME# disabled
[    1.571837] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.571843] pci 0000:00:1a.0: PME# disabled
[    1.592505] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.592511] pci 0000:00:1b.0: PME# disabled
[    1.594505] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.594511] pci 0000:00:1c.0: PME# disabled
[    1.595886] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.595891] pci 0000:00:1c.1: PME# disabled
[    1.597321] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.597326] pci 0000:00:1c.3: PME# disabled
[    1.598827] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.598832] pci 0000:00:1c.4: PME# disabled
[    1.601708] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    1.601713] pci 0000:00:1c.7: PME# disabled
[    1.603625] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.603631] pci 0000:00:1d.0: PME# disabled
[    1.626526] pci 0000:00:1f.2: PME# supported from D3hot
[    1.626533] pci 0000:00:1f.2: PME# disabled
[    1.631221] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.631228] pci 0000:05:00.0: PME# disabled
[    1.634980] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    1.635032] pci 0000:09:00.0: PME# disabled
[    1.636915] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.636921] pci 0000:0b:00.0: PME# disabled
[   14.215072] pcieport 0000:00:1c.0: PME# enabled
[   14.233911] r8169 0000:05:00.0: PME# enabled
[   23.133946] r8169 0000:05:00.0: PME# disabled
#


Doh! I don't see 11:00 in the coldboot listing. Why nothing related to 11:00
is logged at all? The card was inserted during boot.
Comparing bootup dmesg files from an unpatched 3.9-rc1 to this patch I see
that your patch caused:

  rtc_cmos 00:04: RTC can wake from S4
+ rtc (null): alarm rollover: day
  rtc rtc0: rtc_cmos: dev (254:0)
  rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
  rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs

also the following reorderings happen due to your patch:

  iwlwifi 0000:09:00.0: RF_KILL bit toggled to disable radio.
  ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
  ata7: SATA link down (SStatus 0 SControl 0)
+ pcieport 0000:00:1c.0: PME# enabled
+ r8169 0000:05:00.0: PME# enabled
  [drm] Memory usable by graphics device = 2048M
  i915 0000:00:02.0: setting latency timer to 64
  i915 0000:00:02.0: irq 44 for MSI/MSI-X
@@ -791,8 +794,12 @@
  [drm] Wrong MCH_SSKPD value: 0x16040307
  [drm] This can cause pipe underruns and display issues.
  [drm] Please upgrade your BIOS to fix this.
- fbcon: inteldrmfb (fb0) is primary device
  ata8: SATA link down (SStatus 0 SControl 0)
+ fbcon: inteldrmfb (fb0) is primary device
+ r8169 0000:05:00.0 eth0: rtl_phyar_cond == 1 (loop: 20, delay: 25).
+ r8169 0000:05:00.0 eth0: rtl_phyar_cond == 1 (loop: 20, delay: 25).
+ r8169 0000:05:00.0 eth0: rtl_phyar_cond == 1 (loop: 20, delay: 25).
+ r8169 0000:05:00.0 eth0: rtl_phyar_cond == 1 (loop: 20, delay: 25).
  Console: switching to colour frame buffer device 170x48
  i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
  i915 0000:00:02.0: registered panic notifier
@@ -800,22 +807,14 @@
  ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
  input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input12
  [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
- r8169 0000:05:00.0: PME# enabled
- pcieport 0000:00:1c.0: PME# enabled
  [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
  EXT3-fs (sda5): using internal journal
  Adding 4998972k swap on /dev/sda6.  Priority:-1 extents:1 across:4998972k 
  r8169 0000:05:00.0: PME# disabled
  r8169 0000:05:00.0 eth0: unable to load firmware patch rtl_nic/rtl8168e-2.fw (-2)
  r8169 0000:05:00.0 eth0: link down
- r8169 0000:05:00.0 eth0: link down
- r8169 0000:05:00.0 eth0: link up
- r8169 0000:05:00.0 eth0: link down
  microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x1b
  microcode: CPU0 updated to revision 0x28, date = 2012-04-24
  microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x1b
  microcode: CPU1 updated to revision 0x28, date = 2012-04-24
  perf_event_intel: PEBS enabled due to microcode update
- r8169 0000:05:00.0 eth0: link up
- r8169 0000:05:00.0 eth0: link down
- r8169 0000:05:00.0 eth0: link up


I don't why is there the extra debug print on the rtl8169 device
bound to 05:00. Wasn't your patch aimed to change 1c.7 and 11:00
debug? ;-)





While still thinking of dmesg missing so far common log output it
would be nice if pci drivers reported the PME# disabled status of
the 11:00 device during cold boot. Likewise sata_sil24 could do it
in addition as well. Something is broken during cold boot already
in 3.9-rc1.

In my previous emails in many places you can find that the eSATA card
supports only D1 and D2. Somewhere at the end of this email you will
see once sata_sil24 complaining that the device was believed to be
in D3. I suspect the kernel thinks it is in D3 state after every
hot eject. Yet another bug?


lspci after the cold boot of patched 3.9-rc1 shows the following:

00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport


11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
        Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
        Region 4: I/O ports at c000 [size=128]
        Expansion ROM at f6c00000 [disabled] [size=512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24


So, looks PME# is disabled for 11:00? Looking what runtime_status says:

# cat runtime_status_initial.txt 
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
#


The hotremoval of the cold booted eSATA card does not affect /proc/interrupts.
It still says that sata_sil24 is using IRQ 19. Wrong. Also /proc/iomem
is lying and reporting stale data:

# diff -u -w iomem_initial.txt iomem_ejected.txt 
# grep 11:00 iomem_ejected.txt 
    f6c00000-f6c7ffff : 0000:11:00.0
    f6c80000-f6c83fff : 0000:11:00.0
    f6c84000-f6c8407f : 0000:11:00.0
#

I believe it is nothing new but if anything is able to realize a hotremoval happened
under pciehp + your patch, then it is lspci. At least something is correct:

 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
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
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport

[cut]
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
+       !!! Unknown header type 7f
        Kernel driver in use: sata_sil24


I have two ideas. The MAbort+ is preventing "kernel" to remove the PCI entry for the 11:00 device.
Second, the sata_sil24 cannot release and maybe due to that /proc/iomem and /proc/interrupts is
not updated?

A subsequent hotinsert does not clear the MAbort+ value although from the rest of lspci output
I would believe it worked fine (after the caching of /sys data fixed maybe we will realize that
also lspci does not report all value, now we just don't know what is cached and what is not,
that is not visible in chimeric lspci entries when two differnet cards were exchanged):

 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-


While the rest of the PCI detection works. I do not have an external drive available right now
to test but believe the 11:00 would have been functional despite the "Control: I/O- Mem- BusMaster-"
and "Latency: 0, Cache Line Size: 64 bytes" being gone altogether.


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
        Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
+                       MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24

When I do rmmod sata_sil24 the stale 11:00 entry is removed. Notably, 1c.7 is
placed into PME#enabled, a D3 state (I will return to this later also):

 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport

[cut]

 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
        !!! Unknown header type 7f
-       Kernel driver in use: sata_sil24
 

The rmmod cause finally something logged by kernel:

 [   31.688061] microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x1b
 [   31.688576] microcode: CPU0 updated to revision 0x28, date = 2012-04-24
 [   31.689134] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x1b
 [   31.689397] microcode: CPU1 updated to revision 0x28, date = 2012-04-24
 [   31.689400] perf_event_intel: PEBS enabled due to microcode update
+[  237.198970] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  237.199120] pcieport 0000:00:1c.7: PME# enabled
+[  246.330463] pcieport 0000:00:1c.7: PME# disabled
+[  246.330587] pcieport 0000:00:1c.7: PME# enabled

The third PME# enabled is likely due to the laptop-mode-tools re-enabling the suspend?


It looks the sata_sil24 driver loading is wrong if upstream root port 1c.7
has disabled powersaving. Due to that, it does not bother to report what powersaving
states are suppported by the eSATA card?

 [  432.700796] pcieport 0000:00:1c.7: PME# disabled
+[  536.295010] sata_sil24 0000:11:00.0: version 1.1
+[  536.295027] sata_sil24 0000:11:00.0: enabling device (0000 -> 0003)
+[  536.389064] sata_sil24 0000:11:00.0: failed to clear port RST
+[  536.489186] sata_sil24 0000:11:00.0: failed to clear port RST
+[  536.489207] sata_sil24 0000:11:00.0: enabling bus mastering
+[  536.492029] scsi8 : sata_sil24
+[  536.492701] scsi9 : sata_sil24
+[  536.493183] ata9: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
+[  536.493187] ata10: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
+[  536.599398] ata9: controller in dubious state, performing PORT_RST
+[  538.812110] ata9: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
+[  538.912214] ata10: controller in dubious state, performing PORT_RST
+[  541.124965] ata10: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)

The diff of runtime_status should show instead that 11:00 appear *newly* in the kernel,
not that it moved from supended state to active:

@@ -7,7 +7,7 @@
 /sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
-/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:suspended
+/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:suspended
 /sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
@@ -15,4 +15,4 @@
 /sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
 /sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
 /sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended
-/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:suspended
+/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active

Because of that I believe around [  432.700796] was not associated change
about 11:00, but maybe that stems already since the bootup times that
no *initial* PME status was ever logged for 11:00. For sure we are hitting
here a bug due to cached /proc or /sys data.

This is bringing kernel into a more screwed state. Here, clearly, the hot removal
does not work under pciehp, lspci shows 0xff for 11:00 bogus entry sata_sil24
cannot release the device and therefore, /proc/interrupts and /proc/iomem
report stale data. Doing rmmod sata_sil24 works but it only clears one
of the three iomem ranges while it leaves those for 11:00 device.  That
is confirmed by lspci showing that just no driver is associated with the
bogus 11:00 device. It is 

/proc/iomem
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

lspci diff: 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
        !!! Unknown header type 7f
-       Kernel driver in use: sata_sil24
 

interrupts diff:
- 19:          0          0   IO-APIC-fasteoi   sata_sil24


The /proc/interrupts change caused by the rmmod sata_sil24 is interesting. It
shows that lspci failed to report that the bogus 11:00 entry with 0xff register
values had actually allocated IRQ 19. Or did we just get rid of cached /proc
value?


There is one more scenarion what happens if kernel believes per /proc/iomem
and /proc/interrupts that the eSATA card is inserted. Doing a modprobe sata_sil24
causes the driver to be loaded but it reveals other source of wrong input
values. Note: I already commented the [  432.700796] - [  623.588496] range above
but include it here so you can compare both unusual scenarios.


 [  432.700796] pcieport 0000:00:1c.7: PME# disabled
 [  536.295010] sata_sil24 0000:11:00.0: version 1.1
 [  536.295027] sata_sil24 0000:11:00.0: enabling device (0000 -> 0003)
 [  536.389064] sata_sil24 0000:11:00.0: failed to clear port RST
 [  536.489186] sata_sil24 0000:11:00.0: failed to clear port RST
 [  536.489207] sata_sil24 0000:11:00.0: enabling bus mastering
 [  536.492029] scsi8 : sata_sil24
 [  536.492701] scsi9 : sata_sil24
 [  536.493183] ata9: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
 [  536.493187] ata10: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
 [  536.599398] ata9: controller in dubious state, performing PORT_RST
 [  538.812110] ata9: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
 [  538.912214] ata10: controller in dubious state, performing PORT_RST
 [  541.124965] ata10: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
 [  623.588496] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  685.684189] pcieport 0000:00:1c.0: PME# disabled
+[  689.884813] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)  <- I believe the i2c_801 issue
+[  939.557549] pcieport 0000:00:1c.0: PME# enabled
+[  939.575079] pcieport 0000:00:1c.7: PME# enabled
+[  974.021661] pcieport 0000:00:1c.0: PME# disabled
+[  974.041697] pcieport 0000:00:1c.7: PME# disabled
+[ 1048.450168] sata_sil24 0000:11:00.0: version 1.1
+[ 1048.463692] sata_sil24 0000:11:00.0: Refused to change power state, currently in D3
+[ 1048.563818] sata_sil24 0000:11:00.0: failed to clear port RST
+[ 1048.663935] sata_sil24 0000:11:00.0: failed to clear port RST
+[ 1048.666779] scsi10 : sata_sil24
+[ 1048.667394] scsi11 : sata_sil24
+[ 1048.667900] ata11: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
+[ 1048.667902] ata12: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
+[ 1048.764083] ata11: controller in dubious state, performing PORT_RST
+[ 1050.976850] ata11: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
+[ 1051.076943] ata12: controller in dubious state, performing PORT_RST
+[ 1053.289699] ata12: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)


Provided the eSATA card does not support D3 I wonder whether sata_sil24 reports
the status of the root port 1c.7 by mistake or whether it really reports bad
values deemed about 11:00 itself. What happens in pci/pcieport driver if a device
does not report supported powersaving states? Usually, the sata_sil24 reports
"pci 0000:11:00.0: supports D1 D2" and I just miss anything similar to this line
in the abobve dmesg outputs.


The driver during [ 1048.450168] - [ 1053.289699] received IRQ 19 as usually
(there was a diff in /proc/interrupts).
In contrary, because /proc/iomem claimed 11:00 device was before the modprobe already
in the system the only iomem change actually visible was that the driver associated
with the memory ranges:

013-03-31 16:18:09.000000000 +0200
@@ -1,86 +1,88 @@
 00000000-00000fff : reserved
 00001000-0009d3ff : System RAM
 0009d400-0009ffff : reserved
 000a0000-000bffff : PCI Bus 0000:00
 000c0000-000cedff : Video ROM
 000cf000-000cffff : Adapter ROM
 000d0000-000d3fff : PCI Bus 0000:00
 000d4000-000d7fff : PCI Bus 0000:00
 000d8000-000dbfff : PCI Bus 0000:00
 000dc000-000dffff : PCI Bus 0000:00
 000e0000-000fffff : reserved
   000e0000-000e3fff : PCI Bus 0000:00
   000e4000-000e7fff : PCI Bus 0000:00
   000f0000-000fffff : System ROM
 00100000-1fffffff : System RAM
   01000000-015e40c9 : Kernel code
   015e40ca-019b0d7f : Kernel data
   01aaa000-02571fff : Kernel bss
 20000000-201fffff : reserved
   20000000-201fffff : pnp 00:0c
 20200000-3fffffff : System RAM
 40000000-401fffff : reserved
   40000000-401fffff : pnp 00:0c
 40200000-da4e4fff : System RAM
 da4e5000-da527fff : ACPI Non-volatile Storage
 da528000-da792fff : System RAM
 da793000-da966fff : reserved
 da967000-daa88fff : System RAM
 daa89000-dad67fff : reserved
 dad68000-dafe7fff : ACPI Non-volatile Storage
 dafe8000-daffffff : ACPI Tables
 db000000-db7fffff : RAM buffer
 db800000-df9fffff : reserved
 dfa00000-feafffff : PCI Bus 0000:00
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
   f0000000-f10fffff : PCI Bus 0000:11
   f1100000-f11fffff : PCI Bus 0000:05
     f1100000-f1103fff : 0000:05:00.0
       f1100000-f1103fff : r8169
     f1104000-f1104fff : 0000:05:00.0
       f1104000-f1104fff : r8169
   f6800000-f6bfffff : 0000:00:02.0
   f6c00000-f7cfffff : PCI Bus 0000:11
     f6c00000-f6c7ffff : 0000:11:00.0
     f6c80000-f6c83fff : 0000:11:00.0
+      f6c80000-f6c83fff : sata_sil24
     f6c84000-f6c8407f : 0000:11:00.0
+      f6c84000-f6c8407f : sata_sil24
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
     f7d10000-f7d11fff : 0000:0b:00.0
   f7e00000-f7efffff : PCI Bus 0000:09
     f7e00000-f7e01fff : 0000:09:00.0
       f7e00000-f7e01fff : iwlwifi
   f7f00000-f7f03fff : 0000:00:1b.0
     f7f00000-f7f03fff : ICH HD audio
   f7f05000-f7f050ff : 0000:00:1f.3
   f7f06000-f7f067ff : 0000:00:1f.2
     f7f06000-f7f067ff : ahci
   f7f07000-f7f073ff : 0000:00:1d.0
   f7f08000-f7f083ff : 0000:00:1a.0
   f7f0a000-f7f0a00f : 0000:00:16.0
   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f8000000-fbffffff : reserved
       f8000000-fbffffff : pnp 00:0a
   fe800000-fe802fff : pnp 00:07
 fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
 fed00000-fed03fff : reserved
   fed00000-fed003ff : HPET 0
 fed10000-fed17fff : pnp 00:0a
 fed18000-fed18fff : pnp 00:0a
 fed19000-fed19fff : pnp 00:0a
 fed1c000-fed1ffff : reserved
   fed1c000-fed1ffff : pnp 00:0a
     fed1f410-fed1f414 : iTCO_wdt
       fed1f410-fed1f414 : iTCO_wdt
 fed20000-fed3ffff : pnp 00:0a
 fed40000-fed44fff : PCI Bus 0000:00
 fed45000-fed8ffff : pnp 00:0a
 fed90000-fed93fff : pnp 00:0a
 fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
 ff000000-ffffffff : reserved
   ff000000-ffffffff : pnp 00:0a
 100000000-41fdfffff : System RAM
 41fe00000-41fffffff : RAM buffer


I don't know about you but I am quite depressed by the number of weird issues
I hit here and there. However, I believe if nothing else, you can come up with
one, aggregate debug patch which will help to study any of the so far spotted
issues. I prefer a patch for 3.9-rc1. The patch should cope with the PME# issues
to be usable for acpiphp and xHCI "dead" port tests on 3.8.x (and likely 3.9).
Take your time.

I am looking forward to your answers, anyway,
Martin


Huang Ying wrote:
> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
>> Hi Ying,
>>   would you please tell me how this report relate to this patch?
>>
>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
>>
>>   Could you tell me why this PME was being flipped back and forth now?
>> Actually, does that make finally some sense to you, pci/acpi devs?
>>
>>
>>   Does is help to say that on the SandyBridge chip I have the following root ports
>> hooked to the following end devices?:
>>
>> 1.c1 -> rtl8169 05:00.0
>> 1.c3 -> iwlwifi 09:00.0
>> 1.c4 -> xhci_hcd 0b:00.0
>> 1.c7 -> 00:11: express card slot
>>
>>
>>   Why didn't I see interleraved lines with 1.c7 *and* 00:11? See the interleaving
>> happening with the network card on 3.7.10 kernel (not broken kernel):
>>
>> [138268.870070] r8169 0000:05:00.0 eth0: link down
>> [138270.809811] r8169 0000:05:00.0 eth0: link up
>> [138365.599744] r8169 0000:05:00.0 eth0: link down
>> [138370.594343] r8169 0000:05:00.0: PME# enabled
>> [138370.623852] pcieport 0000:00:1c.1: PME# enabled
>> [169885.247386] pcieport 0000:00:1c.1: PME# disabled
>> [169885.267374] r8169 0000:05:00.0: PME# disabled
>> [169885.330160] r8169 0000:05:00.0 eth0: link down
>> [169886.992531] r8169 0000:05:00.0 eth0: link up
>> [169904.405769] r8169 0000:05:00.0 eth0: link down
>> [169909.401237] r8169 0000:05:00.0: PME# enabled
>> [169909.430782] pcieport 0000:00:1c.1: PME# enabled
>> [170090.538980] pcieport 0000:00:1c.1: PME# disabled
>> [170090.559088] r8169 0000:05:00.0: PME# disabled
>> [170090.640494] r8169 0000:05:00.0: PME# enabled
>> [170090.678425] pcieport 0000:00:1c.1: PME# enabled
>> [170090.829959] pcieport 0000:00:1c.1: PME# disabled
>> [170090.848479] r8169 0000:05:00.0: PME# disabled
>> [170090.892011] r8169 0000:05:00.0 eth0: link down
>> [170090.892134] r8169 0000:05:00.0 eth0: link down
>> [170090.930998] r8169 0000:05:00.0 eth0: link down
>> [170092.554553] r8169 0000:05:00.0 eth0: link up
> 
> I don't know exactly.  Can you give me the follow output?
> 
> grep . /sys/bus/pci/devices/*/power/control
> grep . /sys/bus/pci/devices/*/power/runtime_status
> 
> And can you try the following patch?
> 
> Best Regards,
> Huang Ying
> 
> -------------------------->
> 
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c |    6 ++++++
>  drivers/pci/pcie/portdrv_pci.c         |    8 +++++---
>  drivers/pci/slot.c                     |   18 ++++++++++++++++++
>  include/linux/pci.h                    |    1 +
>  4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index 202f4a9..7d4cf1a 100644
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
> @@ -473,6 +474,8 @@ int __pci_hp_register(struct hotplug_slot *slot, struct pci_bus *bus,
>  	dbg("Added slot %s to the list\n", name);
>  out:
>  	mutex_unlock(&pci_hp_mutex);
> +	/* Bridge runtime PM state may be influenced by hotplug */
> +	pm_runtime_resume(&bus->self->dev);
>  	return result;
>  }
>  
> @@ -489,6 +492,7 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
>  {
>  	struct hotplug_slot *temp;
>  	struct pci_slot *slot;
> +	struct pci_bus *bus;
>  
>  	if (!hotplug)
>  		return -ENODEV;
> @@ -508,8 +512,10 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
>  
>  	hotplug->release(hotplug);
>  	slot->hotplug = NULL;
> +	bus = slot->bus;
>  	pci_destroy_slot(slot);
>  	mutex_unlock(&pci_hp_mutex);
> +	pm_runtime_resume(&bus->self->dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 08c243a..beb9c90 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -154,9 +154,11 @@ static int pcie_port_runtime_idle(struct device *dev)
>  	 */
>  	pci_walk_bus(pdev->subordinate, pci_dev_pme_poll, &pme_poll);
>  	/* Delay for a short while to prevent too frequent suspend/resume */
> -	if (!pme_poll)
> -		pm_schedule_suspend(dev, 10);
> -	return -EBUSY;
> +	if (pme_poll)
> +		return -EBUSY;
> +	if (pci_bus_has_hotplug_slots(pdev->subordinate))
> +		return -EBUSY;
> +	return pm_schedule_suspend(dev, 10);
>  }
>  #else
>  #define pcie_port_runtime_suspend	NULL
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index ac6412f..10b275b 100644
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
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2461033a..0d0cc94 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -722,6 +722,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  void pci_destroy_slot(struct pci_slot *slot);
>  void pci_renumber_slot(struct pci_slot *slot, int slot_nr);
>  int pci_scan_slot(struct pci_bus *bus, int devfn);
> +bool pci_bus_has_hotplug_slots(struct pci_bus *bus);
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>  unsigned int pci_scan_child_bus(struct pci_bus *bus);
> 
> 
> 
