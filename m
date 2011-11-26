Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pepin.polanet.pl ([193.34.52.2]:44333 "EHLO pepin.polanet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab1KZTUY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 26 Nov 2011 14:20:24 -0500
Date: Sat, 26 Nov 2011 20:01:36 +0100
From: Tomasz Pala <gotar@polanet.pl>
To: linux-pci@vger.kernel.org
Subject: forcedeth@Asus M3N-HT DELUXE quirk
Message-ID: <20111126190133.GA19335@polanet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I've encoutered a problem already described at
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=552299
Disabling MSI by module option fixes mine hardware too, however this
issue should be fixed OOTB. I haven't noticed any problems with AHCI
using PCI-MSI-edge, so this seems not to be entire MB/bridge related.

grep -s . /sys/class/dmi/id/{sys,product,chassis,bios,board}_{vendor,name,version}
/sys/class/dmi/id/sys_vendor:System manufacturer
/sys/class/dmi/id/product_name:System Product Name
/sys/class/dmi/id/product_version:System Version
/sys/class/dmi/id/chassis_vendor:Chassis Manufacture
/sys/class/dmi/id/chassis_version:Chassis Version
/sys/class/dmi/id/bios_vendor:Phoenix Technologies, LTD
/sys/class/dmi/id/bios_version:ASUS M3N-HT Deluxe ACPI BIOS Revision 2904
/sys/class/dmi/id/board_vendor:ASUSTeK Computer INC.
/sys/class/dmi/id/board_name:M3N-HT DELUXE
/sys/class/dmi/id/board_version:1.XX

lspci -v
00:00.0 RAM memory: nVidia Corporation MCP78S [GeForce 8200] Memory Controller (rev a2)
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [94] HyperTransport: #1a
        Capabilities: [60] HyperTransport: Retry Mode
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [d0] HyperTransport: #1c

00:01.0 ISA bridge: nVidia Corporation MCP78S [GeForce 8200] LPC Bridge (rev a2)
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation MCP78S [GeForce 8200] SMBus (rev a1)
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: 66MHz, fast devsel, IRQ 7
        I/O ports at ff00 [size=64]
        I/O ports at 1c00 [size=64]
        I/O ports at 1c40 [size=64]
        Capabilities: [44] Power Management version 2

00:01.2 RAM memory: nVidia Corporation MCP78S [GeForce 8200] Memory Controller (rev a1)
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: 66MHz, fast devsel

00:01.3 Co-processor: nVidia Corporation MCP78S [GeForce 8200] Co-Processor (rev a2)
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at fdf80000 (32-bit, non-prefetchable) [size=512K]

00:01.4 RAM memory: nVidia Corporation MCP78S [GeForce 8200] Memory Controller (rev a1)
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: 66MHz, fast devsel

00:02.0 USB Controller: nVidia Corporation MCP78S [GeForce 8200] OHCI USB 1.1 Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation MCP78S [GeForce 8200] EHCI USB 2.0 Controller (rev a1) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 10
        Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port: BAR=1 offset=00a0
        Capabilities: [80] Power Management version 2

00:04.0 USB Controller: nVidia Corporation MCP78S [GeForce 8200] OHCI USB 1.1 Controller (rev a1) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:04.1 USB Controller: nVidia Corporation MCP78S [GeForce 8200] EHCI USB 2.0 Controller (rev a1) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 7
        Memory at fe02c000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port: BAR=1 offset=00a0
        Capabilities: [80] Power Management version 2

00:06.0 IDE interface: nVidia Corporation MCP78S [GeForce 8200] IDE (rev a1) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0
        [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
        [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
        [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
        [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
        I/O ports at fc00 [size=16]
        Capabilities: [44] Power Management version 2

00:08.0 PCI bridge: nVidia Corporation MCP78S [GeForce 8200] PCI Bridge (rev a1) (prog-if 01 [Subtractive decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fde00000-fdefffff
        Prefetchable memory behind bridge: fdd00000-fddfffff
        Capabilities: [b8] Subsystem: ASUSTeK Computer Inc. Device 82e7
        Capabilities: [8c] HyperTransport: MSI Mapping Enable+ Fixed-

00:09.0 SATA controller: nVidia Corporation MCP78S [GeForce 8200] AHCI Controller (rev a2) (prog-if 01 [AHCI 1.0])
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 40
        I/O ports at 09f0 [size=8]
        I/O ports at 0bf0 [size=4]
        I/O ports at 0970 [size=8]
        I/O ports at 0b70 [size=4]
        I/O ports at f700 [size=16]
        Memory at fe026000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [44] Power Management version 2
        Capabilities: [8c] SATA HBA v1.0
        Capabilities: [b0] MSI: Enable+ Count=1/8 Maskable- 64bit+
        Capabilities: [ec] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: ahci

00:0a.0 Ethernet controller: nVidia Corporation MCP77 Ethernet (rev a2)
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
        Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at f600 [size=8]
        Memory at fe02a000 (32-bit, non-prefetchable) [size=256]
        Memory at fe029000 (32-bit, non-prefetchable) [size=16]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] MSI: Enable- Count=1/16 Maskable+ 64bit+
        Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: forcedeth

00:0b.0 PCI bridge: nVidia Corporation MCP78S [GeForce 8200] PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fb000000-fcffffff
        Prefetchable memory behind bridge: 00000000d8000000-00000000e7ffffff
        Capabilities: [40] Subsystem: ASUSTeK Computer Inc. Device 82e7
        Capabilities: [48] Power Management version 2
        Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-

00:10.0 PCI bridge: nVidia Corporation MCP78S [GeForce 8200] PCI Express Bridge (rev a1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=06, sec-latency=0
        I/O behind bridge: 0000b000-0000cfff
        Memory behind bridge: fdb00000-fdcfffff
        Prefetchable memory behind bridge: 00000000fd900000-00000000fdafffff
        Capabilities: [40] Subsystem: ASUSTeK Computer Inc. Device 82e7
        Capabilities: [48] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/2 Maskable- 64bit+
        Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-
        Capabilities: [80] Express Root Port (Slot-), MSI 00
        Kernel driver in use: pcieport

00:13.0 PCI bridge: nVidia Corporation MCP78S [GeForce 8200] PCI Bridge (rev a1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fd800000-fd8fffff
        Prefetchable memory behind bridge: 00000000fd700000-00000000fd7fffff
        Capabilities: [40] Subsystem: ASUSTeK Computer Inc. Device 82e7
        Capabilities: [48] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/2 Maskable- 64bit+
        Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-
        Capabilities: [80] Express Root Port (Slot+), MSI 00
        Kernel driver in use: pcieport

00:14.0 PCI bridge: nVidia Corporation MCP78S [GeForce 8200] PCI Bridge (rev a1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
        I/O behind bridge: 00008000-00009fff
        Memory behind bridge: fd600000-fd6fffff
        Prefetchable memory behind bridge: 00000000fd500000-00000000fd5fffff
        Capabilities: [40] Subsystem: ASUSTeK Computer Inc. Device 82e7
        Capabilities: [48] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/2 Maskable- 64bit+
        Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-
        Capabilities: [80] Express Root Port (Slot+), MSI 00
        Kernel driver in use: pcieport

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel
        Capabilities: [f0] Secure device <?>
        Kernel driver in use: k8temp

02:00.0 VGA compatible controller: nVidia Corporation C77 [nForce 780a SLI] (rev a2) (prog-if 00 [VGA controller])
        Subsystem: ASUSTeK Computer Inc. Device 82e7
        Flags: bus master, fast devsel, latency 0, IRQ 7
        Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (64-bit, prefetchable) [size=128M]
        Memory at e6000000 (64-bit, prefetchable) [size=32M]
        I/O ports at dc00 [size=128]
        [virtual] Expansion ROM at e0000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+

03:00.0 PCI bridge: nVidia Corporation NF200 PCIe 2.0 switch for mainboards (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=03, secondary=04, subordinate=06, sec-latency=0
        I/O behind bridge: 0000b000-0000cfff
        Memory behind bridge: fdb00000-fdcfffff
        Prefetchable memory behind bridge: 00000000fd900000-00000000fdafffff
        Capabilities: [40] Power Management version 3
        Capabilities: [60] Express Upstream Port, MSI 00
        Capabilities: [a0] Subsystem: nVidia Corporation Device 0c19
        Kernel driver in use: pcieport

04:00.0 PCI bridge: nVidia Corporation NF200 PCIe 2.0 switch for mainboards (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=04, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fdc00000-fdcfffff
        Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
        Capabilities: [40] Power Management version 3
        Capabilities: [60] Express Downstream Port (Slot+), MSI 00
        Kernel driver in use: pcieport

04:02.0 PCI bridge: nVidia Corporation NF200 PCIe 2.0 switch for mainboards (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=04, secondary=06, subordinate=06, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fdb00000-fdbfffff
        Prefetchable memory behind bridge: 00000000fd900000-00000000fd9fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [60] Express Downstream Port (Slot+), MSI 00
        Kernel driver in use: pcieport

08:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II Controller (rev b2) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Marvell Technology Group Ltd. 88SE6121 SATA II Controller
        Flags: bus master, fast devsel, latency 0, IRQ 11
        I/O ports at 9c00 [size=8]
        I/O ports at 9800 [size=4]
        I/O ports at 9400 [size=8]
        I/O ports at 9000 [size=4]
        I/O ports at 8c00 [size=16]
        Memory at fd6ff000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
        Capabilities: [e0] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting

-- 
Tomasz Pala <gotar@pld-linux.org>
