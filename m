Return-Path: <SRS0=RsyK=HA=linux.ee=mroos@kernel.org>
Return-Path: <SRS0=RsyK=HA=linux.ee=mroos@kernel.org>
Date: Wed, 11 Apr 2018 23:25:06 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
    sparclinux@vger.kernel.org
Subject: Re: sparc64 PCI BAR allocation is still problematic
In-Reply-To: <20180411200143.GA105104@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LRH.2.21.1804112323170.25495@math.ut.ee>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee> <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com> <alpine.LRH.2.21.1804102144240.32411@math.ut.ee> <20180410185610.GD24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804111045330.18432@math.ut.ee> <20180411133334.GA91792@bhelgaas-glaptop.roam.corp.google.com> <alpine.LRH.2.21.1804111738260.18432@math.ut.ee> <20180411200143.GA105104@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

> Thanks, this is really interesting.  Would you mind replacing the test
> patch with the following (this applies directly on the upstream
> kernel, e.g., fd3b36d27566)?
> 
> Sorry for the back and forth, but there's a lot going on here that I
> don't understand.  
> 
> I'd like to see the complete dmesg log, /proc/iomem, and "lspci -vv".

00000000-7effdfff : System RAM
  00404000-0085ab9f : Kernel code
  0085aba0-009b8a8f : Kernel data
  009f2000-00a37a37 : Kernel bss
7f000000-7fee5fff : System RAM
7ff04000-7ff0bfff : System RAM
1ff00000000-1ffffffffff : /pci@1f,0
  1ff00000000-1ff000fffff : 0000:00:07.0
  1ff00400000-1ff0041ffff : 0000:00:0c.1
    1ff00400000-1ff0041ffff : sungem
  1ff00420000-1ff00421fff : 0000:00:0c.2
  1ff00422000-1ff00423fff : 0000:00:0c.2
  1ff00424000-1ff00425fff : 0000:00:08.0
  1ff00426000-1ff00427fff : 0000:00:13.0
  1ff00440000-1ff0045ffff : 0000:00:13.0
  1ff00800000-1ff00bfffff : 0000:00:0c.1
  1ff00c00000-1ff00ffffff : 0000:00:0c.2
  1ff01000000-1ff013fffff : 0000:00:0c.3
  1ff02000000-1ff02ffffff : 0000:00:0c.3
    1ff02000000-1ff02ffffff : ohci_hcd
  1ff03000000-1ff030fffff : PCI Bus 0000:01
    1ff03000000-1ff03001fff : 0000:01:00.0
      1ff03000000-1ff03001fff : sym53c8xx
    1ff03002000-1ff03003fff : 0000:01:02.0
    1ff03010000-1ff0301ffff : 0000:01:02.0
  1ff04000000-1ff04ffffff : 0000:00:13.0
    1ff04000000-1ff04ffffff : atyfb
  1ffc0000000-1ffdfffffff : IOMMU
  1fff1000000-1fff1001fff : eeprom


00:03.0 Non-VGA unclassified device: ULi Electronics Inc. M7101 Power Management Controller [PMU]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: [virtual] I/O ports at <unassigned> [size=16]
	Kernel driver in use: ali1535_smbus
00: b9 10 01 71 00 00 00 02 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 20 00 08 18 08 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40 01
70: 0f 11 00 00 00 00 00 08 00 00 00 00 00 00 00 00
80: 00 00 10 10 00 00 00 00 01 04 00 00 00 00 00 00
90: 00 00 02 00 00 00 00 0f 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 40 40 01 00 00 02 00 60 04 01 03 00 00 00 30
c0: 00 10 ff 00 00 00 00 00 01 00 00 00 00 00 00 00
d0: ff 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 08 00 06 01 00 01 00 00 00 00 00 00 00 00 00
f0: 45 00 20 7e 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 03000000-030fffff
	Prefetchable memory behind bridge: fffffffffff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
