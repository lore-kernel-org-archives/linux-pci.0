Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtpout02.impresasemplice.it ([83.221.127.53]:37229 "EHLO
	smtpout02.impresasemplice.it" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371Ab3FHLsw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Jun 2013 07:48:52 -0400
From: Gianluca Oglietti <gianogli@tiscali.it>
To: <linux-pci@vger.kernel.org>
Subject: Reconfigure the Intel 5520 I/O hub
Date: Sat, 8 Jun 2013 13:43:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <201306081343.23776.gianogli@tiscali.it>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've a Supermicro server with a X8DTU-6TF+ matherboard. (You can find the 
system block diagram at http://goo.gl/ibWhb).
It is a NUMA system with 2 processors and only one Intel 5520 I/O hub.
In the last weeks I've made some studies about the optimization of the 
TCP/IP packets realtime analysis but I've encountered a problem.
All the PCIe interfaces, where are used the NICs, are interconnected, 
through the Intel 5520 I/O hub, only to the NUMA node 0:

*************************
~# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 8 9 10 11
node 0 size: 6135 MB
node 0 free: 5170 MB
node 1 cpus: 4 5 6 7 12 13 14 15
node 1 size: 6144 MB
node 1 free: 5840 MB
node distances:
node   0   1 
  0:  10  21 
  1:  21  10
*************************
~# lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port 
[8086:3406] (rev 22)
00:01.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI 
Express Root Port 1 [8086:3408] (rev 22)
00:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI 
Express Root Port 3 [8086:340a] (rev 22)
00:04.0 PCI bridge [0604]: Intel Corporation 5520/X58 I/O Hub PCI 
Express Root Port 4 [8086:340b] (rev 22)
00:05.0 PCI bridge [0604]: Intel Corporation 5520/X58 I/O Hub PCI 
Express Root Port 5 [8086:340c] (rev 22)
00:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI 
Express Root Port 7 [8086:340e] (rev 22)
00:09.0 PCI bridge [0604]: Intel Corporation 7500/5520/5500/X58 I/O Hub 
PCI Express Root Port 9 [8086:3410] (rev 22)
00:13.0 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub 
I/OxAPIC Interrupt Controller [8086:342d] (rev 22)
00:14.0 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub System 
Management Registers [8086:342e] (rev 22)
00:14.1 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO 
and Scratch Pad Registers [8086:3422] (rev 22)
00:14.2 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub Control 
Status and RAS Registers [8086:3423] (rev 22)
00:14.3 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub 
Throttle Registers [8086:3438] (rev 22)
00:16.0 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:3430] (rev 22)
00:16.1 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:3431] (rev 22)
00:16.2 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:3432] (rev 22)
00:16.3 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:3433] (rev 22)
00:16.4 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:3429] (rev 22)
00:16.5 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:342a] (rev 22)
00:16.6 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:342b] (rev 22)
00:16.7 System peripheral [0880]: Intel Corporation 5520/5500/X58 
Chipset QuickData Technology Device [8086:342c] (rev 22)
00:1a.0 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB UHCI Controller #4 [8086:3a37]
00:1a.1 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB UHCI Controller #5 [8086:3a38]
00:1a.2 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB UHCI Controller #6 [8086:3a39]
00:1a.7 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB2 EHCI Controller #2 [8086:3a3c]
00:1c.0 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI 
Express Root Port 1 [8086:3a40]
00:1d.0 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB UHCI Controller #1 [8086:3a34]
00:1d.1 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB UHCI Controller #2 [8086:3a35]
00:1d.2 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB UHCI Controller #3 [8086:3a36]
00:1d.7 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) 
USB2 EHCI Controller #1 [8086:3a3a]
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge 
[8086:244e] (rev 90)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC 
Interface Controller [8086:3a16]
00:1f.2 IDE interface [0101]: Intel Corporation 82801JI (ICH10 Family) 4 
port SATA IDE Controller #1 [8086:3a20]
00:1f.3 SMBus [0c05]: Intel Corporation 82801JI (ICH10 Family) SMBus 
Controller [8086:3a30]
00:1f.5 IDE interface [0101]: Intel Corporation 82801JI (ICH10 Family) 2 
port SATA IDE Controller #2 [8086:3a26]
03:00.0 Ethernet controller [0200]: Intel Corporation 82599EB 10-Gigabit 
SFI/SFP+ Network Connection [8086:10fb] (rev 01)
03:00.1 Ethernet controller [0200]: Intel Corporation 82599EB 10-Gigabit 
SFI/SFP+ Network Connection [8086:10fb] (rev 01)
04:00.0 RAID bus controller [0104]: LSI Logic / Symbios Logic MegaRAID 
SAS 2108 [Liberator] [1000:0079] (rev 04)
06:00.0 Ethernet controller [0200]: Intel Corporation 82599EB 10-Gigabit 
SFI/SFP+ Network Connection [8086:10fb] (rev 01)
06:00.1 Ethernet controller [0200]: Intel Corporation 82599EB 10-Gigabit 
SFI/SFP+ Network Connection [8086:10fb] (rev 01)
07:00.0 Ethernet controller [0200]: Intel Corporation 82576 Gigabit 
Network Connection [8086:10c9] (rev 01)
07:00.1 Ethernet controller [0200]: Intel Corporation 82576 Gigabit 
Network Connection [8086:10c9] (rev 01)
08:01.0 VGA compatible controller [0300]: Matrox Electronics Systems 
Ltd. MGA G200eW WPCM450 [102b:0532] (rev 0a)
fe:00.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
QuickPath Architecture Generic Non-Core Registers [8086:2c40] (rev 05)
fe:00.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
QuickPath Architecture System Address Decoder [8086:2c01] (rev 05)
fe:02.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI Link 
0 [8086:2c10] (rev 05)
fe:02.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI 
Physical 0 [8086:2c11] (rev 05)
fe:02.4 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI Link 
1 [8086:2c14] (rev 05)
fe:02.5 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI 
Physical 1 [8086:2c15] (rev 05)
fe:03.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller [8086:2c18] (rev 05)
fe:03.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Target Address Decoder [8086:2c19] (rev 05)
fe:03.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller RAS Registers [8086:2c1a] (rev 05)
fe:03.4 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Test Registers [8086:2c1c] (rev 05)
fe:04.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Control Registers [8086:2c20] 
(rev 05)
fe:04.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Address Registers [8086:2c21] 
(rev 05)
fe:04.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Rank Registers [8086:2c22] (rev 
05)
fe:04.3 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Thermal Control Registers 
[8086:2c23] (rev 05)
fe:05.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Control Registers [8086:2c28] 
(rev 05)
fe:05.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Address Registers [8086:2c29] 
(rev 05)
fe:05.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Rank Registers [8086:2c2a] (rev 
05)
fe:05.3 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Thermal Control Registers 
[8086:2c2b] (rev 05)
fe:06.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Control Registers [8086:2c30] 
(rev 05)
fe:06.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Address Registers [8086:2c31] 
(rev 05)
fe:06.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Rank Registers [8086:2c32] (rev 
05)
fe:06.3 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Thermal Control Registers 
[8086:2c33] (rev 05)
ff:00.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QuickPath 
Architecture Generic Non-Core Registers [8086:2c40] (rev 05)
ff:00.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QuickPath 
Architecture System Address Decoder [8086:2c01] (rev 05)
ff:02.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI Link 
0 [8086:2c10] (rev 05)
ff:02.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI 
Physical 0 [8086:2c11] (rev 05)
ff:02.4 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI Link 
1 [8086:2c14] (rev 05)
ff:02.5 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 QPI 
Physical 1 [8086:2c15] (rev 05)
ff:03.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller [8086:2c18] (rev 05)
ff:03.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Target Address Decoder [8086:2c19] (rev 05)
ff:03.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller RAS Registers [8086:2c1a] (rev 05)
ff:03.4 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Test Registers [8086:2c1c] (rev 05)
ff:04.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Control Registers [8086:2c20] 
(rev 05)
ff:04.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Address Registers [8086:2c21] 
(rev 05)
ff:04.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Rank Registers [8086:2c22] (rev 
05)
ff:04.3 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 0 Thermal Control Registers 
[8086:2c23] (rev 05)
ff:05.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Control Registers [8086:2c28] 
(rev 05)
ff:05.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Address Registers [8086:2c29] 
(rev 05)
ff:05.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Rank Registers [8086:2c2a] (rev 
05)
ff:05.3 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 1 Thermal Control Registers 
[8086:2c2b] (rev 05)
ff:06.0 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Control Registers [8086:2c30] 
(rev 05)
ff:06.1 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Address Registers [8086:2c31] 
(rev 05)
ff:06.2 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Rank Registers [8086:2c32] (rev 
05)
ff:06.3 Host bridge [0600]: Intel Corporation Xeon 5500/Core i7 
Integrated Memory Controller Channel 2 Thermal Control Registers 
[8086:2c33] (rev 05)
*************************
~# cat /sys/bus/pci/devices/0000\:0[3,6]\:00.[0,1]/local_cpulist 
0-3,8-11
0-3,8-11
0-3,8-11
0-3,8-11
*************************

Is there a way to reconfigure the Intel 5520 I/O hub (via software, 
without a new BIOS) to connect one NIC to NUMA node 0 and the other one 
to NUMA node 1?

****THIS IS WHAT I WOULD WANT****
~# cat /sys/bus/pci/devices/0000\:0[3,6]\:00.[0,1]/local_cpulist 
0-3,8-11
0-3,8-11
4-7,12-15
4-7,12-15
**********************************

Thanks in advance.

    Gianluca

