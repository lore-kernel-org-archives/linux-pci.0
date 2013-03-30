Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:39344 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757266Ab3C3Bhs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2013 21:37:48 -0400
Message-ID: <51563D32.70106@fold.natur.cuni.cz>
Date: Sat, 30 Mar 2013 02:17:38 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <1364545211.1817.228.camel@yhuang-dev> <5155A101.2090705@fold.natur.cuni.cz> <5381191.45N5KLLmWJ@vostro.rjw.lan>
In-Reply-To: <5381191.45N5KLLmWJ@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rafael J. Wysocki wrote:
> On Friday, March 29, 2013 03:11:13 PM Martin Mokrejs wrote:
>> Hi Ying,
>>   thank you for the patch. Here are the results.
>>
>> Huang Ying wrote:
>>> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
>>>> Hi Ying,
>>>>   would you please tell me how this report relate to this patch?
>>>>
>>>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
>>>>
>>>>   Could you tell me why this PME was being flipped back and forth now?
>>>> Actually, does that make finally some sense to you, pci/acpi devs?
> 
> Can you please test this patch:
> 
> https://patchwork.kernel.org/patch/2359611/
> 
> and report back as I asked you?

Sorry for the delay I just had to sort out what belongs under what thread
and the patch was under the other. But I agree its testing with this
particular eSATA/ExpressCardSlot/PM fits better here.


The good news is that the eSATA card hotplug works almost perfectly with the patch.
I cold booted as always with the card in the slot already loaded, same kernel
.config and commandline options as described under this thread. But the kernel
was 3.8.3! Not 3.9-rc1.

