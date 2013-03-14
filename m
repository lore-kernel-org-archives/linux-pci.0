Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:58991 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758077Ab3CNPSt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 11:18:49 -0400
Message-ID: <5141EA55.4000703@fold.natur.cuni.cz>
Date: Thu, 14 Mar 2013 16:18:45 +0100
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

[re-sending without attachment]

Yijing Wang wrote:
> On 2013/3/14 8:05, Martin Mokrejs wrote:
>> Hi Yjing,
>>

> 
>> # diff -u -w iomem_ejected_and_reinserted.txt iomem_ejected_and_reinserted_rmmod_sata_sil24.txt
>> --- iomem_ejected_and_reinserted.txt    2013-03-14 00:27:38.000000000 +0100
>> +++ iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
>> @@ -44,9 +44,7 @@
>>    f6c00000-f7cfffff : PCI Bus 0000:11
>>      f6c00000-f6c7ffff : 0000:11:00.0
>>      f6c80000-f6c83fff : 0000:11:00.0
>> -      f6c80000-f6c83fff : sata_sil24
>>      f6c84000-f6c8407f : 0000:11:00.0
>> -      f6c84000-f6c8407f : sata_sil24
>>    f7d00000-f7dfffff : PCI Bus 0000:0b
>>      f7d00000-f7d0ffff : 0000:0b:00.0
>>      f7d10000-f7d11fff : 0000:0b:00.0
>> # diff -u -w iomem_ejected_and_reinserted_rmmod_sata_sil24.txt iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt
>> --- iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
>> +++ iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt       2013-03-14 00:32:48.000000000 +0100
>> @@ -34,17 +34,12 @@
>>  dfa00000-feafffff : PCI Bus 0000:00
>>    dfa00000-dfa00fff : pnp 00:0a
>>    e0000000-efffffff : 0000:00:02.0
>> -  f0000000-f10fffff : PCI Bus 0000:11
>>    f1100000-f11fffff : PCI Bus 0000:05
>>      f1100000-f1103fff : 0000:05:00.0
>>        f1100000-f1103fff : r8169
>>      f1104000-f1104fff : 0000:05:00.0
>>        f1104000-f1104fff : r8169
>>    f6800000-f6bfffff : 0000:00:02.0
>> -  f6c00000-f7cfffff : PCI Bus 0000:11
>> -    f6c00000-f6c7ffff : 0000:11:00.0
>> -    f6c80000-f6c83fff : 0000:11:00.0
>> -    f6c84000-f6c8407f : 0000:11:00.0
>>    f7d00000-f7dfffff : PCI Bus 0000:0b
>>      f7d00000-f7d0ffff : 0000:0b:00.0
>>      f7d10000-f7d11fff : 0000:0b:00.0
>> #
>>
>> accompanied lspci output showing what happened during rmmod sata_sil24:
>>
>> # diff -u -w lspci_vvvxxx_ejected_and_reinserted.txt lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt 
>> --- lspci_vvvxxx_ejected_and_reinserted.txt     2013-03-14 00:27:26.000000000 +0100
>> +++ lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt    2013-03-14 00:30:06.000000000 +0100
>> @@ -451,12 +451,12 @@
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
>> @@ -473,19 +473,19 @@
>>         Capabilities: [90] Subsystem: Dell Device 04b3
>>         Capabilities: [a0] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>> +               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>>         Kernel driver in use: pcieport
>>  00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>>  10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
>>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>>  40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
>> -50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
>> +50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
>>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
>> -a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>> +a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
>> @@ -793,54 +793,22 @@
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
>> -               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>> -               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>> -                       ClockPM- Surprise- LLActRep- BwNot-
>> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>> -                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>> -       Capabilities: [100 v1] Advanced Error Reporting
>> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>> -               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>> -               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>> -               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> -               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>> -               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>> -       Kernel driver in use: sata_sil24
>> -00: 95 10 32 31 00 00 10 00 01 00 80 01 00 00 00 00
>> -10: 04 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
>> -20: 01 00 00 00 00 00 00 00 00 00 00 00 95 10 32 31
>> -30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
>> -40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
>> -60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -70: 10 00 11 00 03 00 00 00 00 20 00 00 11 f4 03 00
>> -80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
>> -90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
>> +       !!! Unknown header type 7f
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
> 
> This is so strange, seems like 11:00.0 Mass storage controller device is still in OS, but the real hardware is removedï¼OS
> can not access device configure space, so all config register return ff.
> 
> But why the device become stale after ejectï¼ Mass storage controller driver should unregister and release itself.

