Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:35204 "EHLO smtp1.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbbJMUiB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 16:38:01 -0400
Date: Tue, 13 Oct 2015 23:39:34 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
In-Reply-To: <CAE9FiQWhE=-FtZjuC5-fTzuTq0tm9Zt1MiD8J0a_Q_jiB5RLNg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1510132338510.14105@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee> <CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com> <alpine.LRH.2.20.1510120808240.3251@math.ut.ee> <CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
 <alpine.LRH.2.20.1510130800380.3972@math.ut.ee> <CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com> <alpine.LRH.2.20.1510131020140.9747@math.ut.ee> <CAE9FiQWhE=-FtZjuC5-fTzuTq0tm9Zt1MiD8J0a_Q_jiB5RLNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >> Can you send boot log after booting with "debug ignore_loglevel ofpci_debug=1" ?
> >
> > http://kodu.ut.ee/~mroos/dm/dm.v210+patch+debug
> 
> Firmware does reported overlapped resources.
[...] 
> can you send out output for
> lspci -vvxxx
> lspci -tv

Here you are.

0000:00:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
	Subsystem: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 6
	Region 0: Memory at 00200000 (64-bit, non-prefetchable) [size=2M]
	Region 2: Memory at 00110000 (64-bit, non-prefetchable) [size=64K]
	Region 4: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchable)
	Expansion ROM at fffff80900000000 [disabled]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=1
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 2d92e07bc876dbd0  Data: 0c1b
	Kernel driver in use: tg3
00: e4 14 48 16 06 00 b0 02 00 00 00 02 10 40 80 00
10: 04 00 20 00 00 00 00 00 04 00 11 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e4 14 48 16
30: 00 00 81 2b 40 00 00 00 00 00 00 00 a3 01 40 00
40: 07 48 02 00 f8 ff 43 04 01 50 02 40 00 20 00 00
50: 03 58 00 00 3b 79 48 4b 05 00 86 00 d0 db 76 c8
60: 7b e0 92 2d 1b 0c 00 00 98 02 03 20 00 00 3f 76
70: ee 00 00 00 c4 00 00 80 4c 5b 03 00 00 00 00 00
80: 00 00 00 00 00 59 b0 00 36 00 13 04 82 90 20 02
90: 09 97 00 01 01 00 00 00 00 00 00 00 f5 01 00 00
a0: 00 00 00 00 2d 01 00 00 00 00 00 00 e3 01 00 00
b0: 00 00 00 00 00 00 00 71 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
	Subsystem: Oracle/SUN Device 1648
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at 00400000 (64-bit, non-prefetchable) [size=2M]
	Region 2: Memory at 00120000 (64-bit, non-prefetchable) [size=64K]
	Region 4: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at fffff80900000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff80900000000 [disabled]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=1
		Status: Dev=ff:1f.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 2e047d69dfc7ac80  Data: d6f4
	Kernel driver in use: tg3
00: e4 14 48 16 06 00 b0 02 00 00 00 02 10 40 80 00
10: 04 00 40 00 00 00 00 00 04 00 12 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 48 16
30: 00 00 00 00 40 00 00 00 00 00 00 00 22 02 40 00
40: 07 48 02 00 f9 ff 43 04 01 50 02 40 00 20 00 00
50: 03 58 00 00 d8 30 08 01 05 00 86 00 80 ac c7 df
60: 69 7d 04 2e f4 d6 00 00 9a 02 03 20 00 00 3f 76
70: 0e 02 00 00 c4 00 00 00 00 00 00 00 00 00 00 00
80: e4 14 48 16 f8 80 3b 05 36 00 00 00 fe 90 60 02
90: 01 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:00:06.0 Non-VGA unclassified device: ULi Electronics Inc. M7101 Power Management Controller [PMU]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: [virtual] I/O ports at <unassigned> [size=16]
	Region 1: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 2: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 3: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff80100000000 [disabled]
00: b9 10 01 71 00 00 00 02 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 20 00 08 18 08 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40 01
70: 0f 11 00 00 00 00 00 08 00 00 00 00 00 00 00 00
80: 00 00 10 10 00 00 00 00 01 02 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 08 00 00 01 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 40 40 01 00 00 02 00 60 00 00 03 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 06 00 00 00 00 00 00 00 00 00 00 0b 00 00 00
e0: 00 08 00 06 01 00 01 00 00 00 00 00 00 00 00 00
f0: 45 00 88 6e 00 00 00 00 00 00 00 00 00 00 00 00

0001:00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+]
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] I/O ports at 0000 [size=64K]
	Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=1M]
	Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=1M]
	Region 3: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff80100000000 [disabled]
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 03 13 4b 80 83 09 00 47 00 00 06 00 00 00 eb 31
50: 00 00 00 20 90 02 20 03 66 03 00 00 00 00 00 08
60: 40 00 00 00 00 00 00 00 00 00 00 00 80 20 00 00
70: 00 00 0a 00 47 00 00 db 04 02 00 04 00 80 01 90
80: a5 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:00:0a.0 USB controller: ULi Electronics Inc. USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at 01000000 (32-bit, non-prefetchable) [disabled] [size=16M]
	Region 1: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 2: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 3: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 4: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff80100000000 [disabled]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 00 00 90 02 03 10 03 0c 00 40 00 00
