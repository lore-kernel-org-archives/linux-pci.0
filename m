Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:54761 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758170Ab3AIXLC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 18:11:02 -0500
Message-ID: <50EDF8FE.6040607@fold.natur.cuni.cz>
Date: Thu, 10 Jan 2013 00:10:54 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: Yinghai Lu <yinghai@kernel.org>
Subject: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force' on
 kernel command-line for hotplug to work
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
  I am following up on a former thread
Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
about the same issue. I think I found some new info while playing with 3.7.1 kernel.
It happened to me that my hotplug of express cards stopped working so it made me to
to dive in a figure out what driver did I do to my .config, and what combinations
of drivers and kernel command-line parameters work and which not. This email will
cover just one case.

On this Dell Vostro 3550 express card slot works if kernel is without pciehp
altogether and pci_hotplug+acpiphp are loaded as modules later on. The problem
is that I must use pcie_aspm=off. Below is hopefully an answer why. I can provide
dmesg/interrupts/config.gz/lsusb/lspci for each combination I tried. Here I have
pasted just bits which I found only directly related. Please bear in mind previously
it seemed that the hardware has broken PresDet hadling and therefore I faced
'Surprise removal' meesages from pciehp. This email is however about acpiphp
and you can see that actually PresDet flag contains correct values. But I want
to avoid here showing that pciehp has a bug. That will come in another thread. ;-)

The kernel binary has no pciehp at all but pci_hotplug and acpiphp are available as
modules. I load them manually after saving dmesg/lspci/lsusb/interrupts/.config into
a separate directory. I then poke through the collected data and run diff. 
I did everything under two different BIOS configs. I suspected the media
card reader somehow interferes with the express slot card detection because it
was sometime detected on the ehci but when I (un)plugged the express card into
its slot. Am not sure yet, but FYI what is avalable for you off-the-list ;-)
# du -sh MediaCard_reader_*
12M     MediaCard_reader_disabled_in_BIOS
7.5M    MediaCard_reader_enabled_in_BIOS
#


And now the results:

--- MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted/dmesg.notiming        2013-01-09 15:15:28.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off/dmesg.notiming 2013-01-09 15:42:02.000000000 +0100
@@ -1,5 +1,5 @@
 Linux version 3.7.1-default (root@vostro) (gcc version 4.6.3 (Gentoo 4.6.3 p1.8, pie-0.5.2) ) #30 SMP Wed Jan 9 14:45:10 MET 2013
-Command line: root=/dev/sda5 pciehp.pciehp_debug=1 slub_debug=AFPZ
+Command line: root=/dev/sda5 pciehp.pciehp_debug=1 slub_debug=AFPZ pcie_aspm=off

@@ -374,7 +375,6 @@
 pci 0000:11:00.0: reg 20: [io  0xc000-0xc07f]
 pci 0000:11:00.0: reg 30: [mem 0xf6c00000-0xf6c7ffff pref]
 pci 0000:11:00.0: supports D1 D2
-pci 0000:11:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
 pci_bus 0000:11: fixups for bus
 pci 0000:00:1c.7: PCI bridge to [bus 11-16]
 pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
@@ -393,8 +393,7 @@
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP08._PRT]
- pci0000:00: Requesting ACPI _OSC control (0x1d)
- pci0000:00: ACPI _OSC control (0x19) granted
+ pci0000:00: Unable to request _OSC control (_OSC support mask: 0x19)
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
 ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 10 11 12 14 15)
 ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 10 11 12 14 15)
@@ -654,7 +653,6 @@
 io scheduler noop registered
 io scheduler deadline registered (default)
 io scheduler cfq registered
-pcieport 0000:00:1c.7: irq 40 for MSI/MSI-X
 intel_idle: MWAIT substates: 0x21120
 intel_idle: v0.4 model 0x2A
 intel_idle: lapic_timer_reliable_states 0xffffffff