I think the answer is in the PME# messages. In this particular situation
they are flipped from enabled to disabled and back in a never ending loop.
I do not want to try what happens hen I drop pcie_aspm=off from the comandline
yet ;) but somewhat fear things could start working and PME# messages would
disappear. ;-)

> 
>>
>> Please note the funny broken:
>>
>> +11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
>> +       !!! Unknown header type 7f
>> +00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>
>> Who is still thinking the card is in the system? Didn't we agree above that PresDet
>> worked fine in this particular setup?
>>
>> The rmmod sata_sil24 causes that in dmesg is every second repeatedly this, until forever:
>>
>> --- dmesg_ejected.txt   2013-03-14 00:25:59.000000000 +0100
>> +++ dmesg_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:47.000000000 +0100
>> @@ -819,3 +819,277 @@
>>  [   37.426390] r8169 0000:05:00.0 eth0: link up
>>  [   38.686210] r8169 0000:05:00.0 eth0: link down
>>  [   42.551461] r8169 0000:05:00.0 eth0: link up
>> +[  432.686232] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
>> +[  432.695763] pcieport 0000:00:1c.7: PME# enabled
>> +[  432.956104] pcieport 0000:00:1c.7: PME# disabled
>> +[  432.965896] pcieport 0000:00:1c.7: PME# enabled
>> +[  433.006119] pcieport 0000:00:1c.7: PME# disabled
>> +[  433.016047] pcieport 0000:00:1c.7: PME# enabled
>> +[  434.037451] pcieport 0000:00:1c.7: PME# disabled
>> +[  434.047152] pcieport 0000:00:1c.7: PME# enabled
>> +[  434.087516] pcieport 0000:00:1c.7: PME# disabled
>> [cut]
>>
>>
>>
>> I should have tried below to remove 11.0 instead of 1.c7 but it demonstrates
>> that one can get rid of the partial eSATA card entry from lspci output:
>>
>> # echo 1 > /sys/bus/pci/devices/0000\:00\:1c.7/remove
>>
>> That stops the PME# storm:
>>
>> +[  611.843285] pcieport 0000:00:1c.7: PME# disabled
>> +[  611.853086] pcieport 0000:00:1c.7: PME# enabled
>> +[  611.893364] pcieport 0000:00:1c.7: PME# disabled
>> +[  611.903283] pcieport 0000:00:1c.7: PME# enabled
>> +[  612.183893] pci 0000:11:00.0: PME# disabled
>> +[  612.184789] pcieport 0000:00:1c.7: PME# disabled
>> +[  612.203753] pcieport 0000:00:1c.7: PME# disabled
>> +[  612.205521] pci_bus 0000:11: busn_res: [bus 11-16] is released
>>
>> and releases the iomem's:
>>
>> # diff -u -w iomem_ejected_and_reinserted_rmmod_sata_sil24.txt iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt 
>> --- iomem_ejected_and_reinserted_rmmod_sata_sil24.txt   2013-03-14 00:29:02.000000000 +0100
>> +++ iomem_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt       2013-03-14 00:32:48.000000000 +0100
>> @@ -34,17 +34,12 @@
>>  dfa00000-feafffff : PCI Bus 0000:00
>>    dfa00000-dfa00fff : pnp 00:0a
>>    e0000000-efffffff : 0000:00:02.0
>> -  f0000000-f10fffff : PCI Bus 0000:11
>>    f1100000-f11fffff : PCI Bus 0000:05
>>      f1100000-f1103fff : 0000:05:00.0
>>        f1100000-f1103fff : r8169
>>      f1104000-f1104fff : 0000:05:00.0
>>        f1104000-f1104fff : r8169
>>    f6800000-f6bfffff : 0000:00:02.0
>> -  f6c00000-f7cfffff : PCI Bus 0000:11
>> -    f6c00000-f6c7ffff : 0000:11:00.0
>> -    f6c80000-f6c83fff : 0000:11:00.0
>> -    f6c84000-f6c8407f : 0000:11:00.0
>>    f7d00000-f7dfffff : PCI Bus 0000:0b
>>      f7d00000-f7d0ffff : 0000:0b:00.0
>>      f7d10000-f7d11fff : 0000:0b:00.0
>> #
>>
>> The accompanying diff in lspci:
>>
>> # diff -u -w lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt 
>> --- lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24.txt    2013-03-14 00:30:06.000000000 +0100
>> +++ lspci_vvvxxx_ejected_and_reinserted_rmmod_sata_sil24_remove_1c.7.txt        2013-03-14 00:32:20.000000000 +0100
>> @@ -429,69 +429,6 @@
>>  e0: 00 3f 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>>  f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
>>  
> 
> After you remove 00:1c.7 PCI bridge device. The 11:00.0 Mass storage controller device  still shown in lspci?

