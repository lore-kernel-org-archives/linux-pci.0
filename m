Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:50177 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab2GKEIy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Jul 2012 00:08:54 -0400
In-Reply-To: <CAE9FiQVYt5sp9rQ1=L6ak4LJG1ot4WQ_nq8-t3qvmtpT_TRJLg@mail.gmail.com>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>	<CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
	<OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se>	<CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
	<OF9DA7C6E4.12BE1316-ONC1257A38.000618C1-C1257A38.00062838@transmode.se> <CAE9FiQVYt5sp9rQ1=L6ak4LJG1ot4WQ_nq8-t3qvmtpT_TRJLg@mail.gmail.com>
Subject: Re: PICe hotplug problems
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, yhlu.kernel@gmail.com
Message-ID: <OF259177D8.B20ED592-ONC1257A38.00167C85-C1257A38.0016C890@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 11 Jul 2012 06:08:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



yhlu.kernel@gmail.com wrote on 2012/07/11 03:33:05:
>
> On Tue, Jul 10, 2012 at 6:07 PM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > yhlu.kernel@gmail.com wrote on 2012/07/11 00:09:00:
>
> >> No. Can you compile lspci util as static and run it ?
> >
> > That wasn't so hard so here:
> >
> > root@P2020RDB ~ # ./lspci  -vvxxx
> > 00:00.0 Class 0604: Device 1957:0079 (rev 21)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0, Cache Line Size: 32 bytes
> >         Region 0: Memory at <ignored> (32-bit, non-prefetchable)
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >         I/O behind bridge: 00000000-00000fff
> >         Memory behind bridge: 80000000-9fffffff
> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> >         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [44] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
> >                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> >                         ExtTag- RBE- FLReset-
> >                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 unlimited
> >                         ClockPM- Surprise- LLActRep- BwNot-
> >                 LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s, Width x2, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> >                 RootCap: CRSVisible-
> >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>
> There is no slot cap etc, so pciehp will not be loaded.
> the power of you child device can not be turned off/on.
>
> Not sure if can use link off/on make the clock effective.
>
> You can turn off and on the pcie link like following:
>
> 1. remove the child device
>      echo 1 > /sys/..../0000:01:00.0/remove
> 2. disable link
>      echo 1 > /sys/..../0000:00.00.0/pcie_link_disable
> 3. enable link
>      echo 1 > /sys/..../0000:00.00.0/pcie_link_disable
> 4. rescan the pci bus.
>      echo 1 > /sys/..../0000:00:00.0/rescan_bridge
>
> please check link disable patch at
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-pcie-link

Thanks, that was really quick. However, the patches does not apply on my
3.4 kernel and it looks non trivial to me fixup.

Could you create (even quick and dirty) patches on top of 3.4?

 Jocke