10: 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 00 50
40: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 80 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:00:0d.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c4) (prog-if ff)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 0900 [disabled] [size=8]
	Region 1: I/O ports at 0918 [disabled] [size=8]
	Region 2: I/O ports at 0910 [disabled] [size=8]
	Region 3: I/O ports at 0908 [disabled] [size=8]
	Region 4: I/O ports at 0920 [disabled] [size=16]
	Region 5: [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff80100000000 [disabled]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 04 00 90 02 c4 ff 01 01 00 40 00 00
10: 01 09 00 00 19 09 00 00 11 09 00 00 09 09 00 00
20: 21 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 02 04
40: 00 00 00 7f 00 00 00 00 30 00 02 c0 00 80 ba 1a
50: 03 00 00 81 55 55 44 44 03 00 00 00 03 00 00 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0002:00:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic LSI53C1000/1000R/1010R/1010-66 PCI to Ultra160 SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (4250ns min, 4500ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 0900 [size=256]
	Region 1: Memory at 00100000 (64-bit, non-prefetchable) [size=8K]
	Region 3: Memory at 00102000 (64-bit, non-prefetchable) [size=8K]
	Region 5: [virtual] Memory at fffff83100000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff83100000000 [disabled]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: sym53c8xx
00: 00 10 21 00 57 01 30 02 01 00 00 01 10 40 80 00
10: 01 09 00 00 04 00 10 00 00 00 00 00 04 20 10 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 10
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 11 12
40: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
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

0002:00:02.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic LSI53C1000/1000R/1010R/1010-66 PCI to Ultra160 SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (4250ns min, 4500ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 25
	Region 0: I/O ports at 0a00 [size=256]
	Region 1: Memory at 00104000 (64-bit, non-prefetchable) [size=8K]
	Region 3: Memory at 00106000 (64-bit, non-prefetchable) [size=8K]
	Region 5: [virtual] Memory at fffff83100000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff83100000000 [disabled]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: sym53c8xx
00: 00 10 21 00 57 01 30 02 01 00 00 01 10 40 80 00
10: 01 0a 00 00 04 40 10 00 00 00 00 00 04 60 10 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 10
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 02 11 12
40: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
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

0003:00:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
	Subsystem: Oracle/SUN Device 1648
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at 00200000 (64-bit, non-prefetchable) [size=2M]
	Region 2: Memory at 00110000 (64-bit, non-prefetchable) [size=64K]
	Region 4: [virtual] Memory at fffff83900000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at fffff83900000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff83900000000 [disabled]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=1
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 3080414020d22000  Data: 3000
	Kernel driver in use: tg3
00: e4 14 48 16 06 00 b0 02 00 00 00 02 10 40 80 00
10: 04 00 20 00 00 00 00 00 04 00 11 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 48 16
30: 00 00 00 00 40 00 00 00 00 00 00 00 2d 01 40 00
40: 07 48 02 00 f8 ff 43 04 01 50 02 40 00 20 00 00
50: 03 58 00 00 08 04 10 40 05 00 86 00 00 20 d2 20
60: 40 41 80 30 00 30 00 00 9a 02 03 20 00 00 3f 76
70: 8e 02 00 00 c4 00 00 00 00 00 00 00 00 00 00 00
80: e4 14 48 16 ea ec 23 13 36 00 00 00 fe 90 20 02
90: 01 07 00 01 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0003:00:02.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
	Subsystem: Oracle/SUN Device 1648
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 32
	Region 0: Memory at 00400000 (64-bit, non-prefetchable) [size=2M]
	Region 2: Memory at 00120000 (64-bit, non-prefetchable) [size=64K]
	Region 4: [virtual] Memory at fffff83900000000 (32-bit, non-prefetchable)
	Region 5: [virtual] Memory at fffff83900000000 (32-bit, non-prefetchable)
	[virtual] Expansion ROM at fffff83900000000 [disabled]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=1
		Status: Dev=ff:1f.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 30001484410f4000  Data: 0500
	Kernel driver in use: tg3
00: e4 14 48 16 06 00 b0 02 00 00 00 02 10 40 80 00
10: 04 00 40 00 00 00 00 00 04 00 12 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8e 10 48 16
30: 00 00 00 00 40 00 00 00 00 00 00 00 02 02 40 00
40: 07 48 02 00 f9 ff 43 04 01 50 02 40 00 20 00 00
50: 03 58 00 00 0c 01 12 02 05 00 86 00 00 40 0f 41
60: 84 14 00 30 00 05 00 00 9a 02 03 20 00 00 3f 76
70: 8e 02 00 00 c4 00 00 00 00 00 00 00 00 00 00 00
80: e4 14 48 16 60 8b 36 00 36 00 00 00 fe 90 60 02
90: 01 07 00 01 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


-+-[0003:00]-+-02.0  Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
 |           \-02.1  Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
 +-[0002:00]-+-02.0  LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter
 |           \-02.1  LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter
 +-[0001:00]-+-06.0  ULi Electronics Inc. M7101 Power Management Controller [PMU]
 |           +-07.0  ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+]
 |           +-0a.0  ULi Electronics Inc. USB 1.1 Controller
 |           \-0d.0  ULi Electronics Inc. M5229 IDE
 \-[0000:00]-+-02.0  Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
             \-02.1  Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet

-- 
Meelis Roos (mroos@linux.ee)
