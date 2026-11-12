Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517913;
	b=SHguvnRwqm8aHwFTDgJyRH5Yt6U8DNMOmd64pDoQ9vssY5F02sHBhj+KhFS7YI5h2lO5
	 O3kc6gaoZXBPCo7jaDTi8bDX7R0B5cXrVpmCIWuM290YeQBK4NhDtRFZnFxt+E9xrTg6P
	 e5LlHO1f/towEFH+Hyp+nX4LC994CctlPN0bC2ZEXUiHhkqiOVgUXsCoksaVs2wgc1hBV
	 s2+CADMy+Ohtd6PG3PITnTqAaEE+mBVV5sIOn8knrXKHo8cRWUjsIgL5RdVn58aolMSHV
	 byEH9lKogyo1V8GHqrcrCAXv3N0rN0htKUigzBA3CbCpAp1gwjAY+7y+xXsmyOzLviw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517913;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HLDCxYsYp75w8K2QNrUkwKtoX9e1mpLb3OZbQIN+QKQ=;
	b=yUTyt5oMb85Ks3pL80rw6RponQdgGShL9mTWzR3dkkCbGady3PnfJLZTyRaHRb+3JcKZ
	 kmJOIfIuEU3QZe4YeUq3HOwtOBEqoE6QwBOYXr37oSlogNCjCBPeCNy/mNOeVv2UhzMob
	 n6NeMrH2KuXfKknvVpPU3O5MkWKLdAKAK3M5hGGUOgCx9bC6TCmENwpB9Rq+ff74TK0mR
	 PVjefa9y4Y11WdQ7KoTVqIad5P3LwvWDtRZvhu5sobl8qihPobO2MqPp2f44rJGbk2XFv
	 iOF6ng1oBXW/bJKb8vyhvwi+o+A8Ew8y2s8bvwwMmhTsuJ2kU2kaXRmIuqIs9sEafIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzaIeTtE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C30606A31C;
	Thu, 12 Nov 2026 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzaIeTtE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B401F000C4;
	Thu, 12 Nov 2026 21:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794517912;
	bh=HLDCxYsYp75w8K2QNrUkwKtoX9e1mpLb3OZbQIN+QKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OzaIeTtE3odD2ZQFoa+DWFY/u3a33V80rgTSFEivF47yfol3yWSnNDTMzoqwn/nKs
	 M/MNyMbL9f1MKGvApm3enefJ7NT6aHxHUs6Ceerb8upRvVY+xceWIUE8IsFiUvel+r
	 Lw8DskKDnC9XGd2VbyEVby9MleDDYnmziXbXnEGV5ziGHJA8I3MT4ZClbolHSMZGz/
	 Tl9lc8xxgpB4ownXo4iLdKs34C5yFn7yzSRtCmXdLFawKfnpwP9pYVEeqQ3xUHs941
	 nsyMHmHS1e+Jn8J+eoBsesBwVNqAmtw/FnaVtgWhUyfwqCLsax5PcrtK/jwsiRvhem
	 T//z2fwLMiJVQ==
Date: Thu, 12 Nov 2026 15:11:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: hh c <hhc436476@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@lists.ubuntu.com,
	"Maciej W.  Rozycki" <macro@orcam.me.uk>,
	regressions@lists.linux.dev
Subject: Re: 6.8.0-149: forced 2.5GT/s->5GT/s root-port retrain drops XGI Z11
 VGA off the bus, local console goes black
Message-ID: <20261112211151.GA893502@bhelgaas>
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
In-Reply-To: <CALJR0neXyeDb2t3j=CvdK42xwc6Afbo6kQfROedspHuWTZOq6g@mail.gmail.com>

[+cc Maciej, regressions list, -cc stable]

On Thu, Nov 12, 2026 at 09:28:25PM +0800, hh c wrote:
> > These results appear to be on Ubuntu kernels, which upstream has no
> > influence over.  If you can reproduce the issue with recent unmodified
> > upstream kernels, e.g., v7.3, please report as a regression.
> 
> Reproduced on vanilla v7.3.4 (upstream tarball, no patches), on the same
> machine model but a different unit, with a different BIOS (RMIBV519,
> 2018-06-22, versus RMIBV510, 2015-07-10 on the machine I first reported
> from), so this is not a one-off firmware or board artefact.

