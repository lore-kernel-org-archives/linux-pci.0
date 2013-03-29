Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:36065 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755224Ab3C2OLT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2013 10:11:19 -0400
Message-ID: <5155A101.2090705@fold.natur.cuni.cz>
Date: Fri, 29 Mar 2013 15:11:13 +0100
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
  thank you for the patch. Here are the results.

Huang Ying wrote:
> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
>> Hi Ying,
>>   would you please tell me how this report relate to this patch?
>>
>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
>>
>>   Could you tell me why this PME was being flipped back and forth now?
>> Actually, does that make finally some sense to you, pci/acpi devs?



  First of all, now, due to you patch, the following is logged after I run lspci
(I tried several time lspci with none, -v, -vvv, -tv options):

--- dmesg_initial.txt   2013-03-29 14:13:44.000000000 +0100
+++ dmesg_with_eSATA_ejected.txt        2013-03-29 14:16:37.000000000 +0100
@@ -827,3 +827,40 @@
 [   46.635843] r8169 0000:05:00.0: PME# disabled
 [   46.728762] r8169 0000:05:00.0 eth0: link down
 [   48.449706] r8169 0000:05:00.0 eth0: link up
+[  117.546597] pcieport 0000:00:1c.4: PME# enabled
+[  117.642825] pcieport 0000:00:1c.4: PME# disabled
+[  117.642913] pcieport 0000:00:1c.4: PME# enabled
+[  117.682862] pcieport 0000:00:1c.4: PME# disabled
+[  117.682950] pcieport 0000:00:1c.4: PME# enabled
+[  117.722906] pcieport 0000:00:1c.4: PME# disabled
+[  117.722994] pcieport 0000:00:1c.4: PME# enabled
+[  117.762962] pcieport 0000:00:1c.4: PME# disabled
+[  117.763055] pcieport 0000:00:1c.4: PME# enabled
+[  117.803062] pcieport 0000:00:1c.4: PME# disabled
+[  117.803149] pcieport 0000:00:1c.4: PME# enabled
+[  117.843061] pcieport 0000:00:1c.4: PME# disabled
+[  117.843156] pcieport 0000:00:1c.4: PME# enabled
+[  117.883108] pcieport 0000:00:1c.4: PME# disabled
+[  117.883204] pcieport 0000:00:1c.4: PME# enabled
+[  117.923210] pcieport 0000:00:1c.4: PME# disabled
+[  117.923297] pcieport 0000:00:1c.4: PME# enabled
+[  117.963206] pcieport 0000:00:1c.4: PME# disabled
+[  117.963295] pcieport 0000:00:1c.4: PME# enabled
+[  118.003259] pcieport 0000:00:1c.4: PME# disabled
+[  118.003348] pcieport 0000:00:1c.4: PME# enabled
+[  118.043354] pcieport 0000:00:1c.4: PME# disabled
+[  118.043453] pcieport 0000:00:1c.4: PME# enabled
+[  118.083353] pcieport 0000:00:1c.4: PME# disabled
+[  118.083441] pcieport 0000:00:1c.4: PME# enabled
+[  118.123472] pcieport 0000:00:1c.4: PME# disabled
+[  118.123564] pcieport 0000:00:1c.4: PME# enabled
+[  185.527864] pcieport 0000:00:1c.4: PME# disabled
+[  185.527989] pcieport 0000:00:1c.4: PME# enabled
+[  191.958942] pcieport 0000:00:1c.4: PME# disabled
+[  191.959067] pcieport 0000:00:1c.4: PME# enabled
+[  195.104378] pcieport 0000:00:1c.4: PME# disabled
+[  195.104501] pcieport 0000:00:1c.4: PME# enabled
+[  204.670888] pcieport 0000:00:1c.4: PME# disabled
+[  204.671012] pcieport 0000:00:1c.4: PME# enabled
+[  227.029510] pcieport 0000:00:1c.4: PME# disabled
+[  227.029636] pcieport 0000:00:1c.4: PME# enabled

Provided that on 1c.4 is the TI USB3 controller we are hitting again the weird interaction
between USB and the express card slot on this computer.

# cat lspci_tv_initial.txt
-[0000:00]-+-00.0  Intel Corporation 2nd Generation Core Processor Family DRAM Controller
           +-02.0  Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller
           +-16.0  Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1
           +-1a.0  Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2
           +-1b.0  Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller
           +-1c.0-[03-04]--
           +-1c.1-[05-06]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168 PCI Express Gigabit Ethernet controller
           +-1c.3-[09-0a]----00.0  Intel Corporation Centrino Wireless-N 1030 [Rainbow Peak]
           +-1c.4-[0b-0c]----00.0  Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller
           +-1c.7-[11-16]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
           +-1d.0  Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1
           +-1f.0  Intel Corporation HM67 Express Chipset Family LPC Controller
           +-1f.2  Intel Corporation 6 Series/C200 Series Chipset Family 6 port SATA AHCI Controller
           \-1f.3  Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller
#

The 3.9-rc1-ying kernel was compiled with:

$ gzip -dc config.gz | grep USB 
# CONFIG_USB_SWITCH_FSA9480 is not set
# USB GPIO expanders:
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB_ARCH_HAS_XHCI=y
# CONFIG_USB_SUPPORT is not set
$

  Kernel commandline was as in previous tests in this thread:
pciehp.pciehp_debug=1 pciehp_debug=1 slub_debug=AFPZ pcie_aspm=off



  Second, after I ejected the coldplugged eSATA card these 1c.4: PME# messages also
popped up in dmesg. I think just the very last two PME# lines shown above were added (so about
the [  227.029510] time).

  At the "lspci level", the eject resulted in:

# diff -u8 -w lspci_vvv_initial.txt lspci_vvv_with_eSATA_ejected.txt
--- lspci_vvv_initial.txt       2013-03-29 14:13:56.000000000 +0100
+++ lspci_vvv_with_eSATA_ejected.txt    2013-03-29 14:17:09.000000000 +0100
@@ -288,37 +288,37 @@
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
-                       Changed: MRL- PresDet- LinkState-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
@@ -516,44 +516,12 @@
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
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
 

  I think that's not new, somebody said already that the Changed: PresDet value is quickly
cleared to PresDet- (under pciehp, I believe this is not the case with acpiphp but let's
ignore this now).
  Why LinkState+ remains I don't know.




  Third, after the 'rmmod sata_sil24' there is an improvement! (no PME# flipping back and forth)
but what is going on with the root port handling XHCI controller I have no idea:

--- dmesg_with_eSATA_ejected.txt        2013-03-29 14:16:37.000000000 +0100
+++ dmesg_with_eSATA_ejected_and_rmmod_sata_sil24.txt   2013-03-29 14:19:07.000000000 +0100
@@ -864,3 +864,35 @@
 [  204.671012] pcieport 0000:00:1c.4: PME# enabled
 [  227.029510] pcieport 0000:00:1c.4: PME# disabled
 [  227.029636] pcieport 0000:00:1c.4: PME# enabled
+[  311.755721] pcieport 0000:00:1c.4: PME# disabled
+[  311.755848] pcieport 0000:00:1c.4: PME# enabled
+[  311.805807] pcieport 0000:00:1c.4: PME# disabled
+[  311.805900] pcieport 0000:00:1c.4: PME# enabled
+[  311.845877] pcieport 0000:00:1c.4: PME# disabled
+[  311.845968] pcieport 0000:00:1c.4: PME# enabled
+[  311.886058] pcieport 0000:00:1c.4: PME# disabled
+[  311.886149] pcieport 0000:00:1c.4: PME# enabled
+[  311.926012] pcieport 0000:00:1c.4: PME# disabled
+[  311.926109] pcieport 0000:00:1c.4: PME# enabled
+[  311.966080] pcieport 0000:00:1c.4: PME# disabled
+[  311.966172] pcieport 0000:00:1c.4: PME# enabled
+[  312.006146] pcieport 0000:00:1c.4: PME# disabled
+[  312.006244] pcieport 0000:00:1c.4: PME# enabled
+[  312.046220] pcieport 0000:00:1c.4: PME# disabled
+[  312.046319] pcieport 0000:00:1c.4: PME# enabled
+[  312.086359] pcieport 0000:00:1c.4: PME# disabled
+[  312.086450] pcieport 0000:00:1c.4: PME# enabled
+[  312.126359] pcieport 0000:00:1c.4: PME# disabled
+[  312.126451] pcieport 0000:00:1c.4: PME# enabled
+[  312.166432] pcieport 0000:00:1c.4: PME# disabled
+[  312.166524] pcieport 0000:00:1c.4: PME# enabled
+[  312.206550] pcieport 0000:00:1c.4: PME# disabled
+[  312.206648] pcieport 0000:00:1c.4: PME# enabled
+[  312.246565] pcieport 0000:00:1c.4: PME# disabled
+[  312.246656] pcieport 0000:00:1c.4: PME# enabled
+[  312.286635] pcieport 0000:00:1c.4: PME# disabled
+[  312.286731] pcieport 0000:00:1c.4: PME# enabled
+[  318.607575] pcieport 0000:00:1c.4: PME# disabled
+[  318.607702] pcieport 0000:00:1c.4: PME# enabled
+[  388.129192] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  388.129339] pcieport 0000:00:1c.7: PME# enabled





  Forth, the rmmod released IRQ19 of the eSATA card. I did not conenct any device to it maybe
that is why there were 0 interruputs on it?

