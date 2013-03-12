Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:44262 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755444Ab3CLNGg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 09:06:36 -0400
Message-ID: <513F2858.5090907@fold.natur.cuni.cz>
Date: Tue, 12 Mar 2013 14:06:32 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: USB list <linux-usb@vger.kernel.org>, linux-acpi@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: linux-3.7.10: 'nousb' causes repeated PME# enabled/disabled messages
 when 'pcie_aspm=off' and causes only partial acpiphp hotplug detection
References: <513F1829.7080101@fold.natur.cuni.cz>
In-Reply-To: <513F1829.7080101@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Martin Mokrejs wrote:
> Hi,
>   I booted same kernel under same BIOS settings with the only difference that
> in the latter case I added 'nousb'. While inspecting the diffs in dmesg outputs
> I see that something is happening with my network card and 
> 
> +r8169 0000:05:00.0: PME# disabled
> +r8169 0000:05:00.0: PME# enabled
> +r8169 0000:05:00.0: PME# disabled
> 
> but also with SandyBridge PCI Express Root Port 5
> 
> +pcieport 0000:00:1c.4: PME# enabled
> +pcieport 0000:00:1c.4: PME# disabled
> +pcieport 0000:00:1c.4: PME# enabled
> +pcieport 0000:00:1c.4: PME# disabled
> +pcieport 0000:00:1c.4: PME# enabled
> +pcieport 0000:00:1c.4: PME# disabled
> +pcieport 0000:00:1c.4: PME# enabled
> +pcieport 0000:00:1c.4: PME# disabled
> +pcieport 0000:00:1c.4: PME# enabled
> +pcieport 0000:00:1c.4: PME# disabled
> +pcieport 0000:00:1c.4: PME# enabled
> +pcieport 0000:00:1c.4: PME# disabled
> 
> The pcieport messages are repeating every second, until forever, funny. This is probably related
> to the 'pcie_aspm=off' on kernel commandline, but so far it was necessary to get acpiphp working
> on kernels above 3.5.
> 
> 
> Could that be related some udev or other userspace tool misbehaving when
> there is no USB available? Or is that a purely kernel driver issue?
> 
> 
> 
> 00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b5) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=0b, subordinate=0c, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: f7d00000-f7dfffff
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>                 LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>                         Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>                         Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
> 00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
> 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> 20: d0 f7 d0 f7 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 10 00
> 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 05
> 50: 42 00 12 f0 00 b2 24 00 00 00 40 01 00 00 00 00
> 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
> 70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
> e0: 00 3f 00 00 00 00 00 00 01 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
> 
> 
> Although per dmesg the PME# changes happened every second, I managed to catch the
> following difference by lspci only twice or three time sonly. But hope this is what
> the dmesg line is about. The funny thing is that this PME# game is ongoing whether
> the express slot is occupied by a card or not. Well, it is about the root port, so why
> not? ;-)
> Initially I cold-booted with a card inserted into the slot but some driver did not
> realize the card is ejected. But per lspci I can confirm the device 11.00.0 was
> recognized as removed from the slot. But why is the 00.1c.4 being modified I do not
> know.
> 
> Below is the PME# change bacjk and forth immediately.
> 
> --- lspci_loop.23:45:01 2013-03-11 23:45:01.000000000 +0100
> +++ lspci_loop.23:45:02 2013-03-11 23:45:02.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> +               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
> --- lspci_loop.23:45:02 2013-03-11 23:45:02.000000000 +0100
> +++ lspci_loop.23:45:03 2013-03-11 23:45:03.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> +               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
> 
> 
> and more than a minute later another example
> 
> 
> # diff -u -w lspci_loop.23:46:44 lspci_loop.23:46:45
> --- lspci_loop.23:46:44 2013-03-11 23:46:44.000000000 +0100
> +++ lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> +               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
> # diff -u -w lspci_loop.23:46:45 lspci_loop.23:46:46
> --- lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
> +++ lspci_loop.23:46:46 2013-03-11 23:46:46.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> +               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00

The above do not happen on a system cold-booted with an empty express card slot.

