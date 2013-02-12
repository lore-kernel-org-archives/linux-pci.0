Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45740 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295Ab3BLQ3U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:20 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH v3] PCIe support for the Armada 370 and Armada XP SoCs
Date: Tue, 12 Feb 2013 17:28:34 +0100
Message-Id: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This series of patches introduces PCIe support for the Marvell Armada
370 and Armada XP.

This PATCHv3 follows:
 * PATCHv2, sent on January, 28th 2013
 * RFCv1, sent on December, 7th 2012

Thanks to all the people who discussed on the previous version of the
patch set. The discussions have been long and complicated, but
certainly very useful.

In order to make progress on this, and help reducing the size of the
patch set, I would ask if it would be possible to merge patches 1 to
17 from the series for 3.9 (only preparation work), keeping the rest
for 3.10. The patches in question are PCI-related, ARM-related, and
mvebu/orion-related.

Changes between v2 and v3:

 * Use of_irq_map_pci() instead of of_irq_map_raw(), as suggested by
   Andrew Murray. In order to do this, we moved the interrupt-map and
   interrupt-map-mask DT properties from the main PCIe controller node
   to the DT subnodes representing each PCIe interface.

 * Remove the usage of the emulated host bridge.

 * Move the emulated PCI-to-PCI bridge code into the Marvell PCI
   driver itself, in order to allow a tighter integration. Suggested
   by Bjorn Helgaas and Jason Gunthorpe.

 * Make the allocation of address decoding windows dynamic: it's when
   memory accesses or I/O accesses are enabled at the PCI-to-PCI
   bridge level that we allocate and setup the corresponding address
   decoding window. Requested by Bjorn Helgaas.

 * Fixed the implementation of I/O accesses to use I/O addresses that
   fall within the normal IO_SPACE_LIMIT. This required using the
   "remap" functionality of address decoding windows, and therefore
   some changes in the address decoding window allocator. Follows a
   long discussion about I/O accesses.

 * Set up a correct bus number in the configuration of the PCIe
   interfaces so that we don't have to fake bus numbers
   anymore. Requested by Jason Gunthorpe.

 * Fix the of_pci_get_devfn() implementation according to Stephen
   Warren's comment.

 * Use CFLAGS_ instead of ccflags to add the mach-mvebu and plat-orion
   include paths when building the pci-mvebu driver. This ensures that
   the include paths are only added when building this specific
   driver. Requested by Stephen Warren.

 * Fix the ->resource_align() to only apply on bus 0 (the one on which
   the emulated PCI-to-PCI bridges sit), and to request an alignment
   on the size of the window (and not only 64 KB for I/O windows and 1
   MB for memory windows).

 * Clarified the commit log of "clk: mvebu: create parent-child
   relation for PCIe clocks on Armada 370"

A quick description of the patches:

 * Patches 1 to 3 add PCI-related Device Tree parsing functions. Those
   patches are common with the Nvidia Tegra PCIe patch set from
   Thierry Redding. They are included in this series so that it can be
   tested easily.

 * Patch 4 extends the ARM PCI core to store a per-controller private
   data pointer. This patch is common with the Nvidia Tegra PCIe patch
   set from Thierry Redding. It is included in this series so that it
   can be tested easily.

 * Patch 5 fixes a problem in lib/devres.c that prevents certain
   PCI-related functions from being visible on NO_IOPORT platforms. I
   know this patch isn't acceptable by itself, but the discussion
   about this has been so huge and went in so many directions that in
   the end, I don't know what is the correct way of fixing this. If an
   agreement is found on how to fix this properly, I'm willing to work
   on it if needed.

 * Patch 6 extends the ARM PCI core with an additional hook that a PCI
   controller driver can register and get called to realign PCI
   ressource addresses. This is needed for the support of Marvell PCIe
   interfaces because the address decoding windows for I/O ranges have
   a granularity of 64 KB, while the PCI standard requires only a 4 KB
   alignement. See the patch itself for details.

 * Patch 7 fixes a mistake in the interrupt controller node of the
   Armada 370/XP Device Tree, which was invisible until we started
   using the of_irq_map_raw() function, needed in our PCIe support.

 * Patches 8 and 9 fix some issues in the Armada 370/XP clock gating
   driver, related to PCIe interfaces.

 * Patches 10 and 11 are cleanup/refactoring of the common plat-orion
   address decoding code, in preparation for further changes related
   to PCIe.

 * Patches 12 to 17 introduce a ORION_ADDR_MAP_NO_REMAP define that is
   used by existing Marvell SoC code to say "I don't need this window
   to remap anything". Previously a -1 value was used as the remap
   address to communicate the fact that no remap is needed, but this
   prevents any remap address higher than 2 GB.

 * Patch 18 removes __init from a few address window decoding
   functions that are now needed after boot.

 * Patch 19 introduces in the common plat-orion address decoding code
   functions to allocate/free an address decoding window. Until now,
   the address decoding windows were configured statically. With
   Armada XP having up to 10 PCIe interfaces, we don't want to
   allocate useless address decoding windows statically, so we move to
   a more dynamic model in which address decoding windows are
   configured only for the PCIe interfaces that are actually in use.

 * Patch 20 removes __init from a few PCIe functions that are now
   needed after boot.

 * Patch 21 improves the Armada 370/XP specific address decoding code
   to provide functions that add and remove an address decoding window
   for a given PCIe interface. It relies on the common functions added
   in patch 19.

 * Patch 22 makes the common plat-orion PCIe code available on
   PLAT_ORION platforms such as ARCH_MVEBU.

 * Patch 23 creates the drivers/pci/host directory and makes the
   related minimal changes to Kconfig/Makefile. This patch will
   trivially conflict with the NVidia Tegra PCIe support posted by
   Thierry Redding, which also creates the drivers/pci/host directory.

 * Patch 24 contains the Armada 370/XP PCIe driver itself, that
   implements the necessary operations required by the ARM PCI core,
   and configures the address decoding windows as needed. This driver
   relies on a Device Tree description of the PCIe interfaces.

 * Patch 25 marks the ARCH_MVEBU platform has having PCI available,
   which allows the compilation of the PCIe support.

 * Patches 26 and 27 add the SoC-level Device Tree informations
   related to PCIe for Armada 370 and Armada XP.

 * Patch 28 to 31 add the board-level Device Tree informations related
   to PCIe for the Armada XP DB, Armada 370 DB, PlatHome OpenBlocks
   AX3-4 and GlobalScale Mirabox boards.

 * Patch 32 updates mvebu_defconfig with PCI and USB support.