@@ -688,7 +686,7 @@
 ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
 lpc_ich: Resource conflict(s) found affecting gpio_ich
 ahci 0000:00:1f.2: version 3.0
-ahci 0000:00:1f.2: irq 41 for MSI/MSI-X
+ahci 0000:00:1f.2: irq 40 for MSI/MSI-X
 ahci: SSS flag set, parallel bus scan disabled
 ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x31 impl SATA mode
 ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems sxs apst 
@@ -699,18 +697,18 @@
 scsi3 : ahci
 scsi4 : ahci
 scsi5 : ahci
-ata1: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f06100 irq 41
+ata1: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f06100 irq 40
 ata2: DUMMY
 ata3: DUMMY
 ata4: DUMMY
-ata5: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f06300 irq 41
-ata6: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f06380 irq 41
+ata5: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f06300 irq 40
+ata6: SATA max UDMA/133 abar m2048@0xf7f06000 port 0xf7f06380 irq 40
 tun: Universal TUN/TAP device driver, 1.6
 tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
 r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
 r8169 0000:05:00.0: enabling Mem-Wr-Inval
-r8169 0000:05:00.0: irq 42 for MSI/MSI-X
-r8169 0000:05:00.0 eth0: RTL8168e/8111e at 0xffffc9000184a000, 18:03:73:a0:6f:6a, XID 0c200000 IRQ 42
+r8169 0000:05:00.0: irq 41 for MSI/MSI-X
+r8169 0000:05:00.0 eth0: RTL8168e/8111e at 0xffffc9000184a000, 18:03:73:a0:6f:6a, XID 0c200000 IRQ 41
 r8169 0000:05:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
 VMware vmxnet3 virtual NIC driver - version 1.1.29.0-k-NAPI
 ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
@@ -791,9 +789,9 @@
 xhci_hcd 0000:0b:00.0: enabling Mem-Wr-Inval
 xhci_hcd 0000:0b:00.0: supports USB remote wakeup
 xhci_hcd 0000:0b:00.0: irq 16, io mem 0xf7d00000
+xhci_hcd 0000:0b:00.0: irq 42 for MSI/MSI-X
 xhci_hcd 0000:0b:00.0: irq 43 for MSI/MSI-X
 xhci_hcd 0000:0b:00.0: irq 44 for MSI/MSI-X
-xhci_hcd 0000:0b:00.0: irq 45 for MSI/MSI-X
 usb usb3: default language 0x0409
 usb usb3: udev 1, busnum 3, minor = 256
 usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[cut]

I am not much knowing what is this kernel stuff all about but why other
devices retain MSI and only 0000:00:1c.7 lost it? Due to IRQ40 being not
picked up by pcieport it was assigned to other devices in the row and
therefore the diff just shows  changed IRQ numbers for following devices.
I will show below just a snippet of interrupt changes with a question
"Why was the IRQ40 not reported when claimed by pcieport? The is no line
starting as '-40'! Was it never reported through /proc/interrupts until
'pcie_aspm=off'? But dmesg showed that it was used, or thought to be assigned
by the driver itself?

--- MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted/interrupts    2013-01-09 15:14:33.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off/interrupts     2013-01-09 15:42:01.000000000 +0100
@@ -1,29 +1,29 @@
            CPU0       CPU1       
   0:         36          0   IO-APIC-edge      timer
   1:         13          0   IO-APIC-edge      i8042
-  8:         16          0   IO-APIC-edge      rtc0
+  8:         60          0   IO-APIC-edge      rtc0
   9:          0          0   IO-APIC-fasteoi   acpi
  12:        241          0   IO-APIC-edge      i8042