> 
> 
> The first pair of PME changes happened while the Firewire card was still cold-plugged in
> the slot. The latter happened when the card was inserted back into the slot
> but that has been only partially noticed by pcihp hotplug (read further below). Under
> this BIOS+'nousb' setup the *acpiphp* hotplug does not work with this particular Firewire
> OHCI card, or really badly.
> 
> 
> Lets abstract away from the above PME# stuff and see how the system behaved during
> eject of the cold-plugged card and what a partial detection happened on its later
> hotplug insert, eject, insert. I will show intereleaved in the text the slot status
> numbers as reported by lspci whenever they changed. The command is:
> 
> while true; do echo -n "$(date +%T) SlotStatus "; setpci -s1c.7 0x5a.w; sleep 1; done
> 
> 
> 23:45:21 SlotStatus 0040
> 23:45:22 SlotStatus 0040
> 23:45:23 SlotStatus 0040
> 23:45:25 SlotStatus 0040
> 23:45:26 SlotStatus 0040
> 23:45:27 SlotStatus 0040
> 23:45:28 SlotStatus 0108
> 23:45:29 SlotStatus 0100
> 23:45:30 SlotStatus 0100
> 23:45:31 SlotStatus 0100
> 23:45:32 SlotStatus 0100
> 
> --- lspci_loop.23:45:27 2013-03-11 23:45:27.000000000 +0100
> +++ lspci_loop.23:45:28 2013-03-11 23:45:28.000000000 +0100
> @@ -437,7 +437,7 @@
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> @@ -446,18 +446,18 @@
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> -               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> +               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>                 LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
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
> @@ -473,19 +473,19 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> +               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
> -10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
> +10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
> -40: 10 80 42 01 00 80 00 00 00 00 10 00 12 4c 12 08
> -50: 00 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
> +40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
> +50: 00 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
> @@ -793,56 +793,3 @@
>  e0: 00 00 40 63 00 00 00 00 00 00 00 00 00 00 00 00
>  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  
> -11:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6315 Series Firewire Controller (rev 01) (prog-if 10 [OHCI])
> -       Subsystem: VIA Technologies, Inc. VT6315 Series Firewire Controller
> -       Physical Slot: 1
> -       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> -       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -       Latency: 0, Cache Line Size: 64 bytes
> -       Interrupt: pin A routed to IRQ 19
> -       Region 0: Memory at f6c00000 (64-bit, non-prefetchable) [size=2K]
> -       Region 2: I/O ports at c000 [size=256]
> -       Capabilities: [50] Power Management version 3
> -               Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> -       Capabilities: [80] MSI: Enable- Count=1/1 Maskable+ 64bit+
> -               Address: 0000000000000000  Data: 0000
> -               Masking: 00000000  Pending: 00000000
> -       Capabilities: [98] Express (v1) Endpoint, MSI 00
> -               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> -                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> -               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> -                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> -                       MaxPayload 128 bytes, MaxReadReq 512 bytes
> -               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> -               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <64us
> -                       ClockPM+ Surprise- LLActRep- BwNot-
> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> -       Capabilities: [100 v1] Advanced Error Reporting
> -               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> -               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> -               UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> -               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> -               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> -               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> -       Capabilities: [130 v1] Device Serial Number 00-11-06-ff-ff-00-00-03
> -       Kernel driver in use: firewire_ohci
> -00: 06 11 03 34 07 00 10 00 01 10 00 0c 10 00 00 00
> -10: 04 00 c0 f6 00 00 00 00 01 c0 00 00 00 00 00 00
> -20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 03 34
> -30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
> -40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -50: 01 80 03 e4 00 00 00 00 00 00 00 00 00 00 00 00
> -60: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
> -70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -80: 05 98 80 01 00 00 00 00 00 00 00 00 00 00 00 00
> -90: 00 00 00 00 00 00 00 00 10 00 01 00 00 80 90 05
> -a0: 00 20 19 00 11 4c 07 00 00 01 11 00 00 00 00 00
> -b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> Likely a partially detected hotplug insert of the card:
> 
> 23:45:50 SlotStatus 0100
> 23:45:51 SlotStatus 0100
> 23:45:52 SlotStatus 0100
> 23:45:53 SlotStatus 0100
> 23:45:55 SlotStatus 0148
> 23:45:56 SlotStatus 0140
> 23:45:57 SlotStatus 0140
> 23:45:58 SlotStatus 0140
> 
> 
> --- lspci_loop.23:45:53 2013-03-11 23:45:55.000000000 +0100
> +++ lspci_loop.23:45:56 2013-03-11 23:45:56.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> +               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
> @@ -449,14 +449,14 @@
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>                 LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot-
> -               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> +               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>                         Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
> @@ -480,7 +480,7 @@
>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>  40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
> -50: 00 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
> +50: 03 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> --- lspci_loop.23:45:56 2013-03-11 23:45:56.000000000 +0100
> +++ lspci_loop.23:45:57 2013-03-11 23:45:57.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> +               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00

