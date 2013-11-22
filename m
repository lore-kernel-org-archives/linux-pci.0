Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:62759 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3KVQ7S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2013 11:59:18 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so2533206iej.14
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2013 08:59:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <528D4739.80700@fold.natur.cuni.cz>
References: <528D4739.80700@fold.natur.cuni.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 22 Nov 2013 09:58:55 -0700
Message-ID: <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
Subject: Re: pciehp LinkState
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rajat, linux-pci]

On Wed, Nov 20, 2013 at 4:35 PM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> OK, here is one minor issue in pciehp. The LinkState remains in + after card's eject.
> ...
> Ahm, well, maybe the Abort bits could be reset if the slot is empty? Maybe the abort is written while
> the card is being unplugged, but why keep the bit set if the slot is already empty?
>
> vostro ~ # diff -u -w pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial.txt  pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__ejected_but_not_realized.txt
> --- pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial.txt 2013-11-20 19:34:24.430000727 +0100
> +++ pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__ejected_but_not_realized.txt     2013-11-20 19:35:55.670000965 +0100
> @@ -296,7 +296,7 @@
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-

I opened https://bugzilla.kernel.org/show_bug.cgi?id=65511 for this
issue.  I'm not sure exactly where we would clear MAbort -- we'd have
to do it after the driver has been detached.  But it does seem
reasonable to clear it somewhere.

> ...
> But below, still, you can see that LinkState is in "+", no matter how long you wait.
>
> vostro ~ # diff -u -w pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial.txt  pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__ejected_but_not_realized__inserted__ejected.txt
> --- pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial.txt 2013-11-20 19:34:24.430000727 +0100
> +++ pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__ejected_but_not_realized__inserted__ejected.txt  2013-11-20 19:37:43.950001248 +0100
> @@ -296,7 +296,7 @@
>         I/O behind bridge: 0000c000-0000dfff
>         Memory behind bridge: f6c00000-f7cfffff
>         Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> @@ -306,17 +306,17 @@
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> -               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
> +               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot-
> -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
> +               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> -               LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> +               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
>                         Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> -                       Changed: MRL- PresDet- LinkState-
> +                       Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> vostro ~ #
>
>
>
> Below is the overview since cold boot with no card inserted with all those hotplug events. You see,
> pciehp never sets LinkState back to minus once the slot is empty:
>
> vostro ~ # grep LinkState pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__ejected_but_not_realized__inserted__ejected.txt
>                         Changed: MRL- PresDet- LinkState-
>                         Changed: MRL- PresDet- LinkState+
>                         Changed: MRL- PresDet- LinkState+
>                         Changed: MRL- PresDet- LinkState+
>                         Changed: MRL- PresDet- LinkState+

I opened https://bugzilla.kernel.org/show_bug.cgi?id=65521 for this
issue.  I agree that pciehp should probably clear this bit.  Rajat
recently posted some patches [1] that add support for link state
changes.  I haven't look at them in detail yet, but I wouldn't be
surprised if they will fix this issue.  If you wanted to test them,
that would be awesome!

Bjorn

[1] http://lkml.kernel.org/r/528BE8B6.9080007@gmail.com
