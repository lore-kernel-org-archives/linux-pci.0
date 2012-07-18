Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:56755 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab2GRXeS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Jul 2012 19:34:18 -0400
In-Reply-To: <OF85CC1E00.6E804B96-ONC1257A3F.00477FD2-C1257A3F.0048111D@LocalDomain>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>	<CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
	<OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se>	<CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
	<OF9DA7C6E4.12BE1316-ONC1257A38.000618C1-C1257A38.00062838@transmode.se> <CAE9FiQVYt5sp9rQ1=L6ak4LJG1ot4WQ_nq8-t3qvmtpT_TRJLg@mail.gmail.com> <OF85CC1E00.6E804B96-ONC1257A3F.00477FD2-C1257A3F.0048111D@LocalDomain>
Subject: Re: PICe hotplug problems
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	yhlu.kernel@gmail.com
Message-ID: <OF57E68083.D4D2A234-ONC1257A3F.008141AA-C1257A3F.00817A68@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 19 Jul 2012 01:34:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Joakim Tjernlund/Transmode wrote on 2012/07/18 15:07:09:
>
> yhlu.kernel@gmail.com wrote on 2012/07/11 03:33:05:
> >
> > On Tue, Jul 10, 2012 at 6:07 PM, Joakim Tjernlund
> > <joakim.tjernlund@transmode.se> wrote:
> > > yhlu.kernel@gmail.com wrote on 2012/07/11 00:09:00:
> >
> > >> No. Can you compile lspci util as static and run it ?
> > >
> > > That wasn't so hard so here:
> > >
> > > root@P2020RDB ~ # ./lspci  -vvxxx
> > > 00:00.0 Class 0604: Device 1957:0079 (rev 21)
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 32 bytes
> > >         Region 0: Memory at <ignored> (32-bit, non-prefetchable)
> > >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > >         I/O behind bridge: 00000000-00000fff
> > >         Memory behind bridge: 80000000-9fffffff
> > >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> > >         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> > >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > >         Capabilities: [44] Power Management version 2
> > >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> > >                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> > >         Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
> > >                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> > >                         ExtTag- RBE- FLReset-
> > >                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> > >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> > >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> > >                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> > >                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <2us, L1 unlimited
> > >                         ClockPM- Surprise- LLActRep- BwNot-
> > >                 LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
> > >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > >                 LnkSta: Speed 2.5GT/s, Width x2, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> > >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
> > >                 RootCap: CRSVisible-
> > >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >
> > There is no slot cap etc, so pciehp will not be loaded.
> > the power of you child device can not be turned off/on.
> >
> > Not sure if can use link off/on make the clock effective.
> >
> > You can turn off and on the pcie link like following:
> >
> > 1. remove the child device
> >      echo 1 > /sys/..../0000:01:00.0/remove
> > 2. disable link
> >      echo 1 > /sys/..../0000:00.00.0/pcie_link_disable
> > 3. enable link
> >      echo 1 > /sys/..../0000:00.00.0/pcie_link_disable
> > 4. rescan the pci bus.
> >      echo 1 > /sys/..../0000:00:00.0/rescan_bridge
> >
> > please check link disable patch at
> > git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> > for-pci-pcie-link
> >
> > | Subject: [PATCH] PCI: Add link_disable in /sysfs for pcie device
> > |
> > | Found PCIe cards from one vendor, will not respond to scan from bridge,
> > | if we change bus number setting in bridge device.
> > |
> > | Have to do link disable/enable on the pcie root port.
> > |
> > |  So try to expose link disable bit of pcie link control register. We can use
> > |  echo 1 > /sys/..../link_disable
> > |  echo 0 > /sys/..../link_disable
> > | to bring the pcie device back to respond to scan.
>
> Sorry for the delay, got pulled into some high prio stuff.
>
> Anyhow, I have backported your patch to 3.4 as we cannot upgrade easily and
> I cannot make it work. I do
>
> # > echo 1 > /sys/devices/pci0000:00/0000:00:00.0/pcie_link_disable
> # > echo 0 > /sys/devices/pci0000:00/0000:00:00.0/pcie_link_disable
> # > echo 1 > /sys/devices/pci0000:00/0000:00:00.0/rescan

> # > lspci
> 00:00.0 Class 0604: Device 1957:0079 (rev 21)
>
> #> dmesg
> pcieport 0000:00:00.0: pcie_link_disable_set: lnk_ctrl = 18
> pcieport 0000:00:00.0: pcie_link_disable_set: lnk_ctrl = 8
>
> find /sys -name pcie_link_disable
> find /sys -name remove
> find /sys -name rescan
>
> shows
> /sys/devices/pci0000:00/0000:00:00.0/pcie_link_disable
> /sys/devices/pci0000:00/0000:00:00.0/remove
> /sys/bus/pci/rescan
> /sys/devices/pci0000:00/0000:00:00.0/rescan
> /sys/devices/pci0000:00/0000:00:00.0/pci_bus/0000:01/rescan
> /sys/devices/pci0000:00/pci_bus/0000:00/rescan
>
> so something is missing, but what?

Tried with FAKE hotplug too but no luck.

What is best pcie_hotplug or fake hotplug?
Would be nice if I could eliminate one of them.

 Jocke