No. I thought I showed that in the diffs clearly. Please check again. ;-)
A note: It was in the diff output immediately below this place where you
wrote the question. ;))


> If 11:00.0 Mass storage controller device was removed now. you can try to echo 1 > /sys/bus/pci/rescan, rescan the 00:1c.7 PCI bridge
> device and its child devices.
> Then try to insert the card.

Will do below.

> 
> I use pciehp module in my machine and add pciehp_debug=1ï¼debug info will print while I doing eject or insert.
> I don't know why pciehp cannot print debug info in your system, maybe you can try to build it as module.
> We can only trace eject action now, if eject action cannot complete normally, hot insert won't success.

Hmm, I did the following to my kernel commandline to be sure:

-pciehp.pciehp_debug=1 slub_debug=AFPZ pcie_aspm=off
+pciehp.pciehp_debug=1 pciehp_debug=1 slub_debug=AFPZ pcie_aspm=off


So now the test what happens if I remove 1c.7 and do a bus rescan. I can tell you
in advance the hotplugged card was not picked up until I did a second pci rescan.
But please check the diffs below. I tried to say it short but omit many details
which are out of my knowledge. ;)






The eject of a coldplugged card. Note that PresDet on the Changed: line is not set
to PresDet+ or is it because it was overwritten too early (as you said elsewhere)?

--- lspci_loop.11:19:01 2013-03-14 11:19:01.000000000 +0100
+++ lspci_loop.11:19:02 2013-03-14 11:19:02.000000000 +0100
@@ -437,7 +437,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -451,13 +451,13 @@
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

--- lspci_loop.11:19:24 2013-03-14 11:19:24.000000000 +0100
+++ lspci_loop.11:19:25 2013-03-14 11:19:25.000000000 +0100
@@ -653,7 +653,7 @@
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
+               CESta:  RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel

# diff -u -w dmesg.txt dmesg_ejected.txt 
# diff -u -w iomem.txt iomem_ejected.txt 
#


# echo 1 > /sys/bus/pci/devices/0000\:00\:1c.7/remove


--- lspci_loop.11:20:46 2013-03-14 11:20:46.000000000 +0100
+++ lspci_loop.11:20:47 2013-03-14 11:20:47.000000000 +0100
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
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
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
-a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
-b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
-e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
-f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
-
 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
        Subsystem: Dell Device 04b3
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
@@ -793,23 +730,3 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
-11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
-       !!! Unknown header type 7f
-       Kernel driver in use: sata_sil24
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

