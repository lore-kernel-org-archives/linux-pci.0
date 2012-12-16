Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38672 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab2LPMYx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 16 Dec 2012 07:24:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1TkDHD-0002Lk-GA
	for linux-pci@vger.kernel.org; Sun, 16 Dec 2012 13:25:03 +0100
Received: from 91.150.147.9.internetia.net.pl ([91.150.147.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 16 Dec 2012 13:25:03 +0100
Received: from bl0-052 by 91.150.147.9.internetia.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 16 Dec 2012 13:25:03 +0100
To: linux-pci@vger.kernel.org
From: bl0 <bl0-052@playker.info>
Subject: Re: sata_sil data corruption, possible workarounds
Date: Sun, 16 Dec 2012 13:21:01 +0100
Message-ID: <kakea2$dh1$1@ger.gmane.org>
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2169060.BJCX0EGrHf"
Cc: linux-ide@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nextPart2169060.BJCX0EGrHf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit

Thanks for your response.

On Saturday 15 December 2012 22:55, Robert Hancock wrote:

> On 12/15/2012 02:02 AM, bl0 wrote:
>> I have a PCI card based on Silicon Image 3114 SATA controller. Like many
>> people in the past I have experienced silent data corruption.
>> I am lucky to have a hardware configuration where it is easy to reproduce
>> this behavior with 100% rate by copying a file from a USB stick plugged
>> into another PCI card. My motherboard has nvidia chipset.
>>
>> Going through messages and bug reports about this problem, someone
>> mentioned that PCI cache line size may be relevant. I did some testing
>> with different CLS values and found that the problem of data corruption
>> is solved if either
>> A). CLS is set to 0, before or after sata_sil kernel driver is loaded
>>    # setpci -d 1095:3114 CACHE_LINE_SIZE=0
>> where 1095:3114 is the device id as shown by 'lspci -nn'. The same
>> command can also be used in grub2 (recent versions) shell or
>> configuration file before booting linux.
>> or
>> B). CLS is set to a sufficiently large value, only after sata_sil is
>> loaded.
>>    # setpci -d 1095:3114 CACHE_LINE_SIZE=28
>> (value is hexadecimal, in 4-byte units, here it's 160 bytes)
>> What is a sufficiently large value depends on the value that is set
>> before the driver is loaded. If the value before the driver is loaded is
>> 32 or 64 bytes, I have to increase it (after the driver is loaded) to 128
>> or 160 bytes, respectively.
>>
>> In sata_sil.c source in sil_init_controller it writes some
>> hardware-specific value depending on PCI cache line size. By lowering
>> this value I can get it to work with lower CLS. The lowest value 0 works
>> with CLS 64 bytes. If the CLS is 32 bytes, I have to increase the CLS.
> 
> The meaning of that value from the datasheet is: "This bit field is used
> to specify the system cacheline size in terms of 32-bit words. The upper
> 2 bits are not used, resulting a maximum size of 64 32-bit words. With
> the SiI3114 as a master, initiating a read transaction, it issues PCI
> command Read Multiple in place, when empty space in its FIFO is larger
> than the value programmed in this register."
> 
> I think this value is likely the key. The cache line size itself
> shouldn't make any difference with this controller as it only really
> affects Memory Write & Invalidate (MWI) and the driver doesn't try to
> enable that for this device. But it's being used to derive the value
> written into this register.

In practice, on my hardware configuration, increasing the CLS after the
internal value has already been derived does make a difference.

> Can you add in some output to figure out what values are being written
> to this register

If the CLS is 32 or 64 bytes, it writes 2 or 3, respectively.

> and see which values are working or not working? 

That depends on the CLS. If the CLS is 32 bytes, it doesn't work (by work I
mean it's safe from data corruption) no matter what value I write to that
hardware register. If the CLS is 64 bytes, the only value that works is 0.

CLS     A       B       
32      2       none    
64      3       0       
96      4       1       
128     5       2       
160     6       3       

A: value written by default
B: maximum value safe from data corruption, based on my testing, probably
only applies to similar problematic hardware configurations.

Looking at this table you can see that increasing the CLS to a large value
can be a workaround after the driver has set the default value.

By default on my system this part of sata_sil code just overwrites the same
value (2 for 32 bytes CLS) that is already in place (as retrieved using
readw()) because the same value gets set (by the sata controller bios?)
after reboot. Changing this logic can work around data corruption problem.
There is another problem, sata link becoming inaccessible (I wrote more
about it in the first post), not affected by this part of sata_sil code. My
guess is that the main cause of the problems is elsewhere.

>> Data corruption is the biggest problem for me and these workarounds help
>> but another problem remains, sometimes when accessing multiple PCI
>> devices at the same time sata becomes inaccessible and times out with log
>> messages similar to:
>> [  411.351805] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>> frozen
>> [  411.351824] ata3.00: cmd c8/00:00:00:af:00/00:00:00:00:00/e0 tag 0 dma
>> 131072 in
>> [  411.351826]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
>> (timeout)
>> [  411.351830] ata3.00: status: { DRDY }
>> [  411.351843] ata3: hard resetting link
>> [  411.671775] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [  411.697059] ata3.00: configured for UDMA/100
>> [  411.697080] ata3: EH complete
>>
>> Reboot is needed to access sata drives again. If I had the root
>> filesystem on a sata drive it would probably crash the system.
>>
>> Another thing that may be related. Comparing lspci output reveals that
>> when accessing multiple PCI devices at the same time, the flag
>> DiscTmrStat (Discard Timer Status) gets toggled on for device "00:08.0
>> PCI bridge: nVidia Corporation nForce2 External PCI Bridge". I don't know
>> if it's normal or not.
> 
> I'm not an expert on the whole PCI bridge/delayed completion stuff but
> it appears that this means that a device (either the host bridge/CPU or
> a device behind that bridge) initiated a delayed transaction for a read,
> but then didn't retry the request to pick up the read data later. From
> what I can tell this seems abnormal, at least in most cases.
> 
> Can you post the full lspci -vv output? Do the problems only occur if
> there are multiple devices plugged in behind that bridge?

'lspci -vvv' output attached. Yes, I've only encountered problems with the
sata controller if at least one other external PCI card is in active use.
(The built-in devices which appear as PCI under another bridge do not cause
problems.)

>> Finally, the same simple test that I use on Linux does not produce data
>> corruption on FreeBSD. Either this problem doesn't occur there or it's
>> not trivial to reproduce.
>>
>> This bug has been around for so long. I hope someone will find this
>> information useful.


--nextPart2169060.BJCX0EGrHf
Content-Type: text/plain; name="3-lspci-vvv"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="3-lspci-vvv"

00:00.0 Host bridge: nVidia Corporation nForce2 IGP2 (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 80ac
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [40] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
	Capabilities: [60] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
		Revision ID: 0.16
	Kernel driver in use: agpgart-nvidia
	Kernel modules: nvidia-agp

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev a2)
	Subsystem: nVidia Corporation Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev a2)
	Subsystem: nVidia Corporation Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev a2)
	Subsystem: nVidia Corporation Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev a2)
	Subsystem: nVidia Corporation Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev a2)
	Subsystem: nVidia Corporation Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [48] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=1 UnitCnt=15 MastHost- DefDir-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC+ TXO- <CRCErr=0
		Link Config 0: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
		Link Control 1: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO+ <CRCErr=0
		Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
		Revision ID: 0.00

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: I/O ports at ec00 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: nForce2_smbus
	Kernel modules: i2c-nforce2

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at e5080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at e5082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at e5085000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port: BAR=1 offset=0080
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci_hcd

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard onboard nForce2 Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at e5086000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
	Kernel driver in use: forcedeth
	Kernel modules: forcedeth

