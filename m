Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 26 Feb 2018 10:40:28 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: PCI BAR allocation failures in 4.15 and 4.16-rc2+ on HP DL585
Message-ID: <alpine.LRH.2.21.1802261016110.4893@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I added a Atto U320 SCSI card into my HP Proliant DL585 (G1 despite the 
G naming was not used then). I have not tried earlier kernels.

In dmesg there are actually two sets of BAR assignment failures, the 
first bridge may or may not be related.

[    0.353439] pci 0000:00:03.0: BAR 15: no space for [mem size 0x00100000 pref]
[    0.353621] pci 0000:00:03.0: BAR 15: failed to assign [mem size 0x00100000 pref]
[...]
[    0.355801] pci 0000:04:09.0: PCI bridge to [bus 05]
[    0.355801] pci 0000:06:0e.0: BAR 6: no space for [mem size 0x00100000 pref]
[    0.355916] pci 0000:06:0e.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    0.356207] pci 0000:06:0e.1: BAR 6: no space for [mem size 0x00100000 pref]
[    0.356387] pci 0000:06:0e.1: BAR 6: failed to assign [mem size 0x00100000 pref]
[    0.356661] pci 0000:04:0a.0: PCI bridge to [bus 06]
[    0.356834] pci 0000:04:0a.0:   bridge window [io  0x6000-0x6fff]
[    0.357013] pci 0000:04:0a.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    0.357197] pci 0000:04:0b.0: PCI bridge to [bus 07]
[    0.357375] pci 0000:04:0c.0: PCI bridge to [bus 08]

lspci -vvvxxx and full dmesg are below.

00:03.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f5f00000-f7dfffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=3 UnitCnt=4 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency 0: 200MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [f0] HyperTransport: Interrupt Discovery and Configuration
	Kernel modules: shpchp
00: 22 10 60 74 47 01 30 02 07 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 40 40 00 22
20: f0 f5 d0 f7 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 09 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 04 06 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 08 f0 83 00 20 00 00 00 d0 00 00 00 22 00 01 00
d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 00 0d 00 08 00 0e 00 0f 00 15 00 00 00 00 00
f0: 08 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 ISA bridge: Advanced Micro Devices, Inc. [AMD] AMD-8111 LPC (rev 05)
	Subsystem: Compaq Computer Corporation AMD-8111 LPC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 0
