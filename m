Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58119 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3A1S4n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:56:43 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2] PCIe support for the Armada 370 and Armada XP SoCs
Date: Mon, 28 Jan 2013 19:56:09 +0100
Message-Id: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This series of patches introduces PCIe support for the Marvell Armada
370 and Armada XP. This "PATCH v2" follows the "RFC v1" that has been
sent on December, 7th. If possible, I'd like this patch series to be
considered 3.9 material, so reviews and comments are highly
appreciated in order to converge towards something that can be merged.

Since the previous version, the main changes are:

 * We now use the standard PCI Device Tree bindings, both for
   describing memory ranges, and interrupts.

 * We now use an emulated PCI host bridge and emulated PCI-to-PCI
   bridges to link together the PCIe interfaces of the SoC. This also
   has the added benefit that the allocation of memory and I/O
   addresses is now done by the PCI core, which avoids oversizing
   address decoding windows and removes a specific PCI address
   allocator that was present in the v1.

 * The driver is now located in drivers/pci/host.

On the Armada XP evaluation board that has 6 usable PCIe slots, one
Intel e1000e PCIe card connected in slot 3 and one Marvell SATA PCIe
card connected in slot 4, the lspci -t output is:

-[0000:00]-+-00.0
           +-01.0-[01]--
           +-02.0-[02]--
           +-03.0-[03]----00.0
           +-04.0-[04]----00.0
           +-05.0-[09]--
           \-06.0-[0a]--

With lspci showing:

00:00.0 Host bridge: Marvell Technology Group Ltd. Device 102d
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:04.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:06.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
03:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
04:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)

Please see at the end of this e-mail the entire output of lspci -vvv.

A quick description of the patches:

 * Patches 1 to 3 add PCI-related Device Tree parsing functions. Those
   patches are common with the Nvidia Tegra PCIe patch set from
   Thierry Redding. They are included in this series so that it can be
   tested easily.

 * Patch 4 extends the ARM PCI core to store a per-controller private
   data pointer. This patch is common with the Nvidia Tegra PCIe patch
   set from Thierry Redding. It is included in this series so that it
   can be tested easily.

 * Patch 5 extends the ARM PCI core with an additional hook that a PCI
   controller driver can register and get called to realign PCI
   ressource addresses. This is needed for the support of Marvell PCIe
   interfaces because the address decoding windows for I/O ranges have
   a granularity of 64 KB, while the PCI standard requires only a 4 KB
   alignement. See the patch itself for details.

 * Patch 6 fixes a problem in lib/devres.c that prevents certain
   PCI-related functions from being visible on NO_IOPORT platforms. I
   know this patch isn't acceptable by itself, but the discussion
   about this has been so huge and went in so many directions that in
   the end, I don't know what is the correct way of fixing this. If an
   agreement is found on how to fix this properly, I'm willing to work
   on it if needed.

 * Patch 7 and 8 respectively add a minimal emulated PCI host bridge
   and emulated PCI-to-PCI bridge. The former has originally been
   written by Thierry Redding. Even though I made a few minor changes
   to it, I kept Thierry's authorship on it (Thierry do not hesitate
   to let me know if my changes are too substantial to keep your name
   on this code). The latter was largely inspired by Thierry's code.

 * Patch 9 creates the drivers/pci/host directory and makes the
   related minimal changes to Kconfig/Makefile. This patch will
   trivially conflict with the NVidia Tegra PCIe support posted by
   Thierry Redding, which also creates the drivers/pci/host directory.

 * Patch 10 fixes a mistake in the interrupt controller node of the
   Armada 370/XP Device Tree, which was invisible until we started
   using the of_irq_map_raw() function, needed in our PCIe support.

 * Patch 11 and 12 fixes some issues in the Armada 370/XP clock gating
   driver, related to PCIe interfaces.

 * Patch 13 and 14 are cleanup/refactoring of the common plat-orion
   address decoding code, in preparation for further changes related
   to PCIe.

 * Patch 15 introduces in the common plat-orion address decoding code
   functions to allocate/free an address decoding window. Until now,
   the address decoding windows were configured statically. With
   Armada XP having up to 10 PCIe interfaces, we don't want to
   allocate useless address decoding windows statically, so we move to
   a more dynamic model in which address decoding windows are
   configured only for the PCIe interfaces that are actually in use.

 * Patch 16 improves the Armada 370/XP specific address decoding code
   to provide functions that add and remove an address decoding window
   for a given PCIe interface. It relies on the common functions added
   in patch 15.

 * Patch 17 makes the common plat-orion PCIe code available on
   PLAT_ORION platforms such as ARCH_MVEBU.

 * Patch 18 adds some variants of the PCI configuration space
   read/write functions that were available in the plat-orion/pcie.c
   code. Those variants are needed due to the usage of the emulated
   host-bridge + emulated PCI-to-PCI bridge model.

 * Patch 19 contains the Armada 370/XP PCIe driver itself, that
   implements the necessary operations required by the ARM PCI core,
   and configures the address decoding windows as needed. This driver
   relies on a Device Tree description of the PCIe interfaces.

 * Patch 20 marks the ARCH_MVEBU platform has having PCI available,
   which allows the compilation of the PCIe support.

 * Patches 21 and 22 add the SoC-level Device Tree informations
   related to PCIe for Armada 370 and Armada XP.

 * Patch 23, 24, 25 and 26 add the board-level Device Tree
   informations related to PCIe for the Armada XP DB, Armada 370 DB,
   PlatHome OpenBlocks AX3-4 and GlobalScale Mirabox boards.

 * Patch 27 updates mvebu_defconfig with PCI and USB support.

This patch set applies on top of v3.8-rc5, and has been pushed
at:

  git://github.com/MISL-EBU-System-SW/mainline-public.git marvell-pcie-v2

Thanks,

Thomas

---
Output of lspci -vvv:

# /usr/sbin/lspci -vvv
00:00.0 Host bridge: Marvell Technology Group Ltd. Device 102d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin ? routed to IRQ 0
	Capabilities: [fc] <chain broken>

00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 1092 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 1092 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 1092 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: c0000000-c0000fff
	Memory behind bridge: c1000000-c10fffff
	Prefetchable memory behind bridge: c1100000-c11fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:04.0 PCI bridge: Marvell Technology Group Ltd. Device 1092 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: c0010000-c0010fff
	Memory behind bridge: c1200000-c12fffff
	Prefetchable memory behind bridge: c1300000-c13fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 1092 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:06.0 PCI bridge: Marvell Technology Group Ltd. Device 1092 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

03:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
	Subsystem: Intel Corporation PRO/1000 PT Server Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 105
	Region 0: Memory at c1000000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c1020000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at c0000000 [disabled] [size=32]
	[virtual] Expansion ROM at c1100000 [disabled] [size=128K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-1b-21-ff-ff-c1-c4-fe
	Kernel driver in use: e1000e

04:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
	Subsystem: Marvell Technology Group Ltd. Device 11ab
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 106
	Region 0: Memory at c1200000 (64-bit, non-prefetchable) [size=1M]
	Region 2: I/O ports at c0010000 [size=256]
	[virtual] Expansion ROM at c1300000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000012345678  Data: 0000
	Capabilities: [60] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <256ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency L0 <256ns, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: sata_mv

