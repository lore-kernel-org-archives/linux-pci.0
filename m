Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:48268 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754909Ab3C2QpG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2013 12:45:06 -0400
Message-ID: <5155C50C.4050501@fold.natur.cuni.cz>
Date: Fri, 29 Mar 2013 17:45:00 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>  <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>  <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>  <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz> <1364545211.1817.228.camel@yhuang-dev> <5155A101.2090705@fold.natur.cuni.cz>
In-Reply-To: <5155A101.2090705@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+sarah as it shows that I had laptop-mode-tools running even under "ON AC mode"
        and it shows a dicrepancy between XHCI versus EHCI handling]

Martin Mokrejs wrote:
> Hi Ying,
>   thank you for the patch. Here are the results.
> 
> Huang Ying wrote:
>> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
>>> Hi Ying,
>>>   would you please tell me how this report relate to this patch?
>>>
>>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
>>>
>>>   Could you tell me why this PME was being flipped back and forth now?
>>> Actually, does that make finally some sense to you, pci/acpi devs?
> 
> 
> 
>   First of all, now, due to you patch, the following is logged after I run lspci
> (I tried several time lspci with none, -v, -vvv, -tv options):
> 
> --- dmesg_initial.txt   2013-03-29 14:13:44.000000000 +0100
> +++ dmesg_with_eSATA_ejected.txt        2013-03-29 14:16:37.000000000 +0100
> @@ -827,3 +827,40 @@
>  [   46.635843] r8169 0000:05:00.0: PME# disabled
>  [   46.728762] r8169 0000:05:00.0 eth0: link down
>  [   48.449706] r8169 0000:05:00.0 eth0: link up
> +[  117.546597] pcieport 0000:00:1c.4: PME# enabled
> +[  117.642825] pcieport 0000:00:1c.4: PME# disabled
> +[  117.642913] pcieport 0000:00:1c.4: PME# enabled
> +[  117.682862] pcieport 0000:00:1c.4: PME# disabled
> +[  117.682950] pcieport 0000:00:1c.4: PME# enabled
> +[  117.722906] pcieport 0000:00:1c.4: PME# disabled
> +[  117.722994] pcieport 0000:00:1c.4: PME# enabled
> +[  117.762962] pcieport 0000:00:1c.4: PME# disabled
> +[  117.763055] pcieport 0000:00:1c.4: PME# enabled
> +[  117.803062] pcieport 0000:00:1c.4: PME# disabled
> +[  117.803149] pcieport 0000:00:1c.4: PME# enabled
> +[  117.843061] pcieport 0000:00:1c.4: PME# disabled
> +[  117.843156] pcieport 0000:00:1c.4: PME# enabled
> +[  117.883108] pcieport 0000:00:1c.4: PME# disabled
> +[  117.883204] pcieport 0000:00:1c.4: PME# enabled
> +[  117.923210] pcieport 0000:00:1c.4: PME# disabled
> +[  117.923297] pcieport 0000:00:1c.4: PME# enabled
> +[  117.963206] pcieport 0000:00:1c.4: PME# disabled
> +[  117.963295] pcieport 0000:00:1c.4: PME# enabled
> +[  118.003259] pcieport 0000:00:1c.4: PME# disabled
> +[  118.003348] pcieport 0000:00:1c.4: PME# enabled
> +[  118.043354] pcieport 0000:00:1c.4: PME# disabled
> +[  118.043453] pcieport 0000:00:1c.4: PME# enabled
> +[  118.083353] pcieport 0000:00:1c.4: PME# disabled
> +[  118.083441] pcieport 0000:00:1c.4: PME# enabled
> +[  118.123472] pcieport 0000:00:1c.4: PME# disabled
> +[  118.123564] pcieport 0000:00:1c.4: PME# enabled
> +[  185.527864] pcieport 0000:00:1c.4: PME# disabled
> +[  185.527989] pcieport 0000:00:1c.4: PME# enabled
> +[  191.958942] pcieport 0000:00:1c.4: PME# disabled
> +[  191.959067] pcieport 0000:00:1c.4: PME# enabled
> +[  195.104378] pcieport 0000:00:1c.4: PME# disabled
> +[  195.104501] pcieport 0000:00:1c.4: PME# enabled
> +[  204.670888] pcieport 0000:00:1c.4: PME# disabled
> +[  204.671012] pcieport 0000:00:1c.4: PME# enabled
> +[  227.029510] pcieport 0000:00:1c.4: PME# disabled
> +[  227.029636] pcieport 0000:00:1c.4: PME# enabled

