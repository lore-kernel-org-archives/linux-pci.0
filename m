Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from server1.meinberg.de ([85.10.202.66]:37264 "EHLO
	server1.meinberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947Ab2ARP6C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 10:58:02 -0500
Received: from ubuntu-server-1 (unknown [217.6.112.194])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by server1.meinberg.de (Postfix) with ESMTPSA id 3AD7C456593
	for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 16:49:28 +0100 (CET)
Received: from [172.16.100.73] (pc-martin.py.meinberg.de [172.16.100.73])
	by ubuntu-server-1 (Postfix) with ESMTP id E5BA748193
	for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 16:49:27 +0100 (CET)
Message-ID: <4F16EA07.4000607@meinberg.de>
Date: Wed, 18 Jan 2012 16:49:27 +0100
From: Martin Burnicki <martin.burnicki@meinberg.de>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: PCI card not accessible; I/O ports at <ignored>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi folks,

I'm maintaining the driver software for the PCI cards manufactured by 
our company, Meinberg Funkuhren in Germany. Basically our Linux driver 
supports all our PCI cards on all Linux kernels 2.6.x and 3.x. The PCI 
cards are e.g. GPS receivers, radio clocks, or IRIG time code receivers.

Recently I've run into a problem with our PCI Express cards in a certain 
server PC: There are 8 PCI Express slots on the mainboard, and in some 
of the slots the cards work properly, but in some other slots on the 
same machine they don't work since the cards are not accessible by the 
kernel driver.

The cards are accessed via legacy I/O ports. I *know* memory mapped 
registers should be used preferably, but some older types of card don't 
support this. In cases where the cards are not accessible lspci -v 
reports for the I/O base address 0:

   Region 0: I/O ports at <ignored>

First I thought this was a problem with our cards, with the chipset on 
the mainboard, with the BIOS, or whatever. Then I tried to boot Windows 
and FreeDOS on this machine and found that the cards could always be 
accessed in all slots without problems.

Finally I tried different Linux distributions with different kernel 
versions and found that the same card in the same slot with the same 
driver works properly under kernel 2.6.32 and earlier, but doesn't work 
anymore under kernel 2.6.36 and later, including kernel 3.1.4. So there 
must have been some code changes in the newer kernel versions which 
prevent the card from being accessed via I/O, and let lspci say "I/O 
ports at <ignored>".


Here is the full output of lspci under kernel 3.1.4 in case where the 
card is *not* accessible:

root@MMS:~# lspci -vvv -x -d1360:*
87:00.0 System peripheral: Meinberg Funkuhren GPS180PEX GPS Receiver 
(PCI Express) (rev 01)
         Subsystem: Meinberg Funkuhren GPS180PEX GPS Receiver (PCI Express)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 54
         Region 0: I/O ports at <ignored>
         Region 1: Memory at f8cc0000 (32-bit, non-prefetchable) [size=256K]
         Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [80] Express (v1) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr- TransPend-
                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, 
Latency L0 unlimited, L1 unlimited
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Kernel modules: mbgclock
00: 60 13 06 02 47 01 10 00 01 00 80 08 40 00 00 00
10: 01 fc 00 00 00 00 cc f8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 60 13 06 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

The interesting thing here is the hex dump of the configuration space 
above, which shows that actually I/O address 0xFC00 *has* been assigned 
to base address register 0 at offset 0x10. However, when the kernel 
calls the driver's probe routine then this I/O range is *not* in the 
resource list of the device retrieved by the probe routine.

Here is the lspci output if the card is installed in a different slot 
where it can be accessed:

root@MMS:~# lspci -vvv -x -d1360:*
03:00.0 System peripheral: Meinberg Funkuhren GPS180PEX GPS Receiver 
(PCI Express) (rev 01)
         Subsystem: Meinberg Funkuhren GPS180PEX GPS Receiver (PCI Express)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 256 bytes
         Interrupt: pin A routed to IRQ 26
         Region 0: I/O ports at dc00 [size=256]
         Region 1: Memory at faec0000 (32-bit, non-prefetchable) [size=256K]
         Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [80] Express (v1) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- 
AuxPwr- TransPend-
                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, 
Latency L0 unlimited, L1 unlimited
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Kernel driver in use: mbgclock
         Kernel modules: mbgclock
00: 60 13 06 02 47 01 10 00 01 00 80 08 40 00 00 00
10: 01 dc 00 00 00 00 ec fa 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 60 13 06 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00

Here the hex dump of the configuration space shows I/O address 0xDC00 
for base address range 0, lspsi does not say <ignored>, and the card is 
accessible.


Can someone please shed some light on this and tell me:

- What makes lspci say "I/O ports at <ignored>"?

- What could be the reason why base address register 0 is not added to 
the resource list for this PCI device when the kernel scans the bus and 
detects the device?

- What has been the reason to implement this behaviour in newer kernel 
versions whereas this seems to work without problems under older kernels?

If any more information is required to fiddle this out, please let me know.

Thanks for any input on this.


Martin
-- 
Martin Burnicki

Meinberg Funkuhren
Bad Pyrmont
Germany