- 16:         53          0   IO-APIC-fasteoi   ehci_hcd:usb1
- 19:        355          0   IO-APIC-fasteoi   sata_sil24
- 23:        440          0   IO-APIC-fasteoi   ehci_hcd:usb2
- 41:       5342          0   PCI-MSI-edge      ahci
- 42:        264          0   PCI-MSI-edge      eth0
- 43:       1116          0   PCI-MSI-edge      xhci_hcd
+ 16:         50          0   IO-APIC-fasteoi   ehci_hcd:usb1
+ 19:        356          0   IO-APIC-fasteoi   sata_sil24
+ 23:        345          0   IO-APIC-fasteoi   ehci_hcd:usb2
+ 40:       5368          0   PCI-MSI-edge      ahci
+ 41:        205          0   PCI-MSI-edge      eth0
+ 42:        308          0   PCI-MSI-edge      xhci_hcd
+ 43:          0          0   PCI-MSI-edge      xhci_hcd
[cut]


--- MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted/lspci_vvxx    2013-01-09 15:14:26.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off/lspci_vvxx     2013-01-09 15:42:01.000000000 +0100
[cut]
@@ -284,7 +284,7 @@
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
+               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
@@ -316,7 +316,7 @@
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 10 00
 
 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
@@ -354,14 +354,14 @@
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
-       Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
-               Address: fee0300c  Data: 4191
+       Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
+               Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
-00: 86 80 1e 1c 07 04 10 00 b5 00 04 06 10 00 81 00
+00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00


Loading the hotplug drivers does not yield the IRQ (I think actually the modprobe acpiphp replied that
the device does not exist, but forced loading of pci_hotplug and of did load acpiphp):

@@ -1252,3 +1249,67 @@
 perf_event_intel: PEBS enabled due to microcode update
 r8169 0000:05:00.0 eth0: link down
 r8169 0000:05:00.0 eth0: link up
+usb 4-1: remote wakeup needed for autosuspend
+pci_hotplug: PCI Hot Plug PCI Core version: 0.5
+acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
+pci_bus 0000:11: dev 00, created physical slot 1

I think the error that a device does not exist should be logged by kernel. Stderr is not a good storage media,
nor my memory. ;-)


At least appears I really do have my card in the slot since cold boot. ;-) Probably due to the pci_hotplug driver working?

--- MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off/lspci_vvxx     2013-01-09 15:42:01.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off__loaded_acpiphp__pci_hotplug/lspci_vvxx        2013-01-09 15:44:19.000000000 +0100
@@ -589,6 +589,7 @@
 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
+       Physical Slot: 1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes



Does the above make sense to you?

So, 'pcie_aspm=force' kills the 0000:11:00.0 device, probably because of pci0000:00: Unable to request _OSC control (_OSC support mask: 0x19)?




Below I am showing what *works*.

If I don't care about hotplug and do NOT pass 'pcie_aspm=force' here is shown how is the card detected during cold-boot through PCI/PCIe (no hotplug support needed, not even loaded!):

--- MediaCard_reader_enabled_in_BIOS/cold-boot-without-express_card_inserted/dmesg.notiming     2013-01-09 15:04:26.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted/dmesg.notiming        2013-01-09 15:15:28.000000000 +0100
@@ -368,6 +368,13 @@
 pci_bus 0000:0b: bus scan returning with max=0b
 pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 0
 pci_bus 0000:11: scanning bus
+pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+pci 0000:11:00.0: reg 10: [mem 0xf6c84000-0xf6c8407f 64bit]
+pci 0000:11:00.0: reg 18: [mem 0xf6c80000-0xf6c83fff 64bit]
+pci 0000:11:00.0: reg 20: [io  0xc000-0xc07f]
+pci 0000:11:00.0: reg 30: [mem 0xf6c00000-0xf6c7ffff pref]
+pci 0000:11:00.0: supports D1 D2
+pci 0000:11:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
 pci_bus 0000:11: fixups for bus
 pci 0000:00:1c.7: PCI bridge to [bus 11-16]
 pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
