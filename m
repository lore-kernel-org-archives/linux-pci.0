Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:53270 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554AbbIXWbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 18:31:35 -0400
Date: Fri, 25 Sep 2015 00:23:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] pci: mvebu: generate proper configuration access
 cycles
Message-ID: <20150924222322.GF20825@lunn.ch>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
 <E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Testing with an ASM1062 PCIe to SATA mini-PCIe card on Armada 388.
> PCIe capability at 0x80, DevCtl at 0x88, DevSta at 0x8a.
> 
> Before:
> /# setpci -s 1:0.0 0x88.l		- DevSta: CorrErr+
> 00012810
> /# setpci -s 1:0.0 0x88.w=0x2810	- Write DevCtl only
> /# setpci -s 1:0.0 0x88.l		- CorrErr cleared - FAIL
> 00002810
> 
> After:
> /# setpci -s 1:0.0 0x88.l		- DevSta: CorrErr+
> 00012810
> /# setpci -s 1:0.0 0x88.w=0x2810	- check DevCtl only write
> /# setpci -s 1:0.0 0x88.l		- CorErr remains set
> 00012810
> /# setpci -s 1:0.0 0x88.w=0x281f	- check DevCtl write works
> /# setpci -s 1:0.0 0x88.l		- devctl field updated
> 0001281f
> /# setpci -s 1:0.0 0x8a.w=0xffff	- clear DevSta
> /# setpci -s 1:0.0 0x88.l		- CorrErr now cleared
> 0000281f
> /# setpci -s 1:0.0 0x88.w=0x2810	- restore DevCtl
> /# setpci -s 1:0.0 0x88.l		- check
> 00002810

Hi Russell

Can you give me some hints how to test this in my Kirkwood board.

root@dir665:~# lspci -nvvvv
00:01.0 0604: 11ab:6281 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00010000-00010fff
        Memory behind bridge: e0000000-e00fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

01:00.0 0200: 11ab:2a40
        Subsystem: 11ab:2a40
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 83
        Region 0: Memory at e0000000 (64-bit, non-prefetchable) [disabled] [size=64K]
        Region 2: Memory at e0010000 (64-bit, non-prefetchable) [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [130 v1] Device Serial Number 00-00-00-00-00-00-00-00

root@dir665:~# setpci -s 1:0.0 0x88.l
00000000

Nothing there, so your test does not work directly.

I tried

root@dir665:~# setpci -s 1:0.0 0xe8.l
00102000
root@dir665:~# setpci -s 1:0.0 0xe8.w=0x2000
root@dir665:~# setpci -s 1:0.0 0xe8.l
00102000

but that is not producing the FAIL you had.

Thanks
	Andrew