When I cold-boot the laptop with an empty express card slot and let acpiphp do the
hotplug work, I get same lspci values with one difference. The PME# values are flipping
in opposite direction (ASPM L1 Enabled -> ASPM L0s L1 Enabled on pure hotplug whereas
on the subsequent hotplugs on a cold-booted laptop with a card inserted the changes were
ASPM Disabled -> ASPM L0s L1 Enabled [the original email in this thread]):

Below is the pure acpiphp hotplug behavior for reference with 'pcie_aspm=off' and 'nousb'
for which the PME# game does NOT happen:

23:49:22 SlotStatus 0000
23:49:23 SlotStatus 0000
23:49:24 SlotStatus 0000
23:49:26 SlotStatus 0148
23:49:27 SlotStatus 0140
23:49:28 SlotStatus 0140
23:49:29 SlotStatus 0140

--- lspci_loop.23:49:24 2013-03-11 23:49:24.000000000 +0100
+++ lspci_loop.23:49:26 2013-03-11 23:49:26.000000000 +0100
@@ -449,15 +449,15 @@
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
-                       Changed: MRL- PresDet- LinkState-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+                       Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 4c 12 08
-50: 02 00 01 10 60 b2 3c 00 00 00 00 00 00 00 00 00
+50: 03 00 11 30 60 b2 3c 00 00 00 48 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -488,7 +488,7 @@
 a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
+d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
 e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
--- lspci_loop.23:49:26 2013-03-11 23:49:26.000000000 +0100
+++ lspci_loop.23:49:27 2013-03-11 23:49:27.000000000 +0100
@@ -457,7 +457,7 @@
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet+ LinkState+
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 4c 12 08
-50: 03 00 11 30 60 b2 3c 00 00 00 48 01 00 00 00 00
+50: 03 00 11 30 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -488,7 +488,7 @@
 a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
+d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
 e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00


> 
> 
> Similarly, a partially detected eject of the card:
> 
> 23:46:13 SlotStatus 0140
> 23:46:14 SlotStatus 0140
> 23:46:15 SlotStatus 0140
> 23:46:16 SlotStatus 0100
> 23:46:17 SlotStatus 0100
> 23:46:18 SlotStatus 0100
> 
> 
> --- lspci_loop.23:46:15 2013-03-11 23:46:15.000000000 +0100
> +++ lspci_loop.23:46:16 2013-03-11 23:46:16.000000000 +0100
> @@ -449,14 +449,14 @@
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>                 LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot-
> -               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
> +               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
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
> @@ -480,7 +480,7 @@
>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>  40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
> -50: 03 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
> +50: 02 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Dtto partial hotplug eject on a system cold-booted with an empty express card slot:

23:50:03 SlotStatus 0140
23:50:04 SlotStatus 0140
23:50:05 SlotStatus 0140
23:50:07 SlotStatus 0100
23:50:08 SlotStatus 0100
23:50:09 SlotStatus 0100

--- lspci_loop.23:50:05 2013-03-11 23:50:05.000000000 +0100
+++ lspci_loop.23:50:06 2013-03-11 23:50:06.000000000 +0100
@@ -446,17 +446,17 @@
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
+               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
@@ -479,8 +479,8 @@
 10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
-40: 10 80 42 01 00 80 00 00 00 00 10 00 12 4c 12 08
-50: 03 00 11 30 60 b2 3c 00 00 00 40 01 00 00 00 00
+40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
+50: 02 00 11 10 60 b2 3c 00 00 00 00 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00