00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio Processing Unit (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 0c11
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: ASUSTeK Computer Inc. nForce2 AC97 Audio Controler (MCP)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at e800 [size=128]
	Region 2: Memory at e5081000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e3000000-e4ffffff
	Prefetchable memory behind bridge: 50000000-500fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn-
	Kernel modules: shpchp

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: AMD_IDE
	Kernel modules: pata_amd

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 809a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at e5083000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at e5084000 (32-bit, non-prefetchable) [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci1394
	Kernel modules: firewire-ohci

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e2ffffff
	Prefetchable memory behind bridge: d0000000-dfffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Kernel modules: shpchp

01:07.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at c000 [size=128]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=128]
	[virtual] Expansion ROM at 50080000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: 3c59x
	Kernel modules: 3c59x

01:08.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. Unknown device 7114
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at c400 [size=8]
	Region 1: I/O ports at c800 [size=4]
	Region 2: I/O ports at cc00 [size=8]
	Region 3: I/O ports at d000 [size=4]
	Region 4: I/O ports at d400 [size=16]
	Region 5: Memory at e4001000 (32-bit, non-prefetchable) [size=1K]
	[virtual] Expansion ROM at 50000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
	Kernel driver in use: sata_sil

01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! 5.1 Model SB0100
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at d800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: EMU10K1_Audigy
	Kernel modules: snd-emu10k1

01:09.1 Input device controller: Creative Labs SB Live! Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Region 0: I/O ports at dc00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: Emu10k1_gameport
	Kernel modules: emu10k1-gp

01:0a.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation Hama USB 2.0 CardBus
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (250ns min, 10500ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e4002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

01:0a.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation Hama USB 2.0 CardBus
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (250ns min, 10500ns max), Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at e4003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

01:0a.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation USB 2.0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (4000ns min, 8500ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at e4004000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci_hcd

02:00.0 VGA compatible controller: nVidia Corporation G73 [GeForce 7600 GS] (rev a2) (prog-if 00 [VGA controller])
	Subsystem: Giga-byte Technology Unknown device 3428
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at e2000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Kernel driver in use: nvidia
	Kernel modules: nvidia, nvidiafb



--nextPart2169060.BJCX0EGrHf--