This patch set applies on top of v3.8-rc7, and has been pushed
at:

  git://github.com/MISL-EBU-System-SW/mainline-public.git marvell-pcie-v3

Thanks,

Thomas

---
Output of lspci -vvv:

00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 00 [Normal decode])
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

00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 00 [Normal decode])
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

00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00010000-00010fff
	Memory behind bridge: c1000000-c10fffff
	Prefetchable memory behind bridge: c1100000-c11fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:04.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00020000-00020fff
	Memory behind bridge: c1200000-c12fffff
	Prefetchable memory behind bridge: c1300000-c13fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

00:06.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ <MAbort+ >SERR+ <PERR+ INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
		PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+
	Capabilities: [fc] <chain broken>

03:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
	Subsystem: Marvell Technology Group Ltd. Device 11ab
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 105
	Region 0: Memory at c1000000 (64-bit, non-prefetchable) [size=1M]
	Region 2: I/O ports at 10000 [size=256]
	[virtual] Expansion ROM at c1100000 [disabled] [size=512K]
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

05:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
	Subsystem: Intel Corporation PRO/1000 PT Server Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 106
	Region 0: Memory at c1200000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c1220000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 20000 [disabled] [size=32]
	[virtual] Expansion ROM at c1300000 [disabled] [size=128K]
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

Boot messages from the PCI subsystem:

mvebu-pcie pcie-controller.1: PCIe0.0: link down
mvebu-pcie pcie-controller.1: PCIe0.1: link down
mvebu-pcie pcie-controller.1: PCIe0.2: link up
mvebu-pcie pcie-controller.1: PCIe0.3: link down
mvebu-pcie pcie-controller.1: PCIe2.0: link up
mvebu-pcie pcie-controller.1: PCIe3.0: link down
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xc1000000-0xc8ffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:06.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers enabled
PCI: bus2: Fast back to back transfers enabled
PCI: bus3: Fast back to back transfers disabled
PCI: bus4: Fast back to back transfers enabled
PCI: bus5: Fast back to back transfers disabled
PCI: bus6: Fast back to back transfers enabled
pci 0000:00:03.0: BAR 8: assigned [mem 0xc1000000-0xc10fffff]
pci 0000:00:03.0: BAR 9: assigned [mem 0xc1100000-0xc11fffff pref]
pci 0000:00:05.0: BAR 8: assigned [mem 0xc1200000-0xc12fffff]
pci 0000:00:05.0: BAR 9: assigned [mem 0xc1300000-0xc13fffff pref]
pci 0000:00:03.0: BAR 7: assigned [io  0x10000-0x10fff]
pci 0000:00:05.0: BAR 7: assigned [io  0x20000-0x20fff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:03:00.0: BAR 0: assigned [mem 0xc1000000-0xc10fffff 64bit]
pci 0000:03:00.0: BAR 6: assigned [mem 0xc1100000-0xc117ffff pref]
pci 0000:03:00.0: BAR 2: assigned [io  0x10000-0x100ff]
pci 0000:00:03.0: PCI bridge to [bus 03]
pci 0000:00:03.0:   bridge window [io  0x10000-0x10fff]
pci 0000:00:03.0:   bridge window [mem 0xc1000000-0xc10fffff]
pci 0000:00:03.0:   bridge window [mem 0xc1100000-0xc11fffff pref]
pci 0000:00:04.0: PCI bridge to [bus 04]
pci 0000:05:00.0: BAR 0: assigned [mem 0xc1200000-0xc121ffff]
pci 0000:05:00.0: BAR 1: assigned [mem 0xc1220000-0xc123ffff]
pci 0000:05:00.0: BAR 6: assigned [mem 0xc1300000-0xc131ffff pref]
pci 0000:05:00.0: BAR 2: assigned [io  0x20000-0x2001f]
pci 0000:00:05.0: PCI bridge to [bus 05]
pci 0000:00:05.0:   bridge window [io  0x20000-0x20fff]
pci 0000:00:05.0:   bridge window [mem 0xc1200000-0xc12fffff]
pci 0000:00:05.0:   bridge window [mem 0xc1300000-0xc13fffff pref]
pci 0000:00:06.0: PCI bridge to [bus 06]
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:00:02.0 (0140 -> 0143)
PCI: enabling device 0000:00:03.0 (0140 -> 0143)
PCI: enabling device 0000:00:04.0 (0140 -> 0143)
PCI: enabling device 0000:00:05.0 (0140 -> 0143)
PCI: enabling device 0000:00:06.0 (0140 -> 0143)

