Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:7896 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab3CNInC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 04:43:02 -0400
Message-ID: <51418C93.6000407@huawei.com>
Date: Thu, 14 Mar 2013 16:38:43 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>
In-Reply-To: <5141145E.4020300@fold.natur.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/3/14 8:05, Martin Mokrejs wrote:
> Hi Yjing,
>
> Yijing Wang wrote:
>> Hi Martin,
>>    From your diff info, maybe we can analyze this problem step by step.
>> 1、According to your diff info about first eject and first hot add, the pci device 11:00.0 Mass storage
>>    controller was removed and was added ok at pci device level;
>
> I can't confirm that it it was removed fine but looks like hot re-inserting the
> card somewhat returns us to the anticipated state. Would I have hot added completely
> different card I believe lspci would report mixture of both both, the cold-plugged-one
> and of the hot-plugged one. Please see the thread
> 3.8.2: stale pci device info for a previously inserted express card
> for what I mean (different kernel and acpiphp while here we are talking 3.9-rc1 and
> pciehp but still I believe same would happen.)

Hmm, that's a issue, I am not sure it's a memleak problem.

>
>> 2、The main problem is 11:00.0 Mass storage controller can not bind its driver normally, right?
>
> Yes, and you can squeeze out few words from the driver only if you rmmod it.
> Therefore I conclude the sata_sil24 cannot unbind the device and only during
> rmmod it realizes it is gone. What pci driver failed to report the card was
> ejected I don't know but seems per point 1. above that we agree that PresDet
> worked fine (cold boot with the card inserted). So is sata_sil24 at fault?
> Nobody commented on those express slot status values: 0000, 0040, 0100, 0108, 0138, 0140, 0148.
> What are they?

As you mentioned before
cold boot 0040 -> eject 0100 hotplug insert -> 0140 eject -> 0100 hotplug insert -> 0140 eject -> 0100
cold boot(PCIe card detected in slot)-->eject(Data Link state changed detected)-->.....
detail info reference at PCIe Spec 3.0  7.8.11

>
>> 3、According to diff info about first hotadd and coldplug, the mainly diff is
>>> +       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
>>> +       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
>>> +       Region 4: I/O ports at c000 [disabled] [size=128]
>>
>> and
>> MaxReadReq 4096 bytes ----> MaxReadReq 512 bytes
>>
>> So maybe we can try to find why the memory range was disabled after hot add.
>>
>> Martin, can you provide  /proc/iomem info when the system bootup, after first eject and
>> first hot-add?
>
> Not a single change, look:
>
> # diff -u -w iomem.txt iomem_ejected.txt

According to this, the Mass storage controller device MMIO was not released when the eject.
So, If we insert this card again, driver cannot get a MMIO range for the newly inserted card, because
old MMIO range is still in system.

> # diff -u -w iomem_ejected.txt iomem_ejected_and_reinserted.txt
>
> At this moment lspci reports:
>
> # diff -u -w lspci_vvvxxx.txt lspci_vvvxxx_ejected_and_reinserted.txt
> --- lspci_vvvxxx.txt    2013-03-14 00:23:25.000000000 +0100
> +++ lspci_vvvxxx_ejected_and_reinserted.txt     2013-03-14 00:27:26.000000000 +0100
> @@ -437,7 +437,7 @@
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-

Master Abort Error detected.

>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> @@ -457,7 +457,7 @@
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> -                       Changed: MRL- PresDet- LinkState-
> +                       Changed: MRL- PresDet- LinkState+

Every you eject and insert card LinkState Change bit changed detected, so when do hotplug link state change is ok.

>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> @@ -476,11 +476,11 @@
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
> -10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
> +10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
> -50: 40 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
> +50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> @@ -795,14 +795,13 @@
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

I guess these memory ranges disabled because the original MMIO(coldplug boot) is still in system after eject device,
the new device insert cannot get the needed MMIO in system.

