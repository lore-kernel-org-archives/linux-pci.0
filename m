Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D714485CE6;
	Mon, 21 Sep 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993721; cv=pass; b=rWkEDNAGXU4QPXl84afHFAh2Sa2SWQ+3rh5E9BEg6dhxH/vnT6dyDBTrP6yuovQrSVyUUyvWBDJIkF+lUqdoqiYfMhWDv/8NxoifeaTL9CquE/Ty14A/ICc8MaLfNREbhHelTJy+nx8aEoKi4Z/6DgNif4LJF3QTA3H5w1YjpYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993721; c=relaxed/simple;
	bh=GCwKqWZ8SJGaJAh+LVpwLs3jsKBR4stQUct2OkzgBbY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=CXtwWZ9JIA04glomufqum9T+7Gm4Y5Fz31u+8LF3+GPjkQrJtnx3I5M6GLZtrKxhwDjHh0JBxN1eUtkIw+7PpXh+yzR0hBSQMPY5tomsxZvL1exKLP6eGAYiGvo07ASHbTYLfPiODYHL5n6TSBXcOh+6SvrKaAM5ra7BdfeYwKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donnerluetjen.de; spf=none smtp.mailfrom=donnerluetjen.de; dkim=pass (2048-bit key) header.d=donnerluetjen.de header.i=@donnerluetjen.de header.b=KyqXkw9d; dkim=permerror (0-bit key) header.d=donnerluetjen.de header.i=@donnerluetjen.de header.b=MP6iKqYg; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donnerluetjen.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=donnerluetjen.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=donnerluetjen.de header.i=@donnerluetjen.de header.b="KyqXkw9d";
	dkim=permerror (0-bit key) header.d=donnerluetjen.de header.i=@donnerluetjen.de header.b="MP6iKqYg"
ARC-Seal: i=1; a=rsa-sha256; t=1789993707; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y+rq4wYeqVEElB/+rBDPcuAVH3/ROlO0+wkixHT9KiAf18HTi68fBsw3HH4fYE7HVY
    p2wOOnqyxbbH5viBH6VtShxdmfFdbuNw4oRmjAMnDtDnhuTZ2dElEDuKBTB8J/92ErDm
    +m1HFiuTX1tt7yKrytIiNGTnSGfeUqcAx90HEBjrtv220JTeCfhWPixPVY/+Pj7mcrHv
    HB9wEetDe1yVO6nEYaUptxH99LZfUhSxVilf9efsbIasznGI0dgKJLB93XSujuLXsV00
    zDYMhoXGezAIksCmWKlnB79ZvidwTzBKA4DAjGqk5zjItJZ0YxkFJUxsuHAOq/m54p3K
    36Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789993707;
    s=strato-dkim-0002; d=strato.com;
    h=To:Cc:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=uPYvypMqdqu5ySj/BDtWhRNavQC5x3b93Y8UO91/lfk=;
    b=fvP4VVc5KX+sxhXDkGEDPgqcPVKAx24rI4RKvIsEEW041VHghiWXHgOZwlbjxTMjcA
    jIBR/G4KBMKl4ggcxw6d1HG84Ytv2UjPQwMIYM1z8TA+R7ccxwPrbVxVjBrlr8fziOT6
    kuHJLg+1CkZv8I5VQaaCVdKQvVEW8tq8dHaHhWXYEY/IozdtL1PirE7HFi93rxAtFkf7
    0V/UpbwZcgv4zrBxnSF6UzhoDxD6Rjfd6YayxFXHDNIRfdKy1KD4mSVigMWdEAUN01jW
    IMLl6G6rNl36s77Fk2eTi9sGSemN9tuYsU8To54gKSMtxZK5B+qTYvkWzKJLp52/1MgK
    NfrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789993707;
    s=strato-dkim-0002; d=donnerluetjen.de;
    h=To:Cc:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=uPYvypMqdqu5ySj/BDtWhRNavQC5x3b93Y8UO91/lfk=;
    b=KyqXkw9dCSVgd4TWSzro3nIik2X9fnDKJSuvKNn1E/jKHABwesXQB41NDDNEVzoJtr
    KB38OdEUjAyt72j/ySfvJAhWIvjrEuLwvVOCzCbL0X67eAm/xmlwH4QROXDrCIMmDQ/A
    hFQT7LavlY087EzsdDbo5EgNVfJDTziWybb/0QaY/pah+WYgHpOAenIlvTmweQa8j1ci
    6WFPHFAp1nwE7xLylT4y3kW9YQ4YaNzUjfeUX4Bnq2+3rFvFkchbCo7vaPJXXbJzbofc
    4XOQpX0VARquBRaQv6QDnMlmgMApKymFgdlty3CwboDoTmsAf+UZ6mhix/vJbQkirb8e
    5yVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789993707;
    s=strato-dkim-0003; d=donnerluetjen.de;
    h=To:Cc:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=uPYvypMqdqu5ySj/BDtWhRNavQC5x3b93Y8UO91/lfk=;
    b=MP6iKqYgUvZIWy5KbtJjaAbLl/F4DZRmV1tn92gjRAQw7f/H65Vg1cjvA7nxy6kfa+
    AVsPdwbmzyWxaOqrZPDw==