00: 11 10 24 00 07 00 90 02 03 00 04 06 10 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 11 11 80 02
20: 00 03 00 03 f1 ff 01 00 ff ff ff ff 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 3e 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 01
e0: 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+]
	Subsystem: ULi Electronics Inc. ALi M1533 Aladdin IV/V ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] I/O ports at 1fe02000000 [size=64K]
	Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=1M]
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 11 13 49 80 83 09 00 07 00 00 00 10 00 00 fd 01
50: 00 00 00 40 00 07 02 00 6e 03 09 00 00 00 00 08
60: 00 00 00 00 00 00 00 00 00 00 00 00 80 20 00 00
70: 00 00 06 00 41 03 00 d3 04 02 00 02 00 00 01 10
80: 07 00 33 01 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ULi Electronics Inc. M5451 PCI AC-Link Controller Audio Device (rev 01)
	Subsystem: ULi Electronics Inc. M5451 PCI AC-Link Controller Audio Device
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 0900 [disabled] [size=256]
	Region 1: Memory at 00424000 (32-bit, non-prefetchable) [disabled] [size=8K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 51 54 00 00 90 02 01 00 01 04 00 40 00 00
10: 01 09 00 00 00 40 42 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 51 54
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 01 02 18
40: 00 00 00 00 00 04 00 e2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 e6
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 Bridge: Oracle/SUN RIO EBUS (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (2500ns min, 6250ns max), Cache Line Size: 64 bytes
	BIST result: 00
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Region 1: Memory at <ignored> (32-bit, non-prefetchable)
00: 8e 10 00 11 46 01 80 02 01 00 80 06 10 40 80 80
10: 00 00 00 f0 00 00 00 f1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 19
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.1 Ethernet controller: Oracle/SUN RIO 10/100 Ethernet [eri] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (2500ns min, 1250ns max), Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 11
	BIST result: 00
	Region 0: Memory at 00400000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 00800000 [disabled] [size=4M]
	Kernel driver in use: gem
00: 8e 10 01 11 06 00 80 02 01 00 00 02 10 40 80 80
10: 00 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 80 00 00 00 00 00 00 00 00 00 00 00 0a 05
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.2 FireWire (IEEE 1394): Oracle/SUN RIO 1394 (rev 01) (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin ? routed to IRQ 12
	BIST result: 00
	Region 0: Memory at 00420000 (32-bit, non-prefetchable) [size=8K]
	Region 1: Memory at 00422000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at 00c00000 [disabled] [size=4M]
00: 8e 10 02 11 02 00 80 02 01 10 00 0c 10 40 80 80
10: 00 00 42 00 00 20 42 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 0a 05
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.3 USB controller: Oracle/SUN RIO USB (rev 01) (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (2500ns min, 1250ns max), Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 13
	BIST result: 00
	Region 0: Memory at 02000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at 01000000 [disabled] [size=4M]
	Kernel driver in use: ohci-pci
00: 8e 10 03 11 06 00 80 02 01 10 03 0c 10 40 80 80
10: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 01 00 00 00 00 00 00 00 00 00 00 0a 05
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c3) (prog-if ff)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 0a00 [size=8]
	Region 1: I/O ports at 0a18 [size=8]
	Region 2: I/O ports at 0a10 [size=8]
	Region 3: I/O ports at 0a08 [size=8]
	Region 4: I/O ports at 0a20 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pata_ali
00: b9 10 29 52 05 00 90 02 c3 ff 01 01 00 40 00 00
10: 01 0a 00 00 19 0a 00 00 11 0a 00 00 09 0a 00 00
20: 21 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 02 04
40: 06 00 00 7f 00 00 00 00 00 02 20 c9 00 80 ba 1a
50: 03 00 00 81 08 00 a8 00 01 31 31 31 03 09 0a 0a
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:13.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Rage XL PCI (rev 27) (prog-if 00 [VGA controller])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 04000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 0b00 [size=256]
	Region 2: Memory at 00426000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at 00440000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: atyfb
00: 02 10 52 47 83 00 90 02 27 00 00 03 10 40 00 00
10: 00 00 00 04 01 0b 00 00 00 60 42 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 44 00 5c 00 00 00 00 00 00 00 f1 01 08 00
40: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 5c 10 00 01 00 00 ff 00 00 00 00 01 00 02 06
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 12)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (2000ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at 03000000 (32-bit, non-prefetchable) [size=8K]
	Kernel driver in use: sym53c8xx
00: 00 10 01 00 17 00 00 02 12 00 00 01 10 40 00 00
10: 01 10 00 00 00 00 00 03 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 08 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: da 00 00 03 47 00 06 1f 00 08 00 00 80 00 00 02
90: ff e0 dc c1 00 ff ff ff 00 f0 31 21 a0 13 dd c1
a0: 00 08 00 01 00 00 00 50 c0 13 dd c1 c0 13 dd c1
b0: 00 10 dd c1 38 f0 dc c1 ce 6d 00 a1 c0 23 ba c1
c0: 8f 05 00 00 00 05 40 0f 0c 00 80 0f 07 00 02 80
d0: 00 00 02 80 00 00 02 80 00 00 02 80 00 01 ff 40
e0: 00 01 ff 40 00 01 ff 40 00 01 ff 40 00 01 ff 40
f0: 00 01 ff 40 00 01 ff 40 00 01 ff 40 00 01 ff 40

01:01.0 Multimedia audio controller: C-Media Electronics Inc CMI8738/CMI8768 PCI Audio (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 1100 [disabled] [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 00 00 10 02 10 00 01 04 00 40 00 00
10: 01 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f6 13 11 01
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 02 18
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:02.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at 03002000 (32-bit, non-prefetchable) [disabled] [size=8K]
	Region 1: Memory at 03010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: 13 10 05 60 00 00 10 02 01 00 01 04 00 40 00 00
10: 00 20 00 03 00 00 01 03 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 04 18
40: 01 00 22 7e 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


[    0.000059] PROMLIB: Sun IEEE Boot Prom 'OBP 4.17.1 2005/04/11 14:31'
[    0.000116] PROMLIB: Root node compatible: 
[    0.000217] Linux version 4.16.0-11316-gf77cfbe-dirty (mroos@blade100) (gcc version 4.9.3 (Debian 4.9.3-2)) #168 Wed Apr 11 23:14:41 EEST 2018
[    0.280335] bootconsole [earlyprom0] enabled
[    0.331447] ARCH: SUN4U
[    0.360724] Ethernet address: 00:03:ba:0b:7d:5d
[    0.414898] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits == 40)
[    0.494057] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.568973] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.720460] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.797625] Remapping the kernel... 
[    0.798175] done.
[    1.201703] OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
[    1.270449] PROM: Built device tree with 90708 bytes of memory.
[    1.341590] Top of RAM: 0x7ff0c000, Total RAM: 0x7feec000
[    1.406150] Memory hole size: 0MB
[    1.979239] Allocated 16384 bytes for kernel page tables.
[    2.044448] Zone ranges:
[    2.074793]   Normal   [mem 0x0000000000000000-0x000000007ff0bfff]
[    2.148765] Movable zone start for each node
[    2.199783] Early memory node ranges
[    2.242493]   node   0: [mem 0x0000000000000000-0x000000007effdfff]
[    2.317409]   node   0: [mem 0x000000007f000000-0x000000007fee5fff]
[    2.392326]   node   0: [mem 0x000000007ff04000-0x000000007ff0bfff]
[    2.467248] Initmem setup node 0 [mem 0x0000000000000000-0x000000007ff0bfff]
[    2.551514] On node 0 totalpages: 262006
[    2.551525]   Normal zone: 2048 pages used for memmap
[    2.551530]   Normal zone: 0 pages reserved
[    2.551539]   Normal zone: 262006 pages, LIFO batch:15
[    2.653830] Booting Linux...
[    2.688370] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    2.765450] CPU CAPS: [vis]
[    2.804900] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    2.804913] pcpu-alloc: [0] 0 
[    2.807648] Built 1 zonelists, mobility grouping on.  Total pages: 259958
[    2.888901] Kernel command line: root=/dev/sda2 ro console=ttyS0
[    2.974322] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[    3.066836] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    3.151270] Sorting __ex_table...
[    3.346086] Memory: 2069760K/2096048K available (4442K kernel code, 298K rwdata, 1096K rodata, 200K init, 278K bss, 26288K reserved, 0K cma-reserved)
[    3.506677] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    3.585528] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
[    3.655545] clocksource: hbtick: mask: 0xffffffffffffffff max_cycles: 0x148020aa9, max_idle_ns: 440795202069 ns
[    3.776260] clocksource: mult[b400012e] shift[24]
[    3.832470] clockevent: mult[16c16bf] shift[32]
[    3.886908] Console: colour dummy device 80x25
[    4.090118] Calibrating delay using timer specific routine.. 11.12 BogoMIPS (lpj=55648)
[    4.185866] pid_max: default: 32768 minimum: 301
[    4.241727] Mount-cache hash table entries: 4096 (order: 2, 32768 bytes)
[    4.321958] Mountpoint-cache hash table entries: 4096 (order: 2, 32768 bytes)
[    4.411687] devtmpfs: initialized
[    4.456082] random: get_random_u32 called from bucket_table_alloc+0x78/0x1e0 with crng_init=0
[    4.558763] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    4.676445] futex hash table entries: 256 (order: -1, 6144 bytes)
[    4.750134] NET: Registered protocol family 16
[    4.812677] IRQ pre handler NOT supported.
[    4.862096] IRQ pre handler NOT supported.
[    4.911395] IRQ pre handler NOT supported.
[    4.961961] audit: initializing netlink subsys (disabled)
[    5.033921] kworker/u2:0 (40) used greatest stack depth: 10304 bytes left
[    5.115934] random: fast init done
[    5.169855] /pci@1f,0: PCI IO [io  0x1fe02000000-0x1fe02ffffff] offset 1fe02000000
[    5.260566] /pci@1f,0: PCI MEM [mem 0x1ff00000000-0x1ffffffffff] offset 1ff00000000
[    5.352239] /pci@1f,0: SABRE PCI Bus Module ver[0:0]
[    5.411653] PCI: Scanning PBM /pci@1f,0
[    5.457965] sabre f005f408: PCI host bridge to bus 0000:00
[    5.523589] pci_bus 0000:00: root bus resource [io  0x1fe02000000-0x1fe02ffffff] (bus address [0x0000-0xffffff])
[    5.645351] pci_bus 0000:00: root bus resource [mem 0x1ff00000000-0x1ffffffffff] (bus address [0x00000000-0xffffffff])
[    5.773361] pci_bus 0000:00: root bus resource [bus 00-01]
[    5.839024] PCI: scan_bus[/pci@1f,0] bus no 0
[    5.891179]   * /pci@1f,0/ebus@c
[    5.929908]     create device, devfn: 60, type: 
[    5.985145]     class: 0x68000 device name: 0000:00:0c.0
[    6.048714] pci 0000:00:0c.0: [108e:1100] type 00 class 0x068000
[    6.120606]     adding to system ...
[    6.163761] PCI: dev header type: 0
[    6.205506]   * /pci@1f,0/isa@7
[    6.243152]     create device, devfn: 38, type: 
[    6.298419]     class: 0x60100 device name: 0000:00:07.0
[    6.361991] pci 0000:00:07.0: [10b9:1533] type 00 class 0x060100
[    6.433890]     parse addresses (40 bytes) @         (ptrval)
[    6.502673]   start: 1fe02000000, end: 1fe0200ffff, i: 10
[    6.567309] pci 0000:00:07.0: reg 0x10: [io  0x1fe02000000-0x1fe0200ffff]
[    6.648557]   start: 1ff00000000, end: 1ff000fffff, i: 14
[    6.713192] pci 0000:00:07.0: reg 0x14: [mem 0x1ff00000000-0x1ff000fffff]
[    6.794436]     adding to system ...
[    6.837517] PCI: dev header type: 0
[    6.879234]   * /pci@1f,0/pmu@3
[    6.916881]     create device, devfn: 18, type: 
[    6.972141]     class: 0x0 device name: 0000:00:03.0
[    7.031563] pci 0000:00:03.0: [10b9:7101] type 00 class 0x000000
[    7.103460]     parse addresses (20 bytes) @         (ptrval)
[    7.172245]   start: 1fe02000000, end: 1fe0200000f, i: 10
[    7.236882] pci 0000:00:03.0: reg 0x10: [io  0x1fe02000000-0x1fe0200000f]
[    7.318126]     adding to system ...
[    7.360970] pci 0000:00:03.0: quirk: [io  0x1fe02000800-0x1fe0200083f] claimed by ali7101 ACPI
[    7.464025] pci 0000:00:03.0: quirk: [io  0x1fe02000600-0x1fe0200061f] claimed by ali7101 SMB
[    7.566080] pci 0000:00:03.0: quirk_ali7101_acpi+0x0/0x40 took 19531 usecs
[    7.648616] PCI: dev header type: 0
[    7.690327]   * /pci@1f,0/network@c,1
[    7.734236]     create device, devfn: 61, type: network
[    7.796750]     class: 0x20000 device name: 0000:00:0c.1
[    7.860324] pci 0000:00:0c.1: [108e:1101] type 00 class 0x020000
[    7.932219]     parse addresses (40 bytes) @         (ptrval)
[    8.001003]   start: 1ff00400000, end: 1ff0041ffff, i: 10
[    8.065640] pci 0000:00:0c.1: reg 0x10: [mem 0x1ff00400000-0x1ff0041ffff]
[    8.146887]   start: 1ff00800000, end: 1ff00bfffff, i: 30
[    8.211522] pci 0000:00:0c.1: reg 0x30: [mem 0x1ff00800000-0x1ff00bfffff]
[    8.292769]     adding to system ...
[    8.335825] PCI: dev header type: 0
[    8.377569]   * /pci@1f,0/firewire@c,2
[    8.422489]     create device, devfn: 62, type: 
[    8.477747]     class: 0xc0010 device name: 0000:00:0c.2
[    8.541326] pci 0000:00:0c.2: [108e:1102] type 00 class 0x0c0010
[    8.613221]     parse addresses (60 bytes) @         (ptrval)
[    8.682007]   start: 1ff00420000, end: 1ff00421fff, i: 10
[    8.746642] pci 0000:00:0c.2: reg 0x10: [mem 0x1ff00420000-0x1ff00421fff]
[    8.827891]   start: 1ff00422000, end: 1ff00423fff, i: 14
[    8.892525] pci 0000:00:0c.2: reg 0x14: [mem 0x1ff00422000-0x1ff00423fff]
[    8.973775]   start: 1ff00c00000, end: 1ff00ffffff, i: 30
[    9.038411] pci 0000:00:0c.2: reg 0x30: [mem 0x1ff00c00000-0x1ff00ffffff]
[    9.119656]     adding to system ...
[    9.162736] PCI: dev header type: 0
[    9.204457]   * /pci@1f,0/usb@c,3
[    9.244184]     create device, devfn: 63, type: 
[    9.299439]     class: 0xc0310 device name: 0000:00:0c.3
[    9.363017] pci 0000:00:0c.3: [108e:1103] type 00 class 0x0c0310
[    9.434913]     parse addresses (40 bytes) @         (ptrval)
[    9.503701]   start: 1ff02000000, end: 1ff02ffffff, i: 10
[    9.568334] pci 0000:00:0c.3: reg 0x10: [mem 0x1ff02000000-0x1ff02ffffff]
[    9.649582]   start: 1ff01000000, end: 1ff013fffff, i: 30
[    9.714218] pci 0000:00:0c.3: reg 0x30: [mem 0x1ff01000000-0x1ff013fffff]
[    9.795464]     adding to system ...
[    9.838518] PCI: dev header type: 0
[    9.880258]   * /pci@1f,0/sound@8
[    9.919990]     create device, devfn: 40, type: 
[    9.975250]     class: 0x40100 device name: 0000:00:08.0
[   10.038823] pci 0000:00:08.0: [10b9:5451] type 00 class 0x040100
[   10.110721]     parse addresses (40 bytes) @         (ptrval)
[   10.179506]   start: 1fe02000900, end: 1fe020009ff, i: 10
[   10.244142] pci 0000:00:08.0: reg 0x10: [io  0x1fe02000900-0x1fe020009ff]
[   10.325391]   start: 1ff00424000, end: 1ff00425fff, i: 14
[   10.390026] pci 0000:00:08.0: reg 0x14: [mem 0x1ff00424000-0x1ff00425fff]
[   10.471271]     adding to system ...
[   10.514119] pci 0000:00:08.0: supports D1 D2
[   10.514131] pci 0000:00:08.0: PME# supported from D2 D3hot D3cold
[   10.514430] PCI: dev header type: 0
[   10.556172]   * /pci@1f,0/ide@d
[   10.593822]     create device, devfn: 68, type: ide
[   10.652205]     class: 0x101ff device name: 0000:00:0d.0
[   10.715780] pci 0000:00:0d.0: [10b9:5229] type 00 class 0x0101ff
[   10.787672]     parse addresses (100 bytes) @         (ptrval)
[   10.857495]   start: 1fe02000a00, end: 1fe02000a07, i: 10
[   10.922130] pci 0000:00:0d.0: reg 0x10: [io  0x1fe02000a00-0x1fe02000a07]
[   11.003380]   start: 1fe02000a18, end: 1fe02000a1f, i: 14
[   11.068016] pci 0000:00:0d.0: reg 0x14: [io  0x1fe02000a18-0x1fe02000a1f]
[   11.149264]   start: 1fe02000a10, end: 1fe02000a17, i: 18
[   11.213900] pci 0000:00:0d.0: reg 0x18: [io  0x1fe02000a10-0x1fe02000a17]
[   11.295150]   start: 1fe02000a08, end: 1fe02000a0f, i: 1c
[   11.359785] pci 0000:00:0d.0: reg 0x1c: [io  0x1fe02000a08-0x1fe02000a0f]
[   11.441033]   start: 1fe02000a20, end: 1fe02000a2f, i: 20
[   11.505669] pci 0000:00:0d.0: reg 0x20: [io  0x1fe02000a20-0x1fe02000a2f]
[   11.586915]     adding to system ...
[   11.629978] PCI: dev header type: 0
[   11.671708]   * /pci@1f,0/pci@5
[   11.709365]     create device, devfn: 28, type: pci
[   11.767742]     class: 0x60400 device name: 0000:00:05.0
[   11.831315] pci 0000:00:05.0: [1011:0024] type 01 class 0x060400
[   11.903210]     adding to system ...
[   11.946311] PCI: dev header type: 1
[   11.988001] of_scan_pci_bridge(/pci@1f,0/pci@5)
[   12.042236]     Bridge bus range [1 --> 1]
[   12.091470]     Bridge ranges[        (ptrval)] simba[0]
[   12.154985]     RAW Range[81000000:00000000:00001000:81000000:00000000:00001000:00000000:00001000]
[   12.262208]       Using flags[00000101] start[0000000000001000] size[0000000000001000]
[   12.356975]     RAW Range[82000000:00000000:03000000:82000000:00000000:03000000:00000000:00100000]
[   12.464201]       Using flags[00000200] start[0000000003000000] size[0000000000100000]
[   12.558963]     bus name: PCI Bus 0000:01
[   12.606967] PCI: scan_bus[/pci@1f,0/pci@5] bus no 1
[   12.665361]   * /pci@1f,0/pci@5/scsi@0
[   12.710304]     create device, devfn: 0, type: 
[   12.764510]     class: 0x10000 device name: 0000:01:00.0
[   12.828090] pci 0000:01:00.0: [1000:0001] type 00 class 0x010000
[   12.899985]     parse addresses (40 bytes) @         (ptrval)
[   12.968770]   start: 1fe02001000, end: 1fe020010ff, i: 10
[   13.033408] pci 0000:01:00.0: reg 0x10: [io  0x1fe02001000-0x1fe020010ff]
[   13.114655]   start: 1ff03000000, end: 1ff03001fff, i: 14
[   13.179290] pci 0000:01:00.0: reg 0x14: [mem 0x1ff03000000-0x1ff03001fff]
[   13.260537]     adding to system ...
[   13.303636] PCI: dev header type: 0
[   13.345332]   * /pci@1f,0/pci@5/sound@1
[   13.391308]     create device, devfn: 8, type: 
[   13.445520]     class: 0x40100 device name: 0000:01:01.0
[   13.509093] pci 0000:01:01.0: [13f6:0111] type 00 class 0x040100
[   13.580989]     parse addresses (20 bytes) @         (ptrval)
[   13.649773]   start: 1fe02001100, end: 1fe020011ff, i: 10
[   13.714410] pci 0000:01:01.0: reg 0x10: [io  0x1fe02001100-0x1fe020011ff]
[   13.795654]     adding to system ...
[   13.838512] pci 0000:01:01.0: supports D1 D2
[   13.838755] PCI: dev header type: 0
[   13.880452]   * /pci@1f,0/pci@5/sound@2
[   13.926429]     create device, devfn: 10, type: 
[   13.981678]     class: 0x40100 device name: 0000:01:02.0
[   14.045249] pci 0000:01:02.0: [1013:6005] type 00 class 0x040100
[   14.117146]     parse addresses (40 bytes) @         (ptrval)
[   14.185931]   start: 1ff03002000, end: 1ff03003fff, i: 10
[   14.250568] pci 0000:01:02.0: reg 0x10: [mem 0x1ff03002000-0x1ff03003fff]
[   14.331816]   start: 1ff03010000, end: 1ff0301ffff, i: 14
[   14.396450] pci 0000:01:02.0: reg 0x14: [mem 0x1ff03010000-0x1ff0301ffff]
[   14.477696]     adding to system ...
[   14.520555] pci 0000:01:02.0: supports D1 D2
[   14.520565] pci 0000:01:02.0: PME# supported from D0 D1 D2 D3hot
[   14.520870] PCI: dev header type: 0
[   14.562597]   * /pci@1f,0/SUNW,m64B@13
[   14.607528]     create device, devfn: 98, type: display
[   14.670066]     class: 0x30000 device name: 0000:00:13.0
[   14.733629] pci 0000:00:13.0: [1002:4752] type 00 class 0x030000
[   14.805526]     parse addresses (80 bytes) @         (ptrval)
[   14.874311]   start: 1ff04000000, end: 1ff04ffffff, i: 10
[   14.938947] pci 0000:00:13.0: reg 0x10: [mem 0x1ff04000000-0x1ff04ffffff]
[   15.020197]   start: 1fe02000b00, end: 1fe02000bff, i: 14
[   15.084831] pci 0000:00:13.0: reg 0x14: [io  0x1fe02000b00-0x1fe02000bff]
[   15.166080]   start: 1ff00426000, end: 1ff00427fff, i: 18
[   15.230717] pci 0000:00:13.0: reg 0x18: [mem 0x1ff00426000-0x1ff00427fff]
[   15.311966]   start: 1ff00440000, end: 1ff0045ffff, i: 30
[   15.376601] pci 0000:00:13.0: reg 0x30: [mem 0x1ff00440000-0x1ff0045ffff]
[   15.457846]     adding to system ...
[   15.500698] pci 0000:00:13.0: supports D1 D2
[   15.500959] PCI: dev header type: 0
[   15.542832] pci 0000:00:0c.0: class 0x68000
[   15.592936] PCI: Claiming 0000:00:07.0: Resource 0: 000001fe02000000..000001fe0200ffff [101]
[   15.693943] pci 0000:00:07.0: can't claim BAR 0 [io  0x1fe02000000-0x1fe0200ffff]: address conflict with 0000:00:03.0 [io  0x1fe02000600-0x1fe0200061f]
[   15.856232] PCI: Claiming 0000:00:07.0: Resource 1: 000001ff00000000..000001ff000fffff [200]
[   15.957232] pci 0000:00:07.0: class 0x60100
[   16.007314] PCI: Claiming 0000:00:03.0: Resource 0: 000001fe02000000..000001fe0200000f [101]
[   16.108310] pci 0000:00:03.0: class 0x0
[   16.154234] PCI: Claiming 0000:00:0c.1: Resource 0: 000001ff00400000..000001ff0041ffff [200]
[   16.255231] PCI: Claiming 0000:00:0c.1: Resource 6: 000001ff00800000..000001ff00bfffff [44200]
[   16.358309] pci 0000:00:0c.1: class 0x20000
[   16.408389] PCI: Claiming 0000:00:0c.2: Resource 0: 000001ff00420000..000001ff00421fff [200]
[   16.509387] PCI: Claiming 0000:00:0c.2: Resource 1: 000001ff00422000..000001ff00423fff [200]
[   16.610384] PCI: Claiming 0000:00:0c.2: Resource 6: 000001ff00c00000..000001ff00ffffff [44200]
[   16.713462] pci 0000:00:0c.2: class 0xc0010
[   16.763541] PCI: Claiming 0000:00:0c.3: Resource 0: 000001ff02000000..000001ff02ffffff [200]
[   16.864540] PCI: Claiming 0000:00:0c.3: Resource 6: 000001ff01000000..000001ff013fffff [44200]
[   16.967617] pci 0000:00:0c.3: class 0xc0310
[   17.017696] PCI: Claiming 0000:00:08.0: Resource 0: 000001fe02000900..000001fe020009ff [101]
[   17.118693] PCI: Claiming 0000:00:08.0: Resource 1: 000001ff00424000..000001ff00425fff [200]
[   17.219694] pci 0000:00:08.0: class 0x40100
[   17.269774] PCI: Claiming 0000:00:0d.0: Resource 0: 000001fe02000a00..000001fe02000a07 [101]
[   17.370772] PCI: Claiming 0000:00:0d.0: Resource 1: 000001fe02000a18..000001fe02000a1f [101]
[   17.471768] PCI: Claiming 0000:00:0d.0: Resource 2: 000001fe02000a10..000001fe02000a17 [101]
[   17.572766] PCI: Claiming 0000:00:0d.0: Resource 3: 000001fe02000a08..000001fe02000a0f [101]
[   17.673762] PCI: Claiming 0000:00:0d.0: Resource 4: 000001fe02000a20..000001fe02000a2f [101]
[   17.774763] pci 0000:00:0d.0: class 0x101ff
[   17.824843] PCI: Claiming 0000:00:05.0: Resource 7: 000001fe02001000..000001fe02001fff [101]
[   17.925839] PCI: Claiming 0000:00:05.0: Resource 8: 000001ff03000000..000001ff030fffff [200]
[   18.026838] pci 0000:00:05.0: class 0x60400
[   18.076919] PCI: Claiming 0000:00:13.0: Resource 0: 000001ff04000000..000001ff04ffffff [200]
[   18.177916] PCI: Claiming 0000:00:13.0: Resource 1: 000001fe02000b00..000001fe02000bff [101]
[   18.278914] PCI: Claiming 0000:00:13.0: Resource 2: 000001ff00426000..000001ff00427fff [200]
[   18.379910] PCI: Claiming 0000:00:13.0: Resource 6: 000001ff00440000..000001ff0045ffff [44200]
[   18.482987] pci 0000:00:13.0: class 0x30000
[   18.533079] pci 0000:00:13.0: requesting [mem 0x1ff000a0000-0x1ff000bffff] from /pci@1f,0 [mem 0x1ff00000000-0x1ffffffffff]
[   18.666284] pci 0000:00:13.0: can't claim VGA legacy [mem 0x1ff000a0000-0x1ff000bffff]: address conflict with 0000:00:07.0 [mem 0x1ff00000000-0x1ff000fffff]
[   18.833774] PCI: Claiming 0000:01:00.0: Resource 0: 000001fe02001000..000001fe020010ff [101]
[   18.934771] PCI: Claiming 0000:01:00.0: Resource 1: 000001ff03000000..000001ff03001fff [200]
[   19.035769] pci 0000:01:00.0: class 0x10000
[   19.085850] PCI: Claiming 0000:01:01.0: Resource 0: 000001fe02001100..000001fe020011ff [101]
[   19.186849] pci 0000:01:01.0: class 0x40100
[   19.236931] PCI: Claiming 0000:01:02.0: Resource 0: 000001ff03002000..000001ff03003fff [200]
[   19.337928] PCI: Claiming 0000:01:02.0: Resource 1: 000001ff03010000..000001ff0301ffff [200]
[   19.438926] pci 0000:01:02.0: class 0x40100
[   19.496203] audit: type=2000 audit(0.320:1): state=initialized audit_enabled=0 res=1
[   19.622228] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[   19.702481] HugeTLB registered 8.00 MiB page size, pre-allocated 0 pages
[   19.782649] HugeTLB registered 256 MiB page size, pre-allocated 0 pages
[   19.861824] HugeTLB registered 2.00 GiB page size, pre-allocated 0 pages
[   19.945112] pci 0000:00:13.0: vgaarb: command 0x0080
[   20.004588] pci 0000:00:13.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[   20.104590] pci 0000:00:13.0: vgaarb: bridge control possible
[   20.173340] pci 0000:00:13.0: vgaarb: setting as boot device (VGA legacy resources not enabled)
[   20.277446] vgaarb: loaded
[   20.310330] SCSI subsystem initialized
[   20.357726] libata version 3.00 loaded.
[   20.362515] /pci@1f,0/ebus@c/eeprom@1,0: Mostek regs at 0x1fff1000000
[   20.440726] clocksource: Switched to clocksource hbtick
[   20.520493] kworker/u2:2 (232) used greatest stack depth: 9104 bytes left
[   20.628364] NET: Registered protocol family 2
[   20.681769] tcp_listen_portaddr_hash hash table entries: 1024 (order: 1, 16384 bytes)
[   20.775592] TCP established hash table entries: 16384 (order: 4, 131072 bytes)
[   20.862705] TCP bind hash table entries: 16384 (order: 4, 131072 bytes)
[   20.942575] TCP: Hash tables configured (established 16384 bind 16384)
[   21.021233] UDP hash table entries: 1024 (order: 2, 32768 bytes)
[   21.093318] UDP-Lite hash table entries: 1024 (order: 2, 32768 bytes)
[   21.171152] NET: Registered protocol family 1
[   21.223437] pci 0000:00:07.0: Activating ISA DMA hang workarounds
[   21.296401] pci 0000:00:07.0: quirk_isa_dma_hangs+0x0/0x40 took 71237 usecs
[   21.379757] PCI: Enabling device: (0000:00:0c.3), cmd 2
[   21.510825] pci 0000:00:0c.3: quirk_usb_early_handoff+0x0/0x740 took 127968 usecs
[   21.600498] PCI: CLS 64 bytes, default 64
[   21.600871] power: Control reg at 1fe02000800
[   21.658494] workingset: timestamp_bits=62 max_order=18 bucket_order=0
[   21.787091] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[   21.875693] io scheduler noop registered
[   21.923116] io scheduler cfq registered (default)
[   21.979998] PCI: Enabling device: (0000:00:13.0), cmd 83
[   21.980065] atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
[   22.055139] atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
[   22.211443] Console: switching to colour frame buffer device 80x30
[   22.294364] atyfb: fb0: ATY Mach64 frame buffer device on PCI
[   22.366227] f007d64c: ttyS0 at MMIO 0x1fe020003f8 (irq = 9, base_baud = 115387) is a 16550A
[   22.466332] Console: ttyS0 (SU)
[   22.504011] console [ttyS0] enabled
[   22.591449] bootconsole [earlyprom0] disabled
[   22.702383] f007f1a4: ttyS1 at MMIO 0x1fe020002e8 (irq = 9, base_baud = 115387) is a 16550A
[   22.813941] PCI: Enabling device: (0000:00:0d.0), cmd 5
[   22.820467] scsi host0: pata_ali
[   22.864871] scsi host1: pata_ali
[   22.907614] ata1: PATA max UDMA/66 cmd 0x1fe02000a00 ctl 0x1fe02000a18 bmdma 0x1fe02000a20 irq 15
[   23.024268] ata2: PATA max UDMA/66 cmd 0x1fe02000a10 ctl 0x1fe02000a08 bmdma 0x1fe02000a28 irq 15
[   23.143206] mousedev: PS/2 mouse device common for all mice
[   23.219219] rtc-m48t59 rtc-m48t59.0: registered as rtc0
[   23.288749] NET: Registered protocol family 17
[   23.347160] Key type dns_resolver registered
[   23.406899] registered taskstats version 1
[   23.462916] Key type encrypted registered
[   23.516861] rtc-m48t59 rtc-m48t59.0: setting system clock to 2018-04-11 20:18:18 UTC (1523477898)
[   23.633992] ata1.00: ATA-5: ST320414A, 3.28, max UDMA/100
[   23.704921] ata1.00: 39851760 sectors, multi 0: LBA 
[   23.770211] ata1.01: ATAPI: LTN486S, Y3S2, max UDMA/33
[   23.837714] ata1.01: WARNING: ATAPI DMA disabled for reliability issues.  It can be enabled
[   23.947528] ata1.01: WARNING: via pata_ali.atapi_dma modparam or corresponding sysfs node.
[   24.060901] ata1.00: configured for UDMA/66
[   24.118364] ata1.01: configured for UDMA/33
[   24.174823] scsi 0:0:0:0: Direct-Access     ATA      ST320414A        3.28 PQ: 0 ANSI: 5
[   24.283973] sd 0:0:0:0: [sda] 39851760 512-byte logical blocks: (20.4 GB/19.0 GiB)
[   24.385464] scsi 0:0:1:0: CD-ROM            LITEON   CD-ROM LTN486S   Y3S2 PQ: 0 ANSI: 5
[   24.492621] sd 0:0:0:0: [sda] Write Protect is off
[   24.555632] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   24.558277] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   24.686096]  sda: sda1 sda2 sda3 sda4
[   24.749770] sd 0:0:0:0: [sda] Attached SCSI disk
[   24.847810] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   24.948613] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   25.064513] devtmpfs: mounted
[   25.104639] This architecture does not have kernel memory protection.
[   26.061161] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[   26.236661] systemd[1]: Detected architecture 'sparc64'.
[   26.671894] systemd[1]: Inserted module 'autofs4'
[   26.800339] NET: Registered protocol family 10
[   26.946140] modprobe (500) used greatest stack depth: 7200 bytes left
[   27.090050] Segment Routing with IPv6
[   27.138485] systemd[1]: Inserted module 'ipv6'
[   27.210274] systemd[1]: Set hostname to <blade100>.
[   27.970208] systemd-fstab-g (513) used greatest stack depth: 7000 bytes left
[   28.590730] systemd-sysv-ge (518) used greatest stack depth: 6680 bytes left
[   29.410697] systemd[1]: Cannot add dependency job for unit display-manager.service, ignoring: Unit display-manager.service failed to load: No such file or directory.
[   29.609766] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[   29.711102] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   29.810778] systemd[1]: Expecting device dev-ttyS0.device...
[   29.950980] systemd[1]: Starting Remote File Systems (Pre).
[   31.100922] systemd[1]: Listening on Journal Socket.
[   31.166388] systemd[1]: Starting System Slice.
[   31.280957] systemd[1]: Created slice System Slice.
[   31.345305] systemd[1]: Starting File System Check on Root Device...
[   31.495162] systemd[1]: Starting system-systemd\x2dfsck.slice.
[   31.651043] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   31.736980] systemd[1]: Starting system-getty.slice.
[   31.803873] systemd[1]: Created slice system-getty.slice.
[   31.892349] systemd[1]: Starting system-serial\x2dgetty.slice.
[   31.991909] systemd[1]: Created slice system-serial\x2dgetty.slice.
[   32.781823] loop: module loaded
[   33.950896] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   34.594866] systemd-udevd[858]: starting version 215
[   35.389844] /pci@1f,0/ebus@c/flashprom@0,0: OBP Flash, RD 1fff0000000[100000] WR 1fff0000000[100000]
[   35.891041] usbcore: registered new interface driver usbfs
[   35.963346] usbcore: registered new interface driver hub
[   36.033281] usbcore: registered new device driver usb
[   36.178897] PCI: Enabling device: (0000:00:03.0), cmd 1
[   36.194250] PCI: Enabling device: (0000:01:00.0), cmd 3
[   36.194997] sym0: <810a> rev 0x12 at pci 0000:01:00.0 irq 16
[   36.282598] i2c i2c-0: Error: command never completed
[   36.363542] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   36.434571] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   36.671145] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   36.762362] random: crng init done
[   36.896231] i2c i2c-0: Error: command never completed
[   36.986450] sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
[   37.069076] sym0: SCSI BUS has been reset.
[   37.122903] scsi host2: sym-2.2.3
[   37.190955] sr 0:0:1:0: [sr0] scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
[   37.287115] cdrom: Uniform CD-ROM driver Revision: 3.20
[   37.460994] sr 0:0:1:0: Attached scsi generic sg1 type 5
[   37.615750] i2c i2c-0: Error: command never completed
[   37.694838] sr 0:0:1:0: Attached scsi CD-ROM sr0
[   37.697846] i2c i2c-0: Error: command never completed
[   37.789344] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   37.881449] i2c i2c-0: Error: command never completed
[   37.956046] i2c i2c-0: Error: command never completed
[   38.032177] i2c i2c-0: Error: command never completed
[   38.105769] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   38.192532] i2c i2c-0: Error: command never completed
[   38.273178] i2c i2c-0: Error: command never completed
[   38.348701] i2c i2c-0: Error: command never completed
[   38.425577] i2c i2c-0: Error: command never completed
[   38.493495] ehci-pci: EHCI PCI platform driver
[   38.608019] i2c i2c-0: Error: command never completed
[   38.676301] sungem.c:v1.0 David S. Miller <davem@redhat.com>
[   38.752290] gem 0000:00:0c.1 eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:0b:7d:5d
[   38.892964] ohci-pci: OHCI PCI platform driver
[   38.951551] ohci-pci 0000:00:0c.3: OHCI PCI host controller
[   39.024840] ohci-pci 0000:00:0c.3: new USB bus registered, assigned bus number 1
[   39.122190] ohci-pci 0000:00:0c.3: irq 13, io mem 0x1ff02000000
[   39.271178] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.16
[   39.379924] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   39.474909] usb usb1: Product: OHCI PCI host controller
[   39.543571] usb usb1: Manufacturer: Linux 4.16.0-11316-gf77cfbe-dirty ohci_hcd
[   39.638437] usb usb1: SerialNumber: 0000:00:0c.3
[   39.709158] hub 1-0:1.0: USB hub found
[   39.759851] hub 1-0:1.0: 4 ports detected
[   39.823518] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   39.894525] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   40.099630] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   40.170645] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   42.770525] Adding 907664k swap on /dev/sda4.  Priority:-2 extents:1 across:907664k 
[   43.331927] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   43.461921] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   44.086961] systemd-journald[848]: Received request to flush runtime journal from PID 1
[   45.582986] sungem_phy: PHY ID: 437421, addr: 1
[   45.583023] gem 0000:00:0c.1 eth0: Found Generic MII PHY
[   45.653493] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   45.734391] ip (1089) used greatest stack depth: 6528 bytes left
[   47.306788] systemd-udevd (871) used greatest stack depth: 5808 bytes left
[   47.412708] systemd-udevd (863) used greatest stack depth: 4592 bytes left
[   48.151054] gem 0000:00:0c.1 eth0: Link is up at 100 Mbps, full-duplex
[   48.242519] gem 0000:00:0c.1 eth0: Pause is disabled
[   48.311819] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

-- 
Meelis Roos (mroos@linux.ee)
