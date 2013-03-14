Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:56100 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755818Ab3CNNAL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 09:00:11 -0400
Message-ID: <5141C9D7.9040706@fold.natur.cuni.cz>
Date: Thu, 14 Mar 2013 14:00:07 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz> <51417C28.40402@huawei.com>
In-Reply-To: <51417C28.40402@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yijing Wang wrote:
> On 2013/3/14 8:05, Martin Mokrejs wrote:
>> Hi Yjing,
>>
>> Yijing Wang wrote:
>>> Hi Martin,
>>>    From your diff info, maybe we can analyze this problem step by step.
>>> 1、According to your diff info about first eject and first hot add, the pci device 11:00.0 Mass storage
>>>    controller was removed and was added ok at pci device level;
>>
>> I can't confirm that it it was removed fine but looks like hot re-inserting the
>> card somewhat returns us to the anticipated state. Would I have hot added completely
>> different card I believe lspci would report mixture of both both, the cold-plugged-one
>> and of the hot-plugged one. Please see the thread
>> 3.8.2: stale pci device info for a previously inserted express card
>> for what I mean (different kernel and acpiphp while here we are talking 3.9-rc1 and
>> pciehp but still I believe same would happen.)
> 
> Hmm, that's a issue, I am not sure it's a memleak problem.
> 
>>
>>> 2、The main problem is 11:00.0 Mass storage controller can not bind its driver normally, right?
>>
>> Yes, and you can squeeze out few words from the driver only if you rmmod it.
>> Therefore I conclude the sata_sil24 cannot unbind the device and only during
>> rmmod it realizes it is gone. What pci driver failed to report the card was
>> ejected I don't know but seems per point 1. above that we agree that PresDet
>> worked fine (cold boot with the card inserted). So is sata_sil24 at fault?
>> Nobody commented on those express slot status values: 0000, 0040, 0100, 0108, 0138, 0140, 0148.
>> What are they?
> 
> As you mentioned before
> cold boot 0040 -> eject 0100 hotplug insert -> 0140 eject -> 0100 hotplug insert -> 0140 eject -> 0100
> cold boot(PCIe card detected in slot)-->eject(Data Link state changed detected)-->.....
> detail info reference at PCIe Spec 3.0  7.8.11

So doesn't pciehp/acpiphp complain when values 0000, 0108, 0138, 0148 appear?

> 
>>
>>> 3、According to diff info about first hotadd and coldplug, the mainly diff is
>>>> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
>>>> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
>>>> +       Region 4: I/O ports at c000 [disabled] [size=128]
>>>
>>> and
>>> MaxReadReq 4096 bytes ----> MaxReadReq 512 bytes
>>>
>>> So maybe we can try to find why the memory range was disabled after hot add.
>>>
>>> Martin, can you provide  /proc/iomem info when the system bootup, after first eject and
>>> first hot-add?
>>
>> Not a single change, look:
>>
>> # diff -u -w iomem.txt iomem_ejected.txt
> 
> According to this, the Mass storage controller device MMIO was not released when the eject.
> So, If we insert this card again, driver cannot get a MMIO range for the newly inserted card, because
> old MMIO range is still in system.

Was my impression as well, but all I could have added.

> 
>> # diff -u -w iomem_ejected.txt iomem_ejected_and_reinserted.txt
>>
>> At this moment lspci reports:
>>
>> # diff -u -w lspci_vvvxxx.txt lspci_vvvxxx_ejected_and_reinserted.txt
>> --- lspci_vvvxxx.txt    2013-03-14 00:23:25.000000000 +0100
>> +++ lspci_vvvxxx_ejected_and_reinserted.txt     2013-03-14 00:27:26.000000000 +0100
>> @@ -437,7 +437,7 @@
>>         I/O behind bridge: 0000c000-0000dfff
>>         Memory behind bridge: f6c00000-f7cfffff
>>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
>> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 
> Master Abort Error detected.
> 
>>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>> @@ -457,7 +457,7 @@
>>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>> -                       Changed: MRL- PresDet- LinkState-
>> +                       Changed: MRL- PresDet- LinkState+
> 
> Every you eject and insert card LinkState Change bit changed detected, so when do hotplug link state change is ok.
> 
>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>>                 RootCap: CRSVisible-
>>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>> @@ -476,11 +476,11 @@
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
>> @@ -795,14 +795,13 @@
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
> 
> I guess these memory ranges disabled because the original MMIO(coldplug boot) is still in system after eject device,
> the new device insert cannot get the needed MMIO in system.

