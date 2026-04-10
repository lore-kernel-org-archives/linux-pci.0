Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422E29AAEA;
	Fri, 10 Apr 2026 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775799981; cv=none; b=Ug5s4yJWp2AxCVwK4l2AJaXBgIlrhtDSCFXZCdWKf9MGMmfMWORbd9MHV7GYoU7fv+aS3X51rO24xREU58KFDm9f/zc9r1IImCK99enGkfmEl3oV84lzJ57/KdTvavaMceej013BJ5taSX5kGG+sFUZjhBkOxF7XLazo/YHQV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775799981; c=relaxed/simple;
	bh=apSldmX1FKa3J77L/5fUZlHOrxrwVhNnrVu72UtjR4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm4HzWeyWOhHPLCRlthzEGho6fDS0klEG2OpmAp8mC73ZrdsCXxy+DzIpYqoT2IBtSV2uFOSgSBaqmbv9bhJmoZZtYAVGrhpKJ1fjc/N5Kplck/G3gmr7KNiBCtwgUxG7QnvZSO3rJxNLnRXsIn7ZbjVW4WEU1jaFuTRQxrearU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcWdrbkc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcWdrbkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775799980; x=1807335980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=apSldmX1FKa3J77L/5fUZlHOrxrwVhNnrVu72UtjR4g=;
  b=GcWdrbkclyNUr67+ujLsxcU8K6xp6YFdKzSPG/HFCYmGyqoV9Jyik5O5
   wolSkgPLj8W5/wn0jklLqs0NAFYO5CLcS9RvfGDYp6l5s0ttdQ24HfLaQ
   TJHF6KgRrSkOr66iMDWwb7TSpeg7kyPUAz98oZDbwGtUcuKZvTUQ3GDQf
   UV4ojdn55qdmcfjYDi1dubAiGWj1nZa73LRYvSo+uX26SNswoghB0lLv7
   /9kTToWx26iJHEVtgEja8wdbxYkiOpqMcbi2itGYBBNM7FPy/5LdzizIF
   XUMCnF51yxNrJl3MUyIC4749OLEMtXW0UtI6FNMql97Ag+nRtv5CEOZIh
   g==;
X-CSE-ConnectionGUID: Ydj2dXdfTJ2kcOMrIaT80w==
X-CSE-MsgGUID: 2TbYOlFLTDWwOGJIlCQz4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="79401854"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="79401854"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:46:20 -0700
X-CSE-ConnectionGUID: b7UfTOJjRl+D2GoHSZPCHg==
X-CSE-MsgGUID: wJpSNDzoSYCDIRYdOzYMEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="229273989"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 09 Apr 2026 22:46:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B958C95; Fri, 10 Apr 2026 07:46:15 +0200 (CEST)
Date: Fri, 10 Apr 2026 07:46:15 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Georg Klima <Georg.Klima@durst-group.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"thunderbolt@lists.linux.dev" <thunderbolt@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"georg_klima@gmx.at" <georg_klima@gmx.at>,
	Rene Sapiens <rene.sapiens@linux.intel.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject: Re: AW: [BUG] Thunderbolt runtime resume during PCIe removal causes
 IRQ warning and shutdown failure.
Message-ID: <20260410054615.GJ3552@black.igk.intel.com>
References: <AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>
 <adIkaExcG-T5XACV@wunner.de>
 <20260407054151.GC3552@black.igk.intel.com>
 <AM9PR10MB4231785C02F301161C5B2BA6B7592@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM9PR10MB4231785C02F301161C5B2BA6B7592@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>

Hi,

Good to know that it was solved.

Having PCIe hotplug working with Barlow Ridge host requires BIOS support
and due to the fact that BR firmware is updated via UEFI capsule the BIOS
support is not there and that's why hotplug should be disabled (as Lenovo
did with their BIOS update).

