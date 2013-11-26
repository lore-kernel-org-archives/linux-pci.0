Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43141 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3KZDNU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 22:13:20 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so8380995iec.13
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2013 19:13:20 -0800 (PST)
Date: Mon, 25 Nov 2013 20:13:17 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: pciehp LinkState
Message-ID: <20131126031317.GA6258@google.com>
References: <528D4739.80700@fold.natur.cuni.cz>
 <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
 <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
 <20131125194044.GA9710@google.com>
 <5293F3FB.6000401@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5293F3FB.6000401@fold.natur.cuni.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 26, 2013 at 02:06:03AM +0100, Martin Mokrejs wrote:
> Hi Rajat and Bjorn,
>   I tested all the patches, comments below:
> 
> Bjorn Helgaas wrote:
> > On Mon, Nov 25, 2013 at 07:00:01PM +0000, Rajat Jain wrote:
> >> Hello Martin,
> >>
> >>>>
> >>>> Below is the overview since cold boot with no card inserted with all
> >>> those hotplug events. You see,
> >>>> pciehp never sets LinkState back to minus once the slot is empty:
> >>>>
> >>>> vostro ~ # grep LinkState
> >>> pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__eject
> >>> ed_but_not_realized__inserted__ejected.txt
> >>>>                         Changed: MRL- PresDet- LinkState-
> >>>>                         Changed: MRL- PresDet- LinkState+
> >>>>                         Changed: MRL- PresDet- LinkState+
> >>>>                         Changed: MRL- PresDet- LinkState+
> >>>>                         Changed: MRL- PresDet- LinkState+
> >>>
> >>> I opened https://bugzilla.kernel.org/show_bug.cgi?id=65521 for this
> >>> issue.  I agree that pciehp should probably clear this bit.  Rajat
> >>> recently posted some patches [1] that add support for link state
> >>> changes.  I haven't look at them in detail yet, but I wouldn't be
> >>> surprised if they will fix this issue.  If you wanted to test them,
> >>> that would be awesome!
> 
> In brief, the patch works, note below on every 5th line there is LinkState-,
> so the LinkState is not stuck at plus anymore. Why I never see it plus
> I do not know, maybe it is cleared too quickly?
> 
> # grep Changed lspci_vvv_initial* | grep LinkState
> lspci_vvv_initial.txt:                  Changed: MRL- PresDet- LinkState-
> lspci_vvv_initial.txt:                  Changed: MRL- PresDet- LinkState+
> lspci_vvv_initial.txt:                  Changed: MRL- PresDet- LinkState+
> lspci_vvv_initial.txt:                  Changed: MRL- PresDet- LinkState+
> lspci_vvv_initial.txt:                  Changed: MRL- PresDet- LinkState-


Great, thanks for testing this.  The bit labelled "LinkState" here is the
"Data Link Layer State *Changed*" bit in the Slot Status register.  It is
set whenever the Data Link Layer Link Active bit in the Link Status
register is changed.  So this LinkState bit doesn't tell you the state of
the link; basically it just tells you that the link changed from "down" to
"up", or from "up" to "down."

You should not normally see this "LinkStateChanged" bit set via lspci
because pciehp will get an interrupt when it is set, and the ISR will
notice that the link state has changed and immediately clear the
LinkStateChanged bit.

> During very first card hotinsert I get on the upstream rootport:
> 
> 
> # diff -u30 -w lspci_vvv_initial.txt lspci_vvv_initial__inserted.txt 
> --- lspci_vvv_initial.txt       2013-11-26 01:12:19.260000366 +0100
> +++ lspci_vvv_initial__inserted.txt     2013-11-26 01:13:02.780000480 +0100
>  00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> -               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
> +               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us

L0 exit latency depends on clock configuration, which we changed, so this
difference is normal.

>                         ClockPM- Surprise- LLActRep+ BwNot-
> -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
> +               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+

Here's where we changed the clock config.  This is part of ASPM, and these
differences look normal.

>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-

This looks normal.

>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-

This looks normal.

>                         Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee00318  Data: 0000
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  
> 
> and the card itself is detected:
> 
> +11:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
> +       Subsystem: NEC Corporation uPD720200 USB 3.0 Host Controller
> +       Physical Slot: 7
> +       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> +       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> +       Latency: 0, Cache Line Size: 64 bytes
> +       Interrupt: pin A routed to IRQ 19
> +       Region 0: Memory at f6c00000 (64-bit, non-prefetchable) [size=8K]
> +       Capabilities: [50] Power Management version 3
> +               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
> +               Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> +       Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
> +               Address: 0000000000000000  Data: 0000
> +       Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
> +               Vector table: BAR=0 offset=00001000
> +               PBA: BAR=0 offset=00001080
> +       Capabilities: [a0] Express (v2) Endpoint, MSI 00
> +               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
> +                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> +               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> +                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> +                       MaxPayload 128 bytes, MaxReadReq 512 bytes
> +               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> +               LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 unlimited
> +                       ClockPM+ Surprise- LLActRep- BwNot-
> +               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> +                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> +               DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF Not Supported
> +               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> +               LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> +                        Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> +                        Compliance De-emphasis: -6dB
> +               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
> +                        EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> +       Capabilities: [100 v1] Advanced Error Reporting
> +               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> +               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> +               UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> +               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> +               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> +               AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> +       Capabilities: [140 v1] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
> +       Capabilities: [150 v1] Latency Tolerance Reporting
> +               Max snoop latency: 0ns
> +               Max no snoop latency: 0ns
> +       Kernel driver in use: xhci_hcd
> 
> 
> After eject of the card the system differs from a cold-boot state so I get some diffs those are maybe irrelevant?:
> 
> # diff -u30 -w lspci_vvv_initial.txt lspci_vvv_initial__inserted__ejected.txt 
> --- lspci_vvv_initial.txt       2013-11-26 01:12:19.260000366 +0100
> +++ lspci_vvv_initial__inserted__ejected.txt    2013-11-26 01:13:42.060000582 +0100
>  00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-