What is important is the fact that this patch resulted in runtime_status set to
"active" instead of "auto" (3.8.3 with incidentally enabled laptop-mode-tools)
or "on" (also tested on 3.8.3 once laptop-mode-tools were uninstalled). With this
patch, devices did not get suspended during the tests (per /sys/*/power/runtime_status
files). I haven't realized so far that the rtl8169 card at 05:00 and the TI xHCI
controller at 0b:00 support D2 state.

# grep PME dmesg_final.txt 
[    1.571475] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.571500] pci 0000:00:16.0: PME# disabled
[    1.571760] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.571766] pci 0000:00:1a.0: PME# disabled
[    1.571991] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.571997] pci 0000:00:1b.0: PME# disabled
[    1.572200] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.572205] pci 0000:00:1c.0: PME# disabled
[    1.572409] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.572414] pci 0000:00:1c.1: PME# disabled
[    1.572618] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.572623] pci 0000:00:1c.3: PME# disabled
[    1.572826] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.572832] pci 0000:00:1c.4: PME# disabled
[    1.573042] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    1.573047] pci 0000:00:1c.7: PME# disabled
[    1.573292] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.573297] pci 0000:00:1d.0: PME# disabled
[    1.573765] pci 0000:00:1f.2: PME# supported from D3hot
[    1.573770] pci 0000:00:1f.2: PME# disabled
[    1.574521] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.574528] pci 0000:05:00.0: PME# disabled
[    1.587449] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    1.587500] pci 0000:09:00.0: PME# disabled
[    1.605568] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.605575] pci 0000:0b:00.0: PME# disabled
[  362.712584] sata_sil24 0000:11:00.0: PME# disabled
[ 1069.949732] sata_sil24 0000:11:00.0: PME# disabled
[ 1083.878783] sata_sil24 0000:11:00.0: PME# disabled
[ 1096.679536] sata_sil24 0000:11:00.0: PME# disabled
[ 1107.503274] sata_sil24 0000:11:00.0: PME# disabled
#

Seems the sata_sil24 does not report an equivalent of, for example:
[    1.605568] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold


The states before/after tests (did not change):
/sys/bus/pci/devices/0000:00:00.0/power/control:on
/sys/bus/pci/devices/0000:00:02.0/power/control:on
/sys/bus/pci/devices/0000:00:16.0/power/control:on
/sys/bus/pci/devices/0000:00:1a.0/power/control:on
/sys/bus/pci/devices/0000:00:1b.0/power/control:on
/sys/bus/pci/devices/0000:00:1c.0/power/control:on
/sys/bus/pci/devices/0000:00:1c.1/power/control:on
/sys/bus/pci/devices/0000:00:1c.3/power/control:on
/sys/bus/pci/devices/0000:00:1c.4/power/control:on
/sys/bus/pci/devices/0000:00:1c.7/power/control:on
/sys/bus/pci/devices/0000:00:1d.0/power/control:on
/sys/bus/pci/devices/0000:00:1f.0/power/control:on
/sys/bus/pci/devices/0000:00:1f.2/power/control:on
/sys/bus/pci/devices/0000:00:1f.3/power/control:on
/sys/bus/pci/devices/0000:05:00.0/power/control:on
/sys/bus/pci/devices/0000:09:00.0/power/control:on
/sys/bus/pci/devices/0000:0b:00.0/power/control:on
/sys/bus/pci/devices/0000:11:00.0/power/control:on

/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:active
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active




These 2 lines only are logged during hot eject of the eSATA card:

+[  362.712584] sata_sil24 0000:11:00.0: PME# disabled
+[  362.715773] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?



# diff -u50 -w lspci_vvv_initial_all_xHCI_tests_worked.txt lspci_vvv_initial_all_xHCI_tests_worked__eSATA_eject.txt
--- lspci_vvv_initial_all_xHCI_tests_worked.txt 2013-03-30 00:27:32.000000000 +0100
+++ lspci_vvv_initial_all_xHCI_tests_worked__eSATA_eject.txt    2013-03-30 00:28:28.000000000 +0100
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
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport

 
-11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
-       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
-       Physical Slot: 1
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
-       Kernel driver in use: sata_sil24
-
#


You see, no ff anymore in registers, no stale device info about the card being
already physically removed. That's good.


Also the hot-eject results in IRQ and memory release seem correct:

# diff -u -w interrupts.txt interrupts__eSATA_eject.txt
--- interrupts.txt      2013-03-30 00:25:40.000000000 +0100
+++ interrupts_eSATA_eject.txt   2013-03-30 00:28:48.000000000 +0100
@@ -1,32 +1,31 @@
            CPU0       CPU1       
   0:         25          0   IO-APIC-edge      timer
-  1:        780          0   IO-APIC-edge      i8042
+  1:       1975          0   IO-APIC-edge      i8042
   8:          7          0   IO-APIC-edge      rtc0
-  9:          0          0   IO-APIC-fasteoi   acpi
+  9:          1          0   IO-APIC-fasteoi   acpi
  12:        241          0   IO-APIC-edge      i8042
  16:         75          0   IO-APIC-fasteoi   ehci_hcd:usb1
- 19:          0          0   IO-APIC-fasteoi   sata_sil24
  23:         77          0   IO-APIC-fasteoi   ehci_hcd:usb2
- 40:       4025          0   PCI-MSI-edge      ahci
- 41:        521          0   PCI-MSI-edge      eth0
- 42:          0          0   PCI-MSI-edge      xhci_hcd
+ 40:       4215          0   PCI-MSI-edge      ahci
+ 41:        766          0   PCI-MSI-edge      eth0
+ 42:       1300          0   PCI-MSI-edge      xhci_hcd
  43:          0          0   PCI-MSI-edge      xhci_hcd
  44:          0          0   PCI-MSI-edge      xhci_hcd
  45:        227          0   PCI-MSI-edge      snd_hda_intel
  46:          1          0   PCI-MSI-edge      iwlwifi
  47:          4          0   PCI-MSI-edge      i915
-NMI:         12         30   Non-maskable interrupts
-LOC:       7833       6076   Local timer interrupts
+NMI:         15         32   Non-maskable interrupts
+LOC:      10899       8387   Local timer interrupts
 SPU:          0          0   Spurious interrupts
-PMI:         12         30   Performance monitoring interrupts
+PMI:         15         32   Performance monitoring interrupts
 IWI:          0          0   IRQ work interrupts
 RTR:          0          0   APIC ICR read retries
-RES:       4707       3838   Rescheduling interrupts
-CAL:         12       1841   Function call interrupts
-TLB:         95         45   TLB shootdowns
+RES:       6217       6921   Rescheduling interrupts
+CAL:         15       1855   Function call interrupts
+TLB:         98         45   TLB shootdowns
 TRM:          0          0   Thermal event interrupts
 THR:          0          0   Threshold APIC interrupts
 MCE:          0          0   Machine check exceptions
-MCP:          2          2   Machine check polls
+MCP:          3          3   Machine check polls
 ERR:          0
 MIS:          0
# diff -u -w iomem.txt iomem_eSATA_eject.txt
--- iomem_initial.txt   2013-03-30 00:25:31.000000000 +0100
+++ iomem_initial_all_xHCI_tests_worked__eSATA_eject.txt        2013-03-30 00:28:39.000000000 +0100
@@ -42,11 +42,6 @@
       f1104000-f1104fff : r8169
   f6800000-f6bfffff : 0000:00:02.0
   f6c00000-f7cfffff : PCI Bus 0000:11
-    f6c00000-f6c7ffff : 0000:11:00.0
-    f6c80000-f6c83fff : 0000:11:00.0
-      f6c80000-f6c83fff : sata_sil24
-    f6c84000-f6c8407f : 0000:11:00.0
-      f6c84000-f6c8407f : sata_sil24
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
       f7d00000-f7d0ffff : xhci_hcd
#

Even better, also hot-insert works now:

--- dmesg_eSATA_eject.txt        2013-03-30 00:28:17.000000000 +0100
+++ dmesg_eSATA_eject_hotinsert.txt      2013-03-30 00:29:40.000000000 +0100
@@ -4543,3 +4543,169 @@
+[  415.214425] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+[  415.214470] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+[  415.214503] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+[  415.214524] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+[  415.214564] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+[  415.214692] pci 0000:11:00.0: supports D1 D2
+[  415.235200] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+[  415.235204] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+[  415.235227] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+[  415.235229] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+[  415.235250] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+[  415.235251] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+[  415.235259] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+[  415.236357] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+[  415.236580] sata_sil24 0000:11:00.0: enabling bus mastering
+[  415.239813] scsi10 : sata_sil24
+[  415.240576] scsi11 : sata_sil24
+[  415.241188] ata9: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+[  415.241192] ata10: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+[  417.320268] ata9: SATA link down (SStatus 0 SControl 0)
+[  419.407170] ata10: SATA link down (SStatus 0 SControl 0)


The memory allocated is a bit different (comparing cold boot state
to the one after hotplug -- I mean not empty slot against hot-inserted card state):

--- iomem.txt   2013-03-30 00:25:31.000000000 +0100
+++ iomem_eSATA_eject_and_hotinsert.txt      2013-03-30 00:29:22.000000000 +0100
@@ -35,6 +35,7 @@
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
   f0000000-f10fffff : PCI Bus 0000:11
+    f0000000-f007ffff : 0000:11:00.0
   f1100000-f11fffff : PCI Bus 0000:05
     f1100000-f1103fff : 0000:05:00.0
       f1100000-f1103fff : r8169
@@ -42,11 +43,10 @@
       f1104000-f1104fff : r8169
   f6800000-f6bfffff : 0000:00:02.0
   f6c00000-f7cfffff : PCI Bus 0000:11
-    f6c00000-f6c7ffff : 0000:11:00.0
-    f6c80000-f6c83fff : 0000:11:00.0
-      f6c80000-f6c83fff : sata_sil24
-    f6c84000-f6c8407f : 0000:11:00.0
-      f6c84000-f6c8407f : sata_sil24
+    f6c00000-f6c03fff : 0000:11:00.0
+      f6c00000-f6c03fff : sata_sil24
+    f6c04000-f6c0407f : 0000:11:00.0
+      f6c04000-f6c0407f : sata_sil24
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
       f7d00000-f7d0ffff : xhci_hcd



IRQ19 is picked up again by sata_sil24 (no diff compared to cold boot state).
The *zero* on the line is ... weird? ^H^H^H^H probably correct because at the
end of all the tests it was non-zero (after I connected HDD to the eSATA card):

--- interrupts_initial.txt      2013-03-30 00:25:40.000000000 +0100
+++ interrupts_initial_all_xHCI_tests_worked__eSATA_eject_hotinsert.txt 2013-03-30 00:29:15.000000000 +0100
@@ -1,32 +1,32 @@
            CPU0       CPU1       
   0:         25          0   IO-APIC-edge      timer
-  1:        780          0   IO-APIC-edge      i8042
+  1:       2064          0   IO-APIC-edge      i8042
   8:          7          0   IO-APIC-edge      rtc0
-  9:          0          0   IO-APIC-fasteoi   acpi
+  9:          2          0   IO-APIC-fasteoi   acpi
  12:        241          0   IO-APIC-edge      i8042
  16:         75          0   IO-APIC-fasteoi   ehci_hcd:usb1
  19:          0          0   IO-APIC-fasteoi   sata_sil24
  23:         77          0   IO-APIC-fasteoi   ehci_hcd:usb2
- 40:       4025          0   PCI-MSI-edge      ahci
- 41:        521          0   PCI-MSI-edge      eth0
- 42:          0          0   PCI-MSI-edge      xhci_hcd
+ 40:       4255          0   PCI-MSI-edge      ahci
+ 41:        797          0   PCI-MSI-edge      eth0
+ 42:       1300          0   PCI-MSI-edge      xhci_hcd
  43:          0          0   PCI-MSI-edge      xhci_hcd
  44:          0          0   PCI-MSI-edge      xhci_hcd
  45:        227          0   PCI-MSI-edge      snd_hda_intel
  46:          1          0   PCI-MSI-edge      iwlwifi
  47:          4          0   PCI-MSI-edge      i915



Finally lspci of the hot-insert:

--- lspci_vvv_initial_all_xHCI_tests_worked__eSATA_eject.txt    2013-03-30 00:28:28.000000000 +0100
+++ lspci_vvv_initial_all_xHCI_tests_worked__eSATA_eject_hotinsert.txt  2013-03-30 00:29:33.000000000 +0100
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
 
 
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
+       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
+       Physical Slot: 1
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
+       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+       Latency: 0, Cache Line Size: 32 bytes
+       Interrupt: pin A routed to IRQ 19
+       Region 0: Memory at f6c04000 (64-bit, non-prefetchable) [size=128]
+       Region 2: Memory at f6c00000 (64-bit, non-prefetchable) [size=16K]
+       Region 4: I/O ports at c000 [size=128]
+       [virtual] Expansion ROM at f0000000 [disabled] [size=512K]
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
+                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
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
+       Kernel driver in use: sata_sil24

Please note the [virtual] expansion ROM. Maybe that is related to those *different* IOMEM ranges
compared to cold boot state (see the iomem above)?

Despite the "[virtual] expansion ROM" the SATA card actually works:

+[  466.361420] ata10: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
+[  466.361422] ata10: irq_stat 0x00b40090, PHY RDY changed
+[  466.361428] ata10: hard resetting link
+[  468.573249] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
+[  468.573963] ata10.00: ATA-8: ST3000VX000-9YW166, CV12, max UDMA/133
+[  468.573973] ata10.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
+[  468.574694] ata10.00: configured for UDMA/100
+[  468.574875] ata10: EH complete
+[  468.575422] scsi 11:0:0:0: Direct-Access     ATA      ST3000VX000-9YW1 CV12 PQ: 0 ANSI: 5
+[  468.577129] sd 11:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
+[  468.577131] sd 11:0:0:0: [sdb] 4096-byte physical blocks
+[  468.577453] sd 11:0:0:0: Attached scsi generic sg2 type 0
+[  468.577509] sd 11:0:0:0: [sdb] Write Protect is off
+[  468.577511] sd 11:0:0:0: [sdb] Mode Sense: 00 3a 00 00
+[  468.577696] sd 11:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+[  468.623746]  sdb: sdb1
+[  468.625408] sd 11:0:0:0: [sdb] Attached SCSI disk




OK, so now we see the card generated IRQ traffic and the 'zero' increased to 183:

--- interrupts_eSATA_eject_hotinsert.txt 2013-03-30 00:29:15.000000000 +0100
+++ interrupts_eSATA_eject_hotinsert_HDD_attached.txt    2013-03-30 00:30:41.000000000 +0100
@@ -1,14 +1,14 @@
            CPU0       CPU1       
   0:         25          0   IO-APIC-edge      timer
-  1:       2064          0   IO-APIC-edge      i8042
+  1:       2982          0   IO-APIC-edge      i8042
   8:          7          0   IO-APIC-edge      rtc0
   9:          2          0   IO-APIC-fasteoi   acpi
  12:        241          0   IO-APIC-edge      i8042
  16:         75          0   IO-APIC-fasteoi   ehci_hcd:usb1
- 19:          0          0   IO-APIC-fasteoi   sata_sil24
+ 19:        183          0   IO-APIC-fasteoi   sata_sil24
  23:         77          0   IO-APIC-fasteoi   ehci_hcd:usb2


But, in the end I unplugged and reinserted the eSATA card several times and something screwed
because in the very end you will see in /proc/interrupts unoccupied IRQ 19. But first will
show the dmesg should be hiding the cause (I did "grep -v xhci_hcd" to be honest):

+[ 1069.949732] sata_sil24 0000:11:00.0: PME# disabled
+[ 1069.951167] ata10.00: disabled
+[ 1069.954126] sd 11:0:0:0: [sdb] Synchronizing SCSI cache
+[ 1069.954349] sd 11:0:0:0: [sdb]  
+[ 1069.954351] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1069.954352] sd 11:0:0:0: [sdb] Stopping disk
+[ 1069.954396] sd 11:0:0:0: [sdb] START_STOP FAILED
+[ 1069.954397] sd 11:0:0:0: [sdb]  
+[ 1069.954397] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1069.955107] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[ 1074.103645] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+[ 1074.103690] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+[ 1074.103722] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+[ 1074.103743] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+[ 1074.103783] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+[ 1074.103900] pci 0000:11:00.0: supports D1 D2
+[ 1074.124340] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+[ 1074.124344] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+[ 1074.124367] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+[ 1074.124369] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+[ 1074.124390] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+[ 1074.124392] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+[ 1074.124399] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+[ 1074.125532] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+[ 1074.125741] sata_sil24 0000:11:00.0: enabling bus mastering
+[ 1074.129947] scsi13 : sata_sil24
+[ 1074.130840] scsi14 : sata_sil24
+[ 1074.131444] ata11: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+[ 1074.131448] ata12: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+[ 1076.209511] ata11: SATA link down (SStatus 0 SControl 0)
+[ 1078.426255] ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
+[ 1078.426868] ata12.00: ATA-8: ST3000VX000-9YW166, CV12, max UDMA/133
+[ 1078.426876] ata12.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
+[ 1078.427569] ata12.00: configured for UDMA/100
+[ 1078.428022] scsi 14:0:0:0: Direct-Access     ATA      ST3000VX000-9YW1 CV12 PQ: 0 ANSI: 5
+[ 1078.429195] sd 14:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
+[ 1078.429197] sd 14:0:0:0: [sdb] 4096-byte physical blocks
+[ 1078.429564] sd 14:0:0:0: [sdb] Write Protect is off
+[ 1078.429566] sd 14:0:0:0: [sdb] Mode Sense: 00 3a 00 00
+[ 1078.429718] sd 14:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+[ 1078.429884] sd 14:0:0:0: Attached scsi generic sg2 type 0
+[ 1078.481473]  sdb: sdb1
+[ 1078.483078] sd 14:0:0:0: [sdb] Attached SCSI disk
+[ 1083.878783] sata_sil24 0000:11:00.0: PME# disabled
+[ 1083.880005] ata12.00: disabled
+[ 1083.882576] sd 14:0:0:0: [sdb] Synchronizing SCSI cache
+[ 1083.882736] sd 14:0:0:0: [sdb]  
+[ 1083.882738] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1083.882740] sd 14:0:0:0: [sdb] Stopping disk
+[ 1083.882786] sd 14:0:0:0: [sdb] START_STOP FAILED
+[ 1083.882787] sd 14:0:0:0: [sdb]  
+[ 1083.882788] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1083.883436] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[ 1089.740151] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+[ 1089.740196] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+[ 1089.740229] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+[ 1089.740250] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+[ 1089.740291] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+[ 1089.740407] pci 0000:11:00.0: supports D1 D2
+[ 1089.760794] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+[ 1089.760798] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+[ 1089.760821] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+[ 1089.760823] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+[ 1089.760844] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+[ 1089.760846] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+[ 1089.760853] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+[ 1089.761960] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+[ 1089.762171] sata_sil24 0000:11:00.0: enabling bus mastering
+[ 1089.765250] scsi15 : sata_sil24
+[ 1089.765983] scsi16 : sata_sil24
+[ 1089.766593] ata13: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+[ 1089.766596] ata14: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+[ 1091.846016] ata13: SATA link down (SStatus 0 SControl 0)
+[ 1094.062692] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
+[ 1094.063338] ata14.00: ATA-8: ST3000VX000-9YW166, CV12, max UDMA/133
+[ 1094.063347] ata14.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
+[ 1094.064011] ata14.00: configured for UDMA/100
+[ 1094.064462] scsi 16:0:0:0: Direct-Access     ATA      ST3000VX000-9YW1 CV12 PQ: 0 ANSI: 5
+[ 1094.065494] sd 16:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
+[ 1094.065496] sd 16:0:0:0: [sdb] 4096-byte physical blocks
+[ 1094.065920] sd 16:0:0:0: [sdb] Write Protect is off
+[ 1094.065922] sd 16:0:0:0: [sdb] Mode Sense: 00 3a 00 00
+[ 1094.065963] sd 16:0:0:0: Attached scsi generic sg2 type 0
+[ 1094.066077] sd 16:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+[ 1094.098360]  sdb: sdb1
+[ 1094.099845] sd 16:0:0:0: [sdb] Attached SCSI disk
+[ 1096.679536] sata_sil24 0000:11:00.0: PME# disabled
+[ 1096.681263] ata14.00: disabled
+[ 1096.686887] sd 16:0:0:0: [sdb] Synchronizing SCSI cache
+[ 1096.687774] sd 16:0:0:0: [sdb]  
+[ 1096.687776] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1096.687777] sd 16:0:0:0: [sdb] Stopping disk
+[ 1096.687821] sd 16:0:0:0: [sdb] START_STOP FAILED
+[ 1096.687822] sd 16:0:0:0: [sdb]  
+[ 1096.687823] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1096.688418] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[ 1100.693672] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+[ 1100.693718] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+[ 1100.693750] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+[ 1100.693771] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+[ 1100.693812] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+[ 1100.693929] pci 0000:11:00.0: supports D1 D2
+[ 1100.714265] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+[ 1100.714269] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+[ 1100.714291] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+[ 1100.714293] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+[ 1100.714315] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+[ 1100.714316] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+[ 1100.714323] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+[ 1100.715395] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+[ 1100.715606] sata_sil24 0000:11:00.0: enabling bus mastering
+[ 1100.718639] scsi17 : sata_sil24
+[ 1100.719369] scsi18 : sata_sil24
+[ 1100.719975] ata15: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+[ 1100.719978] ata16: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+[ 1102.799553] ata15: SATA link down (SStatus 0 SControl 0)
+[ 1105.016227] ata16: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
+[ 1105.016851] ata16.00: ATA-8: ST3000VX000-9YW166, CV12, max UDMA/133
+[ 1105.016860] ata16.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
+[ 1105.017557] ata16.00: configured for UDMA/100
+[ 1105.018014] scsi 18:0:0:0: Direct-Access     ATA      ST3000VX000-9YW1 CV12 PQ: 0 ANSI: 5
+[ 1105.019011] sd 18:0:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
+[ 1105.019013] sd 18:0:0:0: [sdb] 4096-byte physical blocks
+[ 1105.019387] sd 18:0:0:0: [sdb] Write Protect is off
+[ 1105.019389] sd 18:0:0:0: [sdb] Mode Sense: 00 3a 00 00
+[ 1105.019464] sd 18:0:0:0: Attached scsi generic sg2 type 0
+[ 1105.019543] sd 18:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+[ 1105.055388]  sdb: sdb1
+[ 1105.057436] sd 18:0:0:0: [sdb] Attached SCSI disk
+[ 1107.503274] sata_sil24 0000:11:00.0: PME# disabled
+[ 1107.504776] ata16.00: disabled
+[ 1107.510504] sd 18:0:0:0: [sdb] Synchronizing SCSI cache
+[ 1107.510716] sd 18:0:0:0: [sdb]  
+[ 1107.510717] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1107.510719] sd 18:0:0:0: [sdb] Stopping disk
+[ 1107.510764] sd 18:0:0:0: [sdb] START_STOP FAILED
+[ 1107.510766] sd 18:0:0:0: [sdb]  
+[ 1107.510767] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
+[ 1107.511352] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?


In the above dmesg must be the answer why the first hot remove or some latter
hot event broke so that the IRQ19 was left without sata_sil24 associated
in /proc/interrupts. Unfortunately I had a look only at the very end of testing
into the file.

--- interrupts_eSATA_eject_hotinsert_HDD_attached.txt    2013-03-30 00:30:41.000000000 +0100
+++ interrupts_final.txt        2013-03-30 00:43:54.000000000 +0100
@@ -1,32 +1,32 @@
            CPU0       CPU1       
   0:         25          0   IO-APIC-edge      timer
-  1:       2982          0   IO-APIC-edge      i8042
+  1:       5708          0   IO-APIC-edge      i8042
   8:          7          0   IO-APIC-edge      rtc0
-  9:          2          0   IO-APIC-fasteoi   acpi
+  9:         11          0   IO-APIC-fasteoi   acpi
  12:        241          0   IO-APIC-edge      i8042
  16:         75          0   IO-APIC-fasteoi   ehci_hcd:usb1
- 19:        183          0   IO-APIC-fasteoi   sata_sil24
+ 19:        729          0   IO-APIC-fasteoi 
  23:         77          0   IO-APIC-fasteoi   ehci_hcd:usb2
- 40:       4384          0   PCI-MSI-edge      ahci
- 41:        894          0   PCI-MSI-edge      eth0
- 42:       1300          0   PCI-MSI-edge      xhci_hcd
+ 40:       4970          0   PCI-MSI-edge      ahci
+ 41:       1897          0   PCI-MSI-edge      eth0
+ 42:       2098          0   PCI-MSI-edge      xhci_hcd
  43:          0          0   PCI-MSI-edge      xhci_hcd
  44:          0          0   PCI-MSI-edge      xhci_hcd
  45:        227          0   PCI-MSI-edge      snd_hda_intel
  46:          1          0   PCI-MSI-edge      iwlwifi
- 47:          4          0   PCI-MSI-edge      i915

Unlike the IRQ case, memory was released fine:

--- iomem_initial_all_xHCI_tests_worked__eSATA_eject_hotinsert_HDD_attached.txt 2013-03-30 00:30:32.000000000 +0100
+++ iomem_final.txt     2013-03-30 00:43:45.000000000 +0100
@@ -35,7 +35,6 @@
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
   f0000000-f10fffff : PCI Bus 0000:11
-    f0000000-f007ffff : 0000:11:00.0
   f1100000-f11fffff : PCI Bus 0000:05
     f1100000-f1103fff : 0000:05:00.0
       f1100000-f1103fff : r8169
@@ -43,10 +42,6 @@
       f1104000-f1104fff : r8169
   f6800000-f6bfffff : 0000:00:02.0
   f6c00000-f7cfffff : PCI Bus 0000:11
-    f6c00000-f6c03fff : 0000:11:00.0
-      f6c00000-f6c03fff : sata_sil24
-    f6c04000-f6c0407f : 0000:11:00.0
-      f6c04000-f6c0407f : sata_sil24
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
       f7d00000-f7d0ffff : xhci_hcd

Also from the lspci's perspective hot insert and removes were fine, so maybe the /proc/interrupts
is just a buggy cached file? [I think we came to such conclusion already under the
"Re: 3.8.2: stale pci device info for a previously inserted express card" thread.]

--- lspci_vvv_initial_all_xHCI_tests_worked__eSATA_eject_hotinsert_HDD_attached.txt     2013-03-30 00:30:23.000000000 +0100
+++ lspci_vvv_final.txt 2013-03-30 00:43:37.000000000 +0100
@@ -309,12 +309,12 @@
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
@@ -527,40 +527,3 @@
        Capabilities: [150 v1] Device Serial Number 08-00-28-00-00-20-00-00
        Kernel driver in use: xhci_hcd
 
-11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
-       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
-       Physical Slot: 1
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
-       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 32 bytes
-       Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c04000 (64-bit, non-prefetchable) [size=128]
-       Region 2: Memory at f6c00000 (64-bit, non-prefetchable) [size=16K]
-       Region 4: I/O ports at c000 [size=128]
-       [virtual] Expansion ROM at f0000000 [disabled] [size=512K]
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
-       Kernel driver in use: sata_sil24

So no reason to think that IRQ 19 is still in use by a NULL driver? ;)



> If that is the case, which of the problems remain after applying it (on top
> of the Linus' current tree)?

Sorry, I used plain 3.8.3 so that we can compare with the patch from Sarah.
The behavior is completely different with Yijing's patch and with the one from
Sarah (aimed to fix a different issue) but even from plain 3.8.3. But if you
re-ask again I will fetch the git tree to somewhere outside and download only
my customized kernel. That's doable, sure. Just let me know.

Martin

P.S.: Below am pasting the patch from https://patchwork.kernel.org/patch/2359611/

> 
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: PCI / PM: Disable runtime PM of PCIe ports
> 
> The runtime PM of PCIe ports turns out to be quite fragile, as in
> some cases things work while in some other cases they don't and we
> don't seem to have a good way to determine whether or not they are
> going to work in advance.
> 
> For this reason, avoid enabling runtime PM for PCIe ports by
> keeping their runtime PM reference counters always above 0 for the
> time being.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> Index: linux-pm/drivers/pci/pcie/portdrv_pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pcie/portdrv_pci.c
> +++ linux-pm/drivers/pci/pcie/portdrv_pci.c
> @@ -225,16 +225,11 @@ static int pcie_portdrv_probe(struct pci
>  	 * it by default.
>  	 */
>  	dev->d3cold_allowed = false;
> -	if (!pci_match_id(port_runtime_pm_black_list, dev))
> -		pm_runtime_put_noidle(&dev->dev);
> -
>  	return 0;
>  }
>  
>  static void pcie_portdrv_remove(struct pci_dev *dev)
>  {
> -	if (!pci_match_id(port_runtime_pm_black_list, dev))
> -		pm_runtime_get_noresume(&dev->dev);
>  	pcie_port_device_remove(dev);
>  	pci_disable_device(dev);
>  }
> 