Hmm, I forgot to catch the iomem and dmesg at this stage.


# echo 1 > /sys/bus/pci/rescan
#

# diff -u -w iomem_ejected.txt iomem_ejected_removed_1c.7__pci_rescan.txt 
--- iomem_ejected.txt   2013-03-14 11:19:04.000000000 +0100
+++ iomem_ejected_removed_1c.7__pci_rescan.txt  2013-03-14 11:22:16.000000000 +0100
@@ -34,19 +34,14 @@
 dfa00000-feafffff : PCI Bus 0000:00
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
-  f0000000-f10fffff : PCI Bus 0000:11
   f1100000-f11fffff : PCI Bus 0000:05
     f1100000-f1103fff : 0000:05:00.0
       f1100000-f1103fff : r8169
     f1104000-f1104fff : 0000:05:00.0
       f1104000-f1104fff : r8169
+  f1200000-f24fffff : PCI Bus 0000:11
+  f2500000-f37fffff : PCI Bus 0000:11
   f6800000-f6bfffff : 0000:00:02.0
-  f6c00000-f7cfffff : PCI Bus 0000:11
-    f6c00000-f6c7ffff : 0000:11:00.0
-    f6c80000-f6c83fff : 0000:11:00.0
-      f6c80000-f6c83fff : sata_sil24
-    f6c84000-f6c8407f : 0000:11:00.0
-      f6c84000-f6c8407f : sata_sil24
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
     f7d10000-f7d11fff : 0000:0b:00.0

--- lspci_loop.11:21:17 2013-03-14 11:21:17.000000000 +0100
+++ lspci_loop.11:21:18 2013-03-14 11:21:18.000000000 +0100
@@ -429,6 +429,69 @@
 e0: 00 3f 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
 
+00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+       Latency: 0, Cache Line Size: 64 bytes
+       Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
+       I/O behind bridge: 00002000-00003fff
+       Memory behind bridge: f1200000-f24fffff
+       Prefetchable memory behind bridge: 00000000f2500000-00000000f37fffff
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
+               PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
+       Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
+               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
+                       ExtTag- RBE+ FLReset-
+               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
+                       MaxPayload 128 bytes, MaxReadReq 128 bytes
+               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
+               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
+                       ClockPM- Surprise- LLActRep+ BwNot-
+               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
+                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
+               SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
+                       Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
+               SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
+                       Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+                       Changed: MRL- PresDet- LinkState+
+               RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
+               RootCap: CRSVisible-
+               RootSta: PME ReqID 0000, PMEStatus- PMEPending-
+               DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
+               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
+               LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
+                        Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+                        Compliance De-emphasis: -6dB
+               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
+                        EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
+       Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
+               Address: 00000000  Data: 0000
+       Capabilities: [90] Subsystem: Dell Device 04b3
+       Capabilities: [a0] Power Management version 2
+               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+       Kernel driver in use: pcieport
+00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 20 30 00 00
+20: 20 f1 40 f2 51 f2 71 f3 00 00 00 00 00 00 00 00
+30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
+40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
+50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
+60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
+70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
+a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
+e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
+
 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
        Subsystem: Dell Device 04b3
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-

# diff -u -w dmesg_ejected.txt dmesg_ejected_removed_1c.7__pci_rescan.txt 
--- dmesg_ejected.txt   2013-03-14 11:19:14.000000000 +0100
+++ dmesg_ejected_removed_1c.7__pci_rescan.txt  2013-03-14 11:22:07.000000000 +0100
@@ -824,3 +824,52 @@
 [   36.491646] r8169 0000:05:00.0 eth0: link up
 [   37.742951] r8169 0000:05:00.0 eth0: link down
 [   40.590057] r8169 0000:05:00.0 eth0: link up