But then some driver is stupid and should loudly complain. Looks nobody even knows
why lspci prints those "[disabled]" and "[virtual]" strings in its output.
What are the normal cases of "virtual" ROMs and "disabled" ranges? What *functional*
devices have them and why are they disabled? Is this like a disabled BOOT ROM on a network
card or what?

> 
>> +       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
>>         Capabilities: [54] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>> @@ -813,29 +812,29 @@
>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>> -                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
>> -               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>> +                       MaxPayload 128 bytes, MaxReadReq 512 bytes
>> +               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> I don't think this will cause device hotplug fail.
>>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>>                         ClockPM- Surprise- LLActRep- BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         Capabilities: [100 v1] Advanced Error Reporting
>> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>> +               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> -               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>> +               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
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
>> +70: 10 00 11 00 03 00 00 00 00 20 00 00 11 f4 03 00
>>  80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
>>  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> #
>>
>>
>> I had to rmmod the driver to trigger at least some change:
>>
> 
> When you do rmmod sata driver, the MMIO seems to be released ok.
> Martin, what about try to do hotplug like this?
> 1、coldplug boot up;
> 2、eject device；
> 3、rmmod sata driver；
> 4、modprobe sata driver;
> 5、insert card;

# diff -u -w dmesg.txt dmesg_ejected.txt
# diff -u -w lspci_vvvxxx.txt lspci_vvvxxx_ejected.txt 
--- lspci_vvvxxx.txt    2013-03-14 11:01:06.000000000 +0100
+++ lspci_vvvxxx_ejected.txt    2013-03-14 11:03:26.000000000 +0100
@@ -437,7 +437,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
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
@@ -476,11 +476,11 @@
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
-10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
+50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -793,55 +793,23 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
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
-00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
-10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
-20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
-30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
-40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
-60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-70: 10 00 11 00 03 00 00 00 00 50 0a 00 11 f4 03 00
-80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
-90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

# diff -u -w iomem.txt iomem_ejected.txt 
# diff -u -w dmesg_ejected.txt dmesg_ejected_rmmod_sata_sil24.txt 
--- dmesg_ejected.txt   2013-03-14 11:03:42.000000000 +0100
+++ dmesg_ejected_rmmod_sata_sil24.txt  2013-03-14 11:05:00.000000000 +0100
@@ -824,3 +824,173 @@
 [   38.223082] r8169 0000:05:00.0 eth0: link up
 [   39.471099] r8169 0000:05:00.0 eth0: link down
 [   41.857999] r8169 0000:05:00.0 eth0: link up
+[  270.090796] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  270.091728] pcieport 0000:00:1c.7: PME# enabled
+[  270.972562] pcieport 0000:00:1c.7: PME# disabled
+[  270.982338] pcieport 0000:00:1c.7: PME# enabled
+[  271.022611] pcieport 0000:00:1c.7: PME# disabled
+[  271.032560] pcieport 0000:00:1c.7: PME# enabled
+[  272.053850] pcieport 0000:00:1c.7: PME# disabled
+[  272.063619] pcieport 0000:00:1c.7: PME# enabled
+[  272.103916] pcieport 0000:00:1c.7: PME# disabled
+[  272.113838] pcieport 0000:00:1c.7: PME# enabled
+[  273.145186] pcieport 0000:00:1c.7: PME# disabled
+[  273.156282] pcieport 0000:00:1c.7: PME# enabled
+[  273.195718] pcieport 0000:00:1c.7: PME# disabled
+[  273.205228] pcieport 0000:00:1c.7: PME# enabled
+[  274.226918] pcieport 0000:00:1c.7: PME# disabled
[cut] repeated forever