X-RZG-AUTH: ":KGkSdEGIf/B+T6RgFsN+Ar29fQb+E4Px3RvhcXP0WHkIUo95nzS1OdWHCOUHAjwE10j9ZqMxyIrYVYpwwWg9T4oGeaTsw50op0iKRg=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id 4046de28LCSRFkg
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 21 Sep 2026 14:28:27 +0200 (CEST)
From: Ansgar Asseburg <devaa@donnerluetjen.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: nvme: Apple S3X (106b:2003) unresponsive after resume on MacBook10,1,
 fixed by pcie_port_pm=off
Message-Id: <FB73E91E-BD39-4EB5-9914-9B63D769E490@donnerluetjen.de>
Date: Mon, 21 Sep 2026 14:28:17 +0200
Cc: Len Brown <lenb@kernel.org>,
 linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



Hello,

on a MacBook10,1 (12" Retina, 2017) the Apple S3X NVMe controller stops
responding after every S3 or s2idle resume. About 60 seconds later the
root filesystem goes read-only. Booting with pcie_port_pm=3Doff fixes =
it:
all pm_test levels, a real suspend and a lid close/open then resume
cleanly. pcie_aspm=3Doff and nvme_core.default_ps_max_latency_us=3D0
nvme.noacpi=3D1 did not help. This suggests that power management of the
PCH root port above the SSD (00:1c.0) leaves the device unreachable
after resume, but I do not know the root cause.

Environment
-----------
Machine:      Apple MacBook10,1 (Retina 12", 2017), UEFI, GRUB
CPU/GPU:      Kaby Lake, i915 (device ID 591e)
SSD:          APPLE SSD AP0512J, firmware 16.14.01
Controller:   Apple S3X NVMe Controller [106b:2003] rev 12, 0000:01:00.0
Root port:    Intel Sunrise Point-LP PCH root port 0000:00:1c.0
Namespaces:   nvme0n1 (p1-p3); nvme0n2 (partition table unreadable)
Kernel:       7.0.0-31-generic (Ubuntu 26.04 LTS), tainted by an
              out-of-tree audio DKMS module (snd_hda_codec_cs420x)
mem_sleep:    s2idle [deep]; both modes fail without the workaround

The audio module is not involved: the failure persists with the codec
unloaded and the HDA controller unbound.

Steps to reproduce
------------------
Shortest reproducer, no real sleep and no wake source needed:

  1. Boot without the workaround parameter.
  2. echo platform | sudo tee /sys/power/pm_test
  3. echo mem | sudo tee /sys/power/state
  4. The command does not return normally. Wait about 60 seconds.

The same happens with a real "systemctl suspend" (deep) and with
mem_sleep set to s2idle. pm_test levels freezer and devices pass; the
failure starts at platform (ACPI prepare, suspend_late, suspend_noirq).

Observed behavior (without the workaround)
------------------------------------------
The controller never answers its first admin command after resume. The
60 s admin timeout expires and the driver gives up. Excerpt from one
failing run (pm_test=3Dplatform, deep, without pcie_port_pm=3Doff; the
suspend started at 191.4 s, times are seconds since boot):

  [  191.420305] PM: suspend entry (deep)
  [  259.218334] nvme nvme0: I/O tag 4 (0004) QID 0 timeout, disable =
controller
  [  259.226716] nvme nvme0: Identify Controller failed (-4)
  [  259.226736] nvme nvme0: Disabling device after reset failure: -5

Ext4 then reports I/O errors, aborts its journal and remounts
read-only:

  [  259.236424] Buffer I/O error on device nvme0n1p3, logical block =
23403156
  [  259.238445] Aborting journal on device nvme0n1p3-8.
  [  259.238612] EXT4-fs (nvme0n1p3): I/O error while writing superblock
  [  259.238622] EXT4-fs (nvme0n1p3): Remounting filesystem read-only

The desktop crashes, the lock screen no longer accepts the password and
sshd is unusable. After a hard reset the filesystem recovers through
journal replay. The failing runs with the other parameters listed below
(pcie_aspm=3Doff, the nvme parameters, s2idle) look the same.

With pcie_port_pm=3Doff
---------------------
  nvme 0000:01:00.0: PM: pci_pm_resume_noirq returned 0 after 82 usecs
  nvme nvme0: 1/0/0 default/read/poll queues
  PM: suspend exit

A direct read (dd if=3D/dev/nvme0n1 iflag=3Ddirect) 75 seconds later
succeeds, and dmesg has no NVMe or I/O errors.

What was tested
---------------
  pm_test=3Dfreezer, devices                        pass
  pm_test=3Dplatform, default parameters            SSD dies after =
resume
  mem_sleep=3Ds2idle                                same failure
  audio codec unloaded, HDA controller unbound    same failure
  nvme_core.default_ps_max_latency_us=3D0
    nvme.noacpi=3D1                                 same failure
  pcie_aspm=3Doff                                   same failure
  pcie_port_pm=3Doff: pm_test platform, processors,
    core                                          pass, disk alive
  pcie_port_pm=3Doff: real suspend (deep), lid
    close/open                                    pass, lock screen
                                                  and SSH work

pm_trace gave the same result with serial and async device suspend
and points at a memory device, so I consider it uninformative.

Workaround
----------
Kernel parameter pcie_port_pm=3Doff. It disables runtime power =
management
of all PCIe root ports, so it probably costs some battery life; I have
not measured that.

Questions
---------
- Is the root cause in the PCH root port handling (D3 entry/exit of
  00:1c.0 around the platform phase), or in the S3X controller's own
  resume?
- Can the fix be narrowed to root port 00:1c.0 (for example with a PCI
  quirk) instead of disabling the feature globally? I have not tried
  this.
- Is this a known issue for other MacBooks with Apple S3X SSDs?

What I could not do: I have no patch and no root cause, only the
workaround above. I did not test other kernels or measure the power
cost. Limits of my testing: one machine, one kernel (7.0.0-31-generic),
and real suspends of only a few seconds.

Disclosure: I ran all tests on my own machine, and all logs and
measurements above are unmodified output from it. I used Claude (an AI
assistant) to plan the bisection steps, help interpret the logs and
draft the text of this report. I have reviewed the content and can
answer questions about it.

I can provide full dmesg and journalctl output of the failing and the
working runs, and I can test patches or additional kernel parameters
on this machine.



$ sudo lspci -vvv -s 01:00.0
01:00.0 Mass storage controller: Apple Inc. S3X NVMe Controller (rev 12) =
(prog-if 02)
	Subsystem: Apple Inc. S3X NVMe Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 32
	IOMMU group: 10
	Region 0: Memory at 92700000 (64-bit, non-prefetchable) =
[size=3D16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
	Capabilities: [50] MSI: Enable+ Count=3D2/8 Maskable- 64bit+
		Address: 00000000fee00418  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s =
<4us, L1 <32us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ =
SlotPowerLimit 25W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ =
FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ =
AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, =
Exit Latency L0s <1us, L1 <8us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable- =
CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- =
FltModeDis-
		LnkSta:	Speed 8GT/s, Width x2
			TrErr- Train- SlotClk+ DLActive- BWMgmt- =
ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ =
NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, =
ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, =
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ =
EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- =
Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- =
SpeedDis-
			 Transmit Margin: Normal Operating Range, =
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB =
de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, =
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ =
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, =
FltMode-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- =
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- =
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ =
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- =
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ =
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- =
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- =
AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- =
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- =
ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- =
HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 =
RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- =
WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed =
TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [168 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [188 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [190 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=3D25us =
PortTPowerOnTime=3D10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+
			   T_CommonMode=3D0us LTR1.2_Threshold=3D90112ns
		L1SubCtl2: T_PwrOn=3D44us
	Kernel driver in use: nvme
	Kernel modules: nvme

$ sudo lspci -vvv -s 00:1c.0
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root =
Port #1 (rev f1) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Device 7270
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 25
	IOMMU group: 5
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, =
sec-latency=3D0
	I/O behind bridge: f000-0fff [disabled] [16-bit]
	Memory behind bridge: 92700000-927fffff [size=3D1M] [32-bit]
	Prefetchable memory behind bridge: =
00000000fff00000-00000000000fffff [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- =
FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+ TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- =
AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit =
Latency L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, LnkDisable- =
CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ =
FltModeDis-
		LnkSta:	Speed 8GT/s, Width x2
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- =
ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- =
Surprise-
			Slot #0, PowerLimit 25W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- =
HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- =
Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- =
PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- =
PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ =
NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, =
ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, =
EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- =
ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- =
ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
			 IDOReq- IDOCompl- LTR+ =
EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- =
Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- =
SpeedDis-
			 Transmit Margin: Normal Operating Range, =
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB =
de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, =
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ =
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported, =
FltMode-
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: Intel Corporation Device 7270
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
	Capabilities: [100 v0] Null
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ =
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- =
UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=3D40us =
PortTPowerOnTime=3D44us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+
			   T_CommonMode=3D40us LTR1.2_Threshold=3D90112ns
		L1SubCtl2: T_PwrOn=3D44us
	Capabilities: [220 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport
	Kernel modules: shpchp

Best regards,
Ansgar=