This is https://bugzilla.kernel.org/show_bug.cgi?id=65511

>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> -               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
> +               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot-
> -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
> +               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+

If we restored the ASPM & clock config after removal, these differences
would probably go away.  We could try to do that, but I think there are
more important ASPM things to worry about.

>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-

Linux currently doesn't have monitor these Link Bandwith management things:
we don't enable the interrupts in the Link Control register, and there's no
ISR that would read and clear these Link Status bits.  It might be nice to
do that, but again, there's no pressing need for it.

>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>                         Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee00318  Data: 0000
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
> 
> 
> Notably, upon eject the status line of 00:1c.7 from vanilla 3.12 was always stuck at plus while the patched kernel flipped it back to minus:
> -Changed: MRL- PresDet- LinkState+
> +Changed: MRL- PresDet- LinkState-
> 
> So, I think your patch works fine.
> ...

> If it is clearer, a view froma diffent angle comparing vanilla and patched kernel states after
> very first hotinsert:
> 
> # diff -u40 -w 3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted.txt 3.12-linkchangepatch/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted.txt 
> --- 3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted.txt      2013-11-20 19:34:47.990000788 +0100
> +++ 3.12-linkchangepatch/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted.txt      2013-11-26 01:13:02.780000480 +0100
>  00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
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
>                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> -                       Changed: MRL- PresDet- LinkState+
> +                       Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee00318  Data: 0000
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
> 
> 
> 
> I read a bit too quickly your comments in the patch and while am no kernel developer I will post
> silly questions. Maybe you would like to polish the comments in patches.
> 1. You speak about some 'bells and whistles' ... you mean PresDet bit handled by my SandyBridge chip
> is also one of those fancy things like an eject button? The LinkState is another example of fancy thing?
> Why aren't or weren't these supported before some eject buttons you speak about?

I think this is just a consequence of the fact that we typically add
support for things as we need them, and people haven't needed LinkState in
the past.  Rajat has a somewhat unusual system that needs it, so he's now
adding support for it.

> 2. Concerning eject detection, is there any order of precedence of the information being collected
> and interpreted? Like, is PresDet more important than LinkChange or some "eject button" of whatever
> you mean under thos 'bells and whistles'?
> 
> 3. Related to point 2., should xhci_hcd behave in a different way and say let more happily a USB device
> fall asleep if the LinkState is now being cleared? (Note: to do the above tests I had to redo my test
> of teh patched kernel because I forgot that likely while testing vanilla kernel I had attached USB
> mouse and keyboard to my SandyBridge chip and the TexaInstruments chip. While inspecting lspci differences
> I wondered why in unpatched kernel I had changes between ASPM L0s L1 vs. Disabled while on patched
> kernel the insert/eject changes resulted in ASPM L0s vs L1 only difference. It seem that was because
> I did not have attached USB devices to the ports. But, funny is that these differences were on all
> USB-capable PCI devices (hence am speaking about SandyBridge's USB2 ports, the onboard TexasInstuments
> USB3 chip while affected should have been only the NEC-based USB3 chip presenton the hotpluggable card --
> or its rootport. So, I somehow suspect your patch changed a bit more in behavior or my system.
> 
> 
> I do not want to spoil this message thread anymore, try to check this ASPM stuff yourself if you care.
> I am not the right person to test this. ;-)
> 
> LinkState is being changed and that is enough for my curiosity ATM. ;) You can add my Tested-by:
> if you do not wonder why there is no LinkState+ in my tests. If anybody wants tar.bz2 of the collected
> logs please email me. I have attached only the very last dmesg collected covering all the tests.
> 
> Thank you,
> Martin

> [  174.623769] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 108
> [  174.623781] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [  174.623784] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> [  174.623798] pciehp 0000:00:1c.7:pcie04: Data Link Layer State change
> [  174.623801] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_active: lnk_status = 7011
> [  174.623802] pciehp 0000:00:1c.7:pcie04: slot(7): Link Up event
> [  174.624040] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [  174.624075] pciehp 0000:00:1c.7:pcie04: Link Up event ignored on slot(7): already powering on
> [  174.625660] pciehp 0000:00:1c.7:pcie04: Enabling domain:bus:device=0000:11:00
> [  174.625690] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_active: lnk_status = 7011
> [  174.726003] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7011

These messages are more verbose and possibly more alarming than necessary.
We should clean this up somehow.  Some of it is probably debug stuff that
is no longer relevant.  But I guess you're booting with "pciehp_debug=1",
so maybe the normal messages aren't so verbose.

Bjorn