OK, so the above PME# messages are gone now with your path applied over 3.9-rc1
and while laptop-mode-tools uninstalled. Will have to check vanilla 3.9-rc1 later.


>   Second, after I ejected the coldplugged eSATA card these 1c.4: PME# messages also
> popped up in dmesg. I think just the very last two PME# lines shown above were added (so about
> the [  227.029510] time).

So the eject of the card does not associate with any single *new* line dmesg
output. 


> 
>   At the "lspci level", the eject resulted in:
> 
> # diff -u8 -w lspci_vvv_initial.txt lspci_vvv_with_eSATA_ejected.txt
> --- lspci_vvv_initial.txt       2013-03-29 14:13:56.000000000 +0100
> +++ lspci_vvv_with_eSATA_ejected.txt    2013-03-29 14:17:09.000000000 +0100
> @@ -288,37 +288,37 @@
>  00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>                 LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
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
>                 DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
> @@ -516,44 +516,12 @@
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
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

The above lspci diff did not change except the PME lines once laptop-mode-tools were uninstalled
(so note the LinkState- to LinkState+ while PresDet- to PresDet- on the Changed line).



Here is for what was the result of laptop-mode-tools uninstall (quite interesting I think):

# diff -u25 -w ../3.9-rc1-ying_with_MediaCard_reader_disabled_and_nousb/lspci_vvv_with_eSATA_ejected.txt lspci_vvv_eSATA_ejected.txt
--- ../3.9-rc1-ying_with_MediaCard_reader_disabled_and_nousb/lspci_vvv_with_eSATA_ejected.txt   2013-03-29 14:17:09.000000000 +0100
+++ lspci_vvv_eSATA_ejected.txt 2013-03-29 16:19:31.000000000 +0100
@@ -119,85 +119,85 @@
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
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
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 
 00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 2 (rev b5) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=05, subordinate=06, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000f1100000-00000000f11fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
-               RootSta: PME ReqID 0500, PMEStatus- PMEPending-
+               RootSta: PME ReqID 0000, PMEStatus- PMEPending-
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
 
@@ -260,51 +260,51 @@
00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b5) (prog-if 00 [Normal decode])

[cut]
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 
@@ -385,75 +385,75 @@

 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168 PCI Express Gigabit Ethernet controller (rev 06)
        Subsystem: Dell Device 04b3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 41
        Region 0: I/O ports at e000 [size=256]
        Region 2: Memory at f1104000 (64-bit, prefetchable) [size=4K]
        Region 4: Memory at f1100000 (64-bit, prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 41a1
        Capabilities: [70] Express (v2) Endpoint, MSI 01
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
-               DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+ TransPend-
+               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00000800
        Capabilities: [d0] Vital Product Data
                Unknown small resource type 00, will not decode more.
        Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
+               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
-               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
+               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
        Kernel driver in use: r8169
 

#

The MAbort+ on 1c.1 (handling the rtl8169 eth card) is gone with uninstall of laptop-mode-tools.
with that were maybe associated the errors on the 05:00 devcie itself (the "AERCap")?


Why the following devices do NOT show a difference in PME after laptop-mode-uninstall
I don't know (maybe laptop-mode-tools did NOT fiddle with them):
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family DRAM Controller (rev 09)
00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1 (rev 04)
00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller (rev 05)
00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 4 (rev b5) (prog-if 00 [Normal decode])
00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
00:1f.0 ISA bridge: Intel Corporation HM67 Express Chipset Family LPC Controller (rev 05)
00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset Family 6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller (rev 05)
09:00.0 Network controller: Intel Corporation Centrino Wireless-N 1030 [Rainbow Peak] (rev 34)
0b:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02) (prog-if 30 [XHCI])
11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)



So, looks laptop-mode-tools fiddled with 1c.4 XHCI's root port while NOT with EHCI ports, right?
Messing with both 1c.1 and 05:00 (the root port and the eth card) is probably correct, right?
what is 1c.0 don't know. Likely a TPM module (currently enabled in BIOS) or the in BIOS currently
disabled MediaCardReader?




