Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19196 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736Ab2JVXlL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Oct 2012 19:41:11 -0400
Date: Mon, 22 Oct 2012 16:40:57 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Ulrich Eckhardt <usb@uli-eckhardt.de>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Message-ID: <20121022234057.GA20265@xanatos>
References: <50841CCC.9030809@uli-eckhardt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50841CCC.9030809@uli-eckhardt.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 21, 2012 at 06:03:24PM +0200, Ulrich Eckhardt wrote:
> Hello,
> 
> I have problems to get my USB3 cardreader to work reliably when
> connected to the USB3 port. Due to lack of other USB3 devices I
> don't know if it is the cardreader or the USB3 host (NEC uPD720200)
> but the cardreader always works reliable when connected to USB2.
> 
> Sometimes it is not possible to use the cardreader directly after
> power up and I have to restart the computer. Very often the
> cardreader stops working after removing a SD-card and insert another
> SD-card or during copying data.
> 
> I have tested it with Kernel 3.6.2. The USB3 port is the one built
> in the Mainboard M4A87DT EVO.

Did a previous kernel version work?

> I saw, that the outputs of lspci are different, if there is a
> problem directly after startup.

Bjorn, can you take a look at this PCI output, and tell me if it matters
that the host has bus master and latency 0 when it works and is missing
those properties when it doesn't?

Does the lspci differ when booting the same kernel, or is the lspci from
two different kernels?

