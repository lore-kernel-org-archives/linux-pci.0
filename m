Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428236;
	b=SrKI92AFZEZHCz+X3MnJ7P8zLEr4ugCu734+2m24OWirMqeYSpZ9XD53Pps2amqggCkr
	 ZqQ4DfGa8dG6YM6HeTZGfGdFm2gjWg1MbKmHF7rWHue1u7cY1aJ/rE92LcFMIS6/xFtjE
	 /9YBdHX/oo7qalkGCPNlrm644f9PH1szqcdV4DaKV60PstBnU7wD+nB/VlF/tbpqS1LaI
	 6Zj8R41Dsg5ksBJLNgS/PLhu+PJmP4E87Bm9WppQnPz+SM/4cKmy5gR+IlrjQrrtGbrT7
	 ULwa4quczk9IcHQcE8jYyOuF/8mKH8cvUJQCfqODIPU/RAIXrEde37GUXIZeTjUN7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=T0PFSG3TvuAGjTpKF05+ShakI2FDVhG6OuOtH2JD9D8=;
	b=e2INpaf2p4yAq5LuN2qCXqKqUCYcZgtmnm5zCpC0IN+tjVTqRygWxEr5emLDSv/rGA0e
	 TAWG4bioVm2aotTuC7EuzuGPoxIE7lyCVA6Umz/Gpxsz4ZG5prKKVKhxTKLzWN86OSg+s
	 KA5GJOS/lWGNTsUKXScixNDl4RBtaztpsm3ZG44zSgVQV1yIsfGPhk3EfrYsKz20/0CHS
	 pjJRedswA5nGzICBOlO0FiS0t/NdoSDvoWJhOxyrEE7VDOMeq47LljlBBpM+krNQ+u/I+
	 F8trmhU6jqdhghuBeAMqQFIpT6FyWaxdLtNgeAQkj5Ho6BLuRXWd1f0r2rBOSX7+edQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSSxlqrQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549D606A324;
	Wed, 11 Nov 2026 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSSxlqrQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28BE1F00A06;
	Wed, 11 Nov 2026 20:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428236;
	bh=T0PFSG3TvuAGjTpKF05+ShakI2FDVhG6OuOtH2JD9D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lSSxlqrQb+hpSNT2m8Vr8j4OQ9rR80z8f8M8XIm55kFhujhxZ4xcq9U6lIkl3O6ur
	 7phivjmsOfBvyUMegijdjujZCxNH0I5qvsSA8yZr9CNY9+9ulf5AjzMfxqs80p4y4X
	 c9iXoVd1p84gmjvP0nEHZOmyP8FLRfSNSbww4FRIHX4+vE/GkuGjZaG6Dv2poh9x5+
	 W6NkCpQaqmfYyp249vu2LbhH+YzEmcPrG/NCEi5jxw75JaU4e6FCrfKFQiE8cwQ0ed
	 xPR8MpvW0VcpW75f/Xbn9HqZL/OsW6Wvee62hpaxat614mBZdbGmqVlxlXSmE/p1Pa
	 JY0OGoJdqTz1A==
Date: Wed, 11 Nov 2026 14:17:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: hh c <hhc436476@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@lists.ubuntu.com,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: 6.8.0-149: forced 2.5GT/s->5GT/s root-port retrain drops XGI Z11
 VGA off the bus, local console goes black
Message-ID: <20261111201714.GA726989@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALJR0nehJ5+d7MrPk8rxkNmee_1L5FFsvuF+-swK1nyJ7oJJ8A@mail.gmail.com>

[+cc Maciej (author of 72780f796468, just FYI), -cc stable (no request
of stable maintainers here)]

On Thu, Nov 12, 2026 at 12:09:07AM +0800, hh c wrote:
> After upgrading from 6.8.0-31 to 6.8.0-149 on a Huawei XH320 V2 (Romley
> platform, C600/X79 PCH), the local console goes black at kernel handover.
> The machine boots, SSH works, getty@tty1 is active. Booting the SAME
> installation into 6.8.0-31 restores both the console and the VGA device,
> so this is a regression in the 6.8 SRU stream, not a hardware or BMC fault.
> 
> ROOT CAUSE
> 
> 6.8.0-149 carries the stable backport of upstream commit 72780f796468
> ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining").
> pcie_failed_link_retrain() no longer checks whether the link was ever
> established; it treats "Target Link Speed == 2.5GT/s while LnkCap > 2.5GT/s"
> as "firmware clamped the speed" and force-retrains to the higher speed.

These results appear to be on Ubuntu kernels, which upstream has no
influence over.  If you can reproduce the issue with recent unmodified
upstream kernels, e.g., v7.3, please report as a regression.

> On this machine the onboard VGA is a Gen1-only part behind an Intel PCH root
> port, so the firmware-clamped state is the CORRECT steady state and the
> retrain is not harmless:
> 
>   00:1c.3  PCI bridge [8086:1d16]  C600/X79 Root Port 4
>            LnkCap:  Port #4, Speed 5GT/s, Width x1
>            LnkSta:  Speed 2.5GT/s, Width x1
>            LnkCtl2: Target Link Speed: 2.5GT/s   <- matches the endpoint limit
> 
>   07:00.0  VGA [18ca:0027] XGI Z11/Z11M  (subsystem 19e5:2015 Huawei)
>            LnkCap:  Port #0, Speed 2.5GT/s, Width x1  <- Gen1 only
> 
> The PCH cannot train Gen2 against a Gen1 endpoint. After the forced retrain
> the endpoint stops answering configuration requests and is never enumerated.
> Note that 00:1c.3 does NOT print "retraining failed" (unlike the two empty
> ports, which do): the quirk believes the link came up while the endpoint is
> already gone.
> 
> The console is black - not merely blank - because the framebuffer handed over
> by firmware is the card's own VRAM window, so every console write travels
> over the dead link. simpledrm still probes and reports a normal 640x480 fb0:
> 
>   /proc/iomem
>   90000000-fbffefff : PCI Bus 0000:00
>     90000000-93ffffff : PCI Bus 0000:07
>       90000000-93ffffff : 0000:07:00.0     <- framebuffer inside VGA BAR0
>         90000000-9012bfff : BOOTFB
>           90000000-9012bfff : simpledrm
> 
> EVIDENCE
> 
> Working kernel 6.8.0-31 (same hardware, same installation):
> 
>   # lspci -t -nn | grep -E '1c\.|07:00'
>    |           +-1c.0-[05]--
>    |           +-1c.2-[06]--
>    |           +-1c.3-[07]----00.0
> 
>   # lspci -vv -s 00:1c.3 | grep -E 'LnkCap:|LnkSta:|LnkCtl2:'
>   LnkCap: Port #4, Speed 5GT/s, Width x1
>   LnkSta: Speed 2.5GT/s, Width x1
>   LnkCtl2: Target Link Speed: 2.5GT/s
> 
>   # dmesg | grep -cE '2.5GT/s|retrain'
>   0
> 
>   # lspci -nn | grep -i vga
>   07:00.0 VGA compatible controller [0300]: XGI ... Z11/Z11M [18ca:0027]
> 
>   # lspci -nn | wc -l
>   79
> 
> Broken kernel 6.8.0-149 (upstream base 6.8.12, package 6.8.0-149.149;
> identical hardware; pcie_ports=compat was also tested, see below):
> 
>   # lspci -nn | grep -i vga
>   (nothing)
>   # lspci -nn | wc -l
>   78
> 
>   # journalctl -b -1 -k | grep -E '1c\.[023]|2.5GT/s|retrain'
>   pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
>   pci 0000:00:1c.0: retraining failed        <- empty port, harmless
>   pci 0000:00:1c.2: removing 2.5GT/s downstream link speed restriction
>   pci 0000:00:1c.2: retraining failed        <- empty port, harmless
>   pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
>                                              <- no "retraining failed":
>                                                 quirk thinks the link came
>                                                 up, endpoint is already gone
> 
>   # journalctl -b -1 -k | grep -c '07:00.0'   (during boot)
>   0
> 
> After the forced retrain the port reports a stale "up" link with the target
> left raised:
> 
>   # lspci -vv -s 00:1c.3 | grep -E 'LnkSta:|LnkCtl2:'
>   LnkSta: Speed 2.5GT/s, Width x1            <- stale
>   LnkCtl2: Target Link Speed: 5GT/s          <- quirk left the target raised
> 
> RUNTIME RECOVERY EXPERIMENT (the endpoint itself is fine)
> 
> Restoring the firmware's target speed and retraining brings the device back
> within a second; all enumeration messages appear only at this point, about
> 60 s after boot:
> 
>   # setpci -s 00:1c.3 CAP_EXP+30.w=0x0001    # Target Link Speed := 2.5GT/s
>   # setpci -s 00:1c.3 CAP_EXP+10.w=0x0020    # Retrain Link
>   # echo 1 > /sys/bus/pci/devices/0000:00:1c.3/rescan
>   # lspci -nn | grep -i vga
>   07:00.0 VGA compatible controller [0300]: XGI ... Z11/Z11M [18ca:0027]
>   # lspci -vv -s 00:1c.3 | grep -E 'LnkSta:|LnkCtl2:'
>   LnkSta: Speed 2.5GT/s, Width x1
>   LnkCtl2: Target Link Speed: 2.5GT/s
> 
> BAR0 then reports "can't assign; no space" because simpledrm already owns
> 90000000-9012bfff; programming BAR0 back to 0x90000008 by hand is needed too.
> 
> However the display output does NOT recover. The monitor reports NO SIGNAL
> and writing 1.2 MB of data to /dev/fb0 (640x480x4) has no visible effect.
> So the damage is more than "device removed from the bus": the failed Gen2
> training leaves the XGI display controller dead until the next platform
> reset, and no in-tree driver can re-initialise it (VBE is only callable from
> firmware during POST). Local console is recoverable only by rebooting into a
> kernel that does not perform the retrain.
> 
> ALREADY RULED OUT
> 
> - nomodeset: no effect. CONFIG_DRM_SIMPLEDRM=y, simpledrm still probes and
>   still writes the handed-over framebuffer. Both kernels report
>   fb0 = simpledrmdrmfb, 80x30, 640x480.
> - GRUB_GFXPAYLOAD_LINUX=keep: no effect (the PCIe link dies, not the mode).
> - pcie_ports=compat: does NOT prevent the quirk. Verified with
>   lspci | grep -c pcieport = 0 (port services disabled) while all four ports
>   still print "removing 2.5GT/s downstream link speed restriction". So
>   pcie_failed_link_retrain() is not on the portdrv path and this cannot be
>   worked around from the command line.
> - BIOS: this platform hides PCH/root-port configuration entirely; there is no
>   per-port target-link-speed knob to pre-raise.
> 
> ADDITIONAL (MINOR) IMPACT
> 
> The same quirk fires on two empty ports (00:1c.0, 00:1c.2) and burns about
> 1 s each waiting for a retrain that cannot succeed, delaying simpledrm init
> from 1.3 s to 6.3 s on this machine. Upstream commit "PCI: Skip Target Speed
> quirk on clamped ports with no link" addresses exactly that case but does not
> cover this report: here the link IS up when the quirk runs, and the retrain
> to 5 GT/s is what destroys it.
> 
> REQUESTED ACTION
> 
> 1. Backport a fix that either (a) honours the firmware clamp when the
>    downstream device only advertises 2.5 GT/s, or (b) restores the link
>    (target speed + retrain + rescan) when the forced retrain to a higher
>    speed fails on a port that has an endpoint behind it.
> 2. Until then, note in the 6.8.0-149 release notes that machines with legacy
>    Gen1-only VGA (XGI Z11/Z9, Matrox G200, SiS - common where the BMC shares
>    the VGA path) may boot with no local console and lose the VGA device from
>    the PCI bus under 6.8.0-149.
> 
> --
> Reported-by: chh <hhc436476@gmail.com>
> Affected: Ubuntu 24.04.3, linux-image-6.8.0-149-generic (6.8.0-149.149)
> Hardware: Huawei FusionServer XH320 V2, BIOS RMIBV510 (2015-07-10)
> Attached: dmesg-6.8.0-149.txt, system-6.8.0-31.txt