@@ -433,6 +440,9 @@
 pci 0000:09:00.0: BAR 0: reserving [mem 0xf7e00000-0xf7e01fff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 0: reserving [mem 0xf7d00000-0xf7d0ffff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 2: reserving [mem 0xf7d10000-0xf7d11fff flags 0x140204] (d=0, p=0)
+pci 0000:11:00.0: BAR 0: reserving [mem 0xf6c84000-0xf6c8407f flags 0x140204] (d=0, p=0)
+pci 0000:11:00.0: BAR 2: reserving [mem 0xf6c80000-0xf6c83fff flags 0x140204] (d=0, p=0)
+pci 0000:11:00.0: BAR 4: reserving [io  0xc000-0xc07f flags 0x40101] (d=0, p=0)
 e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
 e820: reserve RAM buffer [mem 0xda4e5000-0xdbffffff]
 e820: reserve RAM buffer [mem 0xda793000-0xdbffffff]
@@ -1152,10 +1162,15 @@
 usbhid 3-1.4:1.0: usb_probe_interface - got id
 input: CHICONY USB Keyboard as /devices/pci0000:00/0000:00:1c.4/0000:0b:00.0/usb3/3-1/3-1.4/3-1.4:1.0/input/input13
 hid-generic 0003:04F2:0116.0002: input,hidraw1: USB HID v1.10 Keyboard [CHICONY USB Keyboard] on usb-0000:0b:00.0-1.4/input0
-hub 2-1:1.0: state 7 ports 8 chg 0000 evt 0040
+hub 3-1:1.0: state 7 ports 4 chg 0000 evt 0008
 scsi 6:0:0:0: Direct-Access     Generic- Multi-Card       1.00 PQ: 0 ANSI: 0 CCS
 sd 6:0:0:0: Attached scsi generic sg2 type 0
-systemd-udevd[1934]: starting version 196
+systemd-udevd[1937]: starting version 196
+sata_sil24 0000:11:00.0: version 1.1
+scsi7 : sata_sil24
+scsi8 : sata_sil24
+ata7: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
+ata8: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
 Intel(R) Wireless WiFi driver for Linux, in-tree:d
 Copyright(c) 2003-2012 Intel Corporation
 iwlwifi 0000:09:00.0: pci_resource_len = 0x00002000
[cut]
--- MediaCard_reader_enabled_in_BIOS/cold-boot-without-express_card_inserted/lspci_vvxx 2013-01-09 15:01:05.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted/lspci_vvxx    2013-01-09 15:14:26.000000000 +0100
@@ -314,54 +314,54 @@
 10: 00 00 00 00 00 00 00 00 00 0b 0c 00 f0 00 00 20
 20: d0 f7 d0 f7 f1 ff 01 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 10 00
 
 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b5) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=11, subordinate=16, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
-               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
+               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4191
        Capabilities: [90] Subsystem: Dell Device 04b3
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 04 10 00 b5 00 04 06 10 00 81 00
 10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
@@ -587,3 +587,43 @@
 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 b3 04
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
 
+11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
+       Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+       Latency: 0, Cache Line Size: 64 bytes
+       Interrupt: pin A routed to IRQ 19
+       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
+       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
+       Region 4: I/O ports at c000 [size=128]
+       Expansion ROM at f6c00000 [disabled] [size=512K]
+       Capabilities: [54] Power Management version 2
+               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
+               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
+       Capabilities: [5c] MSI: Enable- Count=1/1 Maskable- 64bit+
+               Address: 0000000000000000  Data: 0000
+       Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
+               DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
+                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
+               DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
+                       MaxPayload 128 bytes, MaxReadReq 4096 bytes
+               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
+               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
+                       ClockPM- Surprise- LLActRep- BwNot-
+               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
+                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+       Capabilities: [100 v1] Advanced Error Reporting
+               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
+               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+               UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+               AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
+       Kernel driver in use: sata_sil24
+00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
+10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
+20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
+30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
+
--- MediaCard_reader_enabled_in_BIOS/cold-boot-without-express_card_inserted/interrupts 2013-01-09 15:01:29.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted/interrupts    2013-01-09 15:14:33.000000000 +0100
@@ -1,28 +1,29 @@
            CPU0       CPU1       
   0:         36          0   IO-APIC-edge      timer
   1:         13          0   IO-APIC-edge      i8042
-  8:         22          0   IO-APIC-edge      rtc0
+  8:         16          0   IO-APIC-edge      rtc0
   9:          0          0   IO-APIC-fasteoi   acpi
  12:        241          0   IO-APIC-edge      i8042
  16:         53          0   IO-APIC-fasteoi   ehci_hcd:usb1
- 23:        386          0   IO-APIC-fasteoi   ehci_hcd:usb2
- 41:       5381          0   PCI-MSI-edge      ahci
- 42:        309          0   PCI-MSI-edge      eth0
- 43:        422          0   PCI-MSI-edge      xhci_hcd
+ 19:        355          0   IO-APIC-fasteoi   sata_sil24
+ 23:        440          0   IO-APIC-fasteoi   ehci_hcd:usb2
+ 41:       5342          0   PCI-MSI-edge      ahci
+ 42:        264          0   PCI-MSI-edge      eth0
+ 43:       1116          0   PCI-MSI-edge      xhci_hcd
  44:          0          0   PCI-MSI-edge      xhci_hcd
  45:          0          0   PCI-MSI-edge      xhci_hcd
- 46:        509          0   PCI-MSI-edge      snd_hda_intel
+ 46:        506          0   PCI-MSI-edge      snd_hda_intel
  47:          1          0   PCI-MSI-edge      iwlwifi
  48:         13          0   PCI-MSI-edge      i915
-NMI:         17         30   Non-maskable interrupts
-LOC:       8163       6823   Local timer interrupts
+NMI:         16         29   Non-maskable interrupts
+LOC:       8724       6451   Local timer interrupts
 SPU:          0          0   Spurious interrupts
-PMI:         17         30   Performance monitoring interrupts
+PMI:         16         29   Performance monitoring interrupts
 IWI:          0          0   IRQ work interrupts
 RTR:          0          0   APIC ICR read retries
-RES:       3121       3805   Rescheduling interrupts
-CAL:         34       2857   Function call interrupts
-TLB:         93        142   TLB shootdowns
+RES:       4084       4027   Rescheduling interrupts
+CAL:         23       2719   Function call interrupts
+TLB:        104         50   TLB shootdowns
 TRM:          0          0   Thermal event interrupts
 THR:          0          0   Threshold APIC interrupts
 MCE:          0          0   Machine check exceptions




And showing, that acpiphp works here while 'pcie_aspm=off':


--- MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off/dmesg.notiming 2013-01-09 15:42:02.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-without-express_card_inserted__pcie_aspm-off__loaded_acpiphp__pci_hotplug__card_hotplugged/dmesg.notiming        2013-01-09 15:58:36.000000000 +0100
@@ -369,12 +369,6 @@
 pci_bus 0000:0b: bus scan returning with max=0b
 pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 0
 pci_bus 0000:11: scanning bus
-pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
-pci 0000:11:00.0: reg 10: [mem 0xf6c84000-0xf6c8407f 64bit]
-pci 0000:11:00.0: reg 18: [mem 0xf6c80000-0xf6c83fff 64bit]
-pci 0000:11:00.0: reg 20: [io  0xc000-0xc07f]
-pci 0000:11:00.0: reg 30: [mem 0xf6c00000-0xf6c7ffff pref]
-pci 0000:11:00.0: supports D1 D2
 pci_bus 0000:11: fixups for bus
 pci 0000:00:1c.7: PCI bridge to [bus 11-16]
 pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
@@ -439,9 +433,6 @@
 pci 0000:09:00.0: BAR 0: reserving [mem 0xf7e00000-0xf7e01fff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 0: reserving [mem 0xf7d00000-0xf7d0ffff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 2: reserving [mem 0xf7d10000-0xf7d11fff flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 0: reserving [mem 0xf6c84000-0xf6c8407f flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 2: reserving [mem 0xf6c80000-0xf6c83fff flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 4: reserving [io  0xc000-0xc07f flags 0x40101] (d=0, p=0)
 e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
 e820: reserve RAM buffer [mem 0xda4e5000-0xdbffffff]
 e820: reserve RAM buffer [mem 0xda793000-0xdbffffff]
@@ -1162,12 +1153,7 @@
 hub 3-1:1.0: state 7 ports 4 chg 0000 evt 0008
 scsi 6:0:0:0: Direct-Access     Generic- Multi-Card       1.00 PQ: 0 ANSI: 0 CCS
 sd 6:0:0:0: Attached scsi generic sg2 type 0
-systemd-udevd[1935]: starting version 196
-sata_sil24 0000:11:00.0: version 1.1
-scsi7 : sata_sil24
-scsi8 : sata_sil24
-ata7: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c80000 irq 19
-ata8: SATA max UDMA/100 host m128@0xf6c84000 port 0xf6c82000 irq 19
+systemd-udevd[1933]: starting version 196
 Intel(R) Wireless WiFi driver for Linux, in-tree:d
 Copyright(c) 2003-2012 Intel Corporation
 iwlwifi 0000:09:00.0: pci_resource_len = 0x00002000
[cut]
@@ -1249,3 +1206,58 @@
 perf_event_intel: PEBS enabled due to microcode update
 r8169 0000:05:00.0 eth0: link down
 r8169 0000:05:00.0 eth0: link up
+usb 4-1: remote wakeup needed for autosuspend
+pci_hotplug: PCI Hot Plug PCI Core version: 0.5
+acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
+pci_bus 0000:11: dev 00, created physical slot 1
+acpiphp: Slot [1] registered
+usb 4-1: remote wakeup needed for autosuspend
+pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+pci 0000:11:00.0: supports D1 D2
+pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+sata_sil24 0000:11:00.0: version 1.1
+sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+sata_sil24 0000:11:00.0: enabling bus mastering
+scsi7 : sata_sil24
+scsi8 : sata_sil24
+ata7: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+ata8: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
+ata7.00: ATA-8: WDC WD10TPVT-00HT5T0, 01.01A01, max UDMA/133
+ata7.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
+ata7.00: failed to get Identify Device Data, Emask 0x1
+ata7.00: failed to get Identify Device Data, Emask 0x1
+ata7.00: configured for UDMA/100
+scsi 7:0:0:0: Direct-Access     ATA      WDC WD10TPVT-00H 01.0 PQ: 0 ANSI: 5
+sd 7:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
+sd 7:0:0:0: [sdc] Write Protect is off
+sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
+sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+sd 7:0:0:0: Attached scsi generic sg3 type 0
+ sdc: sdc1
+sd 7:0:0:0: [sdc] Attached SCSI disk
+ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
+ata8.00: ATA-8: ST3000VX000-9YW166, CV12, max UDMA/133
+ata8.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
+ata8.00: failed to get Identify Device Data, Emask 0x1
+ata8.00: failed to get Identify Device Data, Emask 0x1
+ata8.00: configured for UDMA/100
+scsi 8:0:0:0: Direct-Access     ATA      ST3000VX000-9YW1 CV12 PQ: 0 ANSI: 5
+sd 8:0:0:0: Attached scsi generic sg4 type 0
+sd 8:0:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
+sd 8:0:0:0: [sdd] 4096-byte physical blocks
+sd 8:0:0:0: [sdd] Write Protect is off
+sd 8:0:0:0: [sdd] Mode Sense: 00 3a 00 00
+sd 8:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+ sdd: sdd1
+sd 8:0:0:0: [sdd] Attached SCSI disk

--- MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off/lspci_vvxx     2013-01-09 15:42:01.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-without-express_card_inserted__pcie_aspm-off__loaded_acpiphp__pci_hotplug__card_hotplugged/lspci_vvxx    2013-01-09 15:58:36.000000000 +0100
@@ -343,7 +343,7 @@
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet- LinkState-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -589,14 +589,15 @@
 
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Physical Slot: 1
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 64 bytes
+       Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
-       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
+       Region 0: Memory at f6c04000 (64-bit, non-prefetchable) [size=128]
+       Region 2: Memory at f6c00000 (64-bit, non-prefetchable) [size=16K]
        Region 4: I/O ports at c000 [size=128]
-       Expansion ROM at f6c00000 [disabled] [size=512K]
+       [virtual] Expansion ROM at f0000000 [disabled] [size=512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
@@ -622,8 +623,8 @@
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24
-00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
-10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
+00: 95 10 32 31 07 01 10 00 01 00 80 01 08 00 00 00
+10: 04 40 c0 f6 00 00 00 00 04 00 c0 f6 00 00 00 00
 20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
-30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
+30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
 
--- MediaCard_reader_enabled_in_BIOS/cold-boot-with-express_card_inserted__pcie_aspm-off/interrupts     2013-01-09 15:42:01.000000000 +0100
+++ MediaCard_reader_enabled_in_BIOS/cold-boot-without-express_card_inserted__pcie_aspm-off__loaded_acpiphp__pci_hotplug__card_hotplugged/interrupts    2013-01-09 15:58:36.000000000 +0100
@@ -1,29 +1,29 @@
            CPU0       CPU1       
   0:         36          0   IO-APIC-edge      timer
   1:         13          0   IO-APIC-edge      i8042
-  8:         60          0   IO-APIC-edge      rtc0
-  9:          0          0   IO-APIC-fasteoi   acpi
+  8:         24          0   IO-APIC-edge      rtc0
+  9:          1          0   IO-APIC-fasteoi   acpi
  12:        241          0   IO-APIC-edge      i8042
- 16:         50          0   IO-APIC-fasteoi   ehci_hcd:usb1
- 19:        356          0   IO-APIC-fasteoi   sata_sil24
- 23:        345          0   IO-APIC-fasteoi   ehci_hcd:usb2
- 40:       5368          0   PCI-MSI-edge      ahci
- 41:        205          0   PCI-MSI-edge      eth0
- 42:        308          0   PCI-MSI-edge      xhci_hcd
+ 16:        100          0   IO-APIC-fasteoi   ehci_hcd:usb1
+ 19:        325          0   IO-APIC-fasteoi   sata_sil24
+ 23:        873          0   IO-APIC-fasteoi   ehci_hcd:usb2
+ 40:       5637          0   PCI-MSI-edge      ahci
+ 41:        375          0   PCI-MSI-edge      eth0
+ 42:        861          0   PCI-MSI-edge      xhci_hcd
  43:          0          0   PCI-MSI-edge      xhci_hcd
  44:          0          0   PCI-MSI-edge      xhci_hcd
- 45:        511          0   PCI-MSI-edge      snd_hda_intel
+ 45:        504          0   PCI-MSI-edge      snd_hda_intel
  46:          1          0   PCI-MSI-edge      iwlwifi
  47:         13          0   PCI-MSI-edge      i915
-NMI:         20         23   Non-maskable interrupts
-LOC:       7196       5604   Local timer interrupts
+NMI:         35         11   Non-maskable interrupts
+LOC:      13694       9226   Local timer interrupts
 SPU:          0          0   Spurious interrupts
-PMI:         20         23   Performance monitoring interrupts
+PMI:         35         11   Performance monitoring interrupts
 IWI:          0          0   IRQ work interrupts
 RTR:          0          0   APIC ICR read retries
-RES:       3203       3903   Rescheduling interrupts
-CAL:         18       2272   Function call interrupts
-TLB:        114         55   TLB shootdowns
+RES:       4840       4130   Rescheduling interrupts
+CAL:         27       2852   Function call interrupts
+TLB:        210        133   TLB shootdowns
 TRM:          0          0   Thermal event interrupts
 THR:          0          0   Threshold APIC interrupts
 MCE:          0          0   Machine check exceptions



Thanks
Martin