Now, back tot he original problem. Doing 'rmmod sata_sil24' did:

# diff -u -w dmesg_eSATA_ejected.txt dmesg_eSATA_ejected_after_rmmod_sata_sil24.txt
--- dmesg_eSATA_ejected.txt     2013-03-29 16:19:22.000000000 +0100
+++ dmesg_eSATA_ejected_after_rmmod_sata_sil24.txt      2013-03-29 16:21:09.000000000 +0100
@@ -815,3 +815,4 @@
 [   36.552799] perf_event_intel: PEBS enabled due to microcode update
 [   39.075539] r8169 0000:05:00.0 eth0: link down
 [   45.523586] r8169 0000:05:00.0 eth0: link up
+[  276.940568] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
#

So, good, the PME# flipping back and forth doe snoty happen, likely a laptop-mode-tools
caused that before.


# diff -u -w lspci_vvv_eSATA_ejected.txt lspci_vvv_eSATA_ejected_after_rmmod_sata_sil24.txt
--- lspci_vvv_eSATA_ejected.txt 2013-03-29 16:19:31.000000000 +0100
+++ lspci_vvv_eSATA_ejected_after_rmmod_sata_sil24.txt  2013-03-29 16:21:00.000000000 +0100
@@ -523,5 +523,4 @@
 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
        !!! Unknown header type 7f
-       Kernel driver in use: sata_sil24
 
#


If we think of the situation with laptop-mode-tools installed and the rmmod, this
would have happened (note the 00:1c.7) lines:

# diff -u -w ../3.9-rc1-ying_with_MediaCard_reader_disabled_and_nousb/lspci_vvv_with_eSATA_ejected.txt ../3.9-rc1-ying_with_MediaCard_reader_disabled_and_nousb/lspci_vvv_with_eSATA_ejected_and_rmmod_sata_sil24.txt 
--- ../3.9-rc1-ying_with_MediaCard_reader_disabled_and_nousb/lspci_vvv_with_eSATA_ejected.txt   2013-03-29 14:17:09.000000000 +0100
+++ ../3.9-rc1-ying_with_MediaCard_reader_disabled_and_nousb/lspci_vvv_with_eSATA_ejected_and_rmmod_sata_sil24.txt      2013-03-29 14:19:18.000000000 +0100
@@ -329,7 +329,7 @@
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
+               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 
 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
@@ -523,5 +523,4 @@
 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev ff) (prog-if ff)
        !!! Unknown header type 7f
-       Kernel driver in use: sata_sil24
 
#

In both cases, the issue with PME# flipping back and forth is gone

Still talking about the rmmod sata-sil24, it does cause release of the memmory
(did not check /proc/iomem this today while tetsing your patch and laptop-mode-tools were
still instaleld):

# diff -u -w iomem_eSATA_ejected.txt iomem_eSATA_ejected_after_rmmod_sata_sil24.txt
--- iomem_eSATA_ejected.txt     2013-03-29 16:19:15.000000000 +0100
+++ iomem_eSATA_ejected_after_rmmod_sata_sil24.txt      2013-03-29 16:21:18.000000000 +0100
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


Like in previous tests the IRQ19 is released during rmmod:
 # diff -u -w interrupts_eSATA_ejected.txt interrupts_eSATA_ejected_after_rmmod_sata_sil24.txt 
--- interrupts_eSATA_ejected.txt        2013-03-29 16:19:05.000000000 +0100
+++ interrupts_eSATA_ejected_after_rmmod_sata_sil24.txt 2013-03-29 16:21:27.000000000 +0100
@@ -1,27 +1,26 @@
            CPU0       CPU1       
   0:         24          0   IO-APIC-edge      timer
-  1:       1366          0   IO-APIC-edge      i8042
+  1:       2524          0   IO-APIC-edge      i8042
   8:         56          0   IO-APIC-edge      rtc0
   9:          1          0   IO-APIC-fasteoi   acpi