On Fri, Apr 10, 2026 at 05:20:06AM +0000, Georg Klima wrote:
> The issue disappears after a BIOS update that changes the PCIe root port SlotCap from HotPlug+ to HotPlug-.
> This strongly suggests that the bug is triggered by PCIe hotplug handling (pciehp) interacting with runtime PM and Thunderbolt.
> 
> Version: N4FET48W (1.29 )
> Firmware Revision: 1.13
> Release Date: 01/26/2026
> was / is not available over fwupdmgr, sorry
> 
> 
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 
> 80:1b.4 PCI bridge: Intel Corporation 800 Series PCH PCIe Root Port #21 (rev 10) (prog-if 00 [Normal decode])
>         Subsystem: Lenovo Device 2347
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 128
>         IOMMU group: 20
>         Bus: primary=80, secondary=88, subordinate=d8, sec-latency=0
>         I/O behind bridge: [disabled] [16-bit]
>         Memory behind bridge: b0000000-b7ffffff [size=128M] [32-bit]
>         Prefetchable memory behind bridge: 4000000000-4fffffffff [size=64G] [32-bit]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0
>                         ExtTag- RBE+ TEE-IO-
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                 LnkCap: Port #21, Speed 16GT/s, Width x4, ASPM not supported
>                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltModeDis-
>                 LnkSta: Speed 16GT/s, Width x4
>                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>                         Slot #25, PowerLimit 25W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>                         Changed: MRL- PresDet+ LinkState+
>                 RootCap: CRSVisible-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp+ 10BitTagReq- OBFF Via WAKE#, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 2
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd+
>                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>                          AtomicOpsCtl: ReqEn- EgressBlck-
>                          IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
>                 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
>                          EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee002b8  Data: 0000
>         Capabilities: [98] Subsystem: Lenovo Device 2347
>         Capabilities: [a0] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
>                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>                          FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
>                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>         Capabilities: [220 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
>                 ACSCtl: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
>         Capabilities: [a30 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [a90 v1] Data Link Feature <?>
>         Capabilities: [a9c v1] Physical Layer 16.0 GT/s
>                 Phy16Sta: EquComplete+ EquPhase1+ EquPhase2+ EquPhase3+ LinkEquRequest-
>         Capabilities: [edc v1] Lane Margining at the Receiver
>                 PortCap: Uses Driver-
>                 PortSta: MargReady+ MargSoftReady-
>         Kernel driver in use: pcieport
>         Kernel modules: shpchp
> 
> ________________________________________
> Von: Mika Westerberg <mika.westerberg@linux.intel.com>
> Gesendet: Dienstag, 7. April 2026 07:41
> An: Lukas Wunner <lukas@wunner.de>
> Cc: Georg Klima <Georg.Klima@durst-group.com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; thunderbolt@lists.linux.dev <thunderbolt@lists.linux.dev>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; georg_klima@gmx.at <georg_klima@gmx.at>; Rene Sapiens <rene.sapiens@linux.intel.com>; Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
> Betreff: Re: [BUG] Thunderbolt runtime resume during PCIe removal causes IRQ warning and shutdown failure.
> 
> [Sie erhalten nicht häufig E-Mails von mika.westerberg@linux.intel.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> On Sun, Apr 05, 2026 at 10:59:20AM +0200, Lukas Wunner wrote:
> > [cc += Mika, Rene, Alan; start of thread is here:
> > https://lore.kernel.org/all/AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM/
> > ]
> >
> > On Thu, Mar 26, 2026 at 04:09:05PM +0000, Georg Klima wrote:
> > > I am reporting a reproducible shutdown issue involving Thunderbolt,
> > > PCIe hotplug, and runtime PM on a Lenovo ThinkPad P16.
> > > System fails to power off cleanly when PCIe ASPM is enabled.
> > > After the kernel prints "Power off", it emits warnings and does not
> > > complete shutdown.
> >
> > The dmesg output shows that the problems start much earlier than
> > on shutdown:  The discrete "Barlow Ridge" Thunderbolt controller
> > is hot-removed at the 08:44:29 timestamp in a noisy fashion:
> >
> > > Mar 26 08:44:28 fedora kernel: usb 3-3: reset full-speed USB device number 2 using xhci_hcd
> > > Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: Data Link Layer Link Active not set in 100 msec
> > > Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25): Card not present
> > > Mar 26 08:44:29 fedora kernel: ------------[ cut here ]------------
> > > Mar 26 08:44:29 fedora kernel: thunderbolt 0000:8a:00.0: interrupt for TX ring 0 is already enabled
> > > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: Controller not ready at resume -19
> > > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: PCI post-resume error -19!
> > > Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: HC died; cleaning up
> > > Mar 26 08:44:29 fedora kernel: WARNING: drivers/thunderbolt/nhi.c:147 at ring_interrupt_active+0x246/0x2f0 [thunderbolt], CPU#3: kworker/u96:5/1092
> >
> > The controller is then re-discovered after the link goes back up.
> > The actual shutdown doesn't seem to start until the 08:45:26 timestamp.
> >
> > Going forward please use "dmesg" to collect kernel output, not journalctl,
> > so that we get timestamps with usec granularity.
> >
> > >   *   Hardware: Lenovo ThinkPad P16 (21RQ003BGE)
> > >   *   BIOS: N4FET30W (1.11) 10/03/2025
> > >   *   Kernel: 6.19.10-200.fc43.x86_64
> > >   *   Distribution: Fedora 43
> > >   *   Platform: Intel (Meteor Lake)
> > >   *   Thunderbolt controller: 0000:8a:00.0
> >
> > It looks like this isn't Meteor Lake but Arrow Lake-S:
> >
> > 0000:80:1b.4 - Arrow Lake-S (800 Series) PCH Root Port #21
> >   0000:88:00.0 - Barlow Ridge Upstream Port
> >     0000:89:00.0 - Barlow Ridge Downstream Port to NHI
> >       0000:8a:00.0 - Barlow Ridge NHI
> >
> 
> Looking at the dmesg there is hotplug enabled for the PCIe root port:
> 
>   Mar 26 09:44:00 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot #25 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> 
> For Barlow Ridge it should be disabled. Lenovo may already have a BIOS fix
> please check. They have done that for other models too.