> +       [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
>         Capabilities: [54] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
> @@ -813,29 +812,29 @@
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> -                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
> -               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
> +                       MaxPayload 128 bytes, MaxReadReq 512 bytes
> +               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
I don't think this will cause device hotplug fail.
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Advanced Error Reporting
> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> +               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> -               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> +               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Kernel driver in use: sata_sil24
> -00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
> -10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
> -20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
> -30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
> +00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
> +10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
> +20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
> +30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
>  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
>  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -70: 10 00 11 00 03 00 00 00 00 50 0a 00 11 f4 03 00
> +70: 10 00 11 00 03 00 00 00 00 20 00 00 11 f4 03 00
>  80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> #
>
>
> I had to rmmod the driver to trigger at least some change:
>

When you do rmmod sata driver, the MMIO seems to be released ok.
Martin, what about try to do hotplug like this?
1、coldplug boot up;
2、eject device；
3、rmmod sata driver；
4、modprobe sata driver;
5、insert card;

> # diff -u -w iomem_ejected_and_reinserted.txt iomem_ejected_and_reinserted_rmmod_sata_sil24.txt
> --- iomem_ejected_and_reinserted.txt    2013-03-14 00:27:38.000000000 +0100
> +++ iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
> @@ -44,9 +44,7 @@
>    f6c00000-f7cfffff : PCI Bus 0000:11
>      f6c00000-f6c7ffff : 0000:11:00.0
>      f6c80000-f6c83fff : 0000:11:00.0
> -      f6c80000-f6c83fff : sata_sil24
>      f6c84000-f6c8407f : 0000:11:00.0
> -      f6c84000-f6c8407f : sata_sil24
>    f7d00000-f7dfffff : PCI Bus 0000:0b
>      f7d00000-f7d0ffff : 0000:0b:00.0
>      f7d10000-f7d11fff : 0000:0b:00.0
> # diff -u -w iomem_ejected_and_reinserted_rmmod_sata_sil24.txt iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt
> --- iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
> +++ iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt       2013-03-14 00:32:48.000000000 +0100
> @@ -34,17 +34,12 @@
>  dfa00000-feafffff : PCI Bus 0000:00
>    dfa00000-dfa00fff : pnp 00:0a
>    e0000000-efffffff : 0000:00:02.0
> -  f0000000-f10fffff : PCI Bus 0000:11
>    f1100000-f11fffff : PCI Bus 0000:05
>      f1100000-f1103fff : 0000:05:00.0
>        f1100000-f1103fff : r8169
>      f1104000-f1104fff : 0000:05:00.0
>        f1104000-f1104fff : r8169
>    f6800000-f6bfffff : 0000:00:02.0
> -  f6c00000-f7cfffff : PCI Bus 0000:11
> -    f6c00000-f6c7ffff : 0000:11:00.0
> -    f6c80000-f6c83fff : 0000:11:00.0
> -    f6c84000-f6c8407f : 0000:11:00.0
>    f7d00000-f7dfffff : PCI Bus 0000:0b
>      f7d00000-f7d0ffff : 0000:0b:00.0
>      f7d10000-f7d11fff : 0000:0b:00.0
> #
>
> accompanied lspci output showing what happened during rmmod sata_sil24:
>
> # diff -u -w lspci_vvvxxx_ejected_and_reinserted.txt lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt
> --- lspci_vvvxxx_ejected_and_reinserted.txt     2013-03-14 00:27:26.000000000 +0100
> +++ lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt    2013-03-14 00:30:06.000000000 +0100
> @@ -451,12 +451,12 @@
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
> @@ -473,19 +473,19 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> +               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
> -50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
> +50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
> @@ -793,54 +793,22 @@
>  e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
> -               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> -               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
> -                       ClockPM- Surprise- LLActRep- BwNot-
> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> -                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> -       Capabilities: [100 v1] Advanced Error Reporting
> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> -               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> -               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> -               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> -               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> -               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> -       Kernel driver in use: sata_sil24
> -00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
> -10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
> -20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
> -30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
> -40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
> -60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -70: 10 00 11 00 03 00 00 00 00 20 00 00 11 f4 03 00
> -80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
> -90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
> +       !!! Unknown header type 7f
> +00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>

This is so strange, seems like 11:00.0 Mass storage controller device is still in OS, but the real hardware is removed，OS
can not access device configure space, so all config register return ff.

But why the device become stale after eject？ Mass storage controller driver should unregister and release itself.

>
> Please note the funny broken:
>
> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
> +       !!! Unknown header type 7f
> +00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> Who is still thinking the card is in the system? Didn't we agree above that PresDet
> worked fine in this particular setup?
>
> The rmmod sata_sil24 causes that in dmesg is every second repeatedly this, until forever:
>
> --- dmesg_ejected.txt   2013-03-14 00:25:59.000000000 +0100
> +++ dmesg_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:47.000000000 +0100
> @@ -819,3 +819,277 @@
>  [   37.426390] r8169 0000:05:00.0 eth0: link up
>  [   38.686210] r8169 0000:05:00.0 eth0: link down
>  [   42.551461] r8169 0000:05:00.0 eth0: link up
> +[  432.686232] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
> +[  432.695763] pcieport 0000:00:1c.7: PME# enabled
> +[  432.956104] pcieport 0000:00:1c.7: PME# disabled
> +[  432.965896] pcieport 0000:00:1c.7: PME# enabled
> +[  433.006119] pcieport 0000:00:1c.7: PME# disabled
> +[  433.016047] pcieport 0000:00:1c.7: PME# enabled
> +[  434.037451] pcieport 0000:00:1c.7: PME# disabled
> +[  434.047152] pcieport 0000:00:1c.7: PME# enabled
> +[  434.087516] pcieport 0000:00:1c.7: PME# disabled
> [cut]
>
>
>
> I should have tried below to remove 11.0 instead of 1.c7 but it demonstrates
> that one can get rid of the partial eSATA card entry from lspci output:
>
> # echo 1 > /sys/bus/pci/devices/0000\:00\:1c.7/remove
>
> That stops the PME# storm:
>
> +[  611.843285] pcieport 0000:00:1c.7: PME# disabled
> +[  611.853086] pcieport 0000:00:1c.7: PME# enabled
> +[  611.893364] pcieport 0000:00:1c.7: PME# disabled
> +[  611.903283] pcieport 0000:00:1c.7: PME# enabled
> +[  612.183893] pci 0000:11:00.0: PME# disabled
> +[  612.184789] pcieport 0000:00:1c.7: PME# disabled
> +[  612.203753] pcieport 0000:00:1c.7: PME# disabled
> +[  612.205521] pci_bus 0000:11: busn_res: [bus 11-16] is released
>
> and releases the iomem's:
>
> # diff -u -w iomem_ejected_and_reinserted_rmmod_sata_sil24.txt iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt
> --- iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
> +++ iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt       2013-03-14 00:32:48.000000000 +0100
> @@ -34,17 +34,12 @@
>  dfa00000-feafffff : PCI Bus 0000:00
>    dfa00000-dfa00fff : pnp 00:0a
>    e0000000-efffffff : 0000:00:02.0
> -  f0000000-f10fffff : PCI Bus 0000:11
>    f1100000-f11fffff : PCI Bus 0000:05
>      f1100000-f1103fff : 0000:05:00.0
>        f1100000-f1103fff : r8169
>      f1104000-f1104fff : 0000:05:00.0
>        f1104000-f1104fff : r8169
>    f6800000-f6bfffff : 0000:00:02.0
> -  f6c00000-f7cfffff : PCI Bus 0000:11
> -    f6c00000-f6c7ffff : 0000:11:00.0
> -    f6c80000-f6c83fff : 0000:11:00.0
> -    f6c84000-f6c8407f : 0000:11:00.0
>    f7d00000-f7dfffff : PCI Bus 0000:0b
>      f7d00000-f7d0ffff : 0000:0b:00.0
>      f7d10000-f7d11fff : 0000:0b:00.0
> #
>
> The accompanying diff in lspci:
>
> # diff -u -w lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt
> --- lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt    2013-03-14 00:30:06.000000000 +0100
> +++ lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt        2013-03-14 00:32:20.000000000 +0100
> @@ -429,69 +429,6 @@
>  e0: 00 3f 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>  f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
>

After you remove 00:1c.7 PCI bridge device. The 11:00.0 Mass storage controller device  still shown in lspci?
If 11:00.0 Mass storage controller device was removed now. you can try to echo 1 > /sys/bus/pci/rescan, rescan the 00:1c.7 PCI bridge
device and its child devices.
Then try to insert the card.

I use pciehp module in my machine and add pciehp_debug=1，debug info will print while I doing eject or insert.
I don't know why pciehp cannot print debug info in your system, maybe you can try to build it as module.
We can only trace eject action now, if eject action cannot complete normally, hot insert won't success.


> -00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
> -       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> -       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -       Latency: 0, Cache Line Size: 64 bytes
> -       Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
> -       I/O behind bridge: 0000c000-0000dfff
> -       Memory behind bridge: f6c00000-f7cfffff
> -       Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> -       BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> -               PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> -       Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> -               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> -                       ExtTag- RBE+ FLReset-
> -               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> -                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> -                       MaxPayload 128 bytes, MaxReadReq 128 bytes
> -               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> -               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
> -                       ClockPM- Surprise- LLActRep+ BwNot-
> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> -                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
> -               SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
> -                       Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
> -               SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> -                       Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> -                       Changed: MRL- PresDet- LinkState+
> -               RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> -               RootCap: CRSVisible-
> -               RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> -               DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
> -               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> -               LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> -                        Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> -                        Compliance De-emphasis: -6dB
> -               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
> -                        EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> -       Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> -               Address: 00000000  Data: 0000
> -       Capabilities: [90] Subsystem: Dell Device 04b3
> -       Capabilities: [a0] Power Management version 2
> -               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> -       Kernel driver in use: pcieport
> -00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
> -10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
> -20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
> -30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
> -40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
> -50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
> -60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
> -70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> -80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
> -b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
> -e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
> -f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
> -
>  00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
>         Subsystem: Dell Device 04b3
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> @@ -793,22 +730,3 @@
>  e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> -11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
> -       !!! Unknown header type 7f
> -00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> -
> #
>
>>
>> I suspect the driver release its MMIO successfully after first eject.
>
> I did not think so and hope I convinced you that this is NOT the case.
>
> Thanks for you time on this, we will find it!
> Martin
>
>>
>> Thanks!
>> Yijing.
>>
>>


-- Thanks! Yijing