00: 22 10 68 74 07 00 20 02 05 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 03 32
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 10 07 ff 01 00 00 80 0b f1 00 01 00 00 00 c0
50: 00 00 00 00 85 01 00 00 43 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 0e 03 32 00 de 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 IDE interface: Advanced Micro Devices, Inc. [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Compaq Computer Corporation AMD-8111 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
	Region 4: I/O ports at 2000 [size=16]
	Kernel driver in use: pata_amd
	Kernel modules: pata_amd
00: 22 10 69 74 05 00 00 02 03 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 20 00 00 00 00 00 00 00 00 00 00 11 0e 04 32
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 42 30 00 00 00 00 00 00 99 99 99 20 2a 00 a8 20
50: 03 03 03 03 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 0e 04 32 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.3 Bridge: Advanced Micro Devices, Inc. [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: Compaq Computer Corporation AMD-8111 ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
	Kernel driver in use: amd756_smbus
	Kernel modules: amd_rng, i2c_amd756
00: 22 10 6b 74 00 00 80 02 05 00 80 06 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 05 32
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 80 b9 09 64 00 00 00 00 20 04 50 00 00 00 00 00
50: 00 80 00 00 0f 00 00 00 01 09 00 00 00 00 00 00
60: 00 00 80 06 13 00 00 00 00 00 00 00 00 00 00 00
70: 00 20 00 00 02 00 00 00 00 00 00 00 11 0e 05 32
80: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 f8 02 00 00 00 00 00 00 07 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 6d 94 26 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: f7e00000-f7efffff
	Prefetchable memory behind bridge: 00000000f5e00000-00000000f5efffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=100MHz
		Status: Dev=00:07.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=7 UnitCnt=2 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency 0: 600MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Kernel modules: shpchp
00: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 51 51 20 22
20: e0 f7 e0 f7 e1 f5 e1 f5 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
40: 05 00 1f 00 01 00 00 00 02 0c 00 00 01 2c 00 00
50: 00 00 03 00 00 00 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 07 b8 83 00 38 00 03 00 0e 00 ff ff 02 00 ff ff
b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 05
c0: 08 00 47 00 20 00 11 11 20 00 00 00 22 04 35 00
d0: 02 00 35 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 08 0e 00 08 08 0f 00 0f 0f 16 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 PIC: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 0
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 00 00 00 04 00 c1 fe 00 00 00 00
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

00:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=100MHz
		Status: Dev=00:08.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Kernel modules: shpchp
00: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 00 03 03 40 f1 01 20 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
40: 05 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 07 b8 83 00 40 00 03 00 0e 00 ff ff 02 00 ff ff
b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 06
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.1 PIC: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 0
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 00 00 00 04 00 c2 fe 00 00 00 00
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

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 600MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 0d 00 08 08 01 00 08 04 01 00 04 04 09 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 30 00 03 00 e4 00 00 00 00 c0 00 0f 14 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 a0 01 21 20 00 11 11 22 04 75 80 02 00 00 00
90: 56 02 51 02 00 00 03 00 07 00 00 00 00 00 00 00
a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
50: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
90: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
80: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
90: 00 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: d8 a8 f9 ea 44 00 00 00 7b 38 ff 80 47 38 01 ec
c0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 71 84 c5 6c 4c e8 f4 b4 c2 a2 fb e2 e9 1e f2 b0
e0: 58 c4 44 6a 6c f4 72 b2 66 c0 ff e3 68 1f f3 da
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
	Kernel driver in use: k8temp
	Kernel modules: k8temp
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 e0 c7 7e
60: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 43 00 00 00 74 00 00 00 00 c0 fa 02 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 38 00 00 e0 c0 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 07 07 e2 04 00 00 00 00 25 25 25 00
e0: 00 00 00 00 20 15 56 00 1f 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 1
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 600MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 04 04 01 00 01 01 0d 00 08 08 05 00 04 08 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 31 00 03 00 e4 00 00 00 00 c0 00 0f 08 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 a0 01 21 20 00 11 11 22 04 75 80 02 00 00 00
90: 56 02 51 02 00 04 08 00 07 00 00 00 00 00 00 00
a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 1
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
50: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
90: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 1
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
80: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
90: 00 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: fa a6 12 eb 44 00 00 00 cf ff a6 81 cf f3 0d e0
c0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 18 64 6d 43 8a 29 68 58 02 a2 41 49 5d 5c 30 2d
e0: 18 a4 24 22 8d 35 24 29 23 80 40 49 0f 3a 10 2a
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 1
	Kernel driver in use: k8temp
	Kernel modules: k8temp
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 43 00 00 00 74 00 00 00 00 c0 fa 02 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 0f 00 00 80 f8 79 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 07 07 e2 04 00 00 00 00 25 25 25 00
e0: 00 00 00 00 20 16 56 00 1f 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 2
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=N/C DwFcInEn- LWO=N/C DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 200MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 08 04 01 00 04 04 09 00 01 01 0d 00 08 08 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 32 00 03 00 e4 00 00 00 00 c0 00 0f 0c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 a0 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 2
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
50: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
90: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 2
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
80: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
90: 00 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: ff 31 2b eb 44 00 00 00 9c be 02 17 4b 1c c7 c1
c0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 8c f0 46 85 04 54 80 a2 65 a0 14 7e 16 28 b6 08
e0: 01 44 aa 26 03 57 42 c2 20 a1 06 2c a1 34 af 1a
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 2
	Kernel driver in use: k8temp
	Kernel modules: k8temp
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 74 3c 18
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 39 00 08 2b 23 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 43 00 00 00 74 00 00 00 00 c0 fa 02 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 33 00 00 20 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 25 25 00
e0: 00 00 00 00 20 12 5c 00 1f 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1b.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 3
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=N/C DwFcInEn- LWO=N/C DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 200MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency: 800MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD- ExtRS- UCnfE-
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 08 08 05 00 04 08 01 00 04 04 01 00 01 01 0d 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 33 00 03 00 e4 00 00 00 00 c0 00 0f 04 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 a0 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
b0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
c0: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
d0: 13 57 13 04 00 00 00 00 03 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1b.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 3
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 ff 00 03 00 00 01 01 00 ff 01
50: 03 00 00 02 02 00 ff 02 03 00 00 03 03 00 ff 03
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 f0 f5 00 80 ef f7 00 03 e0 f5 00 80 ef f5 00
90: 03 f0 f7 00 01 ff f7 00 00 00 00 00 00 00 00 00
a0: 03 0a 00 00 00 0b 00 00 03 00 fe 00 80 ff ff 00
b0: 03 00 f8 00 01 ff fd 00 00 00 00 00 00 00 00 00
c0: 33 10 00 00 00 50 00 00 03 60 00 00 01 60 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 03 13 00 04 08 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1b.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 3
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 01 00 00 00 01 20 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 de e0 0f 00 de e0 0f
80: 00 50 00 00 00 00 00 00 25 31 62 03 20 09 10 00
90: 02 8c 83 08 08 0c 2b 22 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 4b df 43 eb 44 00 00 00 fd 73 c3 39 18 b0 1f 80
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: a0 27 3b 20 20 2a ed 6a b0 6f 01 4a d2 b4 60 05
e0: 71 0d 40 98 02 88 fe 28 d8 35 84 2b bb d4 f0 a4
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1b.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 3
	Kernel driver in use: k8temp
	Kernel modules: k8temp
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 01 c0 01 00 00 00 00 00 00 00 10
50: 00 00 00 00 00 00 00 00 00 00 00 00 80 01 03 e3
60: 64 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 39 00 08 2b 23 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 43 00 00 00 74 00 00 00 00 c0 fa 02 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3f 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 25 25 00
e0: 00 00 00 00 20 16 5a 00 1f 01 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] AMD-8111 USB OHCI (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation AMD-8111 USB OHCI
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	NUMA node: 0
	Region 0: Memory at f7df0000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci
00: 22 10 64 74 17 01 80 02 0b 10 03 0c 00 40 80 00
10: 00 00 df f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 02 32
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 50
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 0e 02 32 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.1 USB controller: Advanced Micro Devices, Inc. [AMD] AMD-8111 USB OHCI (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation AMD-8111 USB OHCI
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	NUMA node: 0
	Region 0: Memory at f7de0000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci
00: 22 10 64 74 17 01 80 02 0b 10 03 0c 00 40 00 00
10: 00 00 de f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 02 32
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 04 00 50
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 0e 02 32 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:02.0 System peripheral: Compaq Computer Corporation Integrated Lights Out Controller (rev 01)
	Subsystem: Compaq Computer Corporation Integrated Lights Out Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 7
	NUMA node: 0
	Region 0: I/O ports at 4800 [size=256]
	Region 1: Memory at f7db0000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [f0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
00: 11 0e 03 b2 03 01 90 02 01 00 80 08 00 00 80 00
10: 01 48 00 00 00 00 db f7 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 06 b2
30: 00 00 00 00 f0 00 00 00 00 00 00 00 07 01 00 00
40: 00 ff 2b fc 00 c0 40 00 00 00 00 00 0f 01 0f 00
50: a6 81 f0 77 04 cb 00 00 fa 37 fd 77 01 00 00 00
60: ff 00 ff ff 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 06 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 08 00 00 03 43 50 51 00
90: 02 02 00 54 02 00 00 5f 00 00 00 01 00 00 00 00
a0: 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00 03
b0: 00 00 00 88 00 00 00 00 f0 01 10 51 fa 48 03 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 00 00 00 00 00 00 01 00 00 00 00 1b 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00

01:02.2 System peripheral: Compaq Computer Corporation Integrated Lights Out  Processor (rev 01)
	Subsystem: Compaq Computer Corporation Integrated Lights Out  Processor
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	NUMA node: 0
	Region 0: I/O ports at 4000 [size=256]
	Region 1: Memory at f7da0000 (32-bit, non-prefetchable) [size=2K]
	Region 2: Memory at f7d90000 (32-bit, non-prefetchable) [size=8K]
	Region 3: Memory at f7d00000 (32-bit, non-prefetchable) [size=512K]
	[virtual] Expansion ROM at f5f20000 [disabled] [size=64K]
	Capabilities: [f0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: hpilo
	Kernel modules: hpilo
00: 11 0e 04 b2 97 01 90 02 01 00 80 08 10 40 80 00
10: 01 40 00 00 00 00 da f7 00 00 d9 f7 00 00 d0 f7
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 06 b2
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0a 02 00 00
40: 00 0d 00 00 00 00 00 00 00 00 00 00 0a 01 15 12
50: 02 e0 7f 00 05 00 33 00 04 00 00 00 00 00 60 00
60: 00 00 04 00 00 00 00 00 85 60 56 05 59 28 82 00
70: 00 08 00 01 03 03 40 00 ec 01 00 80 00 00 00 00
80: 09 00 00 00 09 a2 06 00 e0 f4 22 17 da 03 00 00
90: b8 0b 00 00 03 03 00 00 00 00 00 00 00 00 00 00
a0: 04 06 01 00 80 00 00 00 20 00 00 00 00 00 00 00
b0: 00 00 01 00 00 00 e7 81 ff e5 0e 00 00 00 00 00
c0: 01 00 00 00 00 00 02 00 01 00 00 00 00 00 02 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 0b 00 00 00 00 00 00 00 0b 00 00 00
f0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00

01:03.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Rage XL PCI (rev 27) (prog-if 00 [VGA controller])
	Subsystem: Compaq Computer Corporation Proliant Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (2000ns min), Cache Line Size: 64 bytes
	NUMA node: 0
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 4400 [size=256]
	Region 2: Memory at f5ff0000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel modules: atyfb
00: 02 10 52 47 87 00 90 02 27 00 00 03 10 40 00 00
10: 00 00 00 f6 01 44 00 00 00 00 ff f5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 1e 00
30: 00 00 00 00 5c 00 00 00 00 00 00 00 ff 00 08 00
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

02:04.0 RAID bus controller: Compaq Computer Corporation Smart Array 5i/532 (rev 01)
	Subsystem: Compaq Computer Corporation Smart Array 5i
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 71, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	NUMA node: 0
	Region 0: Memory at f7ec0000 (64-bit, non-prefetchable) [size=256K]
	Region 2: I/O ports at 5000 [size=256]
	Region 3: Memory at f5ef0000 (64-bit, prefetchable) [size=16K]
	[virtual] Expansion ROM at f7e00000 [disabled] [size=16K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [cc] MSI: Enable- Count=1/2 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [dc] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=512 OST=4
		Status: Dev=02:04.0 64bit+ 133MHz- SCD- USC- DC=simple DMMRBC=512 DMOST=4 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Kernel driver in use: hpsa
00: 11 0e 78 b1 57 01 b0 02 01 00 04 01 10 47 00 00
10: 04 00 ec f7 00 00 00 00 01 50 00 00 0c 00 ef f5
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 80 40
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 ff 01 07 00 00 00 00 00
50: d2 03 00 00 ff ff 37 7d 29 0c 00 00 60 00 00 00
60: c3 21 00 00 00 00 00 a0 01 00 00 e0 00 00 00 e0
70: 00 00 00 00 00 00 30 80 00 00 00 00 00 00 00 00
80: 00 00 00 00 01 00 00 00 03 00 fc ff 00 00 7c 40
90: 01 ff ff ff 00 00 00 98 01 c0 ff ff 00 00 f7 ff
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 cc 02 02 00 00 00 00 10 00 00 00 05 dc 82 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 07 00 30 00
e0: 20 02 81 05 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.0 Ethernet controller: Broadcom Limited NetXtreme BCM5704 Gigabit Ethernet (rev 10)
	Subsystem: Compaq Computer Corporation NC7782 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 25
	NUMA node: 0
	Region 0: Memory at f7eb0000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=2048 OST=1
		Status: Dev=02:06.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Not readable
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: e8a2a6d71492d000  Data: 23a0
	Kernel driver in use: tg3
	Kernel modules: tg3
00: e4 14 48 16 46 01 b0 02 10 00 00 02 10 40 80 00
10: 04 00 eb f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e d0 00
30: 00 00 4c 39 40 00 00 00 00 00 00 00 0a 01 40 00
40: 07 48 08 00 30 02 43 04 01 50 02 c0 00 21 00 64
50: 03 58 00 00 c2 d3 c3 30 05 00 86 00 00 d0 92 14
60: d7 a6 a2 e8 a0 23 00 00 98 02 00 21 00 40 9f 76
70: e2 30 00 00 c6 00 00 80 00 00 00 00 00 00 00 00
80: e4 14 48 16 34 72 54 92 34 00 13 04 82 90 68 00
90: 09 97 00 01 24 00 00 00 00 00 00 00 38 00 00 00
a0: 00 00 00 00 70 03 00 00 00 00 00 00 24 00 00 00
b0: 00 00 00 00 00 00 00 e3 04 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.1 Ethernet controller: Broadcom Limited NetXtreme BCM5704 Gigabit Ethernet (rev 10)
	Subsystem: Compaq Computer Corporation NC7782 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 26
	NUMA node: 0
	Region 0: Memory at f7ea0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=2048 OST=1
		Status: Dev=02:06.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: HP NC7782 Gigabit Server Adapter
		Read-only fields:
			[PN] Part number: 349321-001
			[EC] Engineering changes: N/A
			[SN] Serial number: 0123456789
			[MN] Manufacture ID: 31 34 65 34
			[RV] Reserved: checksum bad, 46 byte(s) reserved
		Read/write fields:
			[YA] Asset tag: N/A
			[RW] Read-write area: 115 byte(s) free
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: c88adcda8510736c  Data: 183d
	Kernel driver in use: tg3
	Kernel modules: tg3
00: e4 14 48 16 46 01 b0 02 10 00 00 02 10 40 80 00
10: 04 00 ea f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e d0 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 07 02 40 00
40: 07 48 08 00 31 02 43 04 01 50 02 c0 00 20 00 64
50: 03 58 fc 80 00 00 00 78 05 00 86 00 6c 73 10 85
60: da dc 8a c8 3d 18 00 00 9a 02 00 21 00 40 9f 76
70: 82 32 00 00 c6 00 00 00 00 00 00 00 00 00 00 00
80: e4 14 48 16 da 7e 5e 7f 34 00 00 00 fe 90 20 00
90: 01 07 00 01 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 1
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
		Status: Dev=04:09.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=9 UnitCnt=2 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=N/C DwFcInEn- LWO=N/C DwFcOutEn-
		Revision ID: 1.02
		Link Frequency 0: 600MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 600MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Kernel modules: shpchp
00: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 04 05 05 40 f1 01 20 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
40: 05 00 1f 00 01 00 00 00 02 0c 00 00 01 2c 00 00
50: 00 00 03 00 00 00 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 07 b8 c3 00 48 04 03 00 0e 00 ff ff 02 00 ff ff
b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 07
c0: 08 00 49 00 20 00 11 00 50 00 00 77 22 04 35 00
d0: 02 04 35 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 08 0e 00 08 08 0d 00 0f 0f 15 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:09.1 PIC: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 1
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 00 00 00 04 00 c0 fd 00 00 00 00
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

04:0a.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 1
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=64
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: f7f00000-f7ffffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
		Status: Dev=04:0a.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Kernel modules: shpchp
00: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 04 06 06 40 61 61 20 22
20: f0 f7 f0 f7 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
40: 05 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 07 b8 c3 00 50 04 03 00 0e 00 ff ff 02 00 ff ff
b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 08
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:0a.1 PIC: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 1
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 00 00 00 04 00 c1 fd 00 00 00 00
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

04:0b.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 1
	Bus: primary=04, secondary=07, subordinate=07, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=100MHz
		Status: Dev=04:0b.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=11 UnitCnt=2 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency 0: 600MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 600MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Kernel modules: shpchp
00: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 04 07 07 40 f1 01 20 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
40: 05 00 1f 00 01 00 00 00 02 0c 00 00 01 2c 00 00
50: 00 00 03 00 00 00 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 07 b8 83 00 58 04 03 00 0e 00 ff ff 02 00 ff ff
b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 09
c0: 08 00 4b 00 20 00 11 11 20 00 00 00 22 04 35 00
d0: 02 04 35 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 08 08 0f 00 08 08 0f 00 0f 0f 17 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:0b.1 PIC: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 1
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 00 00 00 04 00 c2 fd 00 00 00 00
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

04:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 1
	Bus: primary=04, secondary=08, subordinate=08, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=100MHz
		Status: Dev=04:0c.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Kernel modules: shpchp
00: 22 10 50 74 47 01 30 02 12 00 04 06 00 40 81 00
10: 00 00 00 00 00 00 00 00 04 08 08 40 f1 01 20 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 01 00
40: 05 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 07 b8 83 00 60 04 03 00 0e 00 ff ff 02 00 ff ff
b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 0a
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:0c.1 PIC: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 1
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 00 00 00 04 00 c3 fd 00 00 00 00
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

06:0e.0 SCSI storage controller: ATTO Technology, Inc. Ultra320 SCSI Host Adapter (rev 08)
	Subsystem: ATTO Technology, Inc. ExpressPCI UL4D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (4000ns min, 1500ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 24
	NUMA node: 1
	Region 0: I/O ports at 6000 [size=256]
	Region 1: Memory at f7fc0000 (64-bit, non-prefetchable) [size=256K]
	Region 3: Memory at f7f80000 (64-bit, non-prefetchable) [size=256K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=1024 OST=2
		Status: Dev=06:0e.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=8 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Kernel driver in use: mptspi
	Kernel modules: mptspi
00: 7c 11 30 00 57 01 30 02 08 00 00 01 10 40 80 00
10: 01 60 00 00 04 00 fc f7 00 00 00 00 04 00 f8 f7
20: 00 00 00 00 00 00 00 00 00 00 00 00 7c 11 13 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 07 01 10 06
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 02 06 00 00 00 00 05 68 80 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 07 00 14 00 70 06 43 06
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

06:0e.1 SCSI storage controller: ATTO Technology, Inc. Ultra320 SCSI Host Adapter (rev 08)
	Subsystem: ATTO Technology, Inc. ExpressPCI UL4D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (4000ns min, 1500ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 27
	NUMA node: 1
	Region 0: I/O ports at 6400 [size=256]
	Region 1: Memory at f7f40000 (64-bit, non-prefetchable) [size=256K]
	Region 3: Memory at f7f00000 (64-bit, non-prefetchable) [size=256K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=1024 OST=2
		Status: Dev=06:0e.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=8 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Kernel driver in use: mptspi
	Kernel modules: mptspi
00: 7c 11 30 00 57 01 30 02 08 00 00 01 10 40 80 00
10: 01 64 00 00 04 00 f4 f7 00 00 00 00 04 00 f0 f7
20: 00 00 00 00 00 00 00 00 00 00 00 00 7c 11 13 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 10 06
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 02 06 00 00 00 00 05 68 80 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 07 00 14 00 71 06 43 06
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


[    0.000000] Linux version 4.16.0-rc2-00374-g3664ce2d9309 (mroos@dl585) (gcc version 6.3.0 20170516 (Debian 6.3.0-18)) #89 SMP Sun Feb 25 18:02:47 EET 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.16.0-rc2-00374-g3664ce2d9309 root=/dev/sda1 ro log_buf_len=4M
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000f57f67ff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f57f6800-0x00000000f57fffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000fdc00000-0x00000000fdc00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fdc10000-0x00000000fdc10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fdc20000-0x00000000fdc20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fdc30000-0x00000000fdc30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003ffffefff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] random: fast init done
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: HP ProLiant DL585 G1, BIOS A01 02/14/2007
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x3fffff max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-back
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00F5800000 mask FFFF800000 uncachable
[    0.000000]   1 base 00F6000000 mask FFFE000000 uncachable
[    0.000000]   2 base 00F8000000 mask FFF8000000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: last_pfn = 0xf57f6 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4fa0-0x000f4faf] mapped at [        (ptrval)]
[    0.000000] Base memory trampoline at [        (ptrval)] 99000 size 24576
[    0.000000] BRK [0x02ba1000, 0x02ba1fff] PGTABLE
[    0.000000] BRK [0x02ba2000, 0x02ba2fff] PGTABLE
[    0.000000] BRK [0x02ba3000, 0x02ba3fff] PGTABLE
[    0.000000] BRK [0x02ba4000, 0x02ba4fff] PGTABLE
[    0.000000] BRK [0x02ba5000, 0x02ba5fff] PGTABLE
[    0.000000] BRK [0x02ba6000, 0x02ba6fff] PGTABLE
[    0.000000] log_buf_len: 4194304 bytes
[    0.000000] early log buf free: 127816(97%)
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F4F20 000024 (v02 HP    )
[    0.000000] ACPI: XSDT 0x00000000F57F6C00 000044 (v01 HP     A01      00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI: FACP 0x00000000F57F6C80 0000F4 (v03 HP     A01      00000002 \xffffffd2?   0000162E)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 32, using default 16 (20180105/tbfadt-708)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1bControlBlock: 32, using default 16 (20180105/tbfadt-708)
[    0.000000] ACPI: DSDT 0x00000000F57F6D80 0051D5 (v01 HP     DSDT     00000001 MSFT 02000001)
[    0.000000] ACPI: FACS 0x00000000F57F68C0 000040
[    0.000000] ACPI: FACS 0x00000000F57F68C0 000040
[    0.000000] ACPI: APIC 0x00000000F57F6900 0000D0 (v01 HP     00000083 00000002      00000000)
[    0.000000] ACPI: SPCR 0x00000000F57F6A00 000050 (v01 HP     SPCRRBSU 00000001 \xffffffd2?   0000162E)
[    0.000000] ACPI: SRAT 0x00000000F57F6A80 000150 (v01 HP     A01      00000001      00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 1 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 2 -> APIC 0x01 -> Node 1
[    0.000000] SRAT: PXM 3 -> APIC 0x02 -> Node 2
[    0.000000] SRAT: PXM 4 -> APIC 0x03 -> Node 3
[    0.000000] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0xffffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 2 [mem 0x100000000-0x1ffffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 3 [mem 0x200000000-0x2ffffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 4 [mem 0x300000000-0x3ffffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0xf57f3000-0xf57f5fff]
[    0.000000] NODE_DATA(1) allocated [mem 0x1ffffd000-0x1ffffffff]
[    0.000000] NODE_DATA(2) allocated [mem 0x2ffffd000-0x2ffffffff]
[    0.000000] NODE_DATA(3) allocated [mem 0x3ffffc000-0x3ffffefff]
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000003ffffefff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000f57f5fff]
[    0.000000]   node   1: [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000]   node   2: [mem 0x0000000200000000-0x00000002ffffffff]
[    0.000000]   node   3: [mem 0x0000000300000000-0x00000003ffffefff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000000f57f5fff]
[    0.000000] On node 0 totalpages: 1005460
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 15648 pages used for memmap
[    0.000000]   DMA32 zone: 1001462 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] On node 1 totalpages: 1048576
[    0.000000]   Normal zone: 16384 pages used for memmap
[    0.000000]   Normal zone: 1048576 pages, LIFO batch:31
[    0.000000] Initmem setup node 2 [mem 0x0000000200000000-0x00000002ffffffff]
[    0.000000] On node 2 totalpages: 1048576
[    0.000000]   Normal zone: 16384 pages used for memmap
[    0.000000]   Normal zone: 1048576 pages, LIFO batch:31
[    0.000000] Initmem setup node 3 [mem 0x0000000300000000-0x00000003ffffefff]
[    0.000000] On node 3 totalpages: 1048575
[    0.000000]   Normal zone: 16384 pages used for memmap
[    0.000000]   Normal zone: 1048575 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x908
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 5, version 17, address 0xfec10000, GSI 24-27
[    0.000000] IOAPIC[2]: apic_id 6, version 17, address 0xfec20000, GSI 28-31
[    0.000000] IOAPIC[3]: apic_id 7, version 17, address 0xfdc00000, GSI 32-35
[    0.000000] IOAPIC[4]: apic_id 8, version 17, address 0xfdc10000, GSI 36-39
[    0.000000] IOAPIC[5]: apic_id 9, version 17, address 0xfdc20000, GSI 40-43
[    0.000000] IOAPIC[6]: apic_id 10, version 17, address 0xfdc30000, GSI 44-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: SPCR: SPCR table version 1
[    0.000000] ACPI: SPCR: Unexpected SPCR Access Width.  Defaulting to byte size
[    0.000000] ACPI: SPCR: console: uart,mmio,0x0,9600
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] e820: [mem 0xf5800000-0xfdbfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:8 nr_node_ids:4
[    0.000000] percpu: Embedded 42 pages/cpu @        (ptrval) s133272 r8192 d30568 u1048576
[    0.000000] pcpu-alloc: s133272 r8192 d30568 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 4 [1] 1 5 [2] 2 6 [3] 3 7 
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 4086302
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.16.0-rc2-00374-g3664ce2d9309 root=/dev/sda1 ro log_buf_len=4M
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] AGP: Node 0: aperture [bus addr 0xe8000000-0xe9ffffff] (32MB)
[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM
[    0.000000] AGP: Mapping aperture over RAM [mem 0xe8000000-0xebffffff] (65536KB)
[    0.000000] Memory: 16179164K/16604748K available (12300K kernel code, 8042K rwdata, 1516K rodata, 980K init, 380K bss, 425584K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=4
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 4352, nr_irqs: 896, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: .
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] ACPI: Core revision 20180105
[    0.000000] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.004000] APIC: Switch to symmetric I/O mode setup
[    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.024000] tsc: Fast TSC calibration using PIT
[    0.028000] tsc: Detected 2197.126 MHz processor
[    0.028000] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.032002] Calibrating delay loop (skipped), value calculated using timer frequency.. 4394.25 BogoMIPS (lpj=8788504)
[    0.032290] pid_max: default: 32768 minimum: 301
[    0.032550] Security Framework initialized
[    0.032752] AppArmor: AppArmor initialized
[    0.045590] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.052219] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.052753] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.053130] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.053879] mce: CPU supports 5 MCE banks
[    0.054057] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 4
[    0.054229] Last level dTLB entries: 4KB 512, 2MB 8, 4MB 4, 1GB 0
[    0.054408] Spectre V2 : Spectre mitigation: LFENCE not serializing, switching to generic retpoline
[    0.054687] Spectre V2 : Vulnerable: Minimal generic ASM retpoline
[    0.054863] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.055224] Freeing SMP alternatives memory: 24K
[    0.056000] smpboot: CPU0: AMD Opteron (tm) Processor 848 (family: 0xf, model: 0x5, stepping: 0x8)
[    0.056000] Performance Events: AMD PMU driver.
[    0.056000] ... version:                0
[    0.056000] ... bit width:              48
[    0.056000] ... generic registers:      4
[    0.056000] ... value mask:             0000ffffffffffff
[    0.056000] ... max period:             00007fffffffffff
[    0.056000] ... fixed-purpose events:   0
[    0.056000] ... event mask:             000000000000000f
[    0.056000] Hierarchical SRCU implementation.
[    0.056000] smp: Bringing up secondary CPUs ...
[    0.056000] x86: Booting SMP configuration:
[    0.056000] .... node  #1, CPUs:      #1
[    0.060217] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.132318] .... node  #2, CPUs:   #2
[    0.212381] .... node  #3, CPUs:   #3
[    0.292319] smp: Brought up 4 nodes, 4 CPUs
[    0.292338] smpboot: Max logical packages: 8
[    0.292507] smpboot: Total of 4 processors activated (17577.92 BogoMIPS)
[    0.296880] devtmpfs: initialized
[    0.296880] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.296880] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.296909] NET: Registered protocol family 16
[    0.297237] audit: initializing netlink subsys (disabled)
[    0.297598] audit: type=2000 audit(1519576396.296:1): state=initialized audit_enabled=0 res=1
[    0.297905] cpuidle: using governor ladder
[    0.298080] cpuidle: using governor menu
[    0.298252] node 0 link 0: io port [1000, 5fff]
[    0.298255] node 1 link 0: io port [6000, 6fff]
[    0.298258] TOM: 00000000f5800000 aka 3928M
[    0.300009] node 0 link 0: mmio [f5f00000, f7efffff]
[    0.300013] node 0 link 0: mmio [f5e00000, f5efffff]
[    0.300015] node 1 link 0: mmio [f7f00000, f7ffffff]
[    0.300018] node 0 link 0: mmio [a0000, bffff]
[    0.300020] node 0 link 0: mmio [fe000000, ffffffff]
[    0.300022] node 1 link 0: mmio [f8000000, fdffffff]
[    0.300024] TOM2: 0000000400000000 aka 16384M
[    0.300196] bus: [bus 00-03] on node 0 link 0
[    0.300197] bus: 00 [io  0x0000-0x5fff]
[    0.300198] bus: 00 [io  0x7000-0xffff]
[    0.300199] bus: 00 [mem 0xf5800000-0xf7efffff]
[    0.300201] bus: 00 [mem 0x000a0000-0x000bffff]
[    0.300202] bus: 00 [mem 0xfe000000-0xffffffff]
[    0.300203] bus: 00 [mem 0x400000000-0xfcffffffff]
[    0.300204] bus: [bus 04-08] on node 1 link 0
[    0.300205] bus: 04 [io  0x6000-0x6fff]
[    0.300206] bus: 04 [mem 0xf7f00000-0xfdffffff]
[    0.300244] ACPI: bus type PCI registered
[    0.300473] PCI: Using configuration type 1 for base access
[    0.300697] mtrr: your CPUs had inconsistent fixed MTRR settings
[    0.300697] mtrr: probably your BIOS does not setup all CPUs.
[    0.300697] mtrr: corrected configuration.
[    0.304395] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.304649] ACPI: Added _OSI(Module Device)
[    0.304817] ACPI: Added _OSI(Processor Device)
[    0.304986] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.305157] ACPI: Added _OSI(Processor Aggregator Device)
[    0.310375] ACPI: Interpreter enabled
[    0.310551] ACPI: (supports S0 S5)
[    0.310716] ACPI: Using IOAPIC for interrupt routing
[    0.310930] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.322317] ACPI: PCI Root Bridge [CFG0] (domain 0000 [bus 00-03])
[    0.322503] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.322684] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.322879] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.324057] PCI host bridge to bus 0000:00
[    0.324228] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.324408] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    0.324587] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    0.324767] pci_bus 0000:00: root bus resource [io  0x03e0-0x0fff window]
[    0.324947] pci_bus 0000:00: root bus resource [io  0x1000-0x5fff window]
[    0.325128] pci_bus 0000:00: root bus resource [mem 0xf5f00000-0xf7efffff window]
[    0.325402] pci_bus 0000:00: root bus resource [mem 0xf5e00000-0xf5efffff window]
[    0.325676] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.325951] pci_bus 0000:00: root bus resource [bus 00-03]
[    0.326146] pci 0000:00:03.0: [1022:7460] type 01 class 0x060400
[    0.326318] pci 0000:00:04.0: [1022:7468] type 00 class 0x060100
[    0.326460] pci 0000:00:04.1: [1022:7469] type 00 class 0x01018a
[    0.326500] pci 0000:00:04.1: reg 0x20: [io  0x2000-0x200f]
[    0.326517] pci 0000:00:04.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.326700] pci 0000:00:04.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.326878] pci 0000:00:04.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.327059] pci 0000:00:04.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.327317] pci 0000:00:04.3: [1022:746b] type 00 class 0x068000
[    0.327465] pci 0000:00:07.0: [1022:7450] type 01 class 0x060400
[    0.327583] pci 0000:00:07.1: [1022:7451] type 00 class 0x080010
[    0.327700] pci 0000:00:08.0: [1022:7450] type 01 class 0x060400
[    0.327812] pci 0000:00:08.1: [1022:7451] type 00 class 0x080010
[    0.327934] pci 0000:00:18.0: [1022:1100] type 00 class 0x060000
[    0.328030] pci 0000:00:18.1: [1022:1101] type 00 class 0x060000
[    0.328117] pci 0000:00:18.2: [1022:1102] type 00 class 0x060000
[    0.328194] pci 0000:00:18.3: [1022:1103] type 00 class 0x060000
[    0.328277] pci 0000:00:19.0: [1022:1100] type 00 class 0x060000
[    0.328372] pci 0000:00:19.1: [1022:1101] type 00 class 0x060000
[    0.328451] pci 0000:00:19.2: [1022:1102] type 00 class 0x060000
[    0.328531] pci 0000:00:19.3: [1022:1103] type 00 class 0x060000
[    0.328620] pci 0000:00:1a.0: [1022:1100] type 00 class 0x060000
[    0.328709] pci 0000:00:1a.1: [1022:1101] type 00 class 0x060000
[    0.328791] pci 0000:00:1a.2: [1022:1102] type 00 class 0x060000
[    0.328872] pci 0000:00:1a.3: [1022:1103] type 00 class 0x060000
[    0.328964] pci 0000:00:1b.0: [1022:1100] type 00 class 0x060000
[    0.329055] pci 0000:00:1b.1: [1022:1101] type 00 class 0x060000
[    0.329139] pci 0000:00:1b.2: [1022:1102] type 00 class 0x060000
[    0.329222] pci 0000:00:1b.3: [1022:1103] type 00 class 0x060000
[    0.329373] pci 0000:01:00.0: [1022:7464] type 00 class 0x0c0310
[    0.329394] pci 0000:01:00.0: reg 0x10: [mem 0xf7df0000-0xf7df0fff]
[    0.329516] pci 0000:01:00.1: [1022:7464] type 00 class 0x0c0310
[    0.329536] pci 0000:01:00.1: reg 0x10: [mem 0xf7de0000-0xf7de0fff]
[    0.329672] pci 0000:01:02.0: [0e11:b203] type 00 class 0x088000
[    0.329696] pci 0000:01:02.0: reg 0x10: [io  0x4800-0x48ff]
[    0.329707] pci 0000:01:02.0: reg 0x14: [mem 0xf7db0000-0xf7db01ff]
[    0.329853] pci 0000:01:02.2: [0e11:b204] type 00 class 0x088000
[    0.329880] pci 0000:01:02.2: reg 0x10: [io  0x4000-0x40ff]
[    0.329892] pci 0000:01:02.2: reg 0x14: [mem 0xf7da0000-0xf7da07ff]
[    0.329904] pci 0000:01:02.2: reg 0x18: [mem 0xf7d90000-0xf7d91fff]
[    0.329916] pci 0000:01:02.2: reg 0x1c: [mem 0xf7d00000-0xf7d7ffff]
[    0.329950] pci 0000:01:02.2: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.329989] pci 0000:01:02.2: PME# supported from D0 D3hot D3cold
[    0.330065] pci 0000:01:03.0: [1002:4752] type 00 class 0x030000
[    0.330089] pci 0000:01:03.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
[    0.330101] pci 0000:01:03.0: reg 0x14: [io  0x4400-0x44ff]
[    0.330112] pci 0000:01:03.0: reg 0x18: [mem 0xf5ff0000-0xf5ff0fff]
[    0.330153] pci 0000:01:03.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.330190] pci 0000:01:03.0: supports D1 D2
[    0.330288] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.330465] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
[    0.330469] pci 0000:00:03.0:   bridge window [mem 0xf5f00000-0xf7dfffff]
[    0.330533] pci 0000:02:04.0: [0e11:b178] type 00 class 0x010400
[    0.330553] pci 0000:02:04.0: reg 0x10: [mem 0xf7ec0000-0xf7efffff 64bit]
[    0.330560] pci 0000:02:04.0: reg 0x18: [io  0x5000-0x50ff]
[    0.330570] pci 0000:02:04.0: reg 0x1c: [mem 0xf5ef0000-0xf5ef3fff 64bit pref]
[    0.330583] pci 0000:02:04.0: reg 0x30: [mem 0x00000000-0x00003fff pref]
[    0.330614] pci 0000:02:04.0: supports D1
[    0.330680] pci 0000:02:06.0: [14e4:1648] type 00 class 0x020000
[    0.330698] pci 0000:02:06.0: reg 0x10: [mem 0xf7eb0000-0xf7ebffff 64bit]
[    0.330754] pci 0000:02:06.0: PME# supported from D3hot D3cold
[    0.330822] pci 0000:02:06.1: [14e4:1648] type 00 class 0x020000
[    0.330840] pci 0000:02:06.1: reg 0x10: [mem 0xf7ea0000-0xf7eaffff 64bit]
[    0.330897] pci 0000:02:06.1: PME# supported from D3hot D3cold
[    0.330980] pci 0000:00:07.0: PCI bridge to [bus 02]
[    0.331154] pci 0000:00:07.0:   bridge window [io  0x5000-0x5fff]
[    0.331157] pci 0000:00:07.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    0.331162] pci 0000:00:07.0:   bridge window [mem 0xf5e00000-0xf5efffff 64bit pref]
[    0.331357] pci 0000:00:08.0: PCI bridge to [bus 03]
[    0.332614] ACPI: PCI Root Bridge [CFG1] (domain 0000 [bus 04-08])
[    0.332796] acpi PNP0A03:01: _OSC: OS supports [Segments MSI]
[    0.332974] acpi PNP0A03:01: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.333157] acpi PNP0A03:01: [Firmware Bug]: no _PXM; falling back to node 1 from hardware (may be inconsistent with ACPI node numbers)
[    0.333460] acpi PNP0A03:01: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.334521] PCI host bridge to bus 0000:04
[    0.334691] pci_bus 0000:04: root bus resource [io  0x6000-0x6fff window]
[    0.334871] pci_bus 0000:04: root bus resource [mem 0xf7f00000-0xf7ffffff window]
[    0.335145] pci_bus 0000:04: root bus resource [bus 04-08]
[    0.335335] pci 0000:04:09.0: [1022:7450] type 01 class 0x060400
[    0.335461] pci 0000:04:09.1: [1022:7451] type 00 class 0x080010
[    0.335574] pci 0000:04:0a.0: [1022:7450] type 01 class 0x060400
[    0.335686] pci 0000:04:0a.1: [1022:7451] type 00 class 0x080010
[    0.335815] pci 0000:04:0b.0: [1022:7450] type 01 class 0x060400
[    0.335920] pci 0000:04:0b.1: [1022:7451] type 00 class 0x080010
[    0.336027] pci 0000:04:0c.0: [1022:7450] type 01 class 0x060400
[    0.336130] pci 0000:04:0c.1: [1022:7451] type 00 class 0x080010
[    0.336379] pci 0000:04:09.0: PCI bridge to [bus 05]
[    0.336685] pci 0000:06:0e.0: [117c:0030] type 00 class 0x010000
[    0.336703] pci 0000:06:0e.0: reg 0x10: [io  0x6000-0x60ff]
[    0.336715] pci 0000:06:0e.0: reg 0x14: [mem 0xf7fc0000-0xf7ffffff 64bit]
[    0.336726] pci 0000:06:0e.0: reg 0x1c: [mem 0xf7f80000-0xf7fbffff 64bit]
[    0.336739] pci 0000:06:0e.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
[    0.336773] pci 0000:06:0e.0: supports D1 D2
[    0.336845] pci 0000:06:0e.1: [117c:0030] type 00 class 0x010000
[    0.336863] pci 0000:06:0e.1: reg 0x10: [io  0x6400-0x64ff]
[    0.336875] pci 0000:06:0e.1: reg 0x14: [mem 0xf7f40000-0xf7f7ffff 64bit]
[    0.336886] pci 0000:06:0e.1: reg 0x1c: [mem 0xf7f00000-0xf7f3ffff 64bit]
[    0.336899] pci 0000:06:0e.1: reg 0x30: [mem 0x00000000-0x000fffff pref]
[    0.336933] pci 0000:06:0e.1: supports D1 D2
[    0.337016] pci 0000:04:0a.0: PCI bridge to [bus 06]
[    0.337192] pci 0000:04:0a.0:   bridge window [io  0x6000-0x6fff]
[    0.337196] pci 0000:04:0a.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    0.337394] pci 0000:04:0b.0: PCI bridge to [bus 07]
[    0.337759] pci 0000:04:0c.0: PCI bridge to [bus 08]
[    0.338132] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 *7 10 11)
[    0.338378] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 7 *10 11)
[    0.338622] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 7 10 *11)
[    0.338866] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *5 7 10 11)
[    0.339281] pci 0000:01:03.0: vgaarb: setting as boot VGA device
[    0.339281] pci 0000:01:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.339281] pci 0000:01:03.0: vgaarb: bridge control possible
[    0.339281] vgaarb: loaded
[    0.340112] SCSI subsystem initialized
[    0.340310] EDAC MC: Ver: 3.0.0
[    0.340721] PCI: Using ACPI for IRQ routing
[    0.340891] PCI: pci_cache_line_size set to 64 bytes
[    0.340978] e820: reserve RAM buffer [mem 0x0009f400-0x0009ffff]
[    0.340981] e820: reserve RAM buffer [mem 0xf57f6800-0xf7ffffff]
[    0.340983] e820: reserve RAM buffer [mem 0x3fffff000-0x3ffffffff]
[    0.341421] clocksource: Switched to clocksource refined-jiffies
[    0.341421] AppArmor: AppArmor Filesystem Enabled
[    0.341421] pnp: PnP ACPI init
[    0.341421] system 00:00: [io  0x0230-0x0233] has been reserved
[    0.341421] system 00:00: [io  0x0260-0x0267] has been reserved
[    0.341524] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.341701] system 00:00: [io  0x0800-0x081f] has been reserved
[    0.341877] system 00:00: [io  0x0900-0x0903] has been reserved
[    0.342053] system 00:00: [io  0x0904-0x0907] has been reserved
[    0.342230] system 00:00: [io  0x0908-0x090b] has been reserved
[    0.342405] system 00:00: [io  0x090c-0x092e] has been reserved
[    0.344022] system 00:00: [io  0x092f] has been reserved
[    0.344198] system 00:00: [io  0x0930-0x09ff] has been reserved
[    0.344374] system 00:00: [io  0x0c80-0x0c87] has been reserved
[    0.344550] system 00:00: [io  0x0cf9] could not be reserved
[    0.344725] system 00:00: [io  0x02f8-0x02ff] has been reserved
[    0.344907] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.344960] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.344994] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    0.345249] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    0.345440] pnp 00:04: [dma 2]
[    0.345476] pnp 00:04: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.345714] pnp: PnP ACPI: found 5 devices
[    0.352907] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.353223] clocksource: Switched to clocksource acpi_pm
[    0.353439] pci 0000:00:03.0: BAR 15: no space for [mem size 0x00100000 pref]
[    0.353621] pci 0000:00:03.0: BAR 15: failed to assign [mem size 0x00100000 pref]
[    0.353900] pci 0000:01:03.0: BAR 6: assigned [mem 0xf5f00000-0xf5f1ffff pref]
[    0.354174] pci 0000:01:02.2: BAR 6: assigned [mem 0xf5f20000-0xf5f2ffff pref]
[    0.354450] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.354624] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
[    0.354805] pci 0000:00:03.0:   bridge window [mem 0xf5f00000-0xf7dfffff]
[    0.354994] pci 0000:02:04.0: BAR 6: assigned [mem 0xf7e00000-0xf7e03fff pref]
[    0.355268] pci 0000:00:07.0: PCI bridge to [bus 02]
[    0.355441] pci 0000:00:07.0:   bridge window [io  0x5000-0x5fff]
[    0.355620] pci 0000:00:07.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    0.355801] pci 0000:00:07.0:   bridge window [mem 0xf5e00000-0xf5efffff 64bit pref]
[    0.355801] pci 0000:00:08.0: PCI bridge to [bus 03]
[    0.355801] pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
[    0.355801] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.355801] pci_bus 0000:00: resource 5 [io  0x03b0-0x03bb window]
[    0.355801] pci_bus 0000:00: resource 6 [io  0x03c0-0x03df window]
[    0.355801] pci_bus 0000:00: resource 7 [io  0x03e0-0x0fff window]
[    0.355801] pci_bus 0000:00: resource 8 [io  0x1000-0x5fff window]
[    0.355801] pci_bus 0000:00: resource 9 [mem 0xf5f00000-0xf7efffff window]
[    0.355801] pci_bus 0000:00: resource 10 [mem 0xf5e00000-0xf5efffff window]
[    0.355801] pci_bus 0000:00: resource 11 [mem 0x000a0000-0x000bffff window]
[    0.355801] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.355801] pci_bus 0000:01: resource 1 [mem 0xf5f00000-0xf7dfffff]
[    0.355801] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
[    0.355801] pci_bus 0000:02: resource 1 [mem 0xf7e00000-0xf7efffff]
[    0.355801] pci_bus 0000:02: resource 2 [mem 0xf5e00000-0xf5efffff 64bit pref]
[    0.355801] pci 0000:04:09.0: PCI bridge to [bus 05]
[    0.355801] pci 0000:06:0e.0: BAR 6: no space for [mem size 0x00100000 pref]
[    0.355916] pci 0000:06:0e.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[    0.356207] pci 0000:06:0e.1: BAR 6: no space for [mem size 0x00100000 pref]
[    0.356387] pci 0000:06:0e.1: BAR 6: failed to assign [mem size 0x00100000 pref]
[    0.356661] pci 0000:04:0a.0: PCI bridge to [bus 06]
[    0.356834] pci 0000:04:0a.0:   bridge window [io  0x6000-0x6fff]
[    0.357013] pci 0000:04:0a.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    0.357197] pci 0000:04:0b.0: PCI bridge to [bus 07]
[    0.357375] pci 0000:04:0c.0: PCI bridge to [bus 08]
[    0.357553] pci_bus 0000:04: resource 4 [io  0x6000-0x6fff window]
[    0.357555] pci_bus 0000:04: resource 5 [mem 0xf7f00000-0xf7ffffff window]
[    0.357558] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
[    0.357560] pci_bus 0000:06: resource 1 [mem 0xf7f00000-0xf7ffffff]
[    0.357733] NET: Registered protocol family 2
[    0.358197] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes)
[    0.358697] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.359910] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.361029] TCP: Hash tables configured (established 131072 bind 65536)
[    0.361417] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.361843] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.362398] NET: Registered protocol family 1
[    0.362605] pci 0000:00:04.3: boot interrupts on device [1022:746b] already disabled
[    0.362885] pci 0000:00:07.0: MSI quirk detected; subordinate MSI disabled
[    0.363066] pci 0000:00:07.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    0.363251] pci 0000:00:08.0: MSI quirk detected; subordinate MSI disabled
[    0.363431] pci 0000:00:08.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    0.520101] pci 0000:01:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.520391] pci 0000:04:09.0: MSI quirk detected; subordinate MSI disabled
[    0.520572] pci 0000:04:09.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    0.520759] pci 0000:04:0a.0: MSI quirk detected; subordinate MSI disabled
[    0.520939] pci 0000:04:0a.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    0.521125] pci 0000:04:0b.0: MSI quirk detected; subordinate MSI disabled
[    0.521304] pci 0000:04:0b.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    0.521491] pci 0000:04:0c.0: MSI quirk detected; subordinate MSI disabled
[    0.521713] pci 0000:04:0c.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    0.521931] PCI: CLS 64 bytes, default 64
[    0.523347] PCI-DMA: Disabling AGP.
[    0.523727] PCI-DMA: aperture base @ e8000000 size 65536 KB
[    0.523935] PCI-DMA: using GART IOMMU.
[    0.524145] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    0.529416] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.531350] workingset: timestamp_bits=42 max_order=22 bucket_order=0
[    0.535553] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.535895] io scheduler noop registered
[    0.536254] io scheduler cfq registered (default)
[    0.536841] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.537189] ACPI: Power Button [PWRF]
[    0.537447] ACPI: ACPI: processor limited to max C-state 1
[    0.537945] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.558692] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.600345] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.601078] Linux agpgart interface v0.103
[    0.601737] HP HPSA Driver (v 3.4.20-125)
[    0.601908] hpsa 0000:02:04.0: legacy board ID: 0x40800e11
[    0.602104] hpsa 0000:02:04.0: legacy board ID: 0x40800e11
[    0.602475] hpsa 0000:02:04.0: Controller reports max supported commands of 0 Using 16 instead. Ensure that firmware is up to date.
[    0.602772] hpsa 0000:02:04.0: Physical aborts not supported
[    0.602947] hpsa 0000:02:04.0: Logical aborts not supported
[    0.603121] hpsa 0000:02:04.0: HP SSD Smart Path aborts not supported
[    0.620222] hpsa 0000:02:04.0: Controller reports max supported commands of 0 Using 16 instead. Ensure that firmware is up to date.
[    0.720226] scsi host0: hpsa
[    0.720506] hpsa can't handle SMP requests
[    0.720869] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    0.722969] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.723146] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.723396] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.723757] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    0.725903] rtc_cmos rtc_cmos: alarms up to one year, y3k, 114 bytes nvram
[    0.726620] NET: Registered protocol family 10
[    0.727854] Segment Routing with IPv6
[    0.728083] NET: Registered protocol family 17
[    0.728682] RAS: Correctable Errors collector initialized.
[    0.729034] registered taskstats version 1
[    0.729215] AppArmor: AppArmor sha1 policy hashing enabled
[    0.729897] rtc_cmos rtc_cmos: setting system clock to 2018-02-25 16:33:17 UTC (1519576397)
[    0.766865] hpsa 0000:02:04.0: C0:T0:L0 Volume status not available, assuming online.
[    0.767666] hpsa 0000:02:04.0: scsi 0:1:0:0: added Direct-Access     COMPAQ   LOGICAL VOLUME   RAID-1(+0) SSDSmartPathCap- En- Exp=1
[    0.767963] hpsa 0000:02:04.0: scsi 0:3:0:0: added RAID              COMPAQ   Smart Array 5i   controller SSDSmartPathCap- En- Exp=1
[    0.768694] scsi 0:1:0:0: Direct-Access     COMPAQ   LOGICAL VOLUME   2.76 PQ: 0 ANSI: 4
[    0.769561] scsi 0:3:0:0: RAID              COMPAQ   Smart Array 5i   2.76 PQ: 0 ANSI: 0
[    0.770526] sd 0:1:0:0: [sda] 142253280 512-byte logical blocks: (72.8 GB/67.8 GiB)
[    0.770896] sd 0:1:0:0: [sda] Write Protect is off
[    0.771070] sd 0:1:0:0: [sda] Mode Sense: 5b 00 00 08
[    0.771248] sd 0:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    0.774550] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.779274]  sda: sda1 sda2 < sda5 >
[    0.780395] sd 0:1:0:0: [sda] Attached SCSI disk
[    0.781277] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[    0.781971] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[    0.805833] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    0.806142] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    0.826261] devtmpfs: mounted
[    0.828304] Freeing unused kernel memory: 980K
[    0.828520] Write protecting the kernel read-only data: 16384k
[    0.830934] Freeing unused kernel memory: 2008K
[    0.833277] Freeing unused kernel memory: 532K
[    0.848636] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.605235] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    1.605927] systemd[1]: Detected architecture x86-64.
[    1.614153] systemd[1]: Set hostname to <dl585>.
[    2.320298] systemd[1]: Created slice System Slice.
[    2.321397] systemd[1]: Listening on Journal Audit Socket.
[    2.322181] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    2.324270] systemd[1]: Mounting Huge Pages File System...
[    2.325160] systemd[1]: Listening on Syslog Socket.
[    2.325998] systemd[1]: Listening on fsck to fsckd communication Socket.
[    2.327126] systemd[1]: Created slice User and Session Slice.
[    2.495025] loop: module loaded
[    2.761660] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    2.873780] systemd-journald[108]: Received request to flush runtime journal from PID 1
[    3.320735] AMD768-HWRNG detected
[    3.331516] shpchp 0000:00:07.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
[    3.331803] shpchp 0000:00:07.0: Cannot reserve MMIO region
[    3.332566] shpchp 0000:00:08.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
[    3.332859] shpchp 0000:00:08.0: Cannot reserve MMIO region
[    3.333434] shpchp 0000:04:09.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
[    3.333751] shpchp 0000:04:09.0: Cannot reserve MMIO region
[    3.334041] shpchp 0000:04:0a.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
[    3.334382] shpchp 0000:04:0a.0: Cannot reserve MMIO region
[    3.338233] shpchp 0000:04:0b.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
[    3.338601] shpchp 0000:04:0b.0: Cannot reserve MMIO region
[    3.339749] shpchp 0000:04:0c.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
[    3.340139] shpchp 0000:04:0c.0: Cannot reserve MMIO region
[    3.340727] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.341585] libata version 3.00 loaded.
[    3.342510] k8temp 0000:00:18.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.343000] k8temp 0000:00:19.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.343531] k8temp 0000:00:1a.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.344064] k8temp 0000:00:1b.3: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.363442] Floppy drive(s): fd0 is 1.44M
[    3.363725] pata_amd 0000:00:04.1: version 0.4.1
[    3.366015] scsi host1: pata_amd
[    3.366357] scsi host2: pata_amd
[    3.366574] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x2000 irq 14
[    3.366756] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x2008 irq 15
[    3.382657] FDC 0 is a National Semiconductor PC87306
[    3.402429] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    3.430155] sd 0:1:0:0: Attached scsi generic sg0 type 0
[    3.430413] scsi 0:3:0:0: Attached scsi generic sg1 type 12
[    3.461426] ACPI: bus type USB registered
[    3.461677] usbcore: registered new interface driver usbfs
[    3.461883] usbcore: registered new interface driver hub
[    3.462135] usbcore: registered new device driver usb
[    3.472345] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.489481] MCE: In-kernel MCE decoding enabled.
[    3.500469] EDAC amd64: Node 0: DRAM ECC enabled.
[    3.500657] EDAC amd64: K8 revE or earlier detected (node 0).
[    3.500866] EDAC amd64: using x4 syndromes.
[    3.501226] EDAC MC0: Giving out device to module amd64_edac controller K8: DEV 0000:00:18.3 (INTERRUPT)
[    3.501540] EDAC amd64: Node 1: DRAM ECC enabled.
[    3.501721] EDAC amd64: K8 revE or earlier detected (node 1).
[    3.501912] EDAC amd64: using x4 syndromes.
[    3.502224] EDAC MC1: Giving out device to module amd64_edac controller K8: DEV 0000:00:19.3 (INTERRUPT)
[    3.502540] EDAC amd64: Node 2: DRAM ECC enabled.
[    3.502726] EDAC amd64: K8 revE or earlier detected (node 2).
[    3.502924] EDAC amd64: using x4 syndromes.
[    3.503248] EDAC MC2: Giving out device to module amd64_edac controller K8: DEV 0000:00:1a.3 (INTERRUPT)
[    3.503559] EDAC amd64: Node 3: DRAM ECC enabled.
[    3.503744] EDAC amd64: K8 revE or earlier detected (node 3).
[    3.503939] EDAC amd64: using x4 syndromes.
[    3.505403] EDAC MC3: Giving out device to module amd64_edac controller K8: DEV 0000:00:1b.3 (INTERRUPT)
[    3.507481] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.2 (POLLED)
[    3.507778] AMD64 EDAC driver v3.5.0
[    3.535087] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.555594] powernow_k8: Power state transitions not supported
[    3.555794] powernow_k8: Power state transitions not supported
[    3.556039] powernow_k8: Power state transitions not supported
[    3.556245] powernow_k8: Power state transitions not supported
[    3.564244] ehci-pci: EHCI PCI platform driver
[    3.570550] Fusion MPT base driver 3.04.20
[    3.570778] Copyright (c) 1999-2008 LSI Corporation
[    3.588380] ohci-pci: OHCI PCI platform driver
[    3.588876] ohci-pci 0000:01:00.0: OHCI PCI host controller
[    3.589090] ohci-pci 0000:01:00.0: new USB bus registered, assigned bus number 1
[    3.589527] ohci-pci 0000:01:00.0: irq 19, io mem 0xf7df0000
[    3.646744] ata1.00: ATAPI: COMPAQ  CD-ROM SN-124, N104, max PIO4
[    3.649799] ata1.00: configured for PIO4
[    3.650195] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    3.650391] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.650665] usb usb1: Product: OHCI PCI host controller
[    3.650837] usb usb1: Manufacturer: Linux 4.16.0-rc2-00374-g3664ce2d9309 ohci_hcd
[    3.651111] usb usb1: SerialNumber: 0000:01:00.0
[    3.651724] hub 1-0:1.0: USB hub found
[    3.651918] hub 1-0:1.0: 3 ports detected
[    3.652628] ohci-pci 0000:01:00.1: OHCI PCI host controller
[    3.652812] ohci-pci 0000:01:00.1: new USB bus registered, assigned bus number 2
[    3.653150] ohci-pci 0000:01:00.1: irq 19, io mem 0xf7de0000
[    3.653361] scsi 1:0:0:0: CD-ROM            COMPAQ   CD-ROM SN-124    N104 PQ: 0 ANSI: 5
[    3.680810] scsi 1:0:0:0: Attached scsi generic sg2 type 5
[    3.681115] ata2: port disabled--ignoring
[    3.718156] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.718339] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.718611] usb usb2: Product: OHCI PCI host controller
[    3.718783] usb usb2: Manufacturer: Linux 4.16.0-rc2-00374-g3664ce2d9309 ohci_hcd
[    3.719059] usb usb2: SerialNumber: 0000:01:00.1
[    3.719407] hub 2-0:1.0: USB hub found
[    3.719589] hub 2-0:1.0: 3 ports detected
[    3.731599] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[    3.731897] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.732631] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    3.752803] Fusion MPT SPI Host driver 3.04.20
[    3.753623] mptbase: ioc0: Initiating bringup
[    3.826461] tg3.c:v3.137 (May 11, 2014)
[    3.865407] tg3 0000:02:06.0 eth0: Tigon3 [partno(349321-001) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:13:21:07:9c:e3
[    3.865710] tg3 0000:02:06.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    3.865994] tg3 0000:02:06.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[0]
[    3.866269] tg3 0000:02:06.0 eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[    3.916453] tg3 0000:02:06.1 eth1: Tigon3 [partno(349321-001) rev 2100] (PCIX:100MHz:64-bit) MAC address 00:13:21:07:9c:e2
[    3.916776] tg3 0000:02:06.1 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    3.917078] tg3 0000:02:06.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    3.917353] tg3 0000:02:06.1 eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[    3.953886] Adding 2927612k swap on /dev/sda5.  Priority:-2 extents:1 across:2927612k 
[    4.512051] ioc0: LSI53C1030 C0: Capabilities={Initiator,Target}
[    4.820307] powernow_k8: Power state transitions not supported
[    4.820507] powernow_k8: Power state transitions not supported
[    4.820714] powernow_k8: Power state transitions not supported
[    4.820937] powernow_k8: Power state transitions not supported
[    5.258504] scsi host3: ioc0: LSI53C1030 C0, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=24
[    5.259713] mptbase: ioc1: Initiating bringup
[    5.988023] ioc1: LSI53C1030 C0: Capabilities={Initiator,Target}
[    6.714688] scsi host4: ioc1: LSI53C1030 C0, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=27
[    7.196701] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    7.900392] random: crng init done
[    8.800211] tg3 0000:02:06.0 eth0: Link is up at 100 Mbps, full duplex
[    8.800411] tg3 0000:02:06.0 eth0: Flow control is off for TX and off for RX
[    8.800633] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready


-- 
Meelis Roos (mroos@linux.ee)