+[  301.976189] sata_sil24 0000:11:00.0: PME# disabled
+[  301.979812] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+[  301.981627] pcieport 0000:00:1c.7: PME# disabled
+[  301.984689] pci_bus 0000:11: busn_res: [bus 11-16] is released
+[  333.819564] pci_bus 0000:00: scanning bus
+[  333.819676] pci 0000:00:1c.7: [8086:1c1e] type 01 class 0x060400
+[  333.819753] pci 0000:00:1c.7: calling pci_fixup_transparent_bridge+0x0/0x1d
+[  333.819855] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
+[  333.819862] pci 0000:00:1c.7: PME# disabled
+[  333.820811] pci 0000:00:1c.7: System wakeup disabled by ACPI
+[  333.821238] pcieport 0000:00:1c.0: scanning [bus 03-04] behind bridge, pass 0
+[  333.821244] pci_bus 0000:03: scanning bus
+[  333.821248] pci_bus 0000:03: bus scan returning with max=03
+[  333.821254] pcieport 0000:00:1c.1: scanning [bus 05-06] behind bridge, pass 0
+[  333.821260] pci_bus 0000:05: scanning bus
+[  333.821262] pci_bus 0000:05: bus scan returning with max=05
+[  333.821268] pcieport 0000:00:1c.3: scanning [bus 09-0a] behind bridge, pass 0
+[  333.821273] pci_bus 0000:09: scanning bus
+[  333.821275] pci_bus 0000:09: bus scan returning with max=09
+[  333.821281] pcieport 0000:00:1c.4: scanning [bus 0b-0c] behind bridge, pass 0
+[  333.821286] pci_bus 0000:0b: scanning bus
+[  333.821288] pci_bus 0000:0b: bus scan returning with max=0b
+[  333.821293] pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 0
+[  333.821624] pci_bus 0000:11: scanning bus
+[  333.821629] pci_bus 0000:11: fixups for bus
+[  333.821630] pci 0000:00:1c.7: PCI bridge to [bus 11-16]
+[  333.821637] pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
+[  333.821643] pci 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
+[  333.821652] pci 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
+[  333.821653] pci_bus 0000:11: bus scan returning with max=11
+[  333.821658] pcieport 0000:00:1c.0: scanning [bus 03-04] behind bridge, pass 1
+[  333.821668] pcieport 0000:00:1c.1: scanning [bus 05-06] behind bridge, pass 1
+[  333.821677] pcieport 0000:00:1c.3: scanning [bus 09-0a] behind bridge, pass 1
+[  333.821686] pcieport 0000:00:1c.4: scanning [bus 0b-0c] behind bridge, pass 1
+[  333.821695] pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 1
+[  333.821702] pci_bus 0000:00: bus scan returning with max=16
+[  333.821788] pci 0000:00:1c.7: bridge window [mem 0x00100000-0x011fffff 64bit pref] to [bus 11-16] add_size 200000
+[  333.821795] pci 0000:00:1c.7: bridge window [mem 0x00100000-0x011fffff] to [bus 11-16] add_size 200000
+[  333.821798] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
+[  333.821828] pci 0000:00:1c.7: res[14]=[mem 0x00100000-0x011fffff] get_res_add_size add_size 200000
+[  333.821830] pci 0000:00:1c.7: res[15]=[mem 0x00100000-0x011fffff 64bit pref] get_res_add_size add_size 200000
+[  333.821836] pci 0000:00:1c.7: BAR 14: assigned [mem 0xf1200000-0xf24fffff]
+[  333.821840] pci 0000:00:1c.7: BAR 15: assigned [mem 0xf2500000-0xf37fffff 64bit pref]
+[  333.821843] pci 0000:00:1c.7: BAR 13: assigned [io  0x2000-0x3fff]
+[  333.821862] pci 0000:00:1c.7: PCI bridge to [bus 11-16]
+[  333.821866] pci 0000:00:1c.7:   bridge window [io  0x2000-0x3fff]
+[  333.821873] pci 0000:00:1c.7:   bridge window [mem 0xf1200000-0xf24fffff]
+[  333.821879] pci 0000:00:1c.7:   bridge window [mem 0xf2500000-0xf37fffff 64bit pref]
+[  333.823391] pci 0000:00:1c.7: enabling bus mastering
#