# diff -u -w lspci_vvvxxx_ejected.txt lspci_vvvxxx_ejected_rmmod_sata_sil24.txt 
--- lspci_vvvxxx_ejected.txt    2013-03-14 11:03:26.000000000 +0100
+++ lspci_vvvxxx_ejected_rmmod_sata_sil24.txt   2013-03-14 11:04:32.000000000 +0100
@@ -473,7 +473,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
@@ -485,7 +485,7 @@
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
@@ -653,7 +653,7 @@
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
+               CESta:  RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
@@ -795,7 +795,6 @@
 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
        !!! Unknown header type 7f
-       Kernel driver in use: sata_sil24
 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

# diff -u -w iomem_ejected.txt iomem_ejected_rmmod_sata_sil24.txt 
--- iomem_ejected.txt   2013-03-14 11:03:18.000000000 +0100
+++ iomem_ejected_rmmod_sata_sil24.txt  2013-03-14 11:04:53.000000000 +0100
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
#


So now you want me to modprobe the sata driver back and re-insert the card
to check what hotplug does:

# diff -u -w dmesg_ejected_rmmod_sata_sil24.txt dmesg_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt 
--- dmesg_ejected_rmmod_sata_sil24.txt  2013-03-14 11:05:00.000000000 +0100
+++ dmesg_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt      2013-03-14 11:06:11.000000000 +0100
[cut away the PME# game]
+[  352.132379] pcieport 0000:00:1c.7: PME# disabled
+[  352.142358] pcieport 0000:00:1c.7: PME# enabled
+[  352.993844] pcieport 0000:00:1c.7: PME# disabled
+[  352.993852] sata_sil24 0000:11:00.0: version 1.1
+[  353.013329] sata_sil24 0000:11:00.0: Refused to change power state, currently in D3
+[  353.113327] sata_sil24 0000:11:00.0: failed to clear port RST
+[  353.213438] sata_sil24 0000:11:00.0: failed to clear port RST
+[  353.216233] scsi8 : sata_sil24
+[  353.216927] scsi9 : sata_sil24
+[  353.217460] ata9: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
+[  353.217463] ata10: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
+[  353.313587] ata9: controller in dubious state, performing PORT_RST
+[  355.526301] ata9: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
+[  355.626420] ata10: controller in dubious state, performing PORT_RST
+[  357.839141] ata10: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
#
# diff -u -w lspci_vvvxxx_ejected_rmmod_sata_sil24.txt lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt 
--- lspci_vvvxxx_ejected_rmmod_sata_sil24.txt   2013-03-14 11:04:32.000000000 +0100
+++ lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt       2013-03-14 11:06:51.000000000 +0100
@@ -473,7 +473,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
@@ -485,7 +485,7 @@
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
-a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
@@ -795,6 +795,7 @@
 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
        !!! Unknown header type 7f
+       Kernel driver in use: sata_sil24
 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
#

Actualy comparing the states before rmmod+modprobe and after boild down just to:

# diff -u -w lspci_vvvxxx_ejected.txt lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt 
--- lspci_vvvxxx_ejected.txt    2013-03-14 11:03:26.000000000 +0100
+++ lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt       2013-03-14 11:06:51.000000000 +0100
@@ -653,7 +653,7 @@
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
+               CESta:  RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
#
# diff -u -w iomem_ejected.txt iomem_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt 
#

Finally we are getting to hotinsert the card:

# diff -u -w dmesg_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt dmesg_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt 
#
# diff -u -w lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt 
--- lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt       2013-03-14 11:06:51.000000000 +0100
+++ lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt     2013-03-14 11:10:43.000000000 +0100
@@ -451,12 +451,12 @@
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
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
+50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -793,23 +793,54 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
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
+00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
+10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
+20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
+30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
+40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
+60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+70: 10 00 11 00 03 00 00 00 00 20 0a 00 11 f4 03 00
+80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
+90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
#
# diff -u -w iomem_ejected_rmmod_sata_sil24_modprobe_sata_sil24.txt iomem_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt 
#


Now, to recapitulate, comparing current hotplug state to the initial cold boot state:

# diff -u -w iomem.txt iomem_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt
#
# diff -u -w lspci_vvvxxx.txt lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt 
--- lspci_vvvxxx.txt    2013-03-14 11:01:06.000000000 +0100
+++ lspci_vvvxxx_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt     2013-03-14 11:10:43.000000000 +0100
@@ -437,7 +437,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -476,7 +476,7 @@
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
-10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
@@ -653,7 +653,7 @@
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
+               CESta:  RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
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
@@ -813,7 +812,7 @@
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
-                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
+                       MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
@@ -828,14 +827,14 @@
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
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
+70: 10 00 11 00 03 00 00 00 00 20 0a 00 11 f4 03 00
 80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# diff -u -w dmesg.txt dmesg_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt

--- dmesg.txt   2013-03-14 11:00:51.000000000 +0100
+++ dmesg_ejected_rmmod_sata_sil24_modprobe_sata_sil24_hotinsert.txt    2013-03-14 11:10:58.000000000 +0100
@@ -824,3 +824,324 @@
 [   38.223082] r8169 0000:05:00.0 eth0: link up
 [   39.471099] r8169 0000:05:00.0 eth0: link down
 [   41.857999] r8169 0000:05:00.0 eth0: link up
+[  270.090796] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  270.091728] pcieport 0000:00:1c.7: PME# enabled
+[  270.972562] pcieport 0000:00:1c.7: PME# disabled
+[  270.982338] pcieport 0000:00:1c.7: PME# enabled
+[  271.022611] pcieport 0000:00:1c.7: PME# disabled
[cut]
+[  348.828290] pcieport 0000:00:1c.7: PME# disabled
+[  348.838079] pcieport 0000:00:1c.7: PME# enabled
+[  348.878351] pcieport 0000:00:1c.7: PME# disabled
+[  348.888342] pcieport 0000:00:1c.7: PME# enabled
+[  349.919473] pcieport 0000:00:1c.7: PME# disabled
+[  349.929450] pcieport 0000:00:1c.7: PME# enabled
+[  349.969697] pcieport 0000:00:1c.7: PME# disabled
+[  349.979638] pcieport 0000:00:1c.7: PME# enabled
+[  351.001127] pcieport 0000:00:1c.7: PME# disabled
+[  351.010718] pcieport 0000:00:1c.7: PME# enabled
+[  351.051021] pcieport 0000:00:1c.7: PME# disabled
+[  351.060979] pcieport 0000:00:1c.7: PME# enabled
+[  352.082294] pcieport 0000:00:1c.7: PME# disabled
+[  352.092056] pcieport 0000:00:1c.7: PME# enabled
+[  352.132379] pcieport 0000:00:1c.7: PME# disabled
+[  352.142358] pcieport 0000:00:1c.7: PME# enabled
+[  352.993844] pcieport 0000:00:1c.7: PME# disabled
+[  352.993852] sata_sil24 0000:11:00.0: version 1.1
+[  353.013329] sata_sil24 0000:11:00.0: Refused to change power state, currently in D3
+[  353.113327] sata_sil24 0000:11:00.0: failed to clear port RST
+[  353.213438] sata_sil24 0000:11:00.0: failed to clear port RST
+[  353.216233] scsi8 : sata_sil24
+[  353.216927] scsi9 : sata_sil24
+[  353.217460] ata9: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
+[  353.217463] ata10: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
+[  353.313587] ata9: controller in dubious state, performing PORT_RST
+[  355.526301] ata9: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
+[  355.626420] ata10: controller in dubious state, performing PORT_RST
+[  357.839141] ata10: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
#


I will answer your remaining following questions in a next reply.

Martin
