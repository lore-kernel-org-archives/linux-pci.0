Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33729 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaATMQM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 07:16:12 -0500
From: "Chen, Jamie" <jamie.chen@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>
CC: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	USB list <linux-usb@vger.kernel.org>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: EHCI host broken -- interrupts disabled
Date: Mon, 20 Jan 2014 12:15:47 +0000
Message-ID: <F01C6967BCFFB14E8DF7F5D2FD1053EB1A18C3@PGSMSX103.gar.corp.intel.com>
References: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
 <20140117182231.GA18421@google.com>
In-Reply-To: <20140117182231.GA18421@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Try to apply this patch to kernel 3.8.0.

Make sure the ehci can work fine and lspci show that PCI_COMMAND_INTX_DISABLE is 0.

The patch can resolved this issue.

#lspci -vv

00:1d.0 USB controller: Intel Corporation Device 0f34 (rev 0a) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Device 7270
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 90612000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

dmesg:
[    1.014556] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.014559] ehci-pci: EHCI PCI platform driver
[    1.014612] ehci-pci 0000:00:1d.0: setting latency timer to 64
[    1.014618] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.014629] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    1.014652] ehci-pci 0000:00:1d.0: debug port 2
[    1.018562] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.018594] ehci-pci 0000:00:1d.0: irq 23, io mem 0x90612000
[    1.029238] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.029274] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.029279] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.029283] usb usb1: Product: EHCI Host Controller
[    1.029286] usb usb1: Manufacturer: Linux 3.8.13.13-pci ehci_hcd
[    1.029290] usb usb1: SerialNumber: 0000:00:1d.0
[    1.029469] hub 1-0:1.0: USB hub found
[    1.029785] ehci-platform: EHCI generic platform driver
[    1.340641] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.473442] usb 1-1: New USB device found, idVendor=8087, idProduct=07e6
[    1.473447] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.475095] hub 1-1:1.0: USB hub found
[    1.749587] usb 1-1.2: new high-speed USB device number 3 using ehci-pci
[    1.841046] usb 1-1.2: New USB device found, idVendor=05e3, idProduct=0608
[    1.841052] usb 1-1.2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.841056] usb 1-1.2: Product: USB2.0 Hub
[    1.841469] hub 1-1.2:1.0: USB hub found
[    2.115558] usb 1-1.2.1: new high-speed USB device number 4 using ehci-pci
[    2.208321] usb 1-1.2.1: New USB device found, idVendor=05e3, idProduct=0608
[    2.208327] usb 1-1.2.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.208331] usb 1-1.2.1: Product: USB2.0 Hub
[    2.209113] hub 1-1.2.1:1.0: USB hub found
[    2.283104] usb 1-1.2.3: new low-speed USB device number 5 using ehci-pci
[    2.378487] usb 1-1.2.3: New USB device found, idVendor=03f0, idProduct=0c4a
[    2.378492] usb 1-1.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.378496] usb 1-1.2.3: Product: HP
[    2.378500] usb 1-1.2.3: Manufacturer: HP
[    2.385945] usbcore: registered new interface driver usbhid
[    2.385950] usbhid: USB HID core driver
[   11.550722] input: HP HP as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.2/1-1.2.3/1-1.2.3:1.0/input/input5
[   11.550963] hid-generic 0003:03F0:0C4A.0001: input,hidraw0: USB HID v1.11 Mouse [HP HP] on usb-0000:00:1d.0-1.2.3/input0


Jamie