> When the port is working:
> 04:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> Controller (rev 03) (prog-if 30 [XHCI])
>         Subsystem: NEC Corporation uPD720200 USB 3.0 Host Controller
>         Flags: bus master, fast devsel, latency 0, IRQ 18
>         Memory at f9efe000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
>         Capabilities: [150] Latency Tolerance Reporting
>         Kernel driver in use: xhci_hcd
> 
> When the port is not working:
> 04:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> Controller (rev 03) (prog-if 30 [XHCI])
>         Subsystem: NEC Corporation uPD720200 USB 3.0 Host Controller
>         Flags: fast devsel, IRQ 18
>         Memory at f9efe000 (64-bit, non-prefetchable) [disabled][size=8K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Capabilities: [90] MSI-X: Enable- Count=8 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
>         Capabilities: [150] Latency Tolerance Reporting
> 
> A dmesg output, when the cardreader stops after removing the SD-card:
> [  483.143351] hub 9-0:1.0: cannot reset port 2 (err = -19)
> [  483.143398] hub 9-0:1.0: hub_port_status failed (err = -19)
> [  483.143433] sd 10:0:0:4: Device offlined - not ready after error recovery
> [  586.083402] sdf: detected capacity change from 2032664576 to 0
> 
> 
> Here is a dmesg output, when the cardreader stops working during
> copying data:

Is there anything before that line in the dmesg?  Because it seems that
the whole xHCI host gets unregistered, and it would be good to know why.

Sarah Sharp

> [  787.343581] usb 9-2: USB disconnect, device number 2
> [  831.620551] xhci_hcd 0000:04:00.0: remove, state 4
> [  831.620604] usb usb9: USB disconnect, device number 1
> [  831.620742] xHCI xhci_drop_endpoint called for root hub
> [  831.620746] xHCI xhci_check_bandwidth called for root hub
> [  831.629149] xhci_hcd 0000:04:00.0: USB bus 9 deregistered
> [  831.629182] xhci_hcd 0000:04:00.0: remove, state 4
> [  831.629192] usb usb8: USB disconnect, device number 1
> [  831.629284] xHCI xhci_drop_endpoint called for root hub
> [  831.629287] xHCI xhci_check_bandwidth called for root hub
> [  831.733941] xhci_hcd 0000:04:00.0: USB bus 8 deregistered
> [  833.765457] xhci_hcd 0000:04:00.0: xHCI Host Controller
> [  833.765484] xhci_hcd 0000:04:00.0: new USB bus registered,
> assigned bus number 8
> [  833.869813] xhci_hcd 0000:04:00.0: irq 18, io mem 0xf9efe000
> [  833.869893] xhci_hcd 0000:04:00.0: irq 46 for MSI/MSI-X
> [  833.869909] xhci_hcd 0000:04:00.0: irq 47 for MSI/MSI-X
> [  833.869925] xhci_hcd 0000:04:00.0: irq 48 for MSI/MSI-X
> [  833.869940] xhci_hcd 0000:04:00.0: irq 49 for MSI/MSI-X
> [  833.869954] xhci_hcd 0000:04:00.0: irq 50 for MSI/MSI-X
> [  833.869969] xhci_hcd 0000:04:00.0: irq 51 for MSI/MSI-X
> [  833.869983] xhci_hcd 0000:04:00.0: irq 52 for MSI/MSI-X
> [  833.870170] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002
> [  833.870177] usb usb8: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [  833.870183] usb usb8: Product: xHCI Host Controller
> [  833.870188] usb usb8: Manufacturer: Linux 3.6.2-ue-desktop xhci_hcd
> [  833.870192] usb usb8: SerialNumber: 0000:04:00.0
> [  833.870430] xHCI xhci_add_endpoint called for root hub
> [  833.870435] xHCI xhci_check_bandwidth called for root hub
> [  833.870503] hub 8-0:1.0: USB hub found
> [  833.870515] hub 8-0:1.0: 2 ports detected
> [  833.900727] xhci_hcd 0000:04:00.0: xHCI Host Controller
> [  833.900743] xhci_hcd 0000:04:00.0: new USB bus registered,
> assigned bus number 9
> [  833.900811] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003
> [  833.900818] usb usb9: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [  833.900823] usb usb9: Product: xHCI Host Controller
> [  833.900828] usb usb9: Manufacturer: Linux 3.6.2-ue-desktop xhci_hcd
> [  833.900833] usb usb9: SerialNumber: 0000:04:00.0
> [  833.901058] xHCI xhci_add_endpoint called for root hub
> [  833.901062] xHCI xhci_check_bandwidth called for root hub
> [  833.901129] hub 9-0:1.0: USB hub found
> [  833.901145] hub 9-0:1.0: 2 ports detected
> [  834.207292] usb 9-2: new SuperSpeed USB device number 2 using xhci_hcd
> [  834.226262] usb 9-2: Parent hub missing LPM exit latency info.
> Power management will be impacted.
> [  834.323600] usb 9-2: New USB device found, idVendor=0bda, idProduct=0301
> [  834.323611] usb 9-2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [  834.323617] usb 9-2: Product: USB3.0 Card Reader
> [  834.323622] usb 9-2: Manufacturer: Realtek
> [  834.323627] usb 9-2: SerialNumber: 201006010301
> [  834.330317] scsi11 : usb-storage 9-2:1.0
> [  835.347621] scsi 11:0:0:0: Direct-Access     Generic- USB3.0
> CRW-CF/MD 1.00 PQ: 0 ANSI: 0 CCS
> [  835.363575] scsi 11:0:0:1: Direct-Access     Generic- USB3.0
> CRW-SM/xD 1.00 PQ: 0 ANSI: 0 CCS
> [  835.379999] scsi 11:0:0:2: Direct-Access     Generic- USB3.0
> CRW-SD   1.00 PQ: 0 ANSI: 0 CCS
> [  835.396476] scsi 11:0:0:3: Direct-Access     Generic- USB3.0
> CRW-MS   1.00 PQ: 0 ANSI: 0 CCS
> [  835.412459] scsi 11:0:0:4: Direct-Access     Generic- USB3.0
> CRW-SD/MS 1.00 PQ: 0 ANSI: 0 CCS
> [  835.414504] sd 11:0:0:0: Attached scsi generic sg4 type 0
> [  835.414809] sd 11:0:0:1: Attached scsi generic sg5 type 0
> [  835.415100] sd 11:0:0:2: Attached scsi generic sg6 type 0
> [  835.415319] sd 11:0:0:3: Attached scsi generic sg7 type 0
> [  835.415514] sd 11:0:0:4: Attached scsi generic sg8 type 0
> [  835.644755] sd 11:0:0:2: [sdf] Attached SCSI removable disk
> [  835.649335] sd 11:0:0:4: [sdh] Attached SCSI removable disk
> [  835.661916] sd 11:0:0:1: [sde] Attached SCSI removable disk
> [  835.670545] sd 11:0:0:0: [sdd] Attached SCSI removable disk
> [  835.674558] sd 11:0:0:3: [sdg] Attached SCSI removable disk
> [  844.984896] sd 11:0:0:2: [sdf] 3970048 512-byte logical blocks:
> (2.03 GB/1.89 GiB)
> [  844.986038] sd 11:0:0:2: [sdf] No Caching mode page present
> [  844.986049] sd 11:0:0:2: [sdf] Assuming drive cache: write through
> [  844.989503] sd 11:0:0:2: [sdf] No Caching mode page present
> [  844.989513] sd 11:0:0:2: [sdf] Assuming drive cache: write through
> [  844.991736]  sdf: sdf1
> [  912.223693] Clocksource tsc unstable (delta = -128663206 ns)
> [  912.223700] hub 9-0:1.0: cannot reset port 2 (err = -19)
> [  912.223772] Switching to clocksource hpet
> [  912.485117] sd 11:0:0:2: Device offlined - not ready after error recovery
> [  912.485128] sd 11:0:0:2: [sdf] Unhandled error code
> [  912.485129] sd 11:0:0:2: [sdf]
> [  912.485131] Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
> [  912.485132] sd 11:0:0:2: [sdf] CDB:
> [  912.485133] Read(10): 28 00 00 34 c7 80 00 00 f0 00
> [  912.485139] end_request: I/O error, dev sdf, sector 3458944
> [  912.485169] sd 11:0:0:2: rejecting I/O to offline device
> [  912.485172] sd 11:0:0:2: killing request
> [  912.485193] sd 11:0:0:2: rejecting I/O to offline device
> [  912.485194] sd 11:0:0:2: [sdf] killing request
> [  912.485199] sd 11:0:0:2: rejecting I/O to offline device
> [  912.485206] sd 11:0:0:2: rejecting I/O to offline device
> [  912.485208] sd 11:0:0:2: rejecting I/O to offline device
> [  912.485215] sd 11:0:0:2: [sdf] Unhandled error code
> [  912.485217] sd 11:0:0:2: [sdf]
> [  912.485218] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [  912.485220] sd 11:0:0:2: [sdf] CDB:
> [  912.485221] Read(10): 28 00 00 34 c8 70 00 00 10 00
> [  912.485231] end_request: I/O error, dev sdf, sector 3459184
> [  912.485249] sd 11:0:0:2: rejecting I/O to offline device
> [  912.485439] hub 9-0:1.0: hub_port_status failed (err = -19)
> [  912.493691] sd 11:0:0:2: rejecting I/O to offline device
> 
> 
> The lsusb-output of the Cardreader from Delock
> lsusb -v -s 9:
> 
> Bus 009 Device 002: ID 0bda:0301 Realtek Semiconductor Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               3.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         9
>   idVendor           0x0bda Realtek Semiconductor Corp.
>   idProduct          0x0301
>   bcdDevice            1.20
>   iManufacturer           1 Realtek
>   iProduct                2 USB3.0 Card Reader
>   iSerial                 3 201006010301
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           44
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          4 CARD READER
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              200mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         8 Mass Storage
>       bInterfaceSubClass      6 SCSI
>       bInterfaceProtocol     80 Bulk (Zip)
>       iInterface              5 Bulk-In, Bulk-Out, Interface
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>     wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               3
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               3
> inary Object Store Descriptor:
>   bLength                 5
>   bDescriptorType        15
>   wTotalLength           22
>   bNumDeviceCaps          2
>   USB 2.0 Extension Device Capability:
>     bLength                 7
>     bDescriptorType        16
>     bDevCapabilityType      2
>     bmAttributes   0x00000002
>       Link Power Management (LPM) Supported
>   SuperSpeed USB Device Capability:
>     bLength                10
>     bDescriptorType        16
>     bDevCapabilityType      3
>     bmAttributes         0x00
>       Latency Tolerance Messages (LTM) Supported
>     wSpeedsSupported   0x000e
>       Device can operate at Full Speed (12Mbps)
>       Device can operate at High Speed (480Mbps)
>       Device can operate at SuperSpeed (5Gbps)
>     bFunctionalitySupport   0
>       Lowest fully-functional device speed is Low Speed (1Mbps)
>     bU1DevExitLat           1 micro seconds
>     bU2DevExitLat        2815 micro seconds
> Device Status:     0x0000
>   (Bus Powered)
> Bus 009 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               3.00
>   bDeviceClass            9 Hub
>   bDeviceSubClass         0 Unused
>   bDeviceProtocol         3
>   bMaxPacketSize0         9
>   idVendor           0x1d6b Linux Foundation
>   idProduct          0x0003 3.0 root hub
>   bcdDevice            3.06
>   iManufacturer           3 Linux 3.6.2-ue-desktop xhci_hcd
>   iProduct                2 xHCI Host Controller
>   iSerial                 1 0000:04:00.0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           31
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         9 Hub
>       bInterfaceSubClass      0 Unused
>       bInterfaceProtocol      0 Full speed (or root) hub
>       iInterface              0
>       Endpoint Descriptor:
>    bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0004  1x 4 bytes
>         bInterval              12
>         bMaxBurst               0
> Hub Descriptor:
>   bLength              12
>   bDescriptorType      42
>   nNbrPorts             2
>   wHubCharacteristic 0x0009
>     Per-port power switching
>     Per-port overcurrent protection
>   bPwrOn2PwrGood       10 * 2 milli seconds
>   bHubContrCurrent      0 milli Ampere
>   bHubDecLat          0.0 micro seconds
>   wHubDelay             0 nano seconds
>   DeviceRemovable    0x00
>  Hub Port Status:
>    Port 1: 0000.02a0 5Gbps power Rx.Detect
>    Port 2: 0000.0203 5Gbps power U0 enable connect
> Binary Object Store Descriptor:
>   bLength                 5
>   bDescriptorType        15
>   wTotalLength           15
>   bNumDeviceCaps          1
>   SuperSpeed USB Device Capability:
>     bLength                10
>     bDescriptorType        16
>     bDevCapabilityType      3
>     bmAttributes         0x02
>     wSpeedsSupported   0x0008
>       Device can operate at SuperSpeed (5Gbps)
>     bFunctionalitySupport   0
>   Lowest fully-functional device speed is Low Speed (1Mbps)
>     bU1DevExitLat           3 micro seconds
>     bU2DevExitLat           0 micro seconds
> Device Status:     0x0001
>   Self Powered
> 
> An output of lspci of my system:
> lspci
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] nee ATI
> RX780/RX790 Chipset Host Bridge
> 00:02.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RD790 PCI
> to PCI bridge (external gfx0 port A)
> 00:09.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RD790 PCI
> to PCI bridge (PCI express gpp port E)
> 00:0a.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RD790 PCI
> to PCI bridge (PCI express gpp port F)
> 00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
> 00:12.0 USB controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:12.2 USB controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:13.0 USB controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:13.2 USB controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:14.0 SMBus: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus
> Controller (rev 41)
> 00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI SBx00
> Azalia (Intel HDA) (rev 40)
> 00:14.3 ISA bridge: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
> 00:14.4 PCI bridge: Advanced Micro Devices [AMD] nee ATI SBx00 PCI
> to PCI Bridge (rev 40)
> 00:14.5 USB controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
> 00:15.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI
> SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0)
> 00:15.1 PCI bridge: Advanced Micro Devices [AMD] nee ATI
> SB700/SB800/SB900 PCI to PCI bridge (PCIE port 1)
> 00:16.0 USB controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:16.2 USB controller: Advanced Micro Devices [AMD] nee ATI
> SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 10h
> Processor HyperTransport Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 10h
> Processor Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 10h
> Processor DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 10h
> Processor Miscellaneous Control
> 00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 10h
> Processor Link Control
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 06)
> 02:00.0 Multimedia video controller: Conexant Systems, Inc. CX23885
> PCI Video and Audio Decoder (rev 02)
> 04:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> Controller (rev ff)
> 05:00.0 SATA controller: JMicron Technology Corp. JMB361 AHCI/IDE (rev 02)
> 05:00.1 IDE interface: JMicron Technology Corp. JMB361 AHCI/IDE (rev 02)
> 06:00.0 VGA compatible controller: NVIDIA Corporation G98 [GeForce
> 8400 GS] (rev a1)
> 
> lsusb
> Bus 001 Device 002: ID 0451:8042 Texas Instruments, Inc.
> Bus 009 Device 002: ID 0bda:0301 Realtek Semiconductor Corp.
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 008 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 009 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 003: ID 046d:c050 Logitech, Inc. RX 250 Optical Mouse
> 
> 
> 
> -- 
> Ulrich Eckhardt                  http://www.uli-eckhardt.de
> 
> Ein Blitzableiter auf dem Kirchturm ist das denkbar stärkste
> Misstrauensvotum gegen den lieben Gott. (Karl Krauss)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