Hot insert of the card:

--- lspci_loop.11:23:22 2013-03-14 11:23:22.000000000 +0100
+++ lspci_loop.11:23:23 2013-03-14 11:23:23.000000000 +0100
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
 20: 20 f1 40 f2 51 f2 71 f3 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
+50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# diff -u -w dmesg_ejected_removed_1c.7__pci_rescan.txt dmesg_ejected_removed_1c.7__pci_rescan_hotinsert.txt 
# diff -u -w iomem_ejected_removed_1c.7__pci_rescan.txt iomem_ejected_removed_1c.7__pci_rescan_hotinsert.txt 
#



Yet another "echo 1 > /sys/bus/pci/rescan"


--- lspci_loop.11:25:04 2013-03-14 11:25:04.000000000 +0100
+++ lspci_loop.11:25:05 2013-03-14 11:25:05.000000000 +0100
@@ -793,3 +793,55 @@
 e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
+       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+       Latency: 0
+       Interrupt: pin A routed to IRQ 19
+       Region 0: Memory at f1204000 (64-bit, non-prefetchable) [size=128]
+       Region 2: Memory at f1200000 (64-bit, non-prefetchable) [size=16K]
+       Region 4: I/O ports at 2000 [size=128]
+       [virtual] Expansion ROM at f2500000 [disabled] [size=512K]
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
+00: 95 10 32 31 07 00 10 00 01 00 80 01 00 00 00 00
+10: 04 40 20 f1 00 00 00 00 04 00 20 f1 00 00 00 00
+20: 01 20 00 00 00 00 00 00 00 00 00 00 95 10 32 31
+30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
+40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
+60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+70: 10 00 11 00 03 00 00 00 00 50 0a 00 11 f4 03 00
+80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
+90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+

# diff -u -w iomem_ejected_removed_1c.7__pci_rescan_hotinsert.txt iomem_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt 
--- iomem_ejected_removed_1c.7__pci_rescan_hotinsert.txt        2013-03-14 11:23:36.000000000 +0100
+++ iomem_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt     2013-03-14 11:25:39.000000000 +0100
@@ -40,7 +40,12 @@
     f1104000-f1104fff : 0000:05:00.0
       f1104000-f1104fff : r8169
   f1200000-f24fffff : PCI Bus 0000:11
+    f1200000-f1203fff : 0000:11:00.0
+      f1200000-f1203fff : sata_sil24
+    f1204000-f120407f : 0000:11:00.0
+      f1204000-f120407f : sata_sil24
   f2500000-f37fffff : PCI Bus 0000:11
+    f2500000-f257ffff : 0000:11:00.0
   f6800000-f6bfffff : 0000:00:02.0
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0

# diff -u -w dmesg_ejected_removed_1c.7__pci_rescan_hotinsert.txt dmesg_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt 
--- dmesg_ejected_removed_1c.7__pci_rescan_hotinsert.txt        2013-03-14 11:23:46.000000000 +0100
+++ dmesg_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt     2013-03-14 11:25:30.000000000 +0100
@@ -873,3 +873,47 @@
 [  333.821873] pci 0000:00:1c.7:   bridge window [mem 0xf1200000-0xf24fffff]
 [  333.821879] pci 0000:00:1c.7:   bridge window [mem 0xf2500000-0xf37fffff 64bit pref]
 [  333.823391] pci 0000:00:1c.7: enabling bus mastering