Initially reported at
https://lore.kernel.org/all/CALJR0nehJ5+d7MrPk8rxkNmee_1L5FFsvuF+-swK1nyJ7oJJ8A@mail.gmail.com
on an Ubuntu kernel and attributed to 72780f796468 ("PCI: Always lift
2.5GT/s restriction in PCIe failed link retraining"), though as far as
I can see it was not actually bisected to 72780f796468.

Thanks for confirming that it affects vanilla v7.3.4 (not just
Ubuntu).  It would be helpful if you could confirm that reverting
72780f796468 fixes it.

>   Linux 7.3.4-070304-generic #202611102049 SMP PREEMPT_DYNAMIC
>   Huawei XH320 V2, C600/X79 PCH, XGI Z11/Z11M VGA [18ca:0027]
> 
>   # lspci -nn | grep -i vga
>   (nothing)                       <- the VGA endpoint is never enumerated
>   # lspci -nn | wc -l
>   78                              <- 79 on a kernel that keeps the console
> 
>   # dmesg | grep -E '2.5GT/s|retrain'
>   pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
> 
>   # lspci -vv -s 00:1c.3
>   LnkCap:  Port #4, Speed 5GT/s, Width x1
>   LnkSta:  Speed 2.5GT/s, Width x1
>            DLActive-                       <- link is down after the retrain
>   LnkCtl2: Target Link Speed: 5GT/s        <- raised, and left raised
> 
> This is the case the existing "clamped port with no link" handling does
> not cover, and v7.3.4 shows it cleanly:
> 
>   - 00:1c.0 and 00:1c.2 (empty ports, target speed also clamped to
>     2.5GT/s) print nothing at all, so the early return for clamped ports
>     without a link does its job.
> 
>   - 00:1c.3 has DLLLA set, so that early return is skipped and the
>     unconditional lift is reached.  The fact that it printed "removing
>     2.5GT/s ..." at all proves the link was up: with the link down and
>     the target clamped, the function returns before the message.
> 
>   - pcie_set_target_speed() reports success, so no "retraining failed"
>     is printed and the firmware's target speed is never restored.  The
>     port ends up with the target raised to 5GT/s and DLActive clear, and
>     the endpoint is off the bus for the rest of the boot.
> 
> The clamp is the correct steady state here: LnkCap of 07:00.0 is
> 2.5GT/s, the PCH cannot train Gen2 against a Gen1-only endpoint, and the
> failed attempt takes the device down permanently - the display controller
> does not come back until a platform reset.  The console is black rather
> than merely blank because the firmware framebuffer sits inside the
> endpoint's own BAR, behind the dead link:
> 
>   90000000-93ffffff : 0000:07:00.0
>     90000000-9012bfff : BOOTFB
>       90000000-9012bfff : simpledrm
> 
> so the machine still boots and stays reachable over the network, with no
> local console at all.  Same behaviour as the distro kernel I originally
> reported, now on an unmodified upstream kernel.
> 
> Would a patch be acceptable that either (a) keeps the clamp when the
> downstream device advertises 2.5GT/s only, or (b) restores the previous
> target speed and retrains when the lift to a higher speed fails on a port
> that has a device behind it?  I have this machine available and can test
> a patch the same day.
> 
> Attached: full dmesg and lspci -vvv of 00:1c.3 from v7.3.4, plus the
> same from 6.8.0-31 where the console works.
> 
> Thanks,
> 
> Greg KH <greg@kroah.com> 于2026年11月12日周四 20:27写道：
> >
> > On Thu, Nov 12, 2026 at 12:09:07AM +0800, hh c wrote:
> > > After upgrading from 6.8.0-31 to 6.8.0-149 on a Huawei XH320 V2 (Romley
> > > platform, C600/X79 PCH), the local console goes black at kernel handover.
> > > The machine boots, SSH works, getty@tty1 is active. Booting the SAME
> > > installation into 6.8.0-31 restores both the console and the VGA device,
> > > so this is a regression in the 6.8 SRU stream, not a hardware or BMC fault.
> >
> > 6.8.0 is very old and obsolete and insecure.  Please use a newer kernel
> > version.
> >
> > > ROOT CAUSE
> > >
> > > 6.8.0-149 carries the stable backport of upstream commit 72780f796468
> >
> > ah, you are using a distro kernel.  Please file a bug with them.
> >
> > thanks,
> >
> > greg k-h

> 00:1c.3 PCI bridge: Intel Corporation C600/X79 series chipset PCI Express Root Port 4 (rev b6) (prog-if 00 [Normal decode])
> 	Subsystem: Huawei Technologies Co., Ltd. C600/X79 series chipset PCI Express Root Port 4
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin D routed to IRQ 33
> 	IOMMU group: 20
> 	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
> 	I/O behind bridge: 2000-2fff [size=4K] [16-bit]
> 	Memory behind bridge: 94500000-945fffff [size=1M] [32-bit]
> 	Prefetchable memory behind bridge: 90000000-93ffffff [size=64M] [32-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
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
> 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 			Slot #3, PowerLimit 10W; Interlock- NoCompl+
> 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 			Changed: MRL- PresDet+ LinkState+
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
> 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: fee00378  Data: 0000
> 	Capabilities: [90] Subsystem: Huawei Technologies Co., Ltd. C600/X79 series chipset PCI Express Root Port 4
> 	Capabilities: [a0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
> 

> [    0.000000] Linux version 7.3.4-070304-generic (kernel@balboa) (x86_64-linux-gnu-gcc-15 (Ubuntu 15.3.0-4ubuntu1) 15.3.0, GNU ld (GNU Binutils for Ubuntu) 2.47) #202611102049 SMP PREEMPT_DYNAMIC Wed Nov 11 00:34:56 UTC 2026
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-7.3.4-070304-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai  
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cfff]  System RAM
> [    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff]  device reserved
> [    0.000000] BIOS-e820: [gap 0x00000000000a0000-0x00000000000dffff]
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]  device reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff]  System RAM
> [    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000400fffff]  device reserved
> [    0.000000] BIOS-e820: [mem 0x0000000040100000-0x000000007e4fefff]  System RAM
> [    0.000000] BIOS-e820: [mem 0x000000007e4ff000-0x000000007e8fefff]  device reserved
> [    0.000000] BIOS-e820: [mem 0x000000007e8ff000-0x000000007eefefff]  ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000007eeff000-0x000000007effefff]  ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000007efff000-0x000000007effffff]  System RAM
> [    0.000000] BIOS-e820: [mem 0x000000007f000000-0x000000008fffffff]  device reserved
> [    0.000000] BIOS-e820: [gap 0x0000000090000000-0x00000000feafffff]
> [    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb03fff]  device reserved
> [    0.000000] BIOS-e820: [gap 0x00000000feb04000-0x00000000febfffff]
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]  device reserved
> [    0.000000] BIOS-e820: [gap 0x00000000fec01000-0x00000000fed17fff]
> [    0.000000] BIOS-e820: [mem 0x00000000fed18000-0x00000000fed18fff]  device reserved
> [    0.000000] BIOS-e820: [gap 0x00000000fed19000-0x00000000fed1bfff]
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed8ffff]  device reserved
> [    0.000000] BIOS-e820: [gap 0x00000000fed90000-0x00000000fedfffff]
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]  device reserved
> [    0.000000] BIOS-e820: [gap 0x00000000fee01000-0x00000000ffbfffff]
> [    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff]  device reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff]  System RAM
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] DMI: SMBIOS 2.7 present.
> [    0.000000] DMI: Huawei Technologies Co., Ltd. XH320 V2/BC21RCSA0, BIOS RMIBV519 06/22/2018
> [    0.000000] DMI: Memory slots populated: 1/12
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 1800.068 MHz processor
> [    0.002117] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved
> [    0.002122] e820: remove [mem 0x000a0000-0x000fffff] System RAM
> [    0.002137] last_pfn = 0x480000 max_arch_pfn = 0x400000000
> [    0.002151] MTRR map: 9 entries (4 fixed + 5 variable; max 24), built from 10 variable MTRRs
> [    0.002155] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.002646] last_pfn = 0x7f000 max_arch_pfn = 0x400000000
> [    0.020904] found SMP MP-table at [mem 0x000fe1b0-0x000fe1bf]
> [    0.020934] Using GB pages for direct mapping
> [    0.021464] RAMDISK: [mem 0x2f775000-0x33bb1fff]
> [    0.022505] ACPI: Early table checksum verification disabled
> [    0.022513] ACPI: RSDP 0x00000000000FE020 000024 (v02 INSYDE)
> [    0.022521] ACPI: XSDT 0x000000007EFFE170 0000AC (v01 INSYDE Romley   00000001      01000013)
> [    0.022553] ACPI: FACP 0x000000007EFFB000 0000F4 (v04 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022598] ACPI: DSDT 0x000000007EFE9000 00DEE2 (v01 INSYDE Romley   00000000 ACPI 00040000)
> [    0.022604] ACPI: FACS 0x000000007ED89000 000040
> [    0.022609] ACPI: FACS 0x000000007ED89000 000040
> [    0.022615] ACPI: SPMI 0x000000007EFFD000 000040 (v05 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022623] ACPI: BOOT 0x000000007EFFC000 000028 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022629] ACPI: APIC 0x000000007EFF9000 000BAA (v03 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022636] ACPI: MCFG 0x000000007EFF8000 00003C (v01 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022643] ACPI: SLIC 0x000000007EFF7000 000176 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022650] ACPI: BDAT 0x000000007EFE8000 000030 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022657] ACPI: PRAD 0x000000007EFE7000 0000BC (v02 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022664] ACPI: MSDM 0x000000007EFE6000 000055 (v03 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022671] ACPI: SSDT 0x000000007EF12000 0D3050 (v02 INSYDE Romley   00004000 ACPI 00040000)
> [    0.022678] ACPI: HPET 0x000000007EFFA000 000038 (v01 INSYDE Romley   00000001 ACPI 00040000)
> [    0.022685] ACPI: WDAT 0x000000007EF11000 000194 (v01 INSYDE INSYDE   00000001 MSFT 01000013)
> [    0.022692] ACPI: DMAR 0x000000007EF10000 0000A0 (v01 INSYDE Romley   00000001 ACPI 00000001)
> [    0.022699] ACPI: HEST 0x000000007EF0F000 0000A8 (v01 INSYDE Romley   00000001 ?    00000001)
> [    0.022706] ACPI: ERST 0x000000007EF0E000 000230 (v01 INSYDE Romley   00000001 ?    00000001)
> [    0.022713] ACPI: BERT 0x000000007EF0D000 000030 (v01 INSYDE Romley   00000001 ?    00000001)
> [    0.022720] ACPI: EINJ 0x000000007EF0C000 000130 (v01 INSYDE Romley   00000001 ?    00000001)
> [    0.022724] ACPI: Reserving FACP table memory at [mem 0x7effb000-0x7effb0f3]
> [    0.022727] ACPI: Reserving DSDT table memory at [mem 0x7efe9000-0x7eff6ee1]
> [    0.022728] ACPI: Reserving FACS table memory at [mem 0x7ed89000-0x7ed8903f]
> [    0.022730] ACPI: Reserving FACS table memory at [mem 0x7ed89000-0x7ed8903f]
> [    0.022732] ACPI: Reserving SPMI table memory at [mem 0x7effd000-0x7effd03f]
> [    0.022733] ACPI: Reserving BOOT table memory at [mem 0x7effc000-0x7effc027]
> [    0.022735] ACPI: Reserving APIC table memory at [mem 0x7eff9000-0x7eff9ba9]
> [    0.022736] ACPI: Reserving MCFG table memory at [mem 0x7eff8000-0x7eff803b]
> [    0.022738] ACPI: Reserving SLIC table memory at [mem 0x7eff7000-0x7eff7175]
> [    0.022739] ACPI: Reserving BDAT table memory at [mem 0x7efe8000-0x7efe802f]
> [    0.022741] ACPI: Reserving PRAD table memory at [mem 0x7efe7000-0x7efe70bb]
> [    0.022742] ACPI: Reserving MSDM table memory at [mem 0x7efe6000-0x7efe6054]
> [    0.022744] ACPI: Reserving SSDT table memory at [mem 0x7ef12000-0x7efe504f]
> [    0.022745] ACPI: Reserving HPET table memory at [mem 0x7effa000-0x7effa037]
> [    0.022747] ACPI: Reserving WDAT table memory at [mem 0x7ef11000-0x7ef11193]
> [    0.022748] ACPI: Reserving DMAR table memory at [mem 0x7ef10000-0x7ef1009f]
> [    0.022750] ACPI: Reserving HEST table memory at [mem 0x7ef0f000-0x7ef0f0a7]
> [    0.022751] ACPI: Reserving ERST table memory at [mem 0x7ef0e000-0x7ef0e22f]
> [    0.022753] ACPI: Reserving BERT table memory at [mem 0x7ef0d000-0x7ef0d02f]
> [    0.022754] ACPI: Reserving EINJ table memory at [mem 0x7ef0c000-0x7ef0c12f]
> [    0.022998] No NUMA configuration found
> [    0.023000] Faking a node at [mem 0x0000000000000000-0x000000047fffffff]
> [    0.023015] NODE_DATA(0) allocated [mem 0x47ffd4f80-0x47fffffff]
> [    0.023684] ACPI: PM-Timer IO Port: 0x408
> [    0.024056] ACPI: X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> [    0.024118] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.024187] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    0.024195] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
> [    0.024257] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.024262] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.024385] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.024388] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.024393] TSC deadline timer available
> [    0.024398] CPU topo: Max. logical packages:   1
> [    0.024400] CPU topo: Max. logical nodes:      1
> [    0.024401] CPU topo: Num. nodes per package:  1
> [    0.024406] CPU topo: Max. logical dies:       1
> [    0.024407] CPU topo: Max. dies per package:   1
> [    0.024416] CPU topo: Max. threads per core:   2
> [    0.024417] CPU topo: Num. cores per package:     8
> [    0.024419] CPU topo: Num. threads per package:  16
> [    0.024420] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
> [    0.024447] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.024451] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x000fffff]
> [    0.024454] PM: hibernation: Registered nosave memory: [mem 0x40000000-0x400fffff]
> [    0.024457] PM: hibernation: Registered nosave memory: [mem 0x7e4ff000-0x7effefff]
> [    0.024460] PM: hibernation: Registered nosave memory: [mem 0x7f000000-0xffffffff]
> [    0.024463] [gap 0x90000000-0xfeafffff] available for PCI devices
> [    0.024465] Booting paravirtualized kernel on bare hardware
> [    0.024468] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.024475] Zone ranges:
> [    0.024476]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.024479]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.024482]   Normal   [mem 0x0000000100000000-0x000000047fffffff]
> [    0.024485]   Device   empty
> [    0.024487] Movable zone start for each node
> [    0.024492] Early memory node ranges
> [    0.024493]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
> [    0.024495]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
> [    0.024497]   node   0: [mem 0x0000000040100000-0x000000007e4fefff]
> [    0.024499]   node   0: [mem 0x000000007efff000-0x000000007effffff]
> [    0.024500]   node   0: [mem 0x0000000100000000-0x000000047fffffff]
> [    0.024502] Initmem setup node 0 [mem 0x0000000000001000-0x000000047fffffff]
> [    0.024797] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.024874] On node 0, zone DMA: 99 pages in unavailable ranges
> [    0.034241] On node 0, zone DMA32: 256 pages in unavailable ranges
> [    0.034319] On node 0, zone DMA32: 2816 pages in unavailable ranges
> [    0.113921] On node 0, zone Normal: 4096 pages in unavailable ranges
> [    0.113962] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
> [    0.117212] percpu: Embedded 85 pages/cpu s225280 r8192 d114688 u524288
> [    0.117225] pcpu-alloc: s225280 r8192 d114688 u524288 alloc=1*2097152
> [    0.117229] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
> [    0.117239] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
> [    0.117280] Kernel command line: BOOT_IMAGE=/vmlinuz-7.3.4-070304-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro
> [    0.117340] printk: log buffer data + meta data: 262144 + 1114112 = 1376256 bytes
> [    0.123118] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.125961] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.126492] software IO TLB: area num 16.
> [    0.172567] Fallback order for Node 0: 0 
> [    0.172582] Built 1 zonelists, mobility grouping on.  Total pages: 4187036
> [    0.172585] Policy zone: Normal
> [    0.172603] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.369742] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
> [    0.370064] Kernel/User page tables isolation: enabled
> [    0.389635] ftrace: allocating 65147 entries in 256 pages
> [    0.389638] ftrace: allocated 256 pages with 1 groups
> [    0.391173] Dynamic Preempt: lazy
> [    0.391661] rcu: Preemptible hierarchical RCU implementation.
> [    0.391664] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
> [    0.391667] 	Trampoline variant of Tasks RCU enabled.
> [    0.391668] 	Rude variant of Tasks RCU enabled.
> [    0.391669] 	Tracing variant of Tasks RCU enabled.
> [    0.391670] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.391671] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> [    0.391709] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> [    0.391715] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> [    0.410928] NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
> [    0.411262] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.411311] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.411612] Console: colour dummy device 80x25
> [    0.411618] printk: legacy console [tty0] enabled
> [    0.412637] ACPI: Core revision 20260408
> [    0.519863] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [    0.519887] APIC: Switch to symmetric I/O mode setup
> [    0.519894] DMAR: Host address width 46
> [    0.519899] DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
> [    0.519930] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0462 ecap f020fe
> [    0.519940] DMAR: ATSR flags: 0x0
> [    0.519964] DMAR: RMRR base: 0x0000007e8b5000 end: 0x0000007e8bbfff
> [    0.519987] DMAR-IR: IOAPIC id 8 under DRHD base  0xfbffc000 IOMMU 0
> [    0.519993] DMAR-IR: IOAPIC id 9 under DRHD base  0xfbffc000 IOMMU 0
> [    0.519999] DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
> [    0.520005] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
> [    0.520006] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
> [    0.520871] DMAR-IR: Enabled IRQ remapping in xapic mode
> [    0.520879] x2apic: IRQ remapping doesn't support X2APIC mode
> [    0.521466] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.525888] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x19f269ebae4, max_idle_ns: 440795252871 ns
> [    0.525904] Calibrating delay loop (skipped), value calculated using timer frequency.. 3600.13 BogoMIPS (lpj=1800068)
> [    0.525955] CPU0: Thermal monitoring enabled (TM1)
> [    0.526059] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> [    0.526067] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> [    0.526102] process: using mwait in idle threads
> [    0.526109] mitigations: Enabled attack vectors: user_kernel, user_user, guest_host, guest_guest, SMT mitigations: auto
> [    0.526124] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.526131] Spectre V2 : Mitigation: Retpolines
> [    0.526136] Spectre V2 : User space: Mitigation: STIBP via prctl
> [    0.526141] MDS: Mitigation: Clear CPU buffers
> [    0.526145] VMSCAPE: Mitigation: IBPB before exit to userspace
> [    0.526150] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.526157] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
> [    0.526163] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.526169] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.526186] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.526193] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.526198] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.526204] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.526209] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [    0.576101] pid_max: default: 32768 minimum: 301
> [    0.577945] landlock: Up and running.
> [    0.577953] Yama: becoming mindful.
> [    0.578157] AppArmor: AppArmor initialized
> [    0.578485] LSM support for eBPF active
> [    0.579539] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.579581] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.580049] VFS: Finished mounting rootfs on nullfs
> [    0.582087] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2450L 0 @ 1.80GHz (family: 0x6, model: 0x2d, stepping: 0x7)
> [    0.582710] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
> [    0.582751] ... version:                   3
> [    0.582756] ... bit width:                 48
> [    0.582760] ... generic counters:          4
> [    0.582764] ... generic bitmap:            000000000000000f
> [    0.582769] ... fixed-purpose counters:    3
> [    0.582773] ... fixed-purpose bitmap:      0000000000000007
> [    0.582777] ... value mask:                0000ffffffffffff
> [    0.582782] ... max period:                00007fffffffffff
> [    0.582786] ... global_ctrl mask:          000000070000000f
> [    0.583143] signal: max sigframe size: 1776
> [    0.583181] Estimated ratio of average max frequency by base frequency (times 1024): 1024
> [    0.585615] rcu: Hierarchical SRCU implementation.
> [    0.585624] rcu: 	Max phase no-delay instances is 400.
> [    0.585801] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
> [    0.587677] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.588120] smp: Bringing up secondary CPUs ...
> [    0.588485] smpboot: x86: Booting SMP configuration:
> [    0.588493] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
> [    0.605278] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.605278] VMSCAPE: SMT on, STIBP is required for full protection. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/vmscape.html for more details.
> [    0.612023] smp: Brought up 1 node, 16 CPUs
> [    0.612023] smpboot: Total of 16 processors activated (57602.17 BogoMIPS)
> [    0.613261] Memory: 16230900K/16748144K available (24388K kernel code, 4959K rwdata, 17724K rodata, 5468K init, 5728K bss, 488800K reserved, 0K cma-reserved)
> [    0.615075] devtmpfs: initialized
> [    0.615075] x86/mm: Memory block size: 128MB
> [    0.619317] ACPI: PM: Registering ACPI NVS region [mem 0x7e8ff000-0x7eefefff] (6291456 bytes)
> [    0.619317] posixtimers hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.619317] futex hash table entries: 4096 (262144 bytes on 1 NUMA nodes, total 256 KiB, linear).
> [    0.621640] PM: RTC time: 13:00:07, date: 2026-11-12
> [    0.622878] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.623362] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.623563] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.623762] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.623783] audit: initializing netlink subsys (disabled)
> [    0.623811] audit: type=2000 audit(1794488407.103:1): state=initialized audit_enabled=0 res=1
> [    0.653169] thermal_sys: Registered thermal governor 'fair_share'
> [    0.653178] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.653190] thermal_sys: Registered thermal governor 'step_wise'
> [    0.653195] thermal_sys: Registered thermal governor 'user_space'
> [    0.653199] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.653236] cpuidle: using governor ladder
> [    0.653236] cpuidle: using governor menu
> [    0.653236] Simple Boot Flag at 0x44 set to 0x1
> [    0.653236] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.653236] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.654109] PCI: ECAM [mem 0x80000000-0x8fffffff] (base 0x80000000) for domain 0000 [bus 00-ff]
> [    0.654152] PCI: Using configuration type 1 for base access
> [    0.654223] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
> [    0.654231] mtrr: your CPUs had inconsistent variable MTRR settings
> [    0.654235] mtrr: probably your BIOS does not setup all CPUs.
> [    0.654240] mtrr: corrected configuration.
> [    0.654244] virt/tdx: TDX not supported by the host platform
> [    0.654310] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.660981] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.660981] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.660981] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.660981] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.670589] fbcon: Taking over console
> [    0.670739] ACPI: Added _OSI(Module Device)
> [    0.670750] ACPI: Added _OSI(Processor Device)
> [    0.670758] ACPI: Added _OSI(Processor Aggregator Device)
> [    1.019541] ACPI: 2 ACPI AML tables successfully acquired and loaded
> [    1.051086] ACPI: \_SB_: platform _OSC: OS support mask [006e7eff]
> [    1.052091] ACPI: \_SB_: platform _OSC: OS control mask [006e7eff]
> [    1.093301] ACPI: Interpreter enabled
> [    1.093356] ACPI: PM: (supports S0 S4 S5)
> [    1.093362] ACPI: Using IOAPIC for interrupt routing
> [    1.099664] HEST: Table parsing has been initialized.
> [    1.099927] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> [    1.099942] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    1.099949] PCI: Using E820 reservations for host bridge windows
> [    1.100880] ACPI: Enabled 7 GPEs in block 00 to 3F
> [    1.145817] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    1.145837] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    1.146802] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
> [    1.146813] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    1.148360] PCI host bridge to bus 0000:00
> [    1.148374] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    1.148382] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
> [    1.148389] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    1.148396] pci_bus 0000:00: root bus resource [mem 0x90000000-0xfbffefff window]
> [    1.148404] pci_bus 0000:00: root bus resource [bus 00-fe]
> [    1.148450] pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000 PCIe Root Port
> [    1.148555] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    1.148734] pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400 PCIe Root Port
> [    1.148767] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    1.148864] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    1.149147] pci 0000:00:01.1: [8086:3c03] type 01 class 0x060400 PCIe Root Port
> [    1.149181] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    1.149189] pci 0000:00:01.1:   bridge window [io  0x5000-0x5fff]
> [    1.149198] pci 0000:00:01.1:   bridge window [mem 0x94800000-0x948fffff]
> [    1.149290] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
> [    1.149557] pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400 PCIe Root Port
> [    1.149590] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    1.149598] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
> [    1.149606] pci 0000:00:03.0:   bridge window [mem 0x94700000-0x947fffff]
> [    1.149628] pci 0000:00:03.0: enabling Extended Tags
> [    1.149709] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [    1.149933] pci 0000:00:04.0: [8086:3c20] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.149980] pci 0000:00:04.0: BAR 0 [mem 0x94900000-0x94903fff 64bit]
> [    1.150135] pci 0000:00:04.1: [8086:3c21] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.150181] pci 0000:00:04.1: BAR 0 [mem 0x94904000-0x94907fff 64bit]
> [    1.150329] pci 0000:00:04.2: [8086:3c22] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.150374] pci 0000:00:04.2: BAR 0 [mem 0x94908000-0x9490bfff 64bit]
> [    1.150521] pci 0000:00:04.3: [8086:3c23] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.150566] pci 0000:00:04.3: BAR 0 [mem 0x9490c000-0x9490ffff 64bit]
> [    1.150718] pci 0000:00:04.4: [8086:3c24] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.150763] pci 0000:00:04.4: BAR 0 [mem 0x94910000-0x94913fff 64bit]
> [    1.150911] pci 0000:00:04.5: [8086:3c25] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.150957] pci 0000:00:04.5: BAR 0 [mem 0x94914000-0x94917fff 64bit]
> [    1.151104] pci 0000:00:04.6: [8086:3c26] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.151149] pci 0000:00:04.6: BAR 0 [mem 0x94918000-0x9491bfff 64bit]
> [    1.151294] pci 0000:00:04.7: [8086:3c27] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.151339] pci 0000:00:04.7: BAR 0 [mem 0x9491c000-0x9491ffff 64bit]
> [    1.151489] pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.151709] pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.151876] pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020 conventional PCI endpoint
> [    1.151919] pci 0000:00:05.4: BAR 0 [mem 0x94928000-0x94928fff]
> [    1.152064] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400 PCIe Root Port
> [    1.152104] pci 0000:00:11.0: PCI bridge to [bus 04]
> [    1.152114] pci 0000:00:11.0:   bridge window [io  0x3000-0x3fff]
> [    1.152122] pci 0000:00:11.0:   bridge window [mem 0x94600000-0x946fffff]
> [    1.152140] pci 0000:00:11.0:   bridge window [mem 0x94000000-0x944fffff 64bit pref]
> [    1.152226] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
> [    1.152442] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000 conventional PCI endpoint
> [    1.152492] pci 0000:00:16.0: BAR 0 [mem 0x94920000-0x9492000f 64bit]
> [    1.152539] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> [    1.152681] pci 0000:00:16.1: [8086:1d3b] type 00 class 0x078000 conventional PCI endpoint
> [    1.152730] pci 0000:00:16.1: BAR 0 [mem 0x94921000-0x9492100f 64bit]
> [    1.152777] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
> [    1.152948] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320 conventional PCI endpoint
> [    1.153829] pci 0000:00:1a.0: BAR 0 [mem 0x94926000-0x949263ff]
> [    1.153891] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> [    1.154050] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400 PCIe Root Port
> [    1.154088] pci 0000:00:1c.0: PCI bridge to [bus 05]
> [    1.154179] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    1.154376] pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400 PCIe Root Port
> [    1.154413] pci 0000:00:1c.2: PCI bridge to [bus 06]
> [    1.154503] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> [    1.154698] pci 0000:00:1c.3: [8086:1d16] type 01 class 0x060400 PCIe Root Port
> [    1.154735] pci 0000:00:1c.3: PCI bridge to [bus 07]
> [    1.154744] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> [    1.154753] pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945fffff]
> [    1.154769] pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ffffff 64bit pref]
> [    1.154801] pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
> [    1.154863] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> [    1.155056] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320 conventional PCI endpoint
> [    1.155906] pci 0000:00:1d.0: BAR 0 [mem 0x94925000-0x949253ff]
> [    1.155968] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    1.156124] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401 conventional PCI bridge
> [    1.156157] pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive decode)
> [    1.156347] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100 conventional PCI endpoint
> [    1.156605] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601 conventional PCI endpoint
> [    1.156650] pci 0000:00:1f.2: BAR 0 [io  0x6048-0x604f]
> [    1.156657] pci 0000:00:1f.2: BAR 1 [io  0x605c-0x605f]
> [    1.156663] pci 0000:00:1f.2: BAR 2 [io  0x6040-0x6047]
> [    1.156670] pci 0000:00:1f.2: BAR 3 [io  0x6058-0x605b]
> [    1.156676] pci 0000:00:1f.2: BAR 4 [io  0x6020-0x603f]
> [    1.156683] pci 0000:00:1f.2: BAR 5 [mem 0x94924000-0x949247ff]
> [    1.156730] pci 0000:00:1f.2: PME# supported from D3hot
> [    1.156867] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500 conventional PCI endpoint
> [    1.156916] pci 0000:00:1f.3: BAR 0 [mem 0x94922000-0x949220ff 64bit]
> [    1.156927] pci 0000:00:1f.3: BAR 4 [io  0x6000-0x601f]
> [    1.157029] pci 0000:00:1f.6: [8086:1d24] type 00 class 0x118000 conventional PCI endpoint
> [    1.157084] pci 0000:00:1f.6: BAR 0 [mem 0x94923000-0x94923fff 64bit]
> [    1.157256] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    1.157365] pci 0000:02:00.0: [8086:1521] type 00 class 0x020000 PCIe Endpoint
> [    1.157408] pci 0000:02:00.0: BAR 0 [mem 0x94820000-0x9483ffff]
> [    1.157416] pci 0000:02:00.0: BAR 2 [io  0x5020-0x503f]
> [    1.157423] pci 0000:02:00.0: BAR 3 [mem 0x94844000-0x94847fff]
> [    1.157510] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    1.157552] pci 0000:02:00.0: VF BAR 0 [mem 0x00000000-0x00003fff 64bit pref]
> [    1.157559] pci 0000:02:00.0: VF BAR 0 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 0 for 8 VFs
> [    1.157570] pci 0000:02:00.0: VF BAR 3 [mem 0x00000000-0x00003fff 64bit pref]
> [    1.157576] pci 0000:02:00.0: VF BAR 3 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 3 for 8 VFs
> [    1.157790] pci 0000:02:00.1: [8086:1521] type 00 class 0x020000 PCIe Endpoint
> [    1.157833] pci 0000:02:00.1: BAR 0 [mem 0x94800000-0x9481ffff]
> [    1.157842] pci 0000:02:00.1: BAR 2 [io  0x5000-0x501f]
> [    1.157848] pci 0000:02:00.1: BAR 3 [mem 0x94840000-0x94843fff]
> [    1.157930] pci 0000:02:00.1: PME# supported from D0 D3hot D3cold
> [    1.157968] pci 0000:02:00.1: VF BAR 0 [mem 0x00000000-0x00003fff 64bit pref]
> [    1.157975] pci 0000:02:00.1: VF BAR 0 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 0 for 8 VFs
> [    1.157985] pci 0000:02:00.1: VF BAR 3 [mem 0x00000000-0x00003fff 64bit pref]
> [    1.157991] pci 0000:02:00.1: VF BAR 3 [mem 0x00000000-0x0001ffff 64bit pref]: contains BAR 3 for 8 VFs
> [    1.158178] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    1.158275] pci 0000:03:00.0: [1000:005b] type 00 class 0x010400 PCIe Endpoint
> [    1.158312] pci 0000:03:00.0: BAR 0 [io  0x4000-0x40ff]
> [    1.158319] pci 0000:03:00.0: BAR 1 [mem 0x94740000-0x94743fff 64bit]
> [    1.158327] pci 0000:03:00.0: BAR 3 [mem 0x94700000-0x9473ffff 64bit]
> [    1.158334] pci 0000:03:00.0: ROM [mem 0xfffe0000-0xffffffff pref]
> [    1.158345] pci 0000:03:00.0: enabling Extended Tags
> [    1.158367] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
> [    1.158413] pci 0000:03:00.0: supports D1 D2
> [    1.158541] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    1.158655] pci 0000:04:00.0: [8086:1d6b] type 00 class 0x010700 PCIe Endpoint
> [    1.158709] pci 0000:04:00.0: BAR 0 [mem 0x94400000-0x94403fff 64bit pref]
> [    1.158718] pci 0000:04:00.0: BAR 2 [mem 0x94000000-0x943fffff 64bit pref]
> [    1.158725] pci 0000:04:00.0: BAR 4 [io  0x3000-0x30ff]
> [    1.158741] pci 0000:04:00.0: enabling Extended Tags
> [    1.158865] pci 0000:04:00.0: VF BAR 0 [mem 0x00000000-0x00003fff 64bit pref]
> [    1.158871] pci 0000:04:00.0: VF BAR 0 [mem 0x00000000-0x0007bfff 64bit pref]: contains BAR 0 for 31 VFs
> [    1.159207] pci 0000:04:00.3: [8086:1d70] type 00 class 0x0c0500 PCIe Endpoint
> [    1.159265] pci 0000:04:00.3: BAR 0 [mem 0x94600000-0x94600fff]
> [    1.159277] pci 0000:04:00.3: BAR 4 [io  0x3100-0x311f]
> [    1.159353] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> [    1.159485] pci 0000:00:11.0: PCI bridge to [bus 04]
> [    1.159581] pci 0000:00:1c.0: PCI bridge to [bus 05]
> [    1.159677] pci 0000:00:1c.2: PCI bridge to [bus 06]
> [    1.159908] pci 0000:00:1c.3: PCI bridge to [bus 07]
> [    1.159945] pci_bus 0000:08: extended config space not accessible
> [    1.160037] pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive decode)
> [    1.160053] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
> [    1.160061] pci 0000:00:1e.0:   bridge window [io  0x1000-0xffff window] (subtractive decode)
> [    1.160068] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [    1.160076] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xfbffefff window] (subtractive decode)
> [    1.161984] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
> [    1.162204] PCI host bridge to bus 0000:ff
> [    1.162215] pci_bus 0000:ff: root bus resource [bus ff]
> [    1.162236] pci 0000:ff:08.0: [8086:3c80] type 00 class 0x088000 conventional PCI endpoint
> [    1.162353] pci 0000:ff:08.3: [8086:3c83] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.162483] pci 0000:ff:08.4: [8086:3c84] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.162607] pci 0000:ff:09.0: [8086:3c90] type 00 class 0x088000 conventional PCI endpoint
> [    1.162713] pci 0000:ff:09.3: [8086:3c93] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.162836] pci 0000:ff:09.4: [8086:3c94] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.162961] pci 0000:ff:0a.0: [8086:3cc0] type 00 class 0x088000 conventional PCI endpoint
> [    1.163064] pci 0000:ff:0a.1: [8086:3cc1] type 00 class 0x088000 conventional PCI endpoint
> [    1.163157] pci 0000:ff:0a.2: [8086:3cc2] type 00 class 0x088000 conventional PCI endpoint
> [    1.163241] pci 0000:ff:0a.3: [8086:3cd0] type 00 class 0x088000 conventional PCI endpoint
> [    1.163334] pci 0000:ff:0b.0: [8086:3ce0] type 00 class 0x088000 conventional PCI endpoint
> [    1.163425] pci 0000:ff:0b.3: [8086:3ce3] type 00 class 0x088000 conventional PCI endpoint
> [    1.163509] pci 0000:ff:0c.0: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.163599] pci 0000:ff:0c.1: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.163690] pci 0000:ff:0c.2: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.163781] pci 0000:ff:0c.3: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.163872] pci 0000:ff:0c.6: [8086:3cf4] type 00 class 0x088000 conventional PCI endpoint
> [    1.164026] pci 0000:ff:0c.7: [8086:3cf6] type 00 class 0x088000 conventional PCI endpoint
> [    1.164120] pci 0000:ff:0d.0: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.164204] pci 0000:ff:0d.1: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.164295] pci 0000:ff:0d.2: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.164385] pci 0000:ff:0d.3: [8086:3ce8] type 00 class 0x088000 conventional PCI endpoint
> [    1.164476] pci 0000:ff:0d.6: [8086:3cf5] type 00 class 0x088000 conventional PCI endpoint
> [    1.164577] pci 0000:ff:0e.0: [8086:3ca0] type 00 class 0x088000 conventional PCI endpoint
> [    1.164673] pci 0000:ff:0e.1: [8086:3c46] type 00 class 0x110100 conventional PCI endpoint
> [    1.164770] pci 0000:ff:0f.0: [8086:3ca8] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.164896] pci 0000:ff:0f.1: [8086:3c71] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165023] pci 0000:ff:0f.2: [8086:3caa] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165149] pci 0000:ff:0f.3: [8086:3cab] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165266] pci 0000:ff:0f.4: [8086:3cac] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165389] pci 0000:ff:0f.5: [8086:3cad] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165516] pci 0000:ff:0f.6: [8086:3cae] type 00 class 0x088000 conventional PCI endpoint
> [    1.165620] pci 0000:ff:10.0: [8086:3cb0] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165738] pci 0000:ff:10.1: [8086:3cb1] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165863] pci 0000:ff:10.2: [8086:3cb2] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.165999] pci 0000:ff:10.3: [8086:3cb3] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.166118] pci 0000:ff:10.5: [8086:3cb5] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.166244] pci 0000:ff:10.6: [8086:3cb6] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.166369] pci 0000:ff:10.7: [8086:3cb7] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [    1.166497] pci 0000:ff:11.0: [8086:3cb8] type 00 class 0x088000 conventional PCI endpoint
> [    1.166596] pci 0000:ff:13.0: [8086:3ce4] type 00 class 0x088000 conventional PCI endpoint
> [    1.166692] pci 0000:ff:13.1: [8086:3c43] type 00 class 0x110100 conventional PCI endpoint
> [    1.166787] pci 0000:ff:13.4: [8086:3ce6] type 00 class 0x110100 conventional PCI endpoint
> [    1.166880] pci 0000:ff:13.5: [8086:3c44] type 00 class 0x110100 conventional PCI endpoint
> [    1.166976] pci 0000:ff:13.6: [8086:3c45] type 00 class 0x088000 conventional PCI endpoint
> [    1.176151] ACPI: PCI: Interrupt link LNKA configured for IRQ 3
> [    1.176293] ACPI: PCI: Interrupt link LNKB configured for IRQ 5
> [    1.176426] ACPI: PCI: Interrupt link LNKC configured for IRQ 6
> [    1.176557] ACPI: PCI: Interrupt link LNKD configured for IRQ 7
> [    1.176685] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> [    1.176692] ACPI: PCI: Interrupt link LNKE disabled
> [    1.176820] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
> [    1.176956] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> [    1.176963] ACPI: PCI: Interrupt link LNKG disabled
> [    1.177091] ACPI: PCI: Interrupt link LNKH configured for IRQ 9
> [    1.177404] iommu: Default domain type: Translated
> [    1.177404] iommu: DMA domain TLB invalidation policy: lazy mode
> [    1.178353] SCSI subsystem initialized
> [    1.178377] libata version 3.00 loaded.
> [    1.178377] ACPI: bus type USB registered
> [    1.178377] usbcore: registered new interface driver usbfs
> [    1.178377] usbcore: registered new interface driver hub
> [    1.178377] usbcore: registered new device driver usb
> [    1.178377] pps_core: LinuxPPS API ver. 1 registered
> [    1.178377] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    1.178377] PTP clock support registered
> [    1.178939] EDAC MC: Ver: 3.0.0
> [    1.180014] NetLabel: Initializing
> [    1.180022] NetLabel:  domain hash size = 128
> [    1.180027] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    1.180059] NetLabel:  unlabeled traffic allowed by default
> [    1.180097] mctp: management component transport protocol core
> [    1.180097] NET: Registered PF_MCTP protocol family
> [    1.180097] PCI: Using ACPI for IRQ routing
> [    1.187309] PCI: pci_cache_line_size set to 64 bytes
> [    1.187453] e820: register RAM buffer resource [mem 0x0009d000-0x0009ffff]
> [    1.187461] e820: register RAM buffer resource [mem 0x7e4ff000-0x7fffffff]
> [    1.187467] e820: register RAM buffer resource [mem 0x7f000000-0x7fffffff]
> [    1.187505] vgaarb: loaded
> [    1.189066] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    1.189066] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> [    1.190970] clocksource: Switched to clocksource tsc-early
> [    1.192158] VFS: Disk quotas dquot_6.6.0
> [    1.192266] VFS: Dquot-cache hash table entries: 512 (4096 bytes)
> [    1.192701] AppArmor: AppArmor Filesystem Enabled
> [    1.192893] acpi PNP0C02:00: Reserved [mem 0xfed1c000-0xfed1ffff]
> [    1.192917] acpi PNP0C02:00: Reserved [mem 0xfbfff000-0xfbffffff]
> [    1.192925] acpi PNP0C02:00: Reserved [mem 0xfed20000-0xfed3ffff]
> [    1.192932] acpi PNP0C02:00: Could not reserve [mem 0xfbffc000-0xfbffdfff]
> [    1.192938] acpi PNP0C02:00: Could not reserve [mem 0xff000000-0xffffffff]
> [    1.192944] acpi PNP0C02:00: Could not reserve [mem 0xfee00000-0xfeefffff]
> [    1.192981] acpi PNP0C02:01: Skipped [io  0x002e-0x002f]
> [    1.192988] acpi PNP0C02:01: Skipped [io  0x004e-0x004f]
> [    1.192993] acpi PNP0C02:01: Skipped [io  0x0061]
> [    1.192998] acpi PNP0C02:01: Skipped [io  0x0063]
> [    1.193003] acpi PNP0C02:01: Skipped [io  0x0065]
> [    1.193008] acpi PNP0C02:01: Skipped [io  0x0067]
> [    1.193013] acpi PNP0C02:01: Skipped [io  0x0070]
> [    1.193017] acpi PNP0C02:01: Skipped [io  0x0080]
> [    1.193022] acpi PNP0C02:01: Skipped [io  0x0092]
> [    1.193026] acpi PNP0C02:01: Skipped [io  0x00b2-0x00b3]
> [    1.193032] acpi PNP0C02:01: Reserved [io  0x0680-0x069f]
> [    1.193038] acpi PNP0C02:01: Reserved [io  0x0400-0x0453]
> [    1.193044] acpi PNP0C02:01: Reserved [io  0x0458-0x047f]
> [    1.193049] acpi PNP0C02:01: Reserved [io  0x0500-0x057f]
> [    1.193054] acpi PNP0C02:01: Reserved [io  0x164e-0x164f]
> [    1.193083] pnp: PnP ACPI init
> [    1.193490] pnp 00:02: [dma 0 disabled]
> [    1.194428] pnp: PnP ACPI: found 3 devices
> [    1.202312] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    1.202808] NET: Registered PF_INET protocol family
> [    1.203250] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    1.210302] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    1.210380] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    1.210574] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    1.211185] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [    1.211672] TCP: Hash tables configured (established 131072 bind 65536)
> [    1.212002] MPTCP token hash table entries: 16384 (order: 7, 393216 bytes, linear)
> [    1.212233] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    1.212547] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    1.212576] NET: Registered PF_XDP protocol family
> [    1.212589] pci 0000:03:00.0: ROM [mem 0xfffe0000-0xffffffff pref]: can't claim; no compatible bridge window
> [    1.212609] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
> [    1.212651] pci 0000:00:01.1: bridge window [mem 0x94a00000-0x94afffff 64bit pref]: assigned
> [    1.212663] pci 0000:00:03.0: bridge window [mem 0x94b00000-0x94cfffff 64bit pref]: assigned
> [    1.212672] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    1.212691] pci 0000:02:00.0: VF BAR 0 [mem 0x94a00000-0x94a1ffff 64bit pref]: assigned
> [    1.212702] pci 0000:02:00.0: VF BAR 3 [mem 0x94a20000-0x94a3ffff 64bit pref]: assigned
> [    1.212711] pci 0000:02:00.1: VF BAR 0 [mem 0x94a40000-0x94a5ffff 64bit pref]: assigned
> [    1.212721] pci 0000:02:00.1: VF BAR 3 [mem 0x94a60000-0x94a7ffff 64bit pref]: assigned
> [    1.212730] pci 0000:00:01.1: PCI bridge to [bus 02]
> [    1.212736] pci 0000:00:01.1:   bridge window [io  0x5000-0x5fff]
> [    1.212746] pci 0000:00:01.1:   bridge window [mem 0x94800000-0x948fffff]
> [    1.212754] pci 0000:00:01.1:   bridge window [mem 0x94a00000-0x94afffff 64bit pref]
> [    1.212766] pci 0000:03:00.0: ROM [mem 0x94760000-0x9477ffff pref]: assigned
> [    1.212773] pci 0000:00:03.0: PCI bridge to [bus 03]
> [    1.212779] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
> [    1.212787] pci 0000:00:03.0:   bridge window [mem 0x94700000-0x947fffff]
> [    1.212795] pci 0000:00:03.0:   bridge window [mem 0x94b00000-0x94cfffff 64bit pref]
> [    1.212808] pci 0000:04:00.0: VF BAR 0 [mem 0x94404000-0x9447ffff 64bit pref]: assigned
> [    1.212818] pci 0000:00:11.0: PCI bridge to [bus 04]
> [    1.212824] pci 0000:00:11.0:   bridge window [io  0x3000-0x3fff]
> [    1.212834] pci 0000:00:11.0:   bridge window [mem 0x94600000-0x946fffff]
> [    1.212842] pci 0000:00:11.0:   bridge window [mem 0x94000000-0x944fffff 64bit pref]
> [    1.212854] pci 0000:00:1c.0: PCI bridge to [bus 05]
> [    1.212870] pci 0000:00:1c.2: PCI bridge to [bus 06]
> [    1.212885] pci 0000:00:1c.3: PCI bridge to [bus 07]
> [    1.212891] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> [    1.212908] pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945fffff]
> [    1.212918] pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ffffff 64bit pref]
> [    1.212930] pci 0000:00:1e.0: PCI bridge to [bus 08]
> [    1.212945] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    1.212951] pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
> [    1.212957] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    1.212963] pci_bus 0000:00: resource 7 [mem 0x90000000-0xfbffefff window]
> [    1.212970] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
> [    1.212975] pci_bus 0000:02: resource 1 [mem 0x94800000-0x948fffff]
> [    1.212981] pci_bus 0000:02: resource 2 [mem 0x94a00000-0x94afffff 64bit pref]
> [    1.212987] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
> [    1.212993] pci_bus 0000:03: resource 1 [mem 0x94700000-0x947fffff]
> [    1.212998] pci_bus 0000:03: resource 2 [mem 0x94b00000-0x94cfffff 64bit pref]
> [    1.213005] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
> [    1.213010] pci_bus 0000:04: resource 1 [mem 0x94600000-0x946fffff]
> [    1.213016] pci_bus 0000:04: resource 2 [mem 0x94000000-0x944fffff 64bit pref]
> [    1.213023] pci_bus 0000:07: resource 0 [io  0x2000-0x2fff]
> [    1.213028] pci_bus 0000:07: resource 1 [mem 0x94500000-0x945fffff]
> [    1.213033] pci_bus 0000:07: resource 2 [mem 0x90000000-0x93ffffff 64bit pref]
> [    1.213040] pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
> [    1.213045] pci_bus 0000:08: resource 5 [io  0x1000-0xffff window]
> [    1.213051] pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff window]
> [    1.213057] pci_bus 0000:08: resource 7 [mem 0x90000000-0xfbffefff window]
> [    1.213200] pci 0000:00:05.0: disabled boot interrupts on device [8086:3c28]
> [    1.224081] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x180 took 10597 usecs
> [    1.235070] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x180 took 10699 usecs
> [    1.235227] PCI: CLS 64 bytes, default 64
> [    1.235353] Trying to unpack rootfs image as initramfs...
> [    1.235404] DMAR: No SATC found
> [    1.235411] DMAR: dmar0: Using Queued invalidation
> [    1.235626] pci 0000:00:00.0: Adding to iommu group 0
> [    1.235673] pci 0000:00:01.0: Adding to iommu group 1
> [    1.235712] pci 0000:00:01.1: Adding to iommu group 2
> [    1.235761] pci 0000:00:03.0: Adding to iommu group 3
> [    1.235804] pci 0000:00:04.0: Adding to iommu group 4
> [    1.235841] pci 0000:00:04.1: Adding to iommu group 5
> [    1.235877] pci 0000:00:04.2: Adding to iommu group 6
> [    1.235925] pci 0000:00:04.3: Adding to iommu group 7
> [    1.235963] pci 0000:00:04.4: Adding to iommu group 8
> [    1.235999] pci 0000:00:04.5: Adding to iommu group 9
> [    1.236036] pci 0000:00:04.6: Adding to iommu group 10
> [    1.236082] pci 0000:00:04.7: Adding to iommu group 11
> [    1.236119] pci 0000:00:05.0: Adding to iommu group 12
> [    1.236157] pci 0000:00:05.2: Adding to iommu group 13
> [    1.236215] pci 0000:00:05.4: Adding to iommu group 14
> [    1.236255] pci 0000:00:11.0: Adding to iommu group 15
> [    1.236333] pci 0000:00:16.0: Adding to iommu group 16
> [    1.236379] pci 0000:00:16.1: Adding to iommu group 16
> [    1.236417] pci 0000:00:1a.0: Adding to iommu group 17
> [    1.236440] pci 0000:00:1c.0: Enabling MPC IRBNCE
> [    1.236447] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
> [    1.236494] pci 0000:00:1c.0: Adding to iommu group 18
> [    1.236512] pci 0000:00:1c.2: Enabling MPC IRBNCE
> [    1.236519] pci 0000:00:1c.2: Intel PCH root port ACS workaround enabled
> [    1.236556] pci 0000:00:1c.2: Adding to iommu group 19
> [    1.236572] pci 0000:00:1c.3: Enabling MPC IRBNCE
> [    1.236579] pci 0000:00:1c.3: Intel PCH root port ACS workaround enabled
> [    1.236616] pci 0000:00:1c.3: Adding to iommu group 20
> [    1.236653] pci 0000:00:1d.0: Adding to iommu group 21
> [    1.236690] pci 0000:00:1e.0: Adding to iommu group 22
> [    1.236813] pci 0000:00:1f.0: Adding to iommu group 23
> [    1.236854] pci 0000:00:1f.2: Adding to iommu group 23
> [    1.236894] pci 0000:00:1f.3: Adding to iommu group 23
> [    1.236948] pci 0000:00:1f.6: Adding to iommu group 23
> [    1.236999] pci 0000:02:00.0: Adding to iommu group 24
> [    1.237039] pci 0000:02:00.1: Adding to iommu group 25
> [    1.237078] pci 0000:03:00.0: Adding to iommu group 26
> [    1.237156] pci 0000:04:00.0: Adding to iommu group 27
> [    1.237199] pci 0000:04:00.3: Adding to iommu group 27
> [    1.237257] pci 0000:ff:08.0: Adding to iommu group 28
> [    1.237297] pci 0000:ff:08.3: Adding to iommu group 29
> [    1.237335] pci 0000:ff:08.4: Adding to iommu group 30
> [    1.237402] pci 0000:ff:09.0: Adding to iommu group 31
> [    1.237442] pci 0000:ff:09.3: Adding to iommu group 32
> [    1.237480] pci 0000:ff:09.4: Adding to iommu group 33
> [    1.237601] pci 0000:ff:0a.0: Adding to iommu group 34
> [    1.237645] pci 0000:ff:0a.1: Adding to iommu group 34
> [    1.237690] pci 0000:ff:0a.2: Adding to iommu group 34
> [    1.237734] pci 0000:ff:0a.3: Adding to iommu group 34
> [    1.237812] pci 0000:ff:0b.0: Adding to iommu group 35
> [    1.237858] pci 0000:ff:0b.3: Adding to iommu group 35
> [    1.238065] pci 0000:ff:0c.0: Adding to iommu group 36
> [    1.238115] pci 0000:ff:0c.1: Adding to iommu group 36
> [    1.238161] pci 0000:ff:0c.2: Adding to iommu group 36
> [    1.238207] pci 0000:ff:0c.3: Adding to iommu group 36
> [    1.238253] pci 0000:ff:0c.6: Adding to iommu group 36
> [    1.238306] pci 0000:ff:0c.7: Adding to iommu group 36
> [    1.238449] pci 0000:ff:0d.0: Adding to iommu group 37
> [    1.238497] pci 0000:ff:0d.1: Adding to iommu group 37
> [    1.238544] pci 0000:ff:0d.2: Adding to iommu group 37
> [    1.238593] pci 0000:ff:0d.3: Adding to iommu group 37
> [    1.238643] pci 0000:ff:0d.6: Adding to iommu group 37
> [    1.238731] pci 0000:ff:0e.0: Adding to iommu group 38
> [    1.238780] pci 0000:ff:0e.1: Adding to iommu group 38
> [    1.238825] pci 0000:ff:0f.0: Adding to iommu group 39
> [    1.238864] pci 0000:ff:0f.1: Adding to iommu group 40
> [    1.238913] pci 0000:ff:0f.2: Adding to iommu group 41
> [    1.238955] pci 0000:ff:0f.3: Adding to iommu group 42
> [    1.238992] pci 0000:ff:0f.4: Adding to iommu group 43
> [    1.239030] pci 0000:ff:0f.5: Adding to iommu group 44
> [    1.239090] pci 0000:ff:0f.6: Adding to iommu group 45
> [    1.239135] pci 0000:ff:10.0: Adding to iommu group 46
> [    1.239173] pci 0000:ff:10.1: Adding to iommu group 47
> [    1.239211] pci 0000:ff:10.2: Adding to iommu group 48
> [    1.239248] pci 0000:ff:10.3: Adding to iommu group 49
> [    1.239286] pci 0000:ff:10.5: Adding to iommu group 50
> [    1.239324] pci 0000:ff:10.6: Adding to iommu group 51
> [    1.239372] pci 0000:ff:10.7: Adding to iommu group 52
> [    1.239431] pci 0000:ff:11.0: Adding to iommu group 53
> [    1.239583] pci 0000:ff:13.0: Adding to iommu group 54
> [    1.239636] pci 0000:ff:13.1: Adding to iommu group 54
> [    1.239690] pci 0000:ff:13.4: Adding to iommu group 54
> [    1.239743] pci 0000:ff:13.5: Adding to iommu group 54
> [    1.239798] pci 0000:ff:13.6: Adding to iommu group 54
> [    1.247333] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    1.247360] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    1.247365] software IO TLB: mapped [mem 0x000000007a4ff000-0x000000007e4ff000] (64MB)
> [    1.254624] Initialise system trusted keyrings
> [    1.254689] Key type blacklist registered
> [    1.254800] workingset: timestamp_bits=36 (anon: 31) max_order=22 bucket_order=0 (anon: 0)
> [    1.259015] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    1.260148] fuse: init (API version 7.46)
> [    1.260692] integrity: Platform Keyring initialized
> [    1.260710] integrity: Machine keyring initialized
> [    1.283221] Key type asymmetric registered
> [    1.283242] Asymmetric key parser 'x509' registered
> [    1.283341] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
> [    1.283525] io scheduler mq-deadline registered
> [    1.285049] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.285716] pcieport 0000:00:01.0: PME: Signaling with IRQ 26
> [    1.285854] pcieport 0000:00:01.0: AER: enabled with IRQ 26
> [    1.286395] pcieport 0000:00:01.1: PME: Signaling with IRQ 27
> [    1.286516] pcieport 0000:00:01.1: AER: enabled with IRQ 27
> [    1.287028] pcieport 0000:00:03.0: PME: Signaling with IRQ 29
> [    1.287190] pcieport 0000:00:03.0: AER: enabled with IRQ 29
> [    1.287247] pcieport 0000:00:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl erratum)
> [    1.287774] pcieport 0000:00:11.0: PME: Signaling with IRQ 30
> [    1.287925] pcieport 0000:00:11.0: AER: enabled with IRQ 30
> [    1.288041] pcieport 0000:00:1c.0: Intel PCH root port ACS workaround enabled
> [    1.288298] pcieport 0000:00:1c.0: PME: Signaling with IRQ 31
> [    1.288393] pcieport 0000:00:1c.2: Intel PCH root port ACS workaround enabled
> [    1.288650] pcieport 0000:00:1c.2: PME: Signaling with IRQ 32
> [    1.288744] pcieport 0000:00:1c.3: Intel PCH root port ACS workaround enabled
> [    1.289012] pcieport 0000:00:1c.3: PME: Signaling with IRQ 33
> [    1.289649] input: Power Button as /devices/platform/LNXPWRBN:00/input/input0
> [    1.289721] ACPI: button: Power Button [PWRF]
> [    1.324661] ERST: Error Record Serialization Table (ERST) support is initialized.
> [    1.324736] pstore: Using crash dump compression: deflate
> [    1.324744] pstore: Registered erst as persistent store backend
> [    1.325141] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    1.346043] 00:02: ttyS0 I/O:0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    1.352660] ACPI: bus type drm_connector registered
> [    1.363014] loop: module loaded
> [    1.363692] tun: Universal TUN/TAP device driver, 1.6
> [    1.364042] PPP generic driver version 2.4.2
> [    1.364508] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    1.364528] ehci-pci 0000:00:1a.0: EHCI Host Controller
> [    1.364550] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
> [    1.364573] ehci-pci 0000:00:1a.0: debug port 2
> [    1.365022] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.365039] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    1.365244] mousedev: PS/2 mouse device common for all mice
> [    1.365460] rtc_cmos PNP0B00:00: RTC can wake from S4
> [    1.365890] rtc_cmos PNP0B00:00: registered as rtc0
> [    1.365955] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [    1.365960] rtc_cmos PNP0B00:00: setting system clock to 2026-11-12T13:00:08 UTC (1794488408)
> [    1.366029] rtc_cmos PNP0B00:00: alarms up to one month, y3k, 242 bytes nvram
> [    1.366088] i2c_dev: i2c /dev entries driver
> [    1.368603] ehci-pci 0000:00:1a.0: irq 16, io mem 0x94926000
> [    1.369047] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
> [    1.369115] device-mapper: uevent: version 1.0.3
> [    1.369234] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
> [    1.369267] intel_pstate: Intel P-state driver initializing
> [    1.370179] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
> [    1.370219] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
> [    1.372069] Console: switching to colour frame buffer device 80x30
> [    1.373299] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
> [    1.373459] drop_monitor: Initializing network drop monitor service
> [    1.374892] NET: Registered PF_INET6 protocol family
> [    1.374914] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    1.374999] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.03
> [    1.375868] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.376438] usb usb1: Product: EHCI Host Controller
> [    1.376726] usb usb1: Manufacturer: Linux 7.3.4-070304-generic ehci_hcd
> [    1.377035] usb usb1: SerialNumber: 0000:00:1a.0
> [    1.377535] hub 1-0:1.0: USB hub found
> [    1.377577] Segment Routing with IPv6
> [    1.377846] hub 1-0:1.0: 2 ports detected
> [    1.378311] In-situ OAM (IOAM) with IPv6
> [    1.378789] ehci-pci 0000:00:1d.0: EHCI Host Controller
> [    1.379050] NET: Registered PF_PACKET protocol family
> [    1.379255] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
> [    1.379756] Key type dns_resolver registered
> [    1.380191] ehci-pci 0000:00:1d.0: debug port 2
> [    1.384869] ehci-pci 0000:00:1d.0: irq 23, io mem 0x94925000
> [    1.386622] microcode: Current revision: 0x0000071a
> [    1.386882] microcode: Updated early from: 0x00000714
> [    1.388668] IPI shorthand broadcast: enabled
> [    1.390937] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> [    1.391281] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.03
> [    1.391867] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.392353] usb usb2: Product: EHCI Host Controller
> [    1.392592] usb usb2: Manufacturer: Linux 7.3.4-070304-generic ehci_hcd
> [    1.392830] usb usb2: SerialNumber: 0000:00:1d.0
> [    1.393383] hub 2-0:1.0: USB hub found
> [    1.393669] hub 2-0:1.0: 2 ports detected
> [    1.394252] sched_clock: Marking stable (1285314818, 108589731)->(1458784064, -64879515)
> [    1.395823] registered taskstats version 1
> [    1.401915] Loading compiled-in X.509 certificates
> [    1.406364] Loaded X.509 cert 'Build time autogenerated kernel key: bc369202f2670964b9a75b8b11b220b98aacf725'
> [    1.408022] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing 2025 Kmod: d541cef61dc7e793b7eb7e899970a2eef0b5dc8c'
> [    1.409755] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing: 14df34d1a87cf37625abec039ef2bf521249b969'
> [    1.411435] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing 2025 Kmod: 4627603d2357a2a3f81006370894c221175893e9'
> [    1.413123] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing: 88f752e560a1e0737e31163a466ad7b70a850c19'
> [    1.413632] blacklist: Loading compiled-in revocation X.509 certificates
> [    1.413959] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing: 61482aa2830d0ab2ad5af10b7250da9033ddcef0'
> [    1.414522] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2017): 242ade75ac4a15e50d50c84b0d45ff3eae707a03'
> [    1.415123] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (ESM 2018): 365188c1d374d6b07c3c8f240f8ef722433d6a8b'
> [    1.415721] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2019): c0746fd6c5da3ae827864651ad66ae47fe24b3e8'
> [    1.416334] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v1): a8d54bbb3825cfb94fa13c9f8a594a195c107b8d'
> [    1.416942] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v2): 4cf046892d6fd3c9a5b03f98d845f90851dc6a8c'
> [    1.417548] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2021 v3): 100437bb6de6e469b581e61cd66bce3ef4ed53af'
> [    1.418245] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (Ubuntu Core 2019): c1d57b8f6b743f23ee41f4f7ee292f06eecadfb9'
> [    1.428588] Demotion targets for Node 0: null
> [    1.429081] Key type .fscrypt registered
> [    1.429388] Key type fscrypt-provisioning registered
> [    1.429935] Key type big_key registered
> [    1.430239] Key type encrypted registered
> [    1.430529] AppArmor: AppArmor sha256 policy hashing enabled
> [    1.430817] ima: No TPM chip found, activating TPM-bypass!
> [    1.431121] Loading compiled-in module X.509 certificates
> [    1.432586] Loaded X.509 cert 'Build time autogenerated kernel key: bc369202f2670964b9a75b8b11b220b98aacf725'
> [    1.433148] ima: Allocated hash algorithm: sha256
> [    1.433554] ima: No architecture policies found
> [    1.433858] evm: Initialising EVM extended attributes:
> [    1.434145] evm: security.selinux
> [    1.434406] evm: security.SMACK64
> [    1.434658] evm: security.SMACK64EXEC
> [    1.434907] evm: security.SMACK64TRANSMUTE
> [    1.435148] evm: security.SMACK64MMAP
> [    1.435375] evm: security.apparmor
> [    1.435591] evm: security.ima
> [    1.435798] evm: security.capability
> [    1.436010] evm: HMAC attrs: 0x1
> [    1.436759] PM:   Magic number: 2:273:28
> [    1.437090] memory memory68: hash matches
> [    1.437826] RAS: Correctable Errors collector initialized.
> [    1.438757] clk: Disabling unused clocks
> [    1.438957] PM: genpd: Disabling unused power domains
> [    1.472611] Freeing initrd memory: 69876K
> [    1.479423] Freeing unused decrypted memory: 2028K
> [    1.481129] Freeing unused kernel image (initmem) memory: 5468K
> [    1.481495] Write protecting the kernel read-only data: 43008k
> [    1.482384] Freeing unused kernel image (text/rodata gap) memory: 184K
> [    1.483094] Freeing unused kernel image (rodata/data gap) memory: 708K
> [    1.571274] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.571468] x86/mm: Checking user space page tables
> [    1.616687] usb 1-1: new high-speed USB device number 2 using ehci-pci
> [    1.632681] usb 2-1: new high-speed USB device number 2 using ehci-pci
> [    1.634629] workqueue: drm_fb_helper_damage_work hogged CPU for >13333us 4 times, consider switching to WQ_UNBOUND
> [    1.656305] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.656493] Run /init as init process
> [    1.656677]   with arguments:
> [    1.656681]     /init
> [    1.656683]   with environment:
> [    1.656685]     HOME=/
> [    1.656687]     TERM=linux
> [    1.708626] workqueue: drm_fb_helper_damage_work hogged CPU for >13333us 5 times, consider switching to WQ_UNBOUND
> [    1.745139] usb 1-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
> [    1.748188] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.749673] hub 1-1:1.0: USB hub found
> [    1.750819] hub 1-1:1.0: 6 ports detected
> [    1.762819] usb 2-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
> [    1.765597] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.767116] hub 2-1:1.0: USB hub found
> [    1.768317] hub 2-1:1.0: 8 ports detected
> [    1.854624] workqueue: drm_fb_helper_damage_work hogged CPU for >13333us 7 times, consider switching to WQ_UNBOUND
> [    1.995916] dca service started, version 1.12.1
> [    2.011252] megasas: 07.734.00.00-rc1
> [    2.012345] megaraid_sas 0000:03:00.0: BAR:0x1  BAR's base_addr(phys):0x0000000094740000  mapped virt_addr:0x(____ptrval____)
> [    2.012357] megaraid_sas 0000:03:00.0: FW now in Ready state
> [    2.012827] megaraid_sas 0000:03:00.0: 63 bit DMA mask and 32 bit consistent mask
> [    2.014376] megaraid_sas 0000:03:00.0: firmware supports msix	: (16)
> [    2.016185] megaraid_sas 0000:03:00.0: requested/available msix 16/16 poll_queue 0
> [    2.017146] megaraid_sas 0000:03:00.0: current msix/max num queues	: (16/16)
> [    2.017655] megaraid_sas 0000:03:00.0: RDPQ mode	: (disabled)
> [    2.018153] megaraid_sas 0000:03:00.0: Current firmware supports maximum commands: 1008	 LDIO threshold: 0
> [    2.021509] ahci 0000:00:1f.2: AHCI vers 0001.0300, 32 command slots, 6 Gbps, SATA mode
> [    2.022484] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> [    2.023000] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck led clo pio slum part ems apst 
> [    2.025723] megaraid_sas 0000:03:00.0: Performance mode :Latency (latency index = 1)
> [    2.026659] megaraid_sas 0000:03:00.0: FW supports sync cache	: No
> [    2.027135] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
> [    2.041246] scsi host1: ahci
> [    2.042397] scsi host2: ahci
> [    2.043276] scsi host3: ahci
> [    2.044088] scsi host4: ahci
> [    2.045178] scsi host5: ahci
> [    2.046028] scsi host6: ahci
> [    2.046568] ata1: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924100 irq 50 lpm-pol 1 ext
> [    2.047262] ata2: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924180 irq 50 lpm-pol 1 ext
> [    2.047866] ata3: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924200 irq 50 lpm-pol 1 ext
> [    2.048382] ata4: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924280 irq 50 lpm-pol 1 ext
> [    2.049254] ata5: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924300 irq 50 lpm-pol 1 ext
> [    2.049909] ata6: SATA max UDMA/133 abar m2048@0x94924000 port 0x94924380 irq 50 lpm-pol 1 ext
> [    2.057404] igb: Intel(R) Gigabit Ethernet Network Driver
> [    2.057703] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    2.059632] igb 0000:02:00.0: PHY reset is blocked due to SOL/IDER session.
> [    2.063575] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
> [    2.063907] isci 0000:04:00.0: driver configured for rev: 6 silicon
> [    2.064184] isci 0000:04:00.0: OEM parameter table found in OROM
> [    2.064440] isci 0000:04:00.0: [0]: invalid oem parameters detected, falling back to firmware
> [    2.065055] isci 0000:04:00.0: OEM SAS parameters (version: 1.3) loaded (firmware)
> [    2.066340] isci 0000:04:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
> [    2.070630] megaraid_sas 0000:03:00.0: FW provided supportMaxExtLDs: 0	max_lds: 64
> [    2.071181] megaraid_sas 0000:03:00.0: controller type	: MR(512MB)
> [    2.071467] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR)	: Enabled
> [    2.071778] megaraid_sas 0000:03:00.0: Secure JBOD support	: No
> [    2.072072] megaraid_sas 0000:03:00.0: NVMe passthru support	: No
> [    2.072359] megaraid_sas 0000:03:00.0: FW provided TM TaskAbort/Reset timeout	: 0 secs/0 secs
> [    2.072929] megaraid_sas 0000:03:00.0: JBOD sequence map support	: No
> [    2.073212] megaraid_sas 0000:03:00.0: PCI Lane Margining support	: No
> [    2.077295] scsi host7: isci
> [    2.096609] megaraid_sas 0000:03:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000
> [    2.097159] megaraid_sas 0000:03:00.0: INIT adapter done
> [    2.097427] megaraid_sas 0000:03:00.0: JBOD sequence map is disabled megasas_setup_jbod_map 5812
> [    2.098357] megaraid_sas 0000:03:00.0: pci id		: (0x1000)/(0x005b)/(0x19e5)/(0xd205)
> [    2.098905] megaraid_sas 0000:03:00.0: unevenspan support	: no
> [    2.099172] megaraid_sas 0000:03:00.0: firmware crash dump	: no
> [    2.099435] megaraid_sas 0000:03:00.0: JBOD sequence map	: disabled
> [    2.099908] megaraid_sas 0000:03:00.0: Max firmware commands: 1007 shared with default hw_queues = 15 poll_queues 0
> [    2.100433] scsi host0: Avago SAS based MegaRAID driver
> [    2.124886] scsi 0:2:0:0: Direct-Access     LSI      LSI              3.19 PQ: 0 ANSI: 5
> [    2.142025] igb 0000:02:00.0: added PHC on eth0
> [    2.142477] igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    2.142751] igb 0000:02:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 48:46:fb:08:86:e1
> [    2.143118] igb 0000:02:00.0: eth0: PBA No: 106300-000
> [    2.143357] igb 0000:02:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> [    2.146141] igb 0000:02:00.1: PHY reset is blocked due to SOL/IDER session.
> [    2.156614] workqueue: drm_fb_helper_damage_work hogged CPU for >13333us 11 times, consider switching to WQ_UNBOUND
> [    2.219618] igb 0000:02:00.1: added PHC on eth1
> [    2.220122] igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
> [    2.220377] igb 0000:02:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 48:46:fb:08:86:e2
> [    2.220789] igb 0000:02:00.1: eth1: PBA No: 106300-000
> [    2.221037] igb 0000:02:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> [    2.280719] tsc: Refined TSC clocksource calibration: 1799.871 MHz
> [    2.280989] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x19f1afb6df9, max_idle_ns: 440795282544 ns
> [    2.281830] clocksource: Switched to clocksource tsc
> [    2.374651] ata6: SATA link down (SStatus 0 SControl 300)
> [    2.374940] ata1: SATA link down (SStatus 0 SControl 300)
> [    2.376994] ata5: SATA link down (SStatus 0 SControl 300)
> [    2.378894] ata2: SATA link down (SStatus 0 SControl 300)
> [    2.381000] ata3: SATA link down (SStatus 0 SControl 300)
> [    2.383351] ata4: SATA link down (SStatus 0 SControl 300)
> [    2.497414] sd 0:2:0:0: [sda] 486326272 512-byte logical blocks: (249 GB/232 GiB)
> [    2.497827] sd 0:2:0:0: Attached scsi generic sg0 type 0
> [    2.498036] sd 0:2:0:0: [sda] Write Protect is off
> [    2.498345] sd 0:2:0:0: [sda] Mode Sense: 1f 00 00 08
> [    2.498623] sd 0:2:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    2.526139]  sda: sda1 sda2 sda3
> [    2.528274] sd 0:2:0:0: [sda] Attached SCSI disk
> [    2.535524] igb 0000:02:00.0 enp2s0f0: renamed from eth0
> [    2.536306] igb 0000:02:00.1 enp2s0f1: renamed from eth1
> [    2.806614] random: crng init done
> [    2.985633] workqueue: drm_fb_helper_damage_work hogged CPU for >13333us 19 times, consider switching to WQ_UNBOUND
> [    3.048123] clocksource: Watchdog hpet read timed out. Readout sequence took: 89746ns
> [    3.093475] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input3
> [    3.132763] xor: automatically using best checksumming function   avx       
> [    3.140019] raid6: using ssse3x2 recovery algorithm
> [    3.144886] raid6: sse2x1   gen()  7129 MB/s
> [    3.148072] raid6: sse2x2   gen()  8860 MB/s
> [    3.151231] raid6: sse2x4   gen()  8909 MB/s
> [    3.151440] raid6: using algorithm sse2x4 gen() 8909 MB/s
> [    3.154187] raid6: .... xor() 5175 MB/s, rmw enabled
> [    3.157525] async_tx: api initialized (async)
> [    3.528450] Btrfs loaded, zoned=yes, fsverity=yes
> [    4.292187] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
> [    4.321690] XFS (dm-0): Mounting V5 Filesystem 0f0e5bf5-7b46-4ea9-9036-e94dc2d615f4
> [    4.337362] XFS (dm-0): Ending clean mount
> [    4.551977] systemd[1]: Inserted module 'autofs4'
> [    4.561093] clocksource: Watchdog hpet read timed out. Readout sequence took: 75288ns
> [    4.634517] systemd[1]: systemd 255.4-1ubuntu8 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
> [    4.635801] systemd[1]: Detected architecture x86-64.
> [    4.638494] systemd[1]: Hostname set to <ubuntu>.
> [    4.971060] systemd[1]: Queued start job for default target graphical.target.
> [    5.038754] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
> [    5.063872] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
> [    5.084455] systemd[1]: Created slice user.slice - User and Session Slice.
> [    5.093803] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
> [    5.109788] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
> [    5.117776] systemd[1]: Expecting device dev-disk-by\x2duuid-4e18c04f\x2de511\x2d426c\x2d9809\x2d4898a1ea6937.device - /dev/disk/by-uuid/4e18c04f-e511-426c-9809-4898a1ea6937...
> [    5.128294] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
> [    5.135733] systemd[1]: Reached target slices.target - Slice Units.
> [    5.142250] systemd[1]: Reached target snapd.mounts-pre.target - Mounting snaps.
> [    5.150139] systemd[1]: Reached target snapd.mounts.target - Mounted snaps.
> [    5.157216] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
> [    5.170373] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
> [    5.187365] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
> [    5.203583] systemd[1]: Listening on multipathd.socket - multipathd control socket.
> [    5.204634] workqueue: drm_fb_helper_damage_work hogged CPU for >13333us 35 times, consider switching to WQ_UNBOUND
> [    5.224646] systemd[1]: Listening on syslog.socket - Syslog Socket.
> [    5.237429] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
> [    5.249420] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
> [    5.265129] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
> [    5.281102] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
> [    5.296786] systemd[1]: Listening on systemd-networkd.socket - Network Service Netlink Socket.
> [    5.305639] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [    5.321583] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
> [    5.336214] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
> [    5.384933] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
> [    5.439135] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
> [    5.484455] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
> [    5.537728] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
> [    5.596726] systemd[1]: Starting keyboard-setup.service - Set the console keyboard layout...
> [    5.647941] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
> [    5.688792] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [    5.733772] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
> [    5.781679] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
> [    5.825742] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
> [    5.871506] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
> [    5.917194] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
> [    5.962968] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
> [    5.972552] systemd[1]: netplan-ovs-cleanup.service - OpenVSwitch configuration for cleanup was skipped because of an unmet condition check (ConditionFileIsExecutable=/usr/bin/ovs-vsctl).
> [    5.981468] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
> [    6.060022] systemd[1]: Starting systemd-journald.service - Journal Service...
> [    6.063045] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
> [    6.064119] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [    6.066547] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
> [    6.067659] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [    6.070361] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
> [    6.074167] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
> [    6.075168] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
> [    6.076426] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
> [    6.077679] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
> [    6.079133] systemd[1]: Finished keyboard-setup.service - Set the console keyboard layout.
> [    6.080736] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
> [    6.082097] systemd-journald[491]: Collecting audit messages is disabled.
> [    6.082311] systemd[1]: Finished lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
> [    6.084050] systemd[1]: modprobe@configfs.service: Deactivated successfully.
> [    6.084678] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
> [    6.087442] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
> [    6.088077] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
> [    6.089707] systemd[1]: modprobe@drm.service: Deactivated successfully.
> [    6.090306] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
> [    6.091839] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
> [    6.092802] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
> [    6.094328] systemd[1]: modprobe@fuse.service: Deactivated successfully.
> [    6.094931] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
> [    6.096442] systemd[1]: modprobe@loop.service: Deactivated successfully.
> [    6.097272] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
> [    6.098749] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
> [    6.115827] systemd[1]: Activating swap swap.img.swap - /swap.img...
> [    6.118415] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
> [    6.121023] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
> [    6.121161] Adding 4194300k swap on /swap.img.  Priority:-1 extents:1 across:4194300k 
> [    6.124188] systemd[1]: Starting multipathd.service - Device-Mapper Multipath Device Controller...
> [    6.126188] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
> [    6.126909] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
> [    6.129466] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
> [    6.130636] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
> [    6.132745] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
> [    6.133818] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
> [    6.134565] systemd[1]: Activated swap swap.img.swap - /swap.img.
> [    6.136978] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
> [    6.138484] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
> [    6.139742] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
> [    6.157307] systemd[1]: Finished systemd-random-seed.service - Load/Save OS Random Seed.
> [    6.181697] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
> [    6.183351] systemd[1]: Reached target swap.target - Swaps.
> [    6.190905] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
> [    6.192038] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
> [    6.194271] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
> [    6.195550] systemd[1]: Started multipathd.service - Device-Mapper Multipath Device Controller.
> [    6.209545] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
> [    6.216091] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
> [    6.216713] systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
> [    6.223831] systemd[1]: Mounting run-qemu.mount - Prepare /run/qemu to allow still running qemu binaries of former builds (after package upgrades) to fallback-load modules from there...
> [    6.226523] systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
> [    6.228701] systemd[1]: Mounted run-qemu.mount - Prepare /run/qemu to allow still running qemu binaries of former builds (after package upgrades) to fallback-load modules from there.
> [    6.229547] systemd[1]: Started systemd-journald.service - Journal Service.
> [    6.265532] systemd-journald[491]: Received client request to flush runtime journal.
> [    6.276886] systemd-journald[491]: /var/log/journal/f656842898f24f7caf37de6a688f6592/system.journal: Journal file uses a different sequence number ID, rotating.
> [    6.276899] systemd-journald[491]: Rotating system journal.
> [    6.582142] ioatdma: Intel(R) QuickData Technology Driver 5.00
> [    6.614706] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
> [    6.626623] igb 0000:02:00.0: DCA enabled
> [    6.629335] igb 0000:02:00.1: DCA enabled
> [    6.693730] lpc_ich 0000:00:1f.0: No MFD cells added
> [    6.724886] IPMI message handler: version 39.2
> [    6.725077] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> [    6.725324] i801_smbus 0000:04:00.3: Enabling SMBus device
> [    6.725363] i801_smbus 0000:04:00.3: SMBus using PCI interrupt
> [    6.743499] ipmi device interface
> [    6.753783] ipmi_si: IPMI System Interface driver
> [    6.754087] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [    6.754097] ipmi_platform: ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1 irq 0
> [    6.754106] ipmi_si: Adding SMBIOS-specified bt state machine
> [    6.754615] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
> [    6.754624] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
> [    6.754629] RAPL PMU: hw unit of domain package 2^-16 Joules
> [    6.754633] RAPL PMU: hw unit of domain dram 2^-16 Joules
> [    6.754995] ipmi_si: Trying SMBIOS-specified bt state machine at i/o address 0xe4, slave address 0x20, irq 0
> [    6.756637] ipmi_si dmi-ipmi-si.0: bt cap response too short: 3
> [    6.756647] ipmi_si dmi-ipmi-si.0: using default values
> [    6.756652] ipmi_si dmi-ipmi-si.0: req2rsp=5 secs retries=2
> [    6.831446] ipmi_si dmi-ipmi-si.0: IPMI message handler: Found new BMC (man_id: 0x0007db, prod_id: 0xaa11, dev_id: 0x01)
> [    7.025656] ipmi_si dmi-ipmi-si.0: IPMI bt interface initialized
> [    7.379572] EXT4-fs (sda2): mounted filesystem 4e18c04f-e511-426c-9809-4898a1ea6937 r/w with ordered data mode. Quota mode: none.
> [    7.437389] audit: type=1400 audit(1794488414.569:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-checkns" pid=774 comm="apparmor_parser"
> [    7.437409] audit: type=1400 audit(1794488414.570:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="crun" pid=778 comm="apparmor_parser"
> [    7.437890] audit: type=1400 audit(1794488414.571:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=772 comm="apparmor_parser"
> [    7.438069] audit: type=1400 audit(1794488414.571:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ch-run" pid=775 comm="apparmor_parser"
> [    7.438149] audit: type=1400 audit(1794488414.571:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=768 comm="apparmor_parser"
> [    7.438217] audit: type=1400 audit(1794488414.571:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=771 comm="apparmor_parser"
> [    7.438869] audit: type=1400 audit(1794488414.572:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=767 comm="apparmor_parser"
> [    7.438879] audit: type=1400 audit(1794488414.572:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=766 comm="apparmor_parser"
> [    7.439054] audit: type=1400 audit(1794488414.572:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="devhelp" pid=779 comm="apparmor_parser"
> [    7.439156] audit: type=1400 audit(1794488414.572:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="element-desktop" pid=780 comm="apparmor_parser"
> [    7.473508] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
> [    7.473559] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
> [    7.473571] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
> [    7.473583] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
> [    7.473589] EDAC sbridge: Seeking for: PCI ID 8086:3c71
> [    7.473932] EDAC sbridge: Seeking for: PCI ID 8086:3c71
> [    7.473940] EDAC sbridge: Seeking for: PCI ID 8086:3caa
> [    7.473953] EDAC sbridge: Seeking for: PCI ID 8086:3caa
> [    7.473959] EDAC sbridge: Seeking for: PCI ID 8086:3cab
> [    7.473972] EDAC sbridge: Seeking for: PCI ID 8086:3cab
> [    7.473977] EDAC sbridge: Seeking for: PCI ID 8086:3cac
> [    7.473990] EDAC sbridge: Seeking for: PCI ID 8086:3cac
> [    7.473995] EDAC sbridge: Seeking for: PCI ID 8086:3cad
> [    7.474009] EDAC sbridge: Seeking for: PCI ID 8086:3cad
> [    7.474015] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
> [    7.474030] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
> [    7.474036] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
> [    7.474049] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
> [    7.474057] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
> [    7.474071] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
> [    7.474079] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
> [    7.474094] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
> [    7.474278] EDAC MC0: Giving out device to module sb_edac controller Sandy Bridge SrcID#0_Ha#0: DEV 0000:ff:0e.0 (INTERRUPT)
> [    7.474286] EDAC sbridge:  Ver: 1.1.2 
> [    7.492696] intel_rapl_common: Found RAPL domain package
> [    7.492707] intel_rapl_common: Found RAPL domain core
> [    7.492716] intel_rapl_common: Found RAPL domain dram
> [    7.839206] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    7.839833] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    7.840211] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [    7.896134] igb 0000:02:00.0 enp2s0f0: igb: enp2s0f0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> [    7.994661] /proc/cgroups lists only v1 controllers, use cgroup.controllers of root cgroup for v2 info
> [    8.032642] workqueue: drm_fb_helper_damage_work hogged CPU for >13333us 67 times, consider switching to WQ_UNBOUND
> [    8.089123] watchdog_print_freq_timeout: 6 callbacks suppressed
> [    8.089132] clocksource: Watchdog hpet read timed out. Readout sequence took: 87580ns
> [    8.126359] loop0: detected capacity change from 0 to 8
> [    8.161849] NET: Registered PF_QIPCRTR protocol family
> [    9.096373] clocksource: Watchdog hpet read timed out. Readout sequence took: 84857ns

#regzbot introduced: 72780f796468
#regzbot link: https://lore.kernel.org/all/CALJR0nehJ5+d7MrPk8rxkNmee_1L5FFsvuF+-swK1nyJ7oJJ8A@mail.gmail.com