# diff -u -w interrupts_with_eSATA_ejected.txt interrupts_with_eSATA_ejected_and_rmmod_sata_sil24.txt 
--- interrupts_with_eSATA_ejected.txt   2013-03-29 14:16:49.000000000 +0100
+++ interrupts_with_eSATA_ejected_and_rmmod_sata_sil24.txt      2013-03-29 14:19:00.000000000 +0100
@@ -1,27 +1,26 @@
            CPU0       CPU1       
   0:         24          0   IO-APIC-edge      timer
-  1:       1710          0   IO-APIC-edge      i8042
+  1:       2458          0   IO-APIC-edge      i8042
   8:         62          0   IO-APIC-edge      rtc0
-  9:         20          0   IO-APIC-fasteoi   acpi
+  9:         22          0   IO-APIC-fasteoi   acpi
  12:        520          0   IO-APIC-edge      i8042
- 19:          0          0   IO-APIC-fasteoi   sata_sil24
- 40:       4223          0   PCI-MSI-edge      ahci
- 41:        571          0   PCI-MSI-edge      eth0
+ 40:       4334          0   PCI-MSI-edge      ahci
+ 41:        728          0   PCI-MSI-edge      eth0
  42:        948          0   PCI-MSI-edge      snd_hda_intel
  43:          1          0   PCI-MSI-edge      iwlwifi
  44:        203          0   PCI-MSI-edge      i915
-NMI:         12         35   Non-maskable interrupts
-LOC:      10849       6919   Local timer interrupts
+NMI:         14         35   Non-maskable interrupts
+LOC:      13541       7743   Local timer interrupts
 SPU:          0          0   Spurious interrupts
-PMI:         12         35   Performance monitoring interrupts
+PMI:         14         35   Performance monitoring interrupts
 IWI:          0          0   IRQ work interrupts
 RTR:          0          0   APIC ICR read retries
-RES:       4073       4299   Rescheduling interrupts
-CAL:         18       2191   Function call interrupts
+RES:       4166       4519   Rescheduling interrupts
+CAL:         18       2216   Function call interrupts
 TLB:        123        100   TLB shootdowns
 TRM:          0          0   Thermal event interrupts
 THR:          0          0   Threshold APIC interrupts
 MCE:          0          0   Machine check exceptions
-MCP:          2          2   Machine check polls
+MCP:          3          3   Machine check polls
 ERR:          0
 MIS:          0
#

 Fifth, after the rmmod I grabbed these values:
# grep . /sys/bus/pci/devices/*/power/control
/sys/bus/pci/devices/0000:00:00.0/power/control:auto
/sys/bus/pci/devices/0000:00:02.0/power/control:auto
/sys/bus/pci/devices/0000:00:16.0/power/control:auto
/sys/bus/pci/devices/0000:00:1a.0/power/control:auto
/sys/bus/pci/devices/0000:00:1b.0/power/control:auto
/sys/bus/pci/devices/0000:00:1c.0/power/control:auto
/sys/bus/pci/devices/0000:00:1c.1/power/control:auto
/sys/bus/pci/devices/0000:00:1c.3/power/control:auto
/sys/bus/pci/devices/0000:00:1c.4/power/control:auto
/sys/bus/pci/devices/0000:00:1c.7/power/control:auto
/sys/bus/pci/devices/0000:00:1d.0/power/control:auto
/sys/bus/pci/devices/0000:00:1f.0/power/control:auto
/sys/bus/pci/devices/0000:00:1f.2/power/control:auto
/sys/bus/pci/devices/0000:00:1f.3/power/control:auto
/sys/bus/pci/devices/0000:05:00.0/power/control:auto
/sys/bus/pci/devices/0000:09:00.0/power/control:auto
/sys/bus/pci/devices/0000:0b:00.0/power/control:auto
/sys/bus/pci/devices/0000:11:00.0/power/control:auto
# grep . /sys/bus/pci/devices/*/power/runtime_status
/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:suspended
#



Finally, after hot-insert the eSATA card did not get IRQ (per /proc/interrupts) as before
and in lspci it reported as before the "[virtual] ROM ...." and SltSta Changed: PresDet-.

# diff -u -w lspci_vvv_with_eSATA_ejected_and_rmmod_sata_sil24.txt lspci_vvv_with_eSATA_ejected_and_rmmod_sata_sil24_and_reinserted.txt 
--- lspci_vvv_with_eSATA_ejected_and_rmmod_sata_sil24.txt       2013-03-29 14:19:18.000000000 +0100
+++ lspci_vvv_with_eSATA_ejected_and_rmmod_sata_sil24_and_reinserted.txt        2013-03-29 14:27:24.000000000 +0100
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
@@ -521,6 +521,37 @@
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
+               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
+               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
+                       ClockPM- Surprise- LLActRep- BwNot-
+               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
+                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+       Capabilities: [100 v1] Advanced Error Reporting
+               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+               CESta:  RxErr- BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr-
+               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-




So, in summary, I think it is a bit better now for me. I get extra debug messages that something
is going on with 1c.4 port (I tested in console mode but in int level 3 but that i did also
in the past).

Hope this helps,
Martin


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
