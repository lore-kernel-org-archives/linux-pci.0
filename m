Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45527 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751432AbaACTBJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 14:01:09 -0500
Date: Fri, 3 Jan 2014 20:01:06 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, linux-pci@vger.kernel.org,
	"Gregory Cl??ment" <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Issue with the emulated PCI bridge implementation
Message-ID: <20140103200106.5a0999a3@skate>
In-Reply-To: <201401031322.31433.arnd@arndb.de>
References: <20131226160534.36cc4203@skate>
	<20131226165241.2c50b244@skate>
	<20140103002656.GA12098@obsidianresearch.com>
	<201401031322.31433.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Fri, 3 Jan 2014 13:22:31 +0100, Arnd Bergmann wrote:

> However the part that made me wonder is that an e1000e with a PCI bridge
> actually /should/not/ need to allocate an I/O space window with a precious
> mbus resource, since AFAIK this adapter does not have an I/O space BARs.
> 
> Thomas, can you send the 'lspci -v' output of the system with this card
> to confirm that the I/O space is actually needed? If not, we should probably
> review the core PCI code to see why the bridge code tries to add this window.

I don't have the hardware next to me, but IIRC the card does have an
I/O space. It is not used by the mainline kernel driver, so I have a
hacky patch that modifies the e1000e driver to make it use the I/O
space and do a few I/O reads and writes. I've used that since the
beginning to test I/O space functionality of the pci-mvebu driver.

Digging in the LAKML archive, I found a lspci -v output about the
e1000e, and it has an I/O space:

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

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