> 
> 
> Again, a partially detect hotplug insert:
> 
> 23:46:25 SlotStatus 0100
> 23:46:26 SlotStatus 0100
> 23:46:27 SlotStatus 0100
> 23:46:29 SlotStatus 0148
> 23:46:31 SlotStatus 0140
> 23:46:32 SlotStatus 0140
> 23:46:33 SlotStatus 0140
> 
> 
> --- lspci_loop.23:46:27 2013-03-11 23:46:27.000000000 +0100
> +++ lspci_loop.23:46:29 2013-03-11 23:46:30.000000000 +0100
> @@ -449,15 +449,15 @@
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>                 LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot-
> -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
> +               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> -               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> -                       Changed: MRL- PresDet- LinkState+
> +               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> +                       Changed: MRL- PresDet+ LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> @@ -480,7 +480,7 @@
>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>  40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
> -50: 02 00 11 50 60 b2 3c 00 00 00 00 01 00 00 00 00
> +50: 03 00 11 70 60 b2 3c 00 00 00 48 01 00 00 00 00
>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> @@ -488,7 +488,7 @@
>  a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
> +d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
>  e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>  f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
> --- lspci_loop.23:46:29 2013-03-11 23:46:30.000000000 +0100
> +++ lspci_loop.23:46:31 2013-03-11 23:46:31.000000000 +0100
> @@ -457,7 +457,7 @@
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> -                       Changed: MRL- PresDet+ LinkState+
> +                       Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> @@ -480,7 +480,7 @@
>  20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
>  30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
>  40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
> -50: 03 00 11 70 60 b2 3c 00 00 00 48 01 00 00 00 00
> +50: 03 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
>  60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
>  70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> @@ -488,7 +488,7 @@
>  a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
> +d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
>  e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>  f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00


Dtto partial hotplug insert on a system cold-booted with an empty express card slot:

23:50:15 SlotStatus 0100
23:50:16 SlotStatus 0100
23:50:17 SlotStatus 0100
23:50:19 SlotStatus 0148
23:50:20 SlotStatus 0140
23:50:21 SlotStatus 0140
23:50:22 SlotStatus 0140

--- lspci_loop.23:50:17 2013-03-11 23:50:17.000000000 +0100
+++ lspci_loop.23:50:19 2013-03-11 23:50:19.000000000 +0100
@@ -449,15 +449,15 @@
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
-                       Changed: MRL- PresDet- LinkState+
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+                       Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
-50: 02 00 11 10 60 b2 3c 00 00 00 00 01 00 00 00 00
+50: 03 00 11 30 60 b2 3c 00 00 00 48 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -488,7 +488,7 @@
 a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
+d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
 e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00
--- lspci_loop.23:50:19 2013-03-11 23:50:19.000000000 +0100
+++ lspci_loop.23:50:20 2013-03-11 23:50:20.000000000 +0100
@@ -457,7 +457,7 @@
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet+ LinkState+
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -480,7 +480,7 @@
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 11 00 12 4c 12 08
-50: 03 00 11 30 60 b2 3c 00 00 00 48 01 00 00 00 00
+50: 03 00 11 30 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -488,7 +488,7 @@
 a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 40
+d0: 00 00 00 01 02 0b 00 00 02 80 11 c1 00 00 00 00
 e0: 00 03 00 00 00 00 00 00 01 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 87 0f 05 08 00 00 00 00


> 
> 
> Finally, the PME# game again:
> --- lspci_loop.23:46:44 2013-03-11 23:46:44.000000000 +0100
> +++ lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> +               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00
> --- lspci_loop.23:46:45 2013-03-11 23:46:45.000000000 +0100
> +++ lspci_loop.23:46:46 2013-03-11 23:46:46.000000000 +0100
> @@ -410,7 +410,7 @@
>         Capabilities: [90] Subsystem: Dell Device 04b3
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> +               Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>         Kernel driver in use: pcieport
>  00: 86 80 18 1c 07 00 10 00 b5 00 04 06 10 00 81 00
>  10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
> @@ -422,7 +422,7 @@
>  70: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 0d a0 00 00 28 10 b3 04 00 00 00 00 00 00 00 00
> -a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
> +a0: 01 00 02 c8 03 01 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 01 02 0b 00 00 00 80 11 81 00 00 00 00

The above do not happen on a system cold-booted with an empty express card slot.

> 
> 
> 
> Further details can be found by comparing these two directories:
> 
> Firewire_coldplug_disabled_Media_card_reader/
> Firewire_coldplug_disabled_Media_card_reader_nousb/
> 
> Fetch them from http://195.113.57.32/~mmokrejs/tmp/3.7.10_acpiphp_pcie_aspm_off_full.tar.bz2
> (1.2MB but covers in additional sub-directories also other cards tested)

The purely acpiphp hotplug data are in Firewire_hotplug_disabled_Media_card_reader_nousb/
subdirectory. Diffing dmesg under Firewire_coldplug_disabled_Media_card_reader_nousb/
and under Firewire_hotplug_disabled_Media_card_reader_nousb/ is left as an exercise for the
reader willing to resolve the 

- ASPM L1 Enabled -> ASPM L0s L1 Enabled
+ ASPM Disabled -> ASPM L0s L1 Enabled

underlying issue.

Martin