+[  560.970367] pci_bus 0000:00: scanning bus
+[  560.970458] pcieport 0000:00:1c.0: scanning [bus 03-04] behind bridge, pass 0
+[  560.970465] pci_bus 0000:03: scanning bus
+[  560.970468] pci_bus 0000:03: bus scan returning with max=03
+[  560.970474] pcieport 0000:00:1c.1: scanning [bus 05-06] behind bridge, pass 0
+[  560.970479] pci_bus 0000:05: scanning bus
+[  560.970481] pci_bus 0000:05: bus scan returning with max=05
+[  560.970487] pcieport 0000:00:1c.3: scanning [bus 09-0a] behind bridge, pass 0
+[  560.970492] pci_bus 0000:09: scanning bus
+[  560.970493] pci_bus 0000:09: bus scan returning with max=09
+[  560.970499] pcieport 0000:00:1c.4: scanning [bus 0b-0c] behind bridge, pass 0
+[  560.970504] pci_bus 0000:0b: scanning bus
+[  560.970505] pci_bus 0000:0b: bus scan returning with max=0b
+[  560.970511] pcieport 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 0
+[  560.970516] pci_bus 0000:11: scanning bus
+[  560.970568] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+[  560.970613] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+[  560.970645] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+[  560.970666] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+[  560.970707] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+[  560.970825] pci 0000:11:00.0: supports D1 D2
+[  560.971265] pci_bus 0000:11: bus scan returning with max=11
+[  560.971271] pcieport 0000:00:1c.0: scanning [bus 03-04] behind bridge, pass 1
+[  560.971280] pcieport 0000:00:1c.1: scanning [bus 05-06] behind bridge, pass 1
+[  560.971289] pcieport 0000:00:1c.3: scanning [bus 09-0a] behind bridge, pass 1
+[  560.971298] pcieport 0000:00:1c.4: scanning [bus 0b-0c] behind bridge, pass 1
+[  560.971307] pcieport 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 1
+[  560.971314] pci_bus 0000:00: bus scan returning with max=16
+[  560.971378] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
+[  560.971403] pci 0000:11:00.0: BAR 6: assigned [mem 0xf2500000-0xf257ffff pref]
+[  560.971406] pci 0000:11:00.0: BAR 2: assigned [mem 0xf1200000-0xf1203fff 64bit]
+[  560.971428] pci 0000:11:00.0: BAR 2: set to [mem 0xf1200000-0xf1203fff 64bit] (PCI address [0xf1200000-0xf1203fff])
+[  560.971429] pci 0000:11:00.0: BAR 0: assigned [mem 0xf1204000-0xf120407f 64bit]
+[  560.971451] pci 0000:11:00.0: BAR 0: set to [mem 0xf1204000-0xf120407f 64bit] (PCI address [0xf1204000-0xf120407f])
+[  560.971453] pci 0000:11:00.0: BAR 4: assigned [io  0x2000-0x207f]
+[  560.971460] pci 0000:11:00.0: BAR 4: set to [io  0x2000-0x207f] (PCI address [0x2000-0x207f])
+[  560.971693] sata_sil24 0000:11:00.0: enabling device (0000 -> 0003)
+[  560.972478] sata_sil24 0000:11:00.0: enabling bus mastering
+[  560.975779] scsi8 : sata_sil24
+[  560.978910] scsi9 : sata_sil24
+[  560.979497] ata9: SATA max UDMA/100 host m128@0xf1204000 port 0xf1200000 irq 19
+[  560.979502] ata10: SATA max UDMA/100 host m128@0xf1204000 port 0xf1202000 irq 19
+[  563.067179] ata9: SATA link down (SStatus 0 SControl 0)
+[  565.159741] ata10: SATA link down (SStatus 0 SControl 0)
#


Let me note that in usually saw instead:
[  211.879397] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)

During cold boot, the the bus scanning messages are much more verbose, call some quirks,
etc. Please see the attached dmesg to have something to compare with the above rescan output .

Whether the i915 thing relates to skipped quirks, I don't know.

Why is there  [bus 03-04] , [bus 05-06] ,  [bus 09-0a] , [bus 0b-0c] but then [bus 11-16]?
Is that in decimal?




Again, a closing comparison of a coldboot state to the one after the eject,
removal of 1c.7, pci rescan, hotinsert, another pci rescan:

# diff -u -w iomem.txt iomem_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt 
--- iomem.txt   2013-03-14 11:17:26.000000000 +0100
+++ iomem_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt     2013-03-14 11:25:39.000000000 +0100
@@ -34,19 +34,19 @@
 dfa00000-feafffff : PCI Bus 0000:00
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
-  f0000000-f10fffff : PCI Bus 0000:11
   f1100000-f11fffff : PCI Bus 0000:05
     f1100000-f1103fff : 0000:05:00.0
       f1100000-f1103fff : r8169
     f1104000-f1104fff : 0000:05:00.0
       f1104000-f1104fff : r8169
+  f1200000-f24fffff : PCI Bus 0000:11
+    f1200000-f1203fff : 0000:11:00.0
+      f1200000-f1203fff : sata_sil24
+    f1204000-f120407f : 0000:11:00.0
+      f1204000-f120407f : sata_sil24
+  f2500000-f37fffff : PCI Bus 0000:11
+    f2500000-f257ffff : 0000:11:00.0
   f6800000-f6bfffff : 0000:00:02.0
-  f6c00000-f7cfffff : PCI Bus 0000:11
-    f6c00000-f6c7ffff : 0000:11:00.0
-    f6c80000-f6c83fff : 0000:11:00.0
-      f6c80000-f6c83fff : sata_sil24
-    f6c84000-f6c8407f : 0000:11:00.0
-      f6c84000-f6c8407f : sata_sil24
   f7d00000-f7dfffff : PCI Bus 0000:0b
     f7d00000-f7d0ffff : 0000:0b:00.0
     f7d10000-f7d11fff : 0000:0b:00.0
#
# diff -u -w lspci_vvvxxx.txt lspci_vvvxxx_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt 
--- lspci_vvvxxx.txt    2013-03-14 11:18:14.000000000 +0100
+++ lspci_vvvxxx_ejected_removed_1c.7__pci_rescan_hotinsert_pci_rescan.txt      2013-03-14 11:25:21.000000000 +0100
@@ -434,9 +434,9 @@
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
-       I/O behind bridge: 0000c000-0000dfff
-       Memory behind bridge: f6c00000-f7cfffff
-       Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
+       I/O behind bridge: 00002000-00003fff
+       Memory behind bridge: f1200000-f24fffff
+       Prefetchable memory behind bridge: 00000000f2500000-00000000f37fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
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
-20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 20 30 00 00
+20: 20 f1 40 f2 51 f2 71 f3 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
+50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -653,7 +653,7 @@
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
+               CESta:  RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
@@ -797,12 +797,12 @@
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 64 bytes
+       Latency: 0
        Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
-       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
-       Region 4: I/O ports at c000 [size=128]
-       Expansion ROM at f6c00000 [disabled] [size=512K]
+       Region 0: Memory at f1204000 (64-bit, non-prefetchable) [size=128]
+       Region 2: Memory at f1200000 (64-bit, non-prefetchable) [size=16K]
+       Region 4: I/O ports at 2000 [size=128]
+       [virtual] Expansion ROM at f2500000 [disabled] [size=512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
@@ -828,10 +828,10 @@
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24
-00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
-10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
-20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
-30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
+00: 95 10 32 31 07 00 10 00 01 00 80 01 00 00 00 00
+10: 04 40 20 f1 00 00 00 00 04 00 20 f1 00 00 00 00
+20: 01 20 00 00 00 00 00 00 00 00 00 00 95 10 32 31
+30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

#

The slot status changes were from coldboot with card loaded:

11:18:26 SlotStatus 0040
11:19:01 SlotStatus 0040

eject 

11:19:02 SlotStatus 0100
11:20:46 SlotStatus 0100

removed 1.c7, rescan

11:21:19 SlotStatus 0100

hot insert

11:23:22 SlotStatus 0100
11:23:23 SlotStatus 0140



Martin