- 12:        256          0   IO-APIC-edge      i8042
- 19:          0          0   IO-APIC-fasteoi   sata_sil24
- 40:       3830          0   PCI-MSI-edge      ahci
- 41:        421          0   PCI-MSI-edge      eth0
+ 12:        466          0   IO-APIC-edge      i8042
+ 40:       3996          0   PCI-MSI-edge      ahci
+ 41:        594          0   PCI-MSI-edge      eth0
  42:        948          0   PCI-MSI-edge      snd_hda_intel
  43:          1          0   PCI-MSI-edge      iwlwifi
  44:        201          0   PCI-MSI-edge      i915





Finally, a hotinsert of the eSATA card now does:

# diff -u -w lspci_vvv_eSATA_ejected_after_rmmod_sata_sil24.txt lspci_vvv_eSATA_ejected_after_rmmod_sata_sil24_and_hotinsert.txt
--- lspci_vvv_eSATA_ejected_after_rmmod_sata_sil24.txt  2013-03-29 16:21:00.000000000 +0100
+++ lspci_vvv_eSATA_ejected_after_rmmod_sata_sil24_and_hotinsert.txt    2013-03-29 16:23:40.000000000 +0100
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
 

Here is this very same hotinsert compared to the previous situation when laptop-mode-tools were installed:

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
-               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 

 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
        Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Region 4: I/O ports at c000 [disabled] [size=128]
        [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
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
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
-               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
+               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr- BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr-
+               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-               AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
+               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
 

Still like before, during the hotinsert, neither iomem nor interrput is assigned to the
eSATA card and not a single line appears in dmesg. The "AERCap: First Error Pointer: 14"
appeared previously during coldboot, now it pops up later, during hotplug. Please do realize
the lspci is mostly a cahced crap (e.g. note the IRQ 19 claimed to be used wheres /proc/interrupts
show it was released during rmmod and not assigtned during hotplug). so what is actually true
in the vary last diff, I don't know, but that is nothing new. Actually lines being "updated"
could be inferred from the thread "Re: 3.8.2: stale pci device info for a previously inserted express card".




The proposed patch was tested on 3.9-rc1 with laptop-mode-tools uninstalled
and while:

# grep . /sys/bus/pci/devices/*/power/control
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
# grep . /sys/bus/pci/devices/*/power/runtime_status
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
#

That's all I could say.
Martin

>>>   Does is help to say that on the SandyBridge chip I have the following root ports
>>> hooked to the following end devices?:
>>>
>>> 1.c1 -> rtl8169 05:00.0
>>> 1.c3 -> iwlwifi 09:00.0
>>> 1.c4 -> xhci_hcd 0b:00.0
>>> 1.c7 -> 00:11: express card slot
>>>
>>>
>>>   Why didn't I see interleraved lines with 1.c7 *and* 00:11? See the interleaving
>>> happening with the network card on 3.7.10 kernel (not broken kernel):
>>>
>>> [138268.870070] r8169 0000:05:00.0 eth0: link down
>>> [138270.809811] r8169 0000:05:00.0 eth0: link up
>>> [138365.599744] r8169 0000:05:00.0 eth0: link down
>>> [138370.594343] r8169 0000:05:00.0: PME# enabled
>>> [138370.623852] pcieport 0000:00:1c.1: PME# enabled
>>> [169885.247386] pcieport 0000:00:1c.1: PME# disabled
>>> [169885.267374] r8169 0000:05:00.0: PME# disabled
>>> [169885.330160] r8169 0000:05:00.0 eth0: link down
>>> [169886.992531] r8169 0000:05:00.0 eth0: link up
>>> [169904.405769] r8169 0000:05:00.0 eth0: link down
>>> [169909.401237] r8169 0000:05:00.0: PME# enabled
>>> [169909.430782] pcieport 0000:00:1c.1: PME# enabled
>>> [170090.538980] pcieport 0000:00:1c.1: PME# disabled
>>> [170090.559088] r8169 0000:05:00.0: PME# disabled
>>> [170090.640494] r8169 0000:05:00.0: PME# enabled
>>> [170090.678425] pcieport 0000:00:1c.1: PME# enabled
>>> [170090.829959] pcieport 0000:00:1c.1: PME# disabled
>>> [170090.848479] r8169 0000:05:00.0: PME# disabled
>>> [170090.892011] r8169 0000:05:00.0 eth0: link down
>>> [170090.892134] r8169 0000:05:00.0 eth0: link down
>>> [170090.930998] r8169 0000:05:00.0 eth0: link down
>>> [170092.554553] r8169 0000:05:00.0 eth0: link up
>>
>> I don't know exactly.  Can you give me the follow output?
>>
>> grep . /sys/bus/pci/devices/*/power/control
>> grep . /sys/bus/pci/devices/*/power/runtime_status
>>
>> And can you try the following patch?
>>
>> Best Regards,
>> Huang Ying
>>
>> -------------------------->
>>
>> ---
>>  drivers/pci/hotplug/pci_hotplug_core.c |    6 ++++++
>>  drivers/pci/pcie/portdrv_pci.c         |    8 +++++---
>>  drivers/pci/slot.c                     |   18 ++++++++++++++++++
>>  include/linux/pci.h                    |    1 +
>>  4 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
>> index 202f4a9..7d4cf1a 100644
>> --- a/drivers/pci/hotplug/pci_hotplug_core.c
>> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
>> @@ -39,6 +39,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci_hotplug.h>
>> +#include <linux/pm_runtime.h>
>>  #include <asm/uaccess.h>
>>  #include "../pci.h"
>>  
>> @@ -473,6 +474,8 @@ int __pci_hp_register(struct hotplug_slot *slot, struct pci_bus *bus,
>>  	dbg("Added slot %s to the list\n", name);
>>  out:
>>  	mutex_unlock(&pci_hp_mutex);
>> +	/* Bridge runtime PM state may be influenced by hotplug */
>> +	pm_runtime_resume(&bus->self->dev);
>>  	return result;
>>  }
>>  
>> @@ -489,6 +492,7 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
>>  {
>>  	struct hotplug_slot *temp;
>>  	struct pci_slot *slot;
>> +	struct pci_bus *bus;
>>  
>>  	if (!hotplug)
>>  		return -ENODEV;
>> @@ -508,8 +512,10 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
>>  
>>  	hotplug->release(hotplug);
>>  	slot->hotplug = NULL;
>> +	bus = slot->bus;
>>  	pci_destroy_slot(slot);
>>  	mutex_unlock(&pci_hp_mutex);
>> +	pm_runtime_resume(&bus->self->dev);
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
>> index 08c243a..beb9c90 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -154,9 +154,11 @@ static int pcie_port_runtime_idle(struct device *dev)
>>  	 */
>>  	pci_walk_bus(pdev->subordinate, pci_dev_pme_poll, &pme_poll);
>>  	/* Delay for a short while to prevent too frequent suspend/resume */
>> -	if (!pme_poll)
>> -		pm_schedule_suspend(dev, 10);
>> -	return -EBUSY;
>> +	if (pme_poll)
>> +		return -EBUSY;
>> +	if (pci_bus_has_hotplug_slots(pdev->subordinate))
>> +		return -EBUSY;
>> +	return pm_schedule_suspend(dev, 10);
>>  }
>>  #else
>>  #define pcie_port_runtime_suspend	NULL
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index ac6412f..10b275b 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -345,6 +345,24 @@ out:
>>  }
>>  EXPORT_SYMBOL_GPL(pci_renumber_slot);
>>  
>> +bool pci_bus_has_hotplug_slots(struct pci_bus *bus)
>> +{
>> +	struct pci_slot *slot;
>> +	bool has_hotplug_slots = false;
>> +
>> +	down_read(&pci_bus_sem);
>> +	list_for_each_entry(slot, &bus->slots, list) {
>> +		if (slot->hotplug) {
>> +			has_hotplug_slots = true;
>> +			break;
>> +		}
>> +	}
>> +	up_read(&pci_bus_sem);
>> +
>> +	return has_hotplug_slots;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_bus_has_hotplug_slots);
>> +
>>  /**
>>   * pci_destroy_slot - decrement refcount for physical PCI slot
>>   * @slot: struct pci_slot to decrement
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 2461033a..0d0cc94 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -722,6 +722,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>  void pci_destroy_slot(struct pci_slot *slot);
>>  void pci_renumber_slot(struct pci_slot *slot, int slot_nr);
>>  int pci_scan_slot(struct pci_bus *bus, int devfn);
>> +bool pci_bus_has_hotplug_slots(struct pci_bus *bus);
>>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>>  unsigned int pci_scan_child_bus(struct pci_bus *bus);
