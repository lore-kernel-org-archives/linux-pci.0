Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2.nber.org ([66.251.72.79]:12003 "EHLO mail2.nber.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771Ab3BRWWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Feb 2013 17:22:03 -0500
Message-ID: <5122A19B.9090308@nber.org>
Date: Mon, 18 Feb 2013 16:48:11 -0500
From: Alex Aminoff <aminoff@nber.org>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: Daniel Feenberg <feenberg@nber.org>,
	Mohan Ramanujan <mohan@nber.org>
Subject: Problem with MSI with QLogic/HP 10Gigabit Ethernet NIC and IRQs solved
 with pci=nomsi
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


As recommended in the MSI-HOWTO, we are submitting our case where we 
believe that certain hardware does not work correctly with MSI.


We have two machines running Scientific Linux:

Linux age9 2.6.32-279.19.1.el6.x86_64 #1 SMP Tue Dec 18 17:22:54 CST 
2012 x86_64 x86_64 x86_64 GNU/Linux

The symptom appeared to be problems with the 10G ethernet card that 
produced error messages about do_IRQ. (It so happens that these machines 
boot diskless so NFS problems would crash or hang the machines; 
therefore others with the same setup but booting from local disk might 
not experience this to the same severity).

The problems appear to be gone now that we are booting with pci=nomsi.

Here is lspci -v from one of them. The problem appears to be with 
04:00.0, though it could be with a PCI bridge on the path to that if I 
correctly understood the MSI howto.


00:00.0 Host bridge: Intel Corporation 5520 I/O Hub to ESI Port (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel
     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
     Capabilities: [90] Express Root Port (Slot-), MSI 00
     Capabilities: [e0] Power Management version 3

00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express 
Root Port 1 (rev 22) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=09, subordinate=0a, sec-latency=0
     I/O behind bridge: 0000e000-0000efff
     Memory behind bridge: fbd00000-fbefffff
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
     Capabilities: [90] Express Root Port (Slot+), MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: shpchp

00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express 
Root Port 3 (rev 22) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
     Capabilities: [90] Express Root Port (Slot+), MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: shpchp

00:05.0 PCI bridge: Intel Corporation 5520/X58 I/O Hub PCI Express Root 
Port 5 (rev 22) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
     Capabilities: [90] Express Root Port (Slot+), MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: shpchp

00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express 
Root Port 7 (rev 22) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
     I/O behind bridge: 0000d000-0000dfff
     Memory behind bridge: fbc00000-fbcfffff
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
     Capabilities: [90] Express Root Port (Slot+), MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: shpchp

00:09.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express 
Root Port 9 (rev 22) (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
     Capabilities: [90] Express Root Port (Slot+), MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: shpchp

00:13.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub I/OxAPIC Interrupt 
Controller (rev 22) (prog-if 20 [IO(X)-APIC])
     Flags: bus master, fast devsel, latency 0
     Memory at fec8a000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [6c] Power Management version 3

00:14.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub System Management 
Registers (rev 22) (prog-if 00 [8259])
     Flags: fast devsel
     Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
     Kernel modules: i7core_edac

00:14.1 PIC: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratch 
Pad Registers (rev 22) (prog-if 00 [8259])
     Flags: fast devsel
     Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00

00:14.2 PIC: Intel Corporation 5520/5500/X58 I/O Hub Control Status and 
RAS Registers (rev 22) (prog-if 00 [8259])
     Flags: fast devsel
     Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00

00:14.3 PIC: Intel Corporation 5520/5500/X58 I/O Hub Throttle Registers 
(rev 22) (prog-if 00 [8259])
     Flags: fast devsel

00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 10
     Memory at fb2d4000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 5
     Memory at fb2d8000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 15
     Memory at fb2dc000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 11
     Memory at fb2e0000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 10
     Memory at fb2e4000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 5
     Memory at fb2e8000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 15
     Memory at fb2ec000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset 
QuickData Technology Device (rev 22)
     Subsystem: Intel Corporation Device 0000
     Flags: fast devsel, IRQ 11
     Memory at fb2f0000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] MSI-X: Enable- Count=1 Masked-
     Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
     Capabilities: [e0] Power Management version 3
     Kernel modules: ioatdma

00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB 
UHCI Controller #4 (prog-if 00 [UHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB UHCI 
Controller #4
     Flags: bus master, medium devsel, latency 0, IRQ 10
     I/O ports at 7400 [size=32]
     Capabilities: [50] PCI Advanced Features
     Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB 
UHCI Controller #5 (prog-if 00 [UHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB UHCI 
Controller #5
     Flags: bus master, medium devsel, latency 0, IRQ 7
     I/O ports at 7480 [size=32]
     Capabilities: [50] PCI Advanced Features
     Kernel driver in use: uhci_hcd

00:1a.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB 
UHCI Controller #6 (prog-if 00 [UHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB UHCI 
Controller #6
     Flags: bus master, medium devsel, latency 0, IRQ 11
     I/O ports at 7800 [size=32]
     Capabilities: [50] PCI Advanced Features
     Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 
EHCI Controller #2 (prog-if 20 [EHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI 
Controller #2
     Flags: bus master, medium devsel, latency 0, IRQ 15
     Memory at fb2f6000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
     Kernel driver in use: ehci_hcd

00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express 
Root Port 1 (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
     I/O behind bridge: 00001000-00001fff
     Memory behind bridge: fb500000-fbbfffff
     Prefetchable memory behind bridge: 00000000c0400000-00000000c05fffff
     Capabilities: [40] Express Root Port (Slot+), MSI 00
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
     Capabilities: [90] Subsystem: Intel Corporation 82801JI (ICH10 
Family) PCI Express Root Port 1
     Capabilities: [a0] Power Management version 2
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express 
Root Port 5 (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: 0000c000-0000cfff
     Memory behind bridge: fb400000-fb4fffff
     Prefetchable memory behind bridge: 00000000c0200000-00000000c03fffff
     Capabilities: [40] Express Root Port (Slot+), MSI 00
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
     Capabilities: [90] Subsystem: Intel Corporation 82801JI (ICH10 
Family) PCI Express Root Port 5
     Capabilities: [a0] Power Management version 2
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express 
Root Port 6 (prog-if 00 [Normal decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 0000b000-0000bfff
     Memory behind bridge: fb300000-fb3fffff
     Prefetchable memory behind bridge: 00000000c0000000-00000000c01fffff
     Capabilities: [40] Express Root Port (Slot+), MSI 00
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
     Capabilities: [90] Subsystem: Intel Corporation 82801JI (ICH10 
Family) PCI Express Root Port 6
     Capabilities: [a0] Power Management version 2
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB 
UHCI Controller #1 (prog-if 00 [UHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB UHCI 
Controller #1
     Flags: bus master, medium devsel, latency 0, IRQ 14
     I/O ports at 7880 [size=32]
     Capabilities: [50] PCI Advanced Features
     Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB 
UHCI Controller #2 (prog-if 00 [UHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB UHCI 
Controller #2
     Flags: bus master, medium devsel, latency 0, IRQ 11
     I/O ports at 7c00 [size=32]
     Capabilities: [50] PCI Advanced Features
     Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB 
UHCI Controller #3 (prog-if 00 [UHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB UHCI 
Controller #3
     Flags: bus master, medium devsel, latency 0, IRQ 15
     I/O ports at 8000 [size=32]
     Capabilities: [50] PCI Advanced Features
     Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 
EHCI Controller #1 (prog-if 20 [EHCI])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI 
Controller #1
     Flags: bus master, medium devsel, latency 0, IRQ 14
     Memory at fb2f8000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
     Kernel driver in use: ehci_hcd

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90) (prog-if 
01 [Subtractive decode])
     Flags: bus master, fast devsel, latency 0
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
     I/O behind bridge: 0000a000-0000afff
     Memory behind bridge: fa700000-faffffff
     Capabilities: [50] Subsystem: Intel Corporation 82801 PCI Bridge

00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface 
Controller
     Subsystem: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller
     Flags: bus master, medium devsel, latency 0
     Capabilities: [e0] Vendor Specific Information <?>
     Kernel modules: iTCO_wdt

00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port 
SATA IDE Controller #1 (prog-if 8f [Master SecP SecO PriP PriO])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) 4 port SATA IDE 
Controller #1
     Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 11
     I/O ports at 8c00 [size=8]
     I/O ports at 8880 [size=4]
     I/O ports at 8800 [size=8]
     I/O ports at 8480 [size=4]
     I/O ports at 8400 [size=16]
     I/O ports at 8080 [size=16]
     Capabilities: [70] Power Management version 3
     Capabilities: [b0] PCI Advanced Features
     Kernel driver in use: ata_piix
     Kernel modules: ata_generic, pata_acpi, ata_piix

00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
     Subsystem: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
     Flags: medium devsel, IRQ 15
     Memory at fb2fa000 (64-bit, non-prefetchable) [size=256]
     I/O ports at 0400 [size=32]
     Kernel driver in use: i801_smbus
     Kernel modules: i2c-i801

00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port 
SATA IDE Controller #2 (prog-if 85 [Master SecO PriO])
     Subsystem: Intel Corporation 82801JI (ICH10 Family) 2 port SATA IDE 
Controller #2
     Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 11
     I/O ports at 9c00 [size=8]
     I/O ports at 9880 [size=4]
     I/O ports at 9800 [size=8]
     I/O ports at 9480 [size=4]
     I/O ports at 9400 [size=16]
     I/O ports at 9080 [size=16]
     Capabilities: [70] Power Management version 3
     Capabilities: [b0] PCI Advanced Features
     Kernel driver in use: ata_piix
     Kernel modules: ata_generic, pata_acpi, ata_piix

01:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED 
Graphics Family (rev 10) (prog-if 00 [VGA controller])
     Subsystem: ASPEED Technology, Inc. ASPEED Graphics Family
     Flags: medium devsel, IRQ 10
     Memory at fa800000 (32-bit, non-prefetchable) [size=8M]
     Memory at fa7e0000 (32-bit, non-prefetchable) [size=128K]
     I/O ports at ac00 [size=128]
     Expansion ROM at <unassigned> [disabled]
     Capabilities: [40] Power Management version 3

02:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network 
Connection
     Subsystem: Tyan Computer Device 7012
     Flags: bus master, fast devsel, latency 0, IRQ 5
     Memory at fb3e0000 (32-bit, non-prefetchable) [size=128K]
     I/O ports at bc00 [size=32]
     Memory at fb3dc000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [c8] Power Management version 2
     Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
     Capabilities: [e0] Express Endpoint, MSI 00
     Capabilities: [a0] MSI-X: Enable- Count=5 Masked-
     Kernel driver in use: e1000e
     Kernel modules: e1000e

03:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network 
Connection
     Subsystem: Tyan Computer Device 7012
     Flags: bus master, fast devsel, latency 0, IRQ 10
     Memory at fb4e0000 (32-bit, non-prefetchable) [size=128K]
     I/O ports at cc00 [size=32]
     Memory at fb4dc000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [c8] Power Management version 2
     Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
     Capabilities: [e0] Express Endpoint, MSI 00
     Capabilities: [a0] MSI-X: Enable- Count=5 Masked-
     Kernel driver in use: e1000e
     Kernel modules: e1000e

04:00.0 Ethernet controller: QLogic Corp. cLOM8214 1/10GbE Controller 
(rev 54)
     Subsystem: Hewlett-Packard Company NC523SFP 10Gb 2-port Server Adapter
     Flags: bus master, fast devsel, latency 0, IRQ 10
     Memory at fb600000 (64-bit, non-prefetchable) [size=2M]
     Memory at fb5f0000 (64-bit, non-prefetchable) [size=64K]
     Expansion ROM at fb580000 [disabled] [size=256K]
     Capabilities: [40] MSI-X: Enable- Count=32 Masked-
     Capabilities: [80] Power Management version 3
     Capabilities: [88] Vital Product Data
     Capabilities: [a0] MSI: Enable- Count=1/32 Maskable- 64bit+
     Capabilities: [c0] Express Endpoint, MSI 00
     Kernel driver in use: qlcnic
     Kernel modules: qlcnic

04:00.1 Ethernet controller: QLogic Corp. cLOM8214 1/10GbE Controller 
(rev 54)
     Subsystem: Hewlett-Packard Company NC523SFP 10Gb 2-port Server Adapter
     Flags: bus master, fast devsel, latency 0, IRQ 10
     Memory at fba00000 (64-bit, non-prefetchable) [size=2M]
     Memory at fb9f0000 (64-bit, non-prefetchable) [size=64K]
     Expansion ROM at fb980000 [disabled] [size=256K]
     Capabilities: [40] MSI-X: Enable- Count=32 Masked-
     Capabilities: [80] Power Management version 3
     Capabilities: [88] Vital Product Data
     Capabilities: [a0] MSI: Enable- Count=1/32 Maskable- 64bit+
     Capabilities: [c0] Express Endpoint, MSI 00
     Kernel driver in use: qlcnic
     Kernel modules: qlcnic

06:00.0 SATA controller: JMicron Technology Corp. JMB362/JMB363 Serial 
ATA Controller (rev 03) (prog-if 01 [AHCI 1.0])
     Subsystem: JMicron Technology Corp. JMB362/JMB363 Serial ATA Controller
     Flags: bus master, fast devsel, latency 0, IRQ 10
     Memory at fbcfe000 (32-bit, non-prefetchable) [size=8K]
     Expansion ROM at fbce0000 [disabled] [size=64K]
     Capabilities: [68] Power Management version 2
     Capabilities: [50] Express Legacy Endpoint, MSI 01
     Kernel driver in use: ahci
     Kernel modules: ahci

06:00.1 IDE interface: JMicron Technology Corp. JMB362/JMB363 Serial ATA 
Controller (rev 03) (prog-if 85 [Master SecO PriO])
     Subsystem: JMicron Technology Corp. JMB362/JMB363 Serial ATA Controller
     Flags: bus master, fast devsel, latency 0, IRQ 5
     I/O ports at dc00 [size=8]
     I/O ports at d880 [size=4]
     I/O ports at d800 [size=8]
     I/O ports at d480 [size=4]
     I/O ports at d400 [size=16]
     Capabilities: [68] Power Management version 2
     Kernel driver in use: pata_jmicron
     Kernel modules: ata_generic, pata_acpi, pata_jmicron

09:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network 
Connection (rev 01)
     Subsystem: Tyan Computer Device 7012
     Flags: bus master, fast devsel, latency 0, IRQ 10
     Memory at fbe20000 (32-bit, non-prefetchable) [size=128K]
     Memory at fbe00000 (32-bit, non-prefetchable) [size=128K]
     I/O ports at e880 [size=32]
     Memory at fbdfc000 (32-bit, non-prefetchable) [size=16K]
     Expansion ROM at fbdc0000 [disabled] [size=128K]
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
     Capabilities: [70] MSI-X: Enable- Count=10 Masked-
     Capabilities: [a0] Express Endpoint, MSI 00
     Kernel driver in use: igb
     Kernel modules: igb

09:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network 
Connection (rev 01)
     Subsystem: Tyan Computer Device 7012
     Flags: bus master, fast devsel, latency 0, IRQ 5
     Memory at fbee0000 (32-bit, non-prefetchable) [size=128K]
     Memory at fbec0000 (32-bit, non-prefetchable) [size=128K]
     I/O ports at ec00 [size=32]
     Memory at fbebc000 (32-bit, non-prefetchable) [size=16K]
     Expansion ROM at fbe80000 [disabled] [size=128K]
     Capabilities: [40] Power Management version 3
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
     Capabilities: [70] MSI-X: Enable- Count=10 Masked-
     Capabilities: [a0] Express Endpoint, MSI 00
     Kernel driver in use: igb
     Kernel modules: igb