> == kernel / cmdline
> Linux ubuntu 6.8.0-31-generic #31-Ubuntu SMP PREEMPT_DYNAMIC Sat Apr 20 00:40:06 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
> BOOT_IMAGE=/vmlinuz-6.8.0-31-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro
> == DMI
> sys_vendor: Huawei Technologies Co., Ltd.
> product_name: XH320 V2
> product_version: V100R002
> board_name: BC21RCSA0
> bios_version: RMIBV510
> bios_date: 07/10/2015
> == kernel packages
> linux-image-6.8.0-149-generic 6.8.0-149.149
> linux-image-6.8.0-31-generic 6.8.0-31.31
> == lspci -t (VGA 分支)
>  |           +-1c.0-[05]--
>  |           +-1c.2-[06]--
>  |           +-1c.3-[07]----00.0
> == endpoint 07:00.0 full
> 07:00.0 VGA compatible controller [0300]: XGI Technology Inc. (eXtreme Graphics Innovation) Z11/Z11M [18ca:0027] (prog-if 00 [VGA controller])
> 	Subsystem: Huawei Technologies Co., Ltd. Z11/Z11M [19e5:2015]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	IOMMU group: 28
> 	BIST result: 00
> 	Region 0: Memory at 90000000 (32-bit, prefetchable) [size=64M]
> 	Region 1: Memory at 94500000 (32-bit, non-prefetchable) [size=256K]
> 	Region 2: I/O ports at 2000 [size=128]
> 	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [a0] Express (v1) Endpoint, MSI 01
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <128ns, L1 <1us
> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W
> 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 128 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
> 			ClockPM- Surprise+ LLActRep+ BwNot- ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1
> 			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> 	Capabilities: [c0] MSI: Enable- Count=1/1 Maskable- 64bit-
> 		Address: 00000000  Data: 0000
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 		AERCap:	First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
> 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> 		HeaderLog: 04000001 0000000f 07010000 00000000
> 
> == root port 00:1c.3 full
> 00:1c.3 PCI bridge [0604]: Intel Corporation C600/X79 series chipset PCI Express Root Port 4 [8086:1d16] (rev b6) (prog-if 00 [Normal decode])
> 	Subsystem: Huawei Technologies Co., Ltd. C600/X79 series chipset PCI Express Root Port 4 [19e5:2015]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin D routed to IRQ 32
> 	IOMMU group: 20
> 	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
> 	I/O behind bridge: 2000-2fff [size=4K] [16-bit]
> 	Memory behind bridge: 94500000-945fffff [size=1M] [32-bit]
> 	Prefetchable memory behind bridge: 90000000-93ffffff [size=64M] [32-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
> 			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1
> 			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #3, PowerLimit 10W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet- LinkState+
> 		RootCap: CRSVisible-
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
> 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		DevCap2: Completion Timeout: Range BC, TimeoutDis+ NROPrPrP- LTR-
> 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> 			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
> 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-
> 			 AtomicOpsCtl: ReqEn- EgressBlck-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: fee00378  Data: 0000
> 	Capabilities: [90] Subsystem: Huawei Technologies Co., Ltd. C600/X79 series chipset PCI Express Root Port 4 [19e5:2015]
> 	Capabilities: [a0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Kernel driver in use: pcieport
> 
> == iomem BOOTFB
> 90000000-fbffefff : PCI Bus 0000:00
>   90000000-93ffffff : PCI Bus 0000:07
>     90000000-93ffffff : 0000:07:00.0
>       90000000-9012bfff : BOOTFB
>         90000000-9012bfff : simpledrm
> == fb0
> simpledrmdrmfb
> 640,480
> 2560
> 32

> Nov 11 17:46:25 ubuntu kernel: Linux version 6.8.0-149-generic (buildd@lcy02-amd64-099) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #149-Ubuntu SMP PREEMPT_DYNAMIC Fri Oct 23 13:21:10 UTC 2026 (Ubuntu 6.8.0-149.149-generic 6.8.12)
> Nov 11 17:46:25 ubuntu kernel: Command line: BOOT_IMAGE=/vmlinuz-6.8.0-149-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro pcie_ports=compat
> Nov 11 17:46:25 ubuntu kernel: KERNEL supported cpus:
> Nov 11 17:46:25 ubuntu kernel:   Intel GenuineIntel
> Nov 11 17:46:25 ubuntu kernel:   AMD AuthenticAMD
> Nov 11 17:46:25 ubuntu kernel:   Hygon HygonGenuine
> Nov 11 17:46:25 ubuntu kernel:   Centaur CentaurHauls
> Nov 11 17:46:25 ubuntu kernel:   zhaoxin   Shanghai  
> Nov 11 17:46:25 ubuntu kernel: BIOS-provided physical RAM map:
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009cfff] usable
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff] usable
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x0000000040000000-0x00000000400fffff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x0000000040100000-0x000000007e4fefff] usable
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x000000007e4ff000-0x000000007e8fefff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x000000007e8ff000-0x000000007eefefff] ACPI NVS
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x000000007eeff000-0x000000007effefff] ACPI data
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x000000007efff000-0x000000007effffff] usable
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x000000007f000000-0x000000008fffffff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x00000000feb00000-0x00000000feb03fff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x00000000fed18000-0x00000000fed18fff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed8ffff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
> Nov 11 17:46:25 ubuntu kernel: BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff] usable
> Nov 11 17:46:25 ubuntu kernel: NX (Execute Disable) protection: active
> Nov 11 17:46:25 ubuntu kernel: APIC: Static calls initialized
> Nov 11 17:46:25 ubuntu kernel: SMBIOS 2.7 present.
> Nov 11 17:46:25 ubuntu kernel: DMI: Huawei Technologies Co., Ltd. XH320 V2/BC21RCSA0, BIOS RMIBV510 07/10/2015
> Nov 11 17:46:25 ubuntu kernel: tsc: Fast TSC calibration using PIT
> Nov 11 17:46:25 ubuntu kernel: tsc: Detected 1800.129 MHz processor
> Nov 11 17:46:25 ubuntu kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> Nov 11 17:46:25 ubuntu kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
> Nov 11 17:46:25 ubuntu kernel: last_pfn = 0x480000 max_arch_pfn = 0x400000000
> Nov 11 17:46:25 ubuntu kernel: MTRR map: 9 entries (4 fixed + 5 variable; max 24), built from 10 variable MTRRs
> Nov 11 17:46:25 ubuntu kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> Nov 11 17:46:25 ubuntu kernel: last_pfn = 0x7f000 max_arch_pfn = 0x400000000
> Nov 11 17:46:25 ubuntu kernel: found SMP MP-table at [mem 0x000fe1b0-0x000fe1bf]
> Nov 11 17:46:25 ubuntu kernel: Using GB pages for direct mapping
> Nov 11 17:46:25 ubuntu kernel: RAMDISK: [mem 0x2ecb7000-0x33652fff]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Early table checksum verification disabled
> Nov 11 17:46:25 ubuntu kernel: ACPI: RSDP 0x00000000000FE020 000024 (v02 INSYDE)
> Nov 11 17:46:25 ubuntu kernel: ACPI: XSDT 0x000000007EFFE170 0000AC (v01 INSYDE Romley   00000001      01000013)
> Nov 11 17:46:25 ubuntu kernel: ACPI: FACP 0x000000007EFFB000 0000F4 (v04 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: DSDT 0x000000007EFE9000 00DEE2 (v01 INSYDE Romley   00000000 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: FACS 0x000000007ED8A000 000040
> Nov 11 17:46:25 ubuntu kernel: ACPI: FACS 0x000000007ED8A000 000040
> Nov 11 17:46:25 ubuntu kernel: ACPI: SPMI 0x000000007EFFD000 000040 (v05 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: BOOT 0x000000007EFFC000 000028 (v01 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: APIC 0x000000007EFF9000 000BAA (v03 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: MCFG 0x000000007EFF8000 00003C (v01 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: SLIC 0x000000007EFF7000 000176 (v01 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: BDAT 0x000000007EFE8000 000030 (v01 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: PRAD 0x000000007EFE7000 0000BC (v02 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: MSDM 0x000000007EFE6000 000055 (v03 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: SSDT 0x000000007EF12000 0D3050 (v02 INSYDE Romley   00004000 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: HPET 0x000000007EFFA000 000038 (v01 INSYDE Romley   00000001 ACPI 00040000)
> Nov 11 17:46:25 ubuntu kernel: ACPI: WDAT 0x000000007EF11000 000194 (v01 INSYDE INSYDE   00000001 MSFT 01000013)
> Nov 11 17:46:25 ubuntu kernel: ACPI: DMAR 0x000000007EF10000 0000A0 (v01 INSYDE Romley   00000001 ACPI 00000001)
> Nov 11 17:46:25 ubuntu kernel: ACPI: HEST 0x000000007EF0F000 0000A8 (v01 INSYDE Romley   00000001 ?    00000001)
> Nov 11 17:46:25 ubuntu kernel: ACPI: ERST 0x000000007EF0E000 000230 (v01 INSYDE Romley   00000001 ?    00000001)
> Nov 11 17:46:25 ubuntu kernel: ACPI: BERT 0x000000007EF0D000 000030 (v01 INSYDE Romley   00000001 ?    00000001)
> Nov 11 17:46:25 ubuntu kernel: ACPI: EINJ 0x000000007EF0C000 000130 (v01 INSYDE Romley   00000001 ?    00000001)
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving FACP table memory at [mem 0x7effb000-0x7effb0f3]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving DSDT table memory at [mem 0x7efe9000-0x7eff6ee1]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving FACS table memory at [mem 0x7ed8a000-0x7ed8a03f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving FACS table memory at [mem 0x7ed8a000-0x7ed8a03f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving SPMI table memory at [mem 0x7effd000-0x7effd03f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving BOOT table memory at [mem 0x7effc000-0x7effc027]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving APIC table memory at [mem 0x7eff9000-0x7eff9ba9]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving MCFG table memory at [mem 0x7eff8000-0x7eff803b]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving SLIC table memory at [mem 0x7eff7000-0x7eff7175]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving BDAT table memory at [mem 0x7efe8000-0x7efe802f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving PRAD table memory at [mem 0x7efe7000-0x7efe70bb]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving MSDM table memory at [mem 0x7efe6000-0x7efe6054]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving SSDT table memory at [mem 0x7ef12000-0x7efe504f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving HPET table memory at [mem 0x7effa000-0x7effa037]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving WDAT table memory at [mem 0x7ef11000-0x7ef11193]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving DMAR table memory at [mem 0x7ef10000-0x7ef1009f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving HEST table memory at [mem 0x7ef0f000-0x7ef0f0a7]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving ERST table memory at [mem 0x7ef0e000-0x7ef0e22f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving BERT table memory at [mem 0x7ef0d000-0x7ef0d02f]
> Nov 11 17:46:25 ubuntu kernel: ACPI: Reserving EINJ table memory at [mem 0x7ef0c000-0x7ef0c12f]
> Nov 11 17:46:25 ubuntu kernel: No NUMA configuration found
> Nov 11 17:46:25 ubuntu kernel: Faking a node at [mem 0x0000000000000000-0x000000047fffffff]
> Nov 11 17:46:25 ubuntu kernel: NODE_DATA(0) allocated [mem 0x47ffd5000-0x47fffffff]
> Nov 11 17:46:25 ubuntu kernel: Zone ranges:
> Nov 11 17:46:25 ubuntu kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> Nov 11 17:46:25 ubuntu kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> Nov 11 17:46:25 ubuntu kernel:   Normal   [mem 0x0000000100000000-0x000000047fffffff]
> Nov 11 17:46:25 ubuntu kernel:   Device   empty
> Nov 11 17:46:25 ubuntu kernel: Movable zone start for each node
> Nov 11 17:46:25 ubuntu kernel: Early memory node ranges
> Nov 11 17:46:25 ubuntu kernel:   node   0: [mem 0x0000000000001000-0x000000000009cfff]
> Nov 11 17:46:25 ubuntu kernel:   node   0: [mem 0x0000000000100000-0x000000003fffffff]
> Nov 11 17:46:25 ubuntu kernel:   node   0: [mem 0x0000000040100000-0x000000007e4fefff]
> Nov 11 17:46:25 ubuntu kernel:   node   0: [mem 0x000000007efff000-0x000000007effffff]
> Nov 11 17:46:25 ubuntu kernel:   node   0: [mem 0x0000000100000000-0x000000047fffffff]
> Nov 11 17:46:25 ubuntu kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000047fffffff]
> Nov 11 17:46:25 ubuntu kernel: On node 0, zone DMA: 1 pages in unavailable ranges
> Nov 11 17:46:25 ubuntu kernel: On node 0, zone DMA: 99 pages in unavailable ranges
> Nov 11 17:46:25 ubuntu kernel: On node 0, zone DMA32: 256 pages in unavailable ranges
> Nov 11 17:46:25 ubuntu kernel: On node 0, zone DMA32: 2816 pages in unavailable ranges
> Nov 11 17:46:25 ubuntu kernel: On node 0, zone Normal: 4096 pages in unavailable ranges
> Nov 11 17:46:25 ubuntu kernel: ACPI: PM-Timer IO Port: 0x408
> Nov 11 17:46:25 ubuntu kernel: ACPI: X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> Nov 11 17:46:25 ubuntu kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> Nov 11 17:46:25 ubuntu kernel: IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> Nov 11 17:46:25 ubuntu kernel: IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
> Nov 11 17:46:25 ubuntu kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Nov 11 17:46:25 ubuntu kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Nov 11 17:46:25 ubuntu kernel: ACPI: Using ACPI (MADT) for SMP configuration information
> Nov 11 17:46:25 ubuntu kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
> Nov 11 17:46:25 ubuntu kernel: TSC deadline timer available
> Nov 11 17:46:25 ubuntu kernel: smpboot: Allowing 16 CPUs, 0 hotplug CPUs
> Nov 11 17:46:25 ubuntu kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> Nov 11 17:46:25 ubuntu kernel: PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x000fffff]
> Nov 11 17:46:25 ubuntu kernel: PM: hibernation: Registered nosave memory: [mem 0x40000000-0x400fffff]
> Nov 11 17:46:25 ubuntu kernel: PM: hibernation: Registered nosave memory: [mem 0x7e4ff000-0x7effefff]
> Nov 11 17:46:25 ubuntu kernel: PM: hibernation: Registered nosave memory: [mem 0x7f000000-0xffffffff]
> Nov 11 17:46:25 ubuntu kernel: [mem 0x90000000-0xfeafffff] available for PCI devices
> Nov 11 17:46:25 ubuntu kernel: Booting paravirtualized kernel on bare hardware
> Nov 11 17:46:25 ubuntu kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> Nov 11 17:46:25 ubuntu kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
> Nov 11 17:46:25 ubuntu kernel: percpu: Embedded 86 pages/cpu s229376 r8192 d114688 u524288
> Nov 11 17:46:25 ubuntu kernel: pcpu-alloc: s229376 r8192 d114688 u524288 alloc=1*2097152
> Nov 11 17:46:25 ubuntu kernel: pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
> Nov 11 17:46:25 ubuntu kernel: pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
> Nov 11 17:46:25 ubuntu kernel: Kernel command line: BOOT_IMAGE=/vmlinuz-6.8.0-149-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro pcie_ports=compat
> Nov 11 17:46:25 ubuntu kernel: Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> Nov 11 17:46:25 ubuntu kernel: Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> Nov 11 17:46:25 ubuntu kernel: Fallback order for Node 0: 0 
> Nov 11 17:46:25 ubuntu kernel: Built 1 zonelists, mobility grouping on.  Total pages: 4121456
> Nov 11 17:46:25 ubuntu kernel: Policy zone: Normal
> Nov 11 17:46:25 ubuntu kernel: mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> Nov 11 17:46:25 ubuntu kernel: software IO TLB: area num 16.
> Nov 11 17:46:25 ubuntu kernel: Memory: 16259676K/16748144K available (22528K kernel code, 4444K rwdata, 14456K rodata, 4948K init, 4756K bss, 488208K reserved, 0K cma-reserved)
> Nov 11 17:46:25 ubuntu kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
> Nov 11 17:46:25 ubuntu kernel: Kernel/User page tables isolation: enabled
> Nov 11 17:46:25 ubuntu kernel: ftrace: allocating 57855 entries in 228 pages
> Nov 11 17:46:25 ubuntu kernel: ftrace: allocated 228 pages with 4 groups
> Nov 11 17:46:25 ubuntu kernel: Dynamic Preempt: voluntary
> Nov 11 17:46:25 ubuntu kernel: rcu: Preemptible hierarchical RCU implementation.
> Nov 11 17:46:25 ubuntu kernel: rcu:         RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
> Nov 11 17:46:25 ubuntu kernel:         Trampoline variant of Tasks RCU enabled.
> Nov 11 17:46:25 ubuntu kernel:         Rude variant of Tasks RCU enabled.
> Nov 11 17:46:25 ubuntu kernel:         Tracing variant of Tasks RCU enabled.
> Nov 11 17:46:25 ubuntu kernel: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> Nov 11 17:46:25 ubuntu kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> Nov 11 17:46:25 ubuntu kernel: RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> Nov 11 17:46:25 ubuntu kernel: RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> Nov 11 17:46:25 ubuntu kernel: RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> Nov 11 17:46:25 ubuntu kernel: NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
> Nov 11 17:46:25 ubuntu kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
> Nov 11 17:46:25 ubuntu kernel: Console: colour dummy device 80x25
> Nov 11 17:46:25 ubuntu kernel: printk: legacy console [tty0] enabled
> Nov 11 17:46:25 ubuntu kernel: ACPI: Core revision 20230628
> Nov 11 17:46:25 ubuntu kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> Nov 11 17:46:25 ubuntu kernel: APIC: Switch to symmetric I/O mode setup
> Nov 11 17:46:25 ubuntu kernel: DMAR: Host address width 46
> Nov 11 17:46:25 ubuntu kernel: DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
> Nov 11 17:46:25 ubuntu kernel: DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0462 ecap f020fe
> Nov 11 17:46:25 ubuntu kernel: DMAR: ATSR flags: 0x0
> Nov 11 17:46:25 ubuntu kernel: DMAR: RMRR base: 0x0000007e8b5000 end: 0x0000007e8bbfff
> Nov 11 17:46:25 ubuntu kernel: DMAR-IR: IOAPIC id 8 under DRHD base  0xfbffc000 IOMMU 0
> Nov 11 17:46:25 ubuntu kernel: DMAR-IR: IOAPIC id 9 under DRHD base  0xfbffc000 IOMMU 0
> Nov 11 17:46:25 ubuntu kernel: DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
> Nov 11 17:46:25 ubuntu kernel: DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> Nov 11 17:46:25 ubuntu kernel: DMAR-IR: Enabled IRQ remapping in x2apic mode
> Nov 11 17:46:25 ubuntu kernel: x2apic enabled
> Nov 11 17:46:25 ubuntu kernel: APIC: Switched APIC routing to: cluster x2apic
> Nov 11 17:46:25 ubuntu kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> Nov 11 17:46:25 ubuntu kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x19f2a3735f3, max_idle_ns: 440795286385 ns
> Nov 11 17:46:25 ubuntu kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 3600.25 BogoMIPS (lpj=1800129)
> Nov 11 17:46:25 ubuntu kernel: CPU0: Thermal monitoring enabled (TM1)
> Nov 11 17:46:25 ubuntu kernel: process: using mwait in idle threads
> Nov 11 17:46:25 ubuntu kernel: Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> Nov 11 17:46:25 ubuntu kernel: Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> Nov 11 17:46:25 ubuntu kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> Nov 11 17:46:25 ubuntu kernel: Spectre V2 : Mitigation: Retpolines
> Nov 11 17:46:25 ubuntu kernel: Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
> Nov 11 17:46:25 ubuntu kernel: Spectre V2 : Enabling Restricted Speculation for firmware calls
> Nov 11 17:46:25 ubuntu kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> Nov 11 17:46:25 ubuntu kernel: Spectre V2 : User space: Mitigation: STIBP via prctl
> Nov 11 17:46:25 ubuntu kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> Nov 11 17:46:25 ubuntu kernel: MDS: Mitigation: Clear CPU buffers
> Nov 11 17:46:25 ubuntu kernel: MMIO Stale Data: Unknown: No mitigations
> Nov 11 17:46:25 ubuntu kernel: VMSCAPE: Mitigation: IBPB before exit to userspace
> Nov 11 17:46:25 ubuntu kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> Nov 11 17:46:25 ubuntu kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> Nov 11 17:46:25 ubuntu kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> Nov 11 17:46:25 ubuntu kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> Nov 11 17:46:25 ubuntu kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> Nov 11 17:46:25 ubuntu kernel: Freeing SMP alternatives memory: 48K
> Nov 11 17:46:25 ubuntu kernel: pid_max: default: 32768 minimum: 301
> Nov 11 17:46:25 ubuntu kernel: LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,integrity
> Nov 11 17:46:25 ubuntu kernel: landlock: Up and running.
> Nov 11 17:46:25 ubuntu kernel: Yama: becoming mindful.
> Nov 11 17:46:25 ubuntu kernel: AppArmor: AppArmor initialized
> Nov 11 17:46:25 ubuntu kernel: Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> Nov 11 17:46:25 ubuntu kernel: Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> Nov 11 17:46:25 ubuntu kernel: smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2450L 0 @ 1.80GHz (family: 0x6, model: 0x2d, stepping: 0x7)
> Nov 11 17:46:25 ubuntu kernel: Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
> Nov 11 17:46:25 ubuntu kernel: ... version:                3
> Nov 11 17:46:25 ubuntu kernel: ... bit width:              48
> Nov 11 17:46:25 ubuntu kernel: ... generic registers:      4
> Nov 11 17:46:25 ubuntu kernel: ... value mask:             0000ffffffffffff
> Nov 11 17:46:25 ubuntu kernel: ... max period:             00007fffffffffff
> Nov 11 17:46:25 ubuntu kernel: ... fixed-purpose events:   3
> Nov 11 17:46:25 ubuntu kernel: ... event mask:             000000070000000f
> Nov 11 17:46:25 ubuntu kernel: signal: max sigframe size: 1776
> Nov 11 17:46:25 ubuntu kernel: Estimated ratio of average max frequency by base frequency (times 1024): 1024
> Nov 11 17:46:25 ubuntu kernel: rcu: Hierarchical SRCU implementation.
> Nov 11 17:46:25 ubuntu kernel: rcu:         Max phase no-delay instances is 400.
> Nov 11 17:46:25 ubuntu kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> Nov 11 17:46:25 ubuntu kernel: smp: Bringing up secondary CPUs ...
> Nov 11 17:46:25 ubuntu kernel: smpboot: x86: Booting SMP configuration:
> Nov 11 17:46:25 ubuntu kernel: .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
> Nov 11 17:46:25 ubuntu kernel: Transient Scheduler Attacks: MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> Nov 11 17:46:25 ubuntu kernel: Transient Scheduler Attacks: VMSCAPE: SMT on, STIBP is required for full protection. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/vmscape.html for more details.
> Nov 11 17:46:25 ubuntu kernel: smp: Brought up 1 node, 16 CPUs
> Nov 11 17:46:25 ubuntu kernel: smpboot: Max logical packages: 1
> Nov 11 17:46:25 ubuntu kernel: smpboot: Total of 16 processors activated (57604.12 BogoMIPS)
> Nov 11 17:46:25 ubuntu kernel: devtmpfs: initialized
> Nov 11 17:46:25 ubuntu kernel: x86/mm: Memory block size: 128MB
> Nov 11 17:46:25 ubuntu kernel: ACPI: PM: Registering ACPI NVS region [mem 0x7e8ff000-0x7eefefff] (6291456 bytes)
> Nov 11 17:46:25 ubuntu kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> Nov 11 17:46:25 ubuntu kernel: futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
> Nov 11 17:46:25 ubuntu kernel: pinctrl core: initialized pinctrl subsystem
> Nov 11 17:46:25 ubuntu kernel: PM: RTC time: 09:46:16, date: 2026-11-11
> Nov 11 17:46:25 ubuntu kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
> Nov 11 17:46:25 ubuntu kernel: DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> Nov 11 17:46:25 ubuntu kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> Nov 11 17:46:25 ubuntu kernel: DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> Nov 11 17:46:25 ubuntu kernel: audit: initializing netlink subsys (disabled)
> Nov 11 17:46:25 ubuntu kernel: audit: type=2000 audit(1794390376.094:1): state=initialized audit_enabled=0 res=1
> Nov 11 17:46:25 ubuntu kernel: thermal_sys: Registered thermal governor 'fair_share'
> Nov 11 17:46:25 ubuntu kernel: thermal_sys: Registered thermal governor 'bang_bang'
> Nov 11 17:46:25 ubuntu kernel: thermal_sys: Registered thermal governor 'step_wise'
> Nov 11 17:46:25 ubuntu kernel: thermal_sys: Registered thermal governor 'user_space'
> Nov 11 17:46:25 ubuntu kernel: thermal_sys: Registered thermal governor 'power_allocator'
> Nov 11 17:46:25 ubuntu kernel: cpuidle: using governor ladder
> Nov 11 17:46:25 ubuntu kernel: cpuidle: using governor menu
> Nov 11 17:46:25 ubuntu kernel: Simple Boot Flag at 0x44 set to 0x1
> Nov 11 17:46:25 ubuntu kernel: ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> Nov 11 17:46:25 ubuntu kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> Nov 11 17:46:25 ubuntu kernel: PCI: ECAM [mem 0x80000000-0x8fffffff] (base 0x80000000) for domain 0000 [bus 00-ff]
> Nov 11 17:46:25 ubuntu kernel: PCI: ECAM [mem 0x80000000-0x8fffffff] reserved as E820 entry
> Nov 11 17:46:25 ubuntu kernel: PCI: Using configuration type 1 for base access
> Nov 11 17:46:25 ubuntu kernel: core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
> Nov 11 17:46:25 ubuntu kernel: mtrr: your CPUs had inconsistent variable MTRR settings
> Nov 11 17:46:25 ubuntu kernel: mtrr: probably your BIOS does not setup all CPUs.
> Nov 11 17:46:25 ubuntu kernel: mtrr: corrected configuration.
> Nov 11 17:46:25 ubuntu kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> Nov 11 17:46:25 ubuntu kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> Nov 11 17:46:25 ubuntu kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> Nov 11 17:46:25 ubuntu kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> Nov 11 17:46:25 ubuntu kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> Nov 11 17:46:25 ubuntu kernel: fbcon: Taking over console
> Nov 11 17:46:25 ubuntu kernel: ACPI: Added _OSI(Module Device)
> Nov 11 17:46:25 ubuntu kernel: ACPI: Added _OSI(Processor Device)
> Nov 11 17:46:25 ubuntu kernel: ACPI: Added _OSI(Processor Aggregator Device)
> Nov 11 17:46:25 ubuntu kernel: ACPI: 2 ACPI AML tables successfully acquired and loaded
> Nov 11 17:46:25 ubuntu kernel: ACPI: _OSC evaluated successfully for all CPUs
> Nov 11 17:46:25 ubuntu kernel: ACPI: Interpreter enabled
> Nov 11 17:46:25 ubuntu kernel: ACPI: PM: (supports S0 S4 S5)
> Nov 11 17:46:25 ubuntu kernel: ACPI: Using IOAPIC for interrupt routing
> Nov 11 17:46:25 ubuntu kernel: HEST: Table parsing has been initialized.
> Nov 11 17:46:25 ubuntu kernel: GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> Nov 11 17:46:25 ubuntu kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> Nov 11 17:46:25 ubuntu kernel: PCI: Using E820 reservations for host bridge windows
> Nov 11 17:46:25 ubuntu kernel: ACPI: Enabled 7 GPEs in block 00 to 3F
> Nov 11 17:46:25 ubuntu kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> Nov 11 17:46:25 ubuntu kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> Nov 11 17:46:25 ubuntu kernel: acpi PNP0A08:00: PCIe port services disabled; not requesting _OSC control
> Nov 11 17:46:25 ubuntu kernel: acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> Nov 11 17:46:25 ubuntu kernel: PCI host bridge to bus 0000:00
> Nov 11 17:46:25 ubuntu kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> Nov 11 17:46:25 ubuntu kernel: pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
> Nov 11 17:46:25 ubuntu kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> Nov 11 17:46:25 ubuntu kernel: pci_bus 0000:00: root bus resource [mem 0x90000000-0xfbffefff window]
> Nov 11 17:46:25 ubuntu kernel: pci_bus 0000:00: root bus resource [bus 00-fe]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.0: removing 2.5GT/s downstream link speed restriction
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.0: retraining failed
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.1: [8086:3c03] type 01 class 0x060400 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.1:   bridge window [io  0x5000-0x5fff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.1:   bridge window [mem 0x94800000-0x948fffff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:03.0: PCI bridge to [bus 03]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:03.0:   bridge window [mem 0x94700000-0x947fffff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:03.0: enabling Extended Tags
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.0: [8086:3c20] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.0: BAR 0 [mem 0x94900000-0x94903fff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.1: [8086:3c21] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.1: BAR 0 [mem 0x94904000-0x94907fff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.2: [8086:3c22] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.2: BAR 0 [mem 0x94908000-0x9490bfff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.3: [8086:3c23] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.3: BAR 0 [mem 0x9490c000-0x9490ffff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.4: [8086:3c24] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.4: BAR 0 [mem 0x94910000-0x94913fff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.5: [8086:3c25] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.5: BAR 0 [mem 0x94914000-0x94917fff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.6: [8086:3c26] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.6: BAR 0 [mem 0x94918000-0x9491bfff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.7: [8086:3c27] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:04.7: BAR 0 [mem 0x9491c000-0x9491ffff 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020 conventional PCI endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:05.4: BAR 0 [mem 0x94928000-0x94928fff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:11.0: PCI bridge to [bus 04]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:11.0:   bridge window [io  0x3000-0x3fff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:11.0:   bridge window [mem 0x94600000-0x946fffff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:11.0:   bridge window [mem 0x94000000-0x944fffff 64bit pref]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000 conventional PCI endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:16.0: BAR 0 [mem 0x94920000-0x9492000f 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:16.1: [8086:1d3b] type 00 class 0x078000 conventional PCI endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:16.1: BAR 0 [mem 0x94921000-0x9492100f 64bit]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320 conventional PCI endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1a.0: BAR 0 [mem 0x94926000-0x949263ff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.0: PCI bridge to [bus 05]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.0: retraining failed
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.0: Enabling MPC IRBNCE
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.2: PCI bridge to [bus 06]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.2: removing 2.5GT/s downstream link speed restriction
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.2: retraining failed
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.2: Enabling MPC IRBNCE
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.2: Intel PCH root port ACS workaround enabled
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3: [8086:1d16] type 01 class 0x060400 PCIe Root Port
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3: PCI bridge to [bus 07]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945fffff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ffffff 64bit pref]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3: Enabling MPC IRBNCE
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1c.3: Intel PCH root port ACS workaround enabled
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320 conventional PCI endpoint
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1d.0: BAR 0 [mem 0x94925000-0x949253ff]
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401 conventional PCI bridge
> Nov 11 17:46:25 ubuntu kernel: pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive decode)
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: BAR 0 [io  0x6048-0x604f]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: BAR 1 [io  0x605c-0x605f]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: BAR 2 [io  0x6040-0x6047]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: BAR 3 [io  0x6058-0x605b]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: BAR 4 [io  0x6020-0x603f]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: BAR 5 [mem 0x94924000-0x949247ff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: PME# supported from D3hot
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.3: BAR 0 [mem 0x94922000-0x949220ff 64bit]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.3: BAR 4 [io  0x6000-0x601f]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.6: [8086:1d24] type 00 class 0x118000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.6: BAR 0 [mem 0x94923000-0x94923fff 64bit]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: [8086:1521] type 00 class 0x020000 PCIe Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: BAR 0 [mem 0x94820000-0x9483ffff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: BAR 2 [io  0x5020-0x503f]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: BAR 3 [mem 0x94844000-0x94847fff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: VF BAR 0 [mem 0x00000000-0x00003fff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: VF BAR 0 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 0 for 8 VFs
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: VF BAR 3 [mem 0x00000000-0x00003fff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: VF BAR 3 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 3 for 8 VFs
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: [8086:1521] type 00 class 0x020000 PCIe Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: BAR 0 [mem 0x94800000-0x9481ffff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: BAR 2 [io  0x5000-0x501f]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: BAR 3 [mem 0x94840000-0x94843fff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: VF BAR 0 [mem 0x00000000-0x00003fff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: VF BAR 0 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 0 for 8 VFs
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: VF BAR 3 [mem 0x00000000-0x00003fff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: VF BAR 3 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 3 for 8 VFs
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: [1000:005b] type 00 class 0x010400 PCIe Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: BAR 0 [io  0x4000-0x40ff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: BAR 1 [mem 0x94740000-0x94743fff 64bit]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: BAR 3 [mem 0x94700000-0x9473ffff 64bit]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: ROM [mem 0xfffe0000-0xffffffff pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: enabling Extended Tags
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: supports D1 D2
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:03.0: PCI bridge to [bus 03]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: [8086:1d6b] type 00 class 0x010700 PCIe Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: BAR 0 [mem 0x94400000-0x94403fff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: BAR 2 [mem 0x94000000-0x943fffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: BAR 4 [io  0x3000-0x30ff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: enabling Extended Tags
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: VF BAR 0 [mem 0x00000000-0x00003fff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: VF BAR 0 [mem 0x00000000-0x0007bfff 64bit pref]: contains BAR 0 for 31 VFs
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.3: [8086:1d70] type 00 class 0x0c0500 PCIe Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.3: BAR 0 [mem 0x94600000-0x94600fff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.3: BAR 4 [io  0x3100-0x311f]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:11.0: PCI bridge to [bus 04]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.0: PCI bridge to [bus 05]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.2: PCI bridge to [bus 06]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.3: PCI bridge to [bus 07]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:08: extended config space not accessible
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive decode)
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1e.0:   bridge window [io  0x1000-0xffff window] (subtractive decode)
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xfbffefff window] (subtractive decode)
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
> Nov 11 17:46:26 ubuntu kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> Nov 11 17:46:26 ubuntu kernel: acpi PNP0A03:00: PCIe port services disabled; not requesting _OSC control
> Nov 11 17:46:26 ubuntu kernel: PCI host bridge to bus 0000:ff
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:ff: root bus resource [bus ff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:08.0: [8086:3c80] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:08.3: [8086:3c83] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:08.4: [8086:3c84] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:09.0: [8086:3c90] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:09.3: [8086:3c93] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:09.4: [8086:3c94] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.0: [8086:3cc0] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.1: [8086:3cc1] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.2: [8086:3cc2] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.3: [8086:3cd0] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0b.0: [8086:3ce0] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0b.3: [8086:3ce3] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.0: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.1: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.2: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.3: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.6: [8086:3cf4] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.7: [8086:3cf6] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.0: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.1: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.2: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.3: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.6: [8086:3cf5] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0e.0: [8086:3ca0] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0e.1: [8086:3c46] type 00 class 0x110100 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.0: [8086:3ca8] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.1: [8086:3c71] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.2: [8086:3caa] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.3: [8086:3cab] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.4: [8086:3cac] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.5: [8086:3cad] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.6: [8086:3cae] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.0: [8086:3cb0] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.1: [8086:3cb1] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.2: [8086:3cb2] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.3: [8086:3cb3] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.5: [8086:3cb5] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.6: [8086:3cb6] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.7: [8086:3cb7] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:11.0: [8086:3cb8] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.0: [8086:3ce4] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.1: [8086:3c43] type 00 class 0x110100 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.4: [8086:3ce6] type 00 class 0x110100 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.5: [8086:3c44] type 00 class 0x110100 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.6: [8086:3c45] type 00 class 0x088000 conventional PCI endpoint
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKA configured for IRQ 3
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKB configured for IRQ 5
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKC configured for IRQ 6
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKD configured for IRQ 7
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKE disabled
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKF configured for IRQ 10
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKG disabled
> Nov 11 17:46:26 ubuntu kernel: ACPI: PCI: Interrupt link LNKH configured for IRQ 9
> Nov 11 17:46:26 ubuntu kernel: iommu: Default domain type: Translated
> Nov 11 17:46:26 ubuntu kernel: iommu: DMA domain TLB invalidation policy: lazy mode
> Nov 11 17:46:26 ubuntu kernel: SCSI subsystem initialized
> Nov 11 17:46:26 ubuntu kernel: libata version 3.00 loaded.
> Nov 11 17:46:26 ubuntu kernel: ACPI: bus type USB registered
> Nov 11 17:46:26 ubuntu kernel: usbcore: registered new interface driver usbfs
> Nov 11 17:46:26 ubuntu kernel: usbcore: registered new interface driver hub
> Nov 11 17:46:26 ubuntu kernel: usbcore: registered new device driver usb
> Nov 11 17:46:26 ubuntu kernel: pps_core: LinuxPPS API ver. 1 registered
> Nov 11 17:46:26 ubuntu kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> Nov 11 17:46:26 ubuntu kernel: PTP clock support registered
> Nov 11 17:46:26 ubuntu kernel: EDAC MC: Ver: 3.0.0
> Nov 11 17:46:26 ubuntu kernel: NetLabel: Initializing
> Nov 11 17:46:26 ubuntu kernel: NetLabel:  domain hash size = 128
> Nov 11 17:46:26 ubuntu kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> Nov 11 17:46:26 ubuntu kernel: NetLabel:  unlabeled traffic allowed by default
> Nov 11 17:46:26 ubuntu kernel: mctp: management component transport protocol core
> Nov 11 17:46:26 ubuntu kernel: NET: Registered PF_MCTP protocol family
> Nov 11 17:46:26 ubuntu kernel: PCI: Using ACPI for IRQ routing
> Nov 11 17:46:26 ubuntu kernel: PCI: pci_cache_line_size set to 64 bytes
> Nov 11 17:46:26 ubuntu kernel: e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
> Nov 11 17:46:26 ubuntu kernel: e820: reserve RAM buffer [mem 0x7e4ff000-0x7fffffff]
> Nov 11 17:46:26 ubuntu kernel: e820: reserve RAM buffer [mem 0x7f000000-0x7fffffff]
> Nov 11 17:46:26 ubuntu kernel: vgaarb: loaded
> Nov 11 17:46:26 ubuntu kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> Nov 11 17:46:26 ubuntu kernel: hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> Nov 11 17:46:26 ubuntu kernel: clocksource: Switched to clocksource tsc-early
> Nov 11 17:46:26 ubuntu kernel: VFS: Disk quotas dquot_6.6.0
> Nov 11 17:46:26 ubuntu kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> Nov 11 17:46:26 ubuntu kernel: AppArmor: AppArmor Filesystem Enabled
> Nov 11 17:46:26 ubuntu kernel: pnp: PnP ACPI init
> Nov 11 17:46:26 ubuntu kernel: system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:00: [mem 0xfbfff000-0xfbffffff] has been reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:00: [mem 0xfbffc000-0xfbffdfff] could not be reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:00: [mem 0xff000000-0xffffffff] could not be reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:00: [mem 0xfee00000-0xfeefffff] could not be reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:01: [io  0x0680-0x069f] has been reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:01: [io  0x0400-0x0453] has been reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:01: [io  0x0458-0x047f] has been reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:01: [io  0x0500-0x057f] has been reserved
> Nov 11 17:46:26 ubuntu kernel: system 00:01: [io  0x164e-0x164f] has been reserved
> Nov 11 17:46:26 ubuntu kernel: pnp 00:05: [dma 0 disabled]
> Nov 11 17:46:26 ubuntu kernel: pnp: PnP ACPI: found 6 devices
> Nov 11 17:46:26 ubuntu kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> Nov 11 17:46:26 ubuntu kernel: NET: Registered PF_INET protocol family
> Nov 11 17:46:26 ubuntu kernel: IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: TCP: Hash tables configured (established 131072 bind 65536)
> Nov 11 17:46:26 ubuntu kernel: MPTCP token hash table entries: 16384 (order: 7, 393216 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> Nov 11 17:46:26 ubuntu kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
> Nov 11 17:46:26 ubuntu kernel: NET: Registered PF_XDP protocol family
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: ROM [mem 0xfffe0000-0xffffffff pref]: can't claim; no compatible bridge window
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.1: bridge window [mem 0x94a00000-0x94afffff 64bit pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:03.0: bridge window [mem 0x94b00000-0x94cfffff 64bit pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: VF BAR 0 [mem 0x94a00000-0x94a1ffff 64bit pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: VF BAR 3 [mem 0x94a20000-0x94a3ffff 64bit pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: VF BAR 0 [mem 0x94a40000-0x94a5ffff 64bit pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: VF BAR 3 [mem 0x94a60000-0x94a7ffff 64bit pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.1:   bridge window [io  0x5000-0x5fff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.1:   bridge window [mem 0x94800000-0x948fffff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.1:   bridge window [mem 0x94a00000-0x94afffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: ROM [mem 0x94760000-0x9477ffff pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:03.0: PCI bridge to [bus 03]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:03.0:   bridge window [mem 0x94700000-0x947fffff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:03.0:   bridge window [mem 0x94b00000-0x94cfffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: VF BAR 0 [mem 0x94404000-0x9447ffff 64bit pref]: assigned
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:11.0: PCI bridge to [bus 04]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:11.0:   bridge window [io  0x3000-0x3fff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:11.0:   bridge window [mem 0x94600000-0x946fffff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:11.0:   bridge window [mem 0x94000000-0x944fffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.0: PCI bridge to [bus 05]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.2: PCI bridge to [bus 06]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.3: PCI bridge to [bus 07]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945fffff]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ffffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1e.0: PCI bridge to [bus 08]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:00: resource 7 [mem 0x90000000-0xfbffefff window]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:02: resource 1 [mem 0x94800000-0x948fffff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:02: resource 2 [mem 0x94a00000-0x94afffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:03: resource 1 [mem 0x94700000-0x947fffff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:03: resource 2 [mem 0x94b00000-0x94cfffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:04: resource 1 [mem 0x94600000-0x946fffff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:04: resource 2 [mem 0x94000000-0x944fffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:07: resource 0 [io  0x2000-0x2fff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:07: resource 1 [mem 0x94500000-0x945fffff]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:07: resource 2 [mem 0x90000000-0x93ffffff 64bit pref]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:08: resource 5 [io  0x1000-0xffff window]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
> Nov 11 17:46:26 ubuntu kernel: pci_bus 0000:08: resource 7 [mem 0x90000000-0xfbffefff window]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:05.0: disabled boot interrupts on device [8086:3c28]
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x190 took 11662 usecs
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x190 took 11673 usecs
> Nov 11 17:46:26 ubuntu kernel: PCI: CLS 64 bytes, default 64
> Nov 11 17:46:26 ubuntu kernel: Trying to unpack rootfs image as initramfs...
> Nov 11 17:46:26 ubuntu kernel: DMAR: No SATC found
> Nov 11 17:46:26 ubuntu kernel: DMAR: dmar0: Using Queued invalidation
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:00.0: Adding to iommu group 0
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.0: Adding to iommu group 1
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:01.1: Adding to iommu group 2
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:03.0: Adding to iommu group 3
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.0: Adding to iommu group 4
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.1: Adding to iommu group 5
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.2: Adding to iommu group 6
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.3: Adding to iommu group 7
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.4: Adding to iommu group 8
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.5: Adding to iommu group 9
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.6: Adding to iommu group 10
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:04.7: Adding to iommu group 11
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:05.0: Adding to iommu group 12
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:05.2: Adding to iommu group 13
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:05.4: Adding to iommu group 14
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:11.0: Adding to iommu group 15
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:16.0: Adding to iommu group 16
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:16.1: Adding to iommu group 16
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1a.0: Adding to iommu group 17
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.0: Adding to iommu group 18
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.2: Adding to iommu group 19
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1c.3: Adding to iommu group 20
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1d.0: Adding to iommu group 21
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1e.0: Adding to iommu group 22
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.0: Adding to iommu group 23
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.2: Adding to iommu group 23
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.3: Adding to iommu group 23
> Nov 11 17:46:26 ubuntu kernel: pci 0000:00:1f.6: Adding to iommu group 23
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.0: Adding to iommu group 24
> Nov 11 17:46:26 ubuntu kernel: pci 0000:02:00.1: Adding to iommu group 25
> Nov 11 17:46:26 ubuntu kernel: pci 0000:03:00.0: Adding to iommu group 26
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.0: Adding to iommu group 27
> Nov 11 17:46:26 ubuntu kernel: pci 0000:04:00.3: Adding to iommu group 27
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:08.0: Adding to iommu group 28
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:08.3: Adding to iommu group 29
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:08.4: Adding to iommu group 30
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:09.0: Adding to iommu group 31
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:09.3: Adding to iommu group 32
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:09.4: Adding to iommu group 33
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.0: Adding to iommu group 34
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.1: Adding to iommu group 34
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.2: Adding to iommu group 34
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0a.3: Adding to iommu group 34
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0b.0: Adding to iommu group 35
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0b.3: Adding to iommu group 35
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.0: Adding to iommu group 36
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.1: Adding to iommu group 36
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.2: Adding to iommu group 36
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.3: Adding to iommu group 36
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.6: Adding to iommu group 36
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0c.7: Adding to iommu group 36
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.0: Adding to iommu group 37
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.1: Adding to iommu group 37
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.2: Adding to iommu group 37
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.3: Adding to iommu group 37
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0d.6: Adding to iommu group 37
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0e.0: Adding to iommu group 38
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0e.1: Adding to iommu group 38
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.0: Adding to iommu group 39
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.1: Adding to iommu group 40
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.2: Adding to iommu group 41
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.3: Adding to iommu group 42
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.4: Adding to iommu group 43
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.5: Adding to iommu group 44
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:0f.6: Adding to iommu group 45
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.0: Adding to iommu group 46
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.1: Adding to iommu group 47
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.2: Adding to iommu group 48
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.3: Adding to iommu group 49
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.5: Adding to iommu group 50
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.6: Adding to iommu group 51
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:10.7: Adding to iommu group 52
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:11.0: Adding to iommu group 53
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.0: Adding to iommu group 54
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.1: Adding to iommu group 54
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.4: Adding to iommu group 54
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.5: Adding to iommu group 54
> Nov 11 17:46:26 ubuntu kernel: pci 0000:ff:13.6: Adding to iommu group 54
> Nov 11 17:46:26 ubuntu kernel: DMAR: Intel(R) Virtualization Technology for Directed I/O
> Nov 11 17:46:26 ubuntu kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> Nov 11 17:46:26 ubuntu kernel: software IO TLB: mapped [mem 0x000000007a4ff000-0x000000007e4ff000] (64MB)
> Nov 11 17:46:26 ubuntu kernel: Initialise system trusted keyrings
> Nov 11 17:46:26 ubuntu kernel: Key type blacklist registered
> Nov 11 17:46:26 ubuntu kernel: workingset: timestamp_bits=36 max_order=22 bucket_order=0
> Nov 11 17:46:26 ubuntu kernel: zbud: loaded
> Nov 11 17:46:26 ubuntu kernel: squashfs: version 4.0 (2009/01/31) Phillip Lougher
> Nov 11 17:46:26 ubuntu kernel: fuse: init (API version 7.39)
> Nov 11 17:46:26 ubuntu kernel: integrity: Platform Keyring initialized
> Nov 11 17:46:26 ubuntu kernel: integrity: Machine keyring initialized
> Nov 11 17:46:26 ubuntu kernel: Key type asymmetric registered
> Nov 11 17:46:26 ubuntu kernel: Asymmetric key parser 'x509' registered
> Nov 11 17:46:26 ubuntu kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> Nov 11 17:46:26 ubuntu kernel: io scheduler mq-deadline registered
> Nov 11 17:46:26 ubuntu kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> Nov 11 17:46:26 ubuntu kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> Nov 11 17:46:26 ubuntu kernel: ACPI: button: Power Button [PWRF]
> Nov 11 17:46:26 ubuntu kernel: ERST: Error Record Serialization Table (ERST) support is initialized.
> Nov 11 17:46:26 ubuntu kernel: pstore: Using crash dump compression: deflate
> Nov 11 17:46:26 ubuntu kernel: pstore: Registered erst as persistent store backend
> Nov 11 17:46:26 ubuntu kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> Nov 11 17:46:26 ubuntu kernel: 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> Nov 11 17:46:26 ubuntu kernel: Linux agpgart interface v0.103
> Nov 11 17:46:26 ubuntu kernel: loop: module loaded
> Nov 11 17:46:26 ubuntu kernel: ACPI: bus type drm_connector registered
> Nov 11 17:46:26 ubuntu kernel: tun: Universal TUN/TAP device driver, 1.6
> Nov 11 17:46:26 ubuntu kernel: PPP generic driver version 2.4.2
> Nov 11 17:46:26 ubuntu kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1a.0: EHCI Host Controller
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1a.0: debug port 2
> Nov 11 17:46:26 ubuntu kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> Nov 11 17:46:26 ubuntu kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Nov 11 17:46:26 ubuntu kernel: mousedev: PS/2 mouse device common for all mice
> Nov 11 17:46:26 ubuntu kernel: rtc_cmos 00:02: RTC can wake from S4
> Nov 11 17:46:26 ubuntu kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> Nov 11 17:46:26 ubuntu kernel: rtc_cmos 00:02: registered as rtc0
> Nov 11 17:46:26 ubuntu kernel: rtc_cmos 00:02: setting system clock to 2026-11-11T09:46:22 UTC (1794390382)
> Nov 11 17:46:26 ubuntu kernel: rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram
> Nov 11 17:46:26 ubuntu kernel: i2c_dev: i2c /dev entries driver
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1a.0: irq 16, io mem 0x94926000
> Nov 11 17:46:26 ubuntu kernel: device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> Nov 11 17:46:26 ubuntu kernel: device-mapper: uevent: version 1.0.3
> Nov 11 17:46:26 ubuntu kernel: device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
> Nov 11 17:46:26 ubuntu kernel: intel_pstate: Intel P-state driver initializing
> Nov 11 17:46:26 ubuntu kernel: ledtrig-cpu: registered to indicate activity on CPUs
> Nov 11 17:46:26 ubuntu kernel: [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebuffer.0 on minor 0
> Nov 11 17:46:26 ubuntu kernel: Console: switching to colour frame buffer device 80x30
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> Nov 11 17:46:26 ubuntu kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
> Nov 11 17:46:26 ubuntu kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> Nov 11 17:46:26 ubuntu kernel: usb usb1: Product: EHCI Host Controller
> Nov 11 17:46:26 ubuntu kernel: usb usb1: Manufacturer: Linux 6.8.0-149-generic ehci_hcd
> Nov 11 17:46:26 ubuntu kernel: usb usb1: SerialNumber: 0000:00:1a.0
> Nov 11 17:46:26 ubuntu kernel: hub 1-0:1.0: USB hub found
> Nov 11 17:46:26 ubuntu kernel: simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
> Nov 11 17:46:26 ubuntu kernel: hub 1-0:1.0: 2 ports detected
> Nov 11 17:46:26 ubuntu kernel: drop_monitor: Initializing network drop monitor service
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1d.0: EHCI Host Controller
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
> Nov 11 17:46:26 ubuntu kernel: NET: Registered PF_INET6 protocol family
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1d.0: debug port 2
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1d.0: irq 23, io mem 0x94925000
> Nov 11 17:46:26 ubuntu kernel: ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> Nov 11 17:46:26 ubuntu kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
> Nov 11 17:46:26 ubuntu kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> Nov 11 17:46:26 ubuntu kernel: usb usb2: Product: EHCI Host Controller
> Nov 11 17:46:26 ubuntu kernel: usb usb2: Manufacturer: Linux 6.8.0-149-generic ehci_hcd
> Nov 11 17:46:26 ubuntu kernel: usb usb2: SerialNumber: 0000:00:1d.0
> Nov 11 17:46:26 ubuntu kernel: hub 2-0:1.0: USB hub found
> Nov 11 17:46:26 ubuntu kernel: hub 2-0:1.0: 2 ports detected
> Nov 11 17:46:26 ubuntu kernel: Freeing initrd memory: 75376K
> Nov 11 17:46:26 ubuntu kernel: Segment Routing with IPv6
> Nov 11 17:46:26 ubuntu kernel: In-situ OAM (IOAM) with IPv6
> Nov 11 17:46:26 ubuntu kernel: NET: Registered PF_PACKET protocol family
> Nov 11 17:46:26 ubuntu kernel: Key type dns_resolver registered
> Nov 11 17:46:26 ubuntu kernel: microcode: Current revision: 0x0000071a
> Nov 11 17:46:26 ubuntu kernel: microcode: Updated early from: 0x00000710
> Nov 11 17:46:26 ubuntu kernel: IPI shorthand broadcast: enabled
> Nov 11 17:46:26 ubuntu kernel: sched_clock: Marking stable (6396003669, 106107174)->(6577654990, -75544147)
> Nov 11 17:46:26 ubuntu kernel: registered taskstats version 1
> Nov 11 17:46:26 ubuntu kernel: Loading compiled-in X.509 certificates
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Build time autogenerated kernel key: 9a137e402f355547be6108f074230bd270d34d14'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Live Patch Signing 2025 Kmod: d541cef61dc7e793b7eb7e899970a2eef0b5dc8c'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Live Patch Signing: 14df34d1a87cf37625abec039ef2bf521249b969'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing 2025 Kmod: 4627603d2357a2a3f81006370894c221175893e9'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing: 88f752e560a1e0737e31163a466ad7b70a850c19'
> Nov 11 17:46:26 ubuntu kernel: blacklist: Loading compiled-in revocation X.509 certificates
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing: 61482aa2830d0ab2ad5af10b7250da9033ddcef0'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2017): 242ade75ac4a15e50d50c84b0d45ff3eae707a03'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (ESM 2018): 365188c1d374d6b07c3c8f240f8ef722433d6a8b'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2019): c0746fd6c5da3ae827864651ad66ae47fe24b3e8'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v1): a8d54bbb3825cfb94fa13c9f8a594a195c107b8d'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v2): 4cf046892d6fd3c9a5b03f98d845f90851dc6a8c'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v3): 100437bb6de6e469b581e61cd66bce3ef4ed53af'
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (Ubuntu Core 2019): c1d57b8f6b743f23ee41f4f7ee292f06eecadfb9'
> Nov 11 17:46:26 ubuntu kernel: Key type .fscrypt registered
> Nov 11 17:46:26 ubuntu kernel: Key type fscrypt-provisioning registered
> Nov 11 17:46:26 ubuntu kernel: cryptd: max_cpu_qlen set to 1000
> Nov 11 17:46:26 ubuntu kernel: AVX version of gcm_enc/dec engaged.
> Nov 11 17:46:26 ubuntu kernel: AES CTR mode by8 optimization enabled
> Nov 11 17:46:26 ubuntu kernel: usb 1-1: new high-speed USB device number 2 using ehci-pci
> Nov 11 17:46:26 ubuntu kernel: Key type encrypted registered
> Nov 11 17:46:26 ubuntu kernel: AppArmor: AppArmor sha256 policy hashing enabled
> Nov 11 17:46:26 ubuntu kernel: ima: No TPM chip found, activating TPM-bypass!
> Nov 11 17:46:26 ubuntu kernel: Loading compiled-in module X.509 certificates
> Nov 11 17:46:26 ubuntu kernel: Loaded X.509 cert 'Build time autogenerated kernel key: 9a137e402f355547be6108f074230bd270d34d14'
> Nov 11 17:46:26 ubuntu kernel: ima: Allocated hash algorithm: sha256
> Nov 11 17:46:26 ubuntu kernel: ima: No architecture policies found
> Nov 11 17:46:26 ubuntu kernel: evm: Initialising EVM extended attributes:
> Nov 11 17:46:26 ubuntu kernel: evm: security.selinux
> Nov 11 17:46:26 ubuntu kernel: evm: security.SMACK64
> Nov 11 17:46:26 ubuntu kernel: evm: security.SMACK64EXEC
> Nov 11 17:46:26 ubuntu kernel: evm: security.SMACK64TRANSMUTE
> Nov 11 17:46:26 ubuntu kernel: evm: security.SMACK64MMAP
> Nov 11 17:46:26 ubuntu kernel: evm: security.apparmor
> Nov 11 17:46:26 ubuntu kernel: evm: security.ima
> Nov 11 17:46:26 ubuntu kernel: evm: security.capability
> Nov 11 17:46:26 ubuntu kernel: evm: HMAC attrs: 0x1
> Nov 11 17:46:26 ubuntu kernel: usb 2-1: new high-speed USB device number 2 using ehci-pci
> Nov 11 17:46:26 ubuntu kernel: PM:   Magic number: 2:48:778
> Nov 11 17:46:26 ubuntu kernel: RAS: Correctable Errors collector initialized.
> Nov 11 17:46:26 ubuntu kernel: clk: Disabling unused clocks
> Nov 11 17:46:26 ubuntu kernel: Freeing unused decrypted memory: 2028K
> Nov 11 17:46:26 ubuntu kernel: Freeing unused kernel image (initmem) memory: 4948K
> Nov 11 17:46:26 ubuntu kernel: Write protecting the kernel read-only data: 38912k
> Nov 11 17:46:26 ubuntu kernel: Freeing unused kernel image (rodata/data gap) memory: 1928K
> Nov 11 17:46:26 ubuntu kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
> Nov 11 17:46:26 ubuntu kernel: x86/mm: Checking user space page tables
> Nov 11 17:46:26 ubuntu kernel: usb 1-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
> Nov 11 17:46:26 ubuntu kernel: usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> Nov 11 17:46:26 ubuntu kernel: hub 1-1:1.0: USB hub found
> Nov 11 17:46:26 ubuntu kernel: hub 1-1:1.0: 6 ports detected
> Nov 11 17:46:26 ubuntu kernel: usb 2-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
> Nov 11 17:46:26 ubuntu kernel: usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> Nov 11 17:46:26 ubuntu kernel: hub 2-1:1.0: USB hub found
> Nov 11 17:46:26 ubuntu kernel: hub 2-1:1.0: 8 ports detected
> Nov 11 17:46:26 ubuntu kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
> Nov 11 17:46:26 ubuntu kernel: Run /init as init process
> Nov 11 17:46:26 ubuntu kernel:   with arguments:
> Nov 11 17:46:26 ubuntu kernel:     /init
> Nov 11 17:46:26 ubuntu kernel:   with environment:
> Nov 11 17:46:26 ubuntu kernel:     HOME=/
> Nov 11 17:46:26 ubuntu kernel:     TERM=linux
> Nov 11 17:46:26 ubuntu kernel: dca service started, version 1.12.1
> Nov 11 17:46:26 ubuntu kernel: megasas: 07.727.03.00-rc1
> Nov 11 17:46:26 ubuntu kernel: ahci 0000:00:1f.2: version 3.0
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: BAR:0x1  BAR's base_addr(phys):0x0000000094740000  mapped virt_addr:0x(____ptrval____)
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: FW now in Ready state
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: 63 bit DMA mask and 32 bit consistent mask
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: firmware supports msix        : (16)
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: requested/available msix 16/16 poll_queue 0
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: current msix/online cpus        : (16/16)
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: RDPQ mode        : (disabled)
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: Current firmware supports maximum commands: 1008         LDIO threshold: 0
> Nov 11 17:46:26 ubuntu kernel: igb: Intel(R) Gigabit Ethernet Network Driver
> Nov 11 17:46:26 ubuntu kernel: igb: Copyright (c) 2007-2014 Intel Corporation.
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0: PHY reset is blocked due to SOL/IDER session.
> Nov 11 17:46:26 ubuntu kernel: ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> Nov 11 17:46:26 ubuntu kernel: ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck led clo pio slum part ems apst 
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: Performance mode :Latency (latency index = 1)
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: FW supports sync cache        : No
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
> Nov 11 17:46:26 ubuntu kernel: isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
> Nov 11 17:46:26 ubuntu kernel: isci 0000:04:00.0: driver configured for rev: 6 silicon
> Nov 11 17:46:26 ubuntu kernel: isci 0000:04:00.0: OEM parameter table found in OROM
> Nov 11 17:46:26 ubuntu kernel: isci 0000:04:00.0: [0]: invalid oem parameters detected, falling back to firmware
> Nov 11 17:46:26 ubuntu kernel: isci 0000:04:00.0: OEM SAS parameters (version: 1.3) loaded (firmware)
> Nov 11 17:46:26 ubuntu kernel: isci 0000:04:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
> Nov 11 17:46:26 ubuntu kernel: scsi host1: isci
> Nov 11 17:46:26 ubuntu kernel: scsi host2: ahci
> Nov 11 17:46:26 ubuntu kernel: scsi host3: ahci
> Nov 11 17:46:26 ubuntu kernel: scsi host4: ahci
> Nov 11 17:46:26 ubuntu kernel: scsi host5: ahci
> Nov 11 17:46:26 ubuntu kernel: scsi host6: ahci
> Nov 11 17:46:26 ubuntu kernel: scsi host7: ahci
> Nov 11 17:46:26 ubuntu kernel: ata1: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924100 irq 25 lpm-pol 0
> Nov 11 17:46:26 ubuntu kernel: ata2: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924180 irq 25 lpm-pol 0
> Nov 11 17:46:26 ubuntu kernel: ata3: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924200 irq 25 lpm-pol 0
> Nov 11 17:46:26 ubuntu kernel: ata4: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924280 irq 25 lpm-pol 0
> Nov 11 17:46:26 ubuntu kernel: ata5: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924300 irq 25 lpm-pol 0
> Nov 11 17:46:26 ubuntu kernel: ata6: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924380 irq 25 lpm-pol 0
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0: added PHC on eth0
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0: eth0: (PCIe:5.0Gb/s:Width x4) dc:d2:fc:9a:79:b4
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0: eth0: PBA No: 106100-000
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1: PHY reset is blocked due to SOL/IDER session.
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: FW provided supportMaxExtLDs: 0        max_lds: 64
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: controller type        : MR(512MB)
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)        : Enabled
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: Secure JBOD support        : No
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: NVMe passthru support        : No
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: FW provided TM TaskAbort/Reset timeout        : 0 secs/0 secs
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: JBOD sequence map support        : No
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: PCI Lane Margining support        : No
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1: added PHC on eth1
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: INIT adapter done
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1: eth1: (PCIe:5.0Gb/s:Width x4) dc:d2:fc:9a:79:b5
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: JBOD sequence map is disabled megasas_setup_jbod_map 5800
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1: eth1: PBA No: 106100-000
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: pci id                : (0x1000)/(0x005b)/(0x19e5)/(0xd204)
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: unevenspan support        : no
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: firmware crash dump        : no
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: JBOD sequence map        : disabled
> Nov 11 17:46:26 ubuntu kernel: megaraid_sas 0000:03:00.0: Max firmware commands: 1007 shared with default hw_queues = 15 poll_queues 0
> Nov 11 17:46:26 ubuntu kernel: scsi host0: Avago SAS based MegaRAID driver
> Nov 11 17:46:26 ubuntu kernel: tsc: Refined TSC clocksource calibration: 1799.999 MHz
> Nov 11 17:46:26 ubuntu kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x19f228ab7a2, max_idle_ns: 440795289252 ns
> Nov 11 17:46:26 ubuntu kernel: clocksource: Switched to clocksource tsc
> Nov 11 17:46:26 ubuntu kernel: scsi 0:2:0:0: Direct-Access     LSI      LSI              3.19 PQ: 0 ANSI: 5
> Nov 11 17:46:26 ubuntu kernel: ata5: SATA link down (SStatus 0 SControl 300)
> Nov 11 17:46:26 ubuntu kernel: ata6: SATA link down (SStatus 0 SControl 300)
> Nov 11 17:46:26 ubuntu kernel: ata1: SATA link down (SStatus 0 SControl 300)
> Nov 11 17:46:26 ubuntu kernel: ata3: SATA link down (SStatus 0 SControl 300)
> Nov 11 17:46:26 ubuntu kernel: ata4: SATA link down (SStatus 0 SControl 300)
> Nov 11 17:46:26 ubuntu kernel: ata2: SATA link down (SStatus 0 SControl 300)
> Nov 11 17:46:26 ubuntu kernel: sd 0:2:0:0: Attached scsi generic sg0 type 0
> Nov 11 17:46:26 ubuntu kernel: sd 0:2:0:0: [sda] 486326272 512-byte logical blocks: (249 GB/232 GiB)
> Nov 11 17:46:26 ubuntu kernel: sd 0:2:0:0: [sda] Write Protect is off
> Nov 11 17:46:26 ubuntu kernel: sd 0:2:0:0: [sda] Mode Sense: 1f 00 00 08
> Nov 11 17:46:26 ubuntu kernel: sd 0:2:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Nov 11 17:46:26 ubuntu kernel:  sda: sda1 sda2 sda3
> Nov 11 17:46:26 ubuntu kernel: sd 0:2:0:0: [sda] Attached SCSI disk
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0 enp2s0f0: renamed from eth0
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1 enp2s0f1: renamed from eth1
> Nov 11 17:46:26 ubuntu kernel: random: crng init done
> Nov 11 17:46:26 ubuntu kernel: raid6: sse2x4   gen()  7869 MB/s
> Nov 11 17:46:26 ubuntu kernel: raid6: sse2x2   gen()  8005 MB/s
> Nov 11 17:46:26 ubuntu kernel: raid6: sse2x1   gen()  7258 MB/s
> Nov 11 17:46:26 ubuntu kernel: raid6: using algorithm sse2x2 gen() 8005 MB/s
> Nov 11 17:46:26 ubuntu kernel: raid6: .... xor() 4751 MB/s, rmw enabled
> Nov 11 17:46:26 ubuntu kernel: raid6: using ssse3x2 recovery algorithm
> Nov 11 17:46:26 ubuntu kernel: xor: automatically using best checksumming function   avx       
> Nov 11 17:46:26 ubuntu kernel: async_tx: api initialized (async)
> Nov 11 17:46:26 ubuntu kernel: input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input3
> Nov 11 17:46:26 ubuntu kernel: Btrfs loaded, zoned=yes, fsverity=yes
> Nov 11 17:46:26 ubuntu kernel: SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
> Nov 11 17:46:26 ubuntu kernel: XFS (dm-0): Mounting V5 Filesystem 3dedd2af-8390-497e-9e5b-e98e2dc00fa0
> Nov 11 17:46:26 ubuntu kernel: XFS (dm-0): Ending clean mount
> Nov 11 17:46:26 ubuntu systemd[1]: Inserted module 'autofs4'
> Nov 11 17:46:26 ubuntu systemd[1]: systemd 255.4-1ubuntu8.18 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> Nov 11 17:46:26 ubuntu systemd[1]: Detected architecture x86-64.
> Nov 11 17:46:26 ubuntu systemd[1]: Hostname set to <ubuntu>.
> Nov 11 17:46:26 ubuntu systemd[1]: Queued start job for default target graphical.target.
> Nov 11 17:46:26 ubuntu systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
> Nov 11 17:46:26 ubuntu systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
> Nov 11 17:46:26 ubuntu systemd[1]: Created slice user.slice - User and Session Slice.
> Nov 11 17:46:26 ubuntu systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
> Nov 11 17:46:26 ubuntu systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
> Nov 11 17:46:26 ubuntu systemd[1]: Expecting device dev-disk-by\x2duuid-0dd1a269\x2d6fa4\x2d47bc\x2d9673\x2d1f83d2a7aeae.device - /dev/disk/by-uuid/0dd1a269-6fa4-47bc-9673-1f83d2a7aeae...
> Nov 11 17:46:26 ubuntu systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
> Nov 11 17:46:26 ubuntu systemd[1]: Reached target slices.target - Slice Units.
> Nov 11 17:46:26 ubuntu systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
> Nov 11 17:46:26 ubuntu systemd[1]: Reached target snapd.mounts.target - Mounted snaps.
> Nov 11 17:46:26 ubuntu systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on multipathd.socket - multipathd control socket.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on syslog.socket - Syslog Socket.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on systemd-journald.socket - Journal Socket.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on systemd-networkd.socket - Network Service Netlink Socket.
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
> Nov 11 17:46:26 ubuntu systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
> Nov 11 17:46:26 ubuntu systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
> Nov 11 17:46:26 ubuntu systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
> Nov 11 17:46:26 ubuntu systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
> Nov 11 17:46:26 ubuntu systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-journald.service - Journal Service...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
> Nov 11 17:46:26 ubuntu systemd-journald[491]: Collecting audit messages is disabled.
> Nov 11 17:46:26 ubuntu systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
> Nov 11 17:46:26 ubuntu systemd[1]: netplan-ovs-cleanup.service - OpenVSwitch configuration for cleanup was skipped because of an unmet condition check (ConditionFileIsExecutable=/usr/bin/ovs-vsctl).
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
> Nov 11 17:46:26 ubuntu systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
> Nov 11 17:46:26 ubuntu systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
> Nov 11 17:46:26 ubuntu systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
> Nov 11 17:46:26 ubuntu systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
> Nov 11 17:46:26 ubuntu systemd[1]: modprobe@configfs.service: Deactivated successfully.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
> Nov 11 17:46:26 ubuntu systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
> Nov 11 17:46:26 ubuntu systemd[1]: modprobe@drm.service: Deactivated successfully.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
> Nov 11 17:46:26 ubuntu systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
> Nov 11 17:46:26 ubuntu systemd[1]: modprobe@fuse.service: Deactivated successfully.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
> Nov 11 17:46:26 ubuntu systemd[1]: modprobe@loop.service: Deactivated successfully.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
> Nov 11 17:46:26 ubuntu systemd[1]: Activating swap swap.img.swap - /swap.img...
> Nov 11 17:46:26 ubuntu systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
> Nov 11 17:46:26 ubuntu systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
> Nov 11 17:46:26 ubuntu kernel: Adding 4194300k swap on /swap.img.  Priority:-2 extents:1 across:4194300k 
> Nov 11 17:46:26 ubuntu systemd[1]: Starting multipathd.service - Device-Mapper Multipath Device Controller...
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> Nov 11 17:46:26 ubuntu systemd[1]: Activated swap swap.img.swap - /swap.img.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
> Nov 11 17:46:26 ubuntu systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
> Nov 11 17:46:26 ubuntu systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
> Nov 11 17:46:26 ubuntu systemd[1]: Reached target swap.target - Swaps.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
> Nov 11 17:46:26 ubuntu systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
> Nov 11 17:46:26 ubuntu systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
> Nov 11 17:46:26 ubuntu systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
> Nov 11 17:46:26 ubuntu systemd[1]: Started systemd-journald.service - Journal Service.
> Nov 11 17:46:26 ubuntu systemd-journald[491]: Received client request to flush runtime journal.
> Nov 11 17:46:26 ubuntu systemd-journald[491]: /var/log/journal/6263d7be1c934449b034610cf926b6b9/system.journal: Journal file uses a different sequence number ID, rotating.
> Nov 11 17:46:26 ubuntu systemd-journald[491]: Rotating system journal.
> Nov 11 17:46:26 ubuntu kernel: ioatdma: Intel(R) QuickData Technology Driver 5.00
> Nov 11 17:46:26 ubuntu kernel: lpc_ich 0000:00:1f.0: No MFD cells added
> Nov 11 17:46:26 ubuntu kernel: i801_smbus 0000:04:00.3: Enabling SMBus device
> Nov 11 17:46:26 ubuntu kernel: i801_smbus 0000:04:00.3: SMBus using PCI interrupt
> Nov 11 17:46:26 ubuntu kernel: i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> Nov 11 17:46:26 ubuntu kernel: i2c i2c-3: 1/12 memory slots populated (from DMI)
> Nov 11 17:46:26 ubuntu kernel: i2c i2c-3: Systems with more than 8 memory slots not supported yet, not instantiating SPD
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.0: DCA enabled
> Nov 11 17:46:26 ubuntu kernel: IPMI message handler: version 39.2
> Nov 11 17:46:26 ubuntu kernel: igb 0000:02:00.1: DCA enabled
> Nov 11 17:46:26 ubuntu kernel: mei_me 0000:00:16.0: Device doesn't have valid ME Interface
> Nov 11 17:46:26 ubuntu kernel: ipmi device interface
> Nov 11 17:46:26 ubuntu kernel: RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
> Nov 11 17:46:26 ubuntu kernel: RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
> Nov 11 17:46:26 ubuntu kernel: RAPL PMU: hw unit of domain package 2^-16 Joules
> Nov 11 17:46:26 ubuntu kernel: RAPL PMU: hw unit of domain dram 2^-16 Joules
> Nov 11 17:46:26 ubuntu kernel: ipmi_si: IPMI System Interface driver
> Nov 11 17:46:26 ubuntu kernel: ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> Nov 11 17:46:26 ubuntu kernel: ipmi_platform: ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
> Nov 11 17:46:26 ubuntu kernel: ipmi_si: Adding SMBIOS-specified bt state machine
> Nov 11 17:46:26 ubuntu kernel: ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x20, irq 0
> Nov 11 17:46:26 ubuntu kernel: ipmi_si dmi-ipmi-si.0: bt cap response too short: 3
> Nov 11 17:46:26 ubuntu kernel: ipmi_si dmi-ipmi-si.0: using default values
> Nov 11 17:46:26 ubuntu kernel: ipmi_si dmi-ipmi-si.0: req2rsp=5 secs retries=2
> Nov 11 17:46:26 ubuntu kernel: ipmi_si dmi-ipmi-si.0: IPMI message handler: Found new BMC (man_id: 0x0007db, prod_id: 0xaa11, dev_id: 0x01)
> Nov 11 17:46:26 ubuntu kernel: EXT4-fs (sda2): mounted filesystem 0dd1a269-6fa4-47bc-9673-1f83d2a7aeae r/w with ordered data mode. Quota mode: none.
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3ca0
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3ca0
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3ca8
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3ca8
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3c71
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3c71
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3caa
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3caa
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cab
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cab
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cac
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cac
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cad
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cad
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cb8
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cb8
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cf4
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cf4
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cf6
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cf6
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cf5
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge: Seeking for: PCI ID 8086:3cf5
> Nov 11 17:46:26 ubuntu kernel: EDAC MC0: Giving out device to module sb_edac controller Sandy Bridge SrcID#0_Ha#0: DEV 0000:ff:0e.0 (INTERRUPT)
> Nov 11 17:46:26 ubuntu kernel: EDAC sbridge:  Ver: 1.1.2 
> Nov 11 17:46:26 ubuntu kernel: intel_rapl_common: Found RAPL domain package
> Nov 11 17:46:26 ubuntu kernel: intel_rapl_common: Found RAPL domain core
> Nov 11 17:46:26 ubuntu kernel: intel_rapl_common: Found RAPL domain dram
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.889:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=783 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.889:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=778 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.889:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=781 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.889:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=776 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.889:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=780 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.889:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="element-desktop" pid=789 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.890:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="crun" pid=787 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.890:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="devhelp" pid=788 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.890:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=777 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: audit: type=1400 audit(1794390386.890:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-checkns" pid=782 comm="apparmor_parser"
> Nov 11 17:46:26 ubuntu kernel: ipmi_si dmi-ipmi-si.0: IPMI bt interface initialized
> Nov 11 17:46:27 ubuntu kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
> Nov 11 17:46:27 ubuntu kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> Nov 11 17:46:27 ubuntu kernel: Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> Nov 11 17:46:27 ubuntu kernel: igb 0000:02:00.0 enp2s0f0: igb: enp2s0f0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> Nov 11 17:46:27 ubuntu kernel: NET: Registered PF_QIPCRTR protocol family
> Nov 11 17:46:27 ubuntu kernel: loop0: detected capacity change from 0 to 8
> Nov 11 17:46:57 ubuntu kernel: megaraid_sas 0000:03:00.0: 63774 (847705617s/0x0008/FATAL) - Battery has failed and cannot support data retention. Please replace the battery
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:1c.0: PCI bridge to [bus 05]
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:1c.2: PCI bridge to [bus 06]
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:1c.3: PCI bridge to [bus 07]
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945fffff]
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ffffff 64bit pref]
> Nov 11 17:47:01 ubuntu kernel: pci 0000:00:1e.0: PCI bridge to [bus 08]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: [18ca:0027] type 00 class 0x030000 PCIe Endpoint
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: BAR 0 [mem 0x00000000-0x03ffffff pref]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: BAR 1 [mem 0x00000000-0x0003ffff]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: BAR 2 [io  0x0000-0x007f]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: enabling Extended Tags
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: supports D1 D2
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: Adding to iommu group 55
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: vgaarb: setting as boot VGA device
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: vgaarb: bridge control possible
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:1c.0: PCI bridge to [bus 05]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:1c.2: PCI bridge to [bus 06]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: BAR 0 [mem size 0x04000000 pref]: can't assign; no space
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: BAR 0 [mem size 0x04000000 pref]: failed to assign
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: BAR 1 [mem 0x94500000-0x9453ffff]: assigned
> Nov 11 17:47:25 ubuntu kernel: pci 0000:07:00.0: BAR 2 [io  0x2000-0x207f]: assigned
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:1c.3: PCI bridge to [bus 07]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945fffff]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ffffff 64bit pref]
> Nov 11 17:47:25 ubuntu kernel: pci 0000:00:1e.0: PCI bridge to [bus 08]
> Nov 11 17:53:11 ubuntu kernel: EXT4-fs (sda2): unmounting filesystem 0dd1a269-6fa4-47bc-9673-1f83d2a7aeae.
> Nov 11 17:53:11 ubuntu systemd-shutdown[1]: Syncing filesystems and block devices.
> Nov 11 17:53:11 ubuntu systemd-shutdown[1]: Sending SIGTERM to remaining processes...
> Nov 11 17:53:11 ubuntu systemd-journald[491]: Received SIGTERM from PID 1 (systemd-shutdow).

