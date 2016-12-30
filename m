Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Date: Fri, 30 Dec 2016 01:16:17 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <20161230000731.GB18700@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info> <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info> <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info> <20161229175028.GA18510@wunner.de> <52715138.511.1483053634089.JavaMail.zimbra@quantumtechnology.info> <20161230000731.GB18700@wunner.de>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>


I will check the echo... that on my next reboot.
I did the debug message on the 4.10-rc1 for now. I could go back to 4.9 if =
that helps but needs some time again to compile.
The debug messages from the first rpm_... to the crash are:
Dec 30 00:48:05 klaptop kernel: [    3.944157] usb usb1-port1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.944158] usb usb1-port2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.944159] usb usb1-port3: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.944605] ehci-pci 0000:00:1d.0: EHCI =
Host Controller
Dec 30 00:48:05 klaptop kernel: [    3.944610] ehci-pci 0000:00:1d.0: new U=
SB bus registered, assigned bus number 2
Dec 30 00:48:05 klaptop kernel: [    3.944621] ehci-pci 0000:00:1d.0: debug=
 port 2
Dec 30 00:48:05 klaptop kernel: [    3.948526] ehci-pci 0000:00:1d.0: cache=
 line size of 64 is not supported
Dec 30 00:48:05 klaptop kernel: [    3.948624] ehci-pci 0000:00:1d.0: irq 2=
3, io mem 0xb4a3d000
Dec 30 00:48:05 klaptop kernel: [    3.962387] ehci-pci 0000:00:1d.0: USB 2=
.0 started, EHCI 1.00
Dec 30 00:48:05 klaptop kernel: [    3.962427] usb usb2: New USB device fou=
nd, idVendor=3D1d6b, idProduct=3D0002
Dec 30 00:48:05 klaptop kernel: [    3.962428] usb usb2: New USB device str=
ings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Dec 30 00:48:05 klaptop kernel: [    3.962429] usb usb2: Product: EHCI Host=
 Controller
Dec 30 00:48:05 klaptop kernel: [    3.962430] usb usb2: Manufacturer: Linu=
x 4.10.0-rc1+ ehci_hcd
Dec 30 00:48:05 klaptop kernel: [    3.962431] usb usb2: SerialNumber: 0000=
:00:1d.0
Dec 30 00:48:05 klaptop kernel: [    3.962564] hub 2-0:1.0: USB hub found
Dec 30 00:48:05 klaptop kernel: [    3.962569] hub 2-0:1.0: 3 ports detecte=
d
Dec 30 00:48:05 klaptop kernel: [    3.962664] usb usb2-port1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.962665] usb usb2-port2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.962666] usb usb2-port3: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.962851] xhci_hcd 0000:00:14.0: xHCI =
Host Controller
Dec 30 00:48:05 klaptop kernel: [    3.962857] xhci_hcd 0000:00:14.0: new U=
SB bus registered, assigned bus number 3
Dec 30 00:48:05 klaptop kernel: [    3.963949] xhci_hcd 0000:00:14.0: hcc p=
arams 0x200077c1 hci version 0x100 quirks 0x00009810
Dec 30 00:48:05 klaptop kernel: [    3.963955] xhci_hcd 0000:00:14.0: cache=
 line size of 64 is not supported
Dec 30 00:48:05 klaptop kernel: [    3.964888] usb usb3: New USB device fou=
nd, idVendor=3D1d6b, idProduct=3D0002
Dec 30 00:48:05 klaptop kernel: [    3.964889] usb usb3: New USB device str=
ings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Dec 30 00:48:05 klaptop kernel: [    3.964891] usb usb3: Product: xHCI Host=
 Controller
Dec 30 00:48:05 klaptop kernel: [    3.964891] usb usb3: Manufacturer: Linu=
x 4.10.0-rc1+ xhci-hcd
Dec 30 00:48:05 klaptop kernel: [    3.964892] usb usb3: SerialNumber: 0000=
:00:14.0
Dec 30 00:48:05 klaptop kernel: [    3.965012] hub 3-0:1.0: USB hub found
Dec 30 00:48:05 klaptop kernel: [    3.965031] hub 3-0:1.0: 15 ports detect=
ed
Dec 30 00:48:05 klaptop kernel: [    3.968107] usb usb3-port1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968109] usb usb3-port2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968110] usb usb3-port3: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968111] usb usb3-port4: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968112] usb usb3-port5: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968113] usb usb3-port6: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968114] usb usb3-port7: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968115] usb usb3-port8: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968116] usb usb3-port9: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968117] usb usb3-port10: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968118] usb usb3-port11: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968119] usb usb3-port12: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968119] usb usb3-port13: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968120] usb usb3-port14: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968121] usb usb3-port15: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.968575] xhci_hcd 0000:00:14.0: xHCI =
Host Controller
Dec 30 00:48:05 klaptop kernel: [    3.968578] xhci_hcd 0000:00:14.0: new U=
SB bus registered, assigned bus number 4
Dec 30 00:48:05 klaptop kernel: [    3.968623] usb usb4: New USB device fou=
nd, idVendor=3D1d6b, idProduct=3D0003
Dec 30 00:48:05 klaptop kernel: [    3.968624] usb usb4: New USB device str=
ings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Dec 30 00:48:05 klaptop kernel: [    3.968625] usb usb4: Product: xHCI Host=
 Controller
Dec 30 00:48:05 klaptop kernel: [    3.968626] usb usb4: Manufacturer: Linu=
x 4.10.0-rc1+ xhci-hcd
Dec 30 00:48:05 klaptop kernel: [    3.968627] usb usb4: SerialNumber: 0000=
:00:14.0
Dec 30 00:48:05 klaptop kernel: [    3.968749] hub 4-0:1.0: USB hub found
Dec 30 00:48:05 klaptop kernel: [    3.968973] hub 4-0:1.0: 6 ports detecte=
d
Dec 30 00:48:05 klaptop kernel: [    3.969256] usb usb3-port1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.969492] usb usb3-port2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.969768] usb usb3-port3: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.970036] usb: port power management m=
ay be unreliable
Dec 30 00:48:05 klaptop kernel: [    3.970634] usb usb3-port9: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.970875] usb usb4-port4: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.970877] usb usb4-port6: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    3.971104] e1000e 0000:00:19.0: Interru=
pt Throttling Rate (ints/sec) set to dynamic conservative mode
Dec 30 00:48:05 klaptop kernel: [    4.074129] usb usb4: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.074132] usb usb4: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.074728] e1000e 0000:00:19.0 0000:00:=
19.0 (uninitialized): registered PHC clock
Dec 30 00:48:05 klaptop kernel: [    4.179267] e1000e 0000:00:19.0 eth0: (P=
CI Express:2.5GT/s:Width x1) 54:ee:75:4d:4e:6d
Dec 30 00:48:05 klaptop kernel: [    4.179268] e1000e 0000:00:19.0 eth0: In=
tel(R) PRO/1000 Network Connection
Dec 30 00:48:05 klaptop kernel: [    4.179304] e1000e 0000:00:19.0 eth0: MA=
C: 11, PHY: 12, PBA No: 1000FF-0FF
Dec 30 00:48:05 klaptop kernel: [    4.179432] i801_smbus 0000:00:1f.3: SPD=
 Write Disable is set
Dec 30 00:48:05 klaptop kernel: [    4.179455] i801_smbus 0000:00:1f.3: SMB=
us using PCI interrupt
Dec 30 00:48:05 klaptop kernel: [    4.180279] i801_smbus 0000:00:1f.3: rpm=
_idle
Dec 30 00:48:05 klaptop kernel: [    4.180281] i801_smbus 0000:00:1f.3: rpm=
_suspend
Dec 30 00:48:05 klaptop kernel: [    4.180326] ahci 0000:00:1f.2: version 3=
.0
Dec 30 00:48:05 klaptop kernel: [    4.180486] ahci 0000:00:1f.2: AHCI 0001=
.0300 32 slots 6 ports 6 Gbps 0x21 impl SATA mode
Dec 30 00:48:05 klaptop kernel: [    4.180488] ahci 0000:00:1f.2: flags: 64=
bit ncq ilck pm led clo pio slum part ems apst=20
Dec 30 00:48:05 klaptop kernel: [    4.180547] e1000e 0000:00:19.0 enp0s25:=
 renamed from eth0
Dec 30 00:48:05 klaptop kernel: [    4.190944] scsi host0: ahci
Dec 30 00:48:05 klaptop kernel: [    4.191011] scsi host0: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.191013] scsi host0: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.191267] scsi host1: ahci
Dec 30 00:48:05 klaptop kernel: [    4.191325] scsi host1: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.191326] scsi host1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.191492] scsi host2: ahci
Dec 30 00:48:05 klaptop kernel: [    4.191550] scsi host2: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.191551] scsi host2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.191601] scsi host3: ahci
Dec 30 00:48:05 klaptop kernel: [    4.191658] scsi host3: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.191659] scsi host3: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.191740] scsi host4: ahci
Dec 30 00:48:05 klaptop kernel: [    4.191785] scsi host4: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.191786] scsi host4: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.191837] scsi host5: ahci
Dec 30 00:48:05 klaptop kernel: [    4.191879] scsi host5: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.191880] scsi host5: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.191886] ata1: SATA max UDMA/133 abar=
 m2048@0xb4a3c000 port 0xb4a3c100 irq 29
Dec 30 00:48:05 klaptop kernel: [    4.191887] ata2: DUMMY
Dec 30 00:48:05 klaptop kernel: [    4.191888] ata3: DUMMY
Dec 30 00:48:05 klaptop kernel: [    4.191888] ata4: DUMMY
Dec 30 00:48:05 klaptop kernel: [    4.191889] ata5: DUMMY
Dec 30 00:48:05 klaptop kernel: [    4.191891] ata6: SATA max UDMA/133 abar=
 m2048@0xb4a3c000 port 0xb4a3c380 irq 29
Dec 30 00:48:05 klaptop kernel: [    4.270186] usb 1-1: new high-speed USB =
device number 2 using ehci-pci
Dec 30 00:48:05 klaptop kernel: [    4.290184] usb 2-1: new high-speed USB =
device number 2 using ehci-pci
Dec 30 00:48:05 klaptop kernel: [    4.294182] usb 3-1: new low-speed USB d=
evice number 2 using xhci_hcd
Dec 30 00:48:05 klaptop kernel: [    4.420368] usb 1-1: New USB device foun=
d, idVendor=3D8087, idProduct=3D8008
Dec 30 00:48:05 klaptop kernel: [    4.420371] usb 1-1: New USB device stri=
ngs: Mfr=3D0, Product=3D0, SerialNumber=3D0
Dec 30 00:48:05 klaptop kernel: [    4.420921] hub 1-1:1.0: USB hub found
Dec 30 00:48:05 klaptop kernel: [    4.421097] hub 1-1:1.0: 6 ports detecte=
d
Dec 30 00:48:05 klaptop kernel: [    4.422531] usb 1-1-port1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.422535] usb 1-1-port2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.422537] usb 1-1-port3: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.422539] usb 1-1-port4: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.422541] usb 1-1-port5: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.422542] usb 1-1-port6: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.438635] usb 2-1: New USB device foun=
d, idVendor=3D8087, idProduct=3D8000
Dec 30 00:48:05 klaptop kernel: [    4.438638] usb 2-1: New USB device stri=
ngs: Mfr=3D0, Product=3D0, SerialNumber=3D0
Dec 30 00:48:05 klaptop kernel: [    4.439158] hub 2-1:1.0: USB hub found
Dec 30 00:48:05 klaptop kernel: [    4.439346] hub 2-1:1.0: 8 ports detecte=
d
Dec 30 00:48:05 klaptop kernel: [    4.440868] usb 2-1-port1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.440870] usb 2-1-port2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.440872] usb 2-1-port3: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.440873] usb 2-1-port4: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.440874] usb 2-1-port5: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.440875] usb 2-1-port6: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.440876] usb 2-1-port7: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.440877] usb 2-1-port8: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.454746] usb 3-1: New USB device foun=
d, idVendor=3D045e, idProduct=3D00db
Dec 30 00:48:05 klaptop kernel: [    4.454749] usb 3-1: New USB device stri=
ngs: Mfr=3D1, Product=3D2, SerialNumber=3D0
Dec 30 00:48:05 klaptop kernel: [    4.454751] usb 3-1: Product: Natural=C2=
=AE Ergonomic Keyboard 4000
Dec 30 00:48:05 klaptop kernel: [    4.454753] usb 3-1: Manufacturer: Micro=
soft
Dec 30 00:48:05 klaptop kernel: [    4.459668] hidraw: raw HID events drive=
r (C) Jiri Kosina
Dec 30 00:48:05 klaptop kernel: [    4.477166] usbcore: registered new inte=
rface driver usbhid
Dec 30 00:48:05 klaptop kernel: [    4.477168] usbhid: USB HID core driver
Dec 30 00:48:05 klaptop kernel: [    4.479926] input: Microsoft Natural=C2=
=AE Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:14.0/usb3/3-1/3-=
1:1.0/0003:045E:00DB.0001/input/input3
Dec 30 00:48:05 klaptop kernel: [    4.506854] ata1: SATA link up 6.0 Gbps =
(SStatus 133 SControl 300)
Dec 30 00:48:05 klaptop kernel: [    4.506895] ata6: SATA link up 1.5 Gbps =
(SStatus 113 SControl 300)
Dec 30 00:48:05 klaptop kernel: [    4.510821] ata1.00: ACPI cmd ef/02:00:0=
0:00:00:a0 (SET FEATURES) succeeded
Dec 30 00:48:05 klaptop kernel: [    4.510826] ata1.00: ACPI cmd f5/00:00:0=
0:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Dec 30 00:48:05 klaptop kernel: [    4.511143] ata1.00: supports DRM functi=
ons and may not be fully accessible
Dec 30 00:48:05 klaptop kernel: [    4.515430] ata6.00: ACPI cmd e3/00:1f:0=
0:00:00:a0 (IDLE) succeeded
Dec 30 00:48:05 klaptop kernel: [    4.516018] ata6.00: ACPI cmd e3/00:02:0=
0:00:00:a0 (IDLE) succeeded
Dec 30 00:48:05 klaptop kernel: [    4.516302] ata6.00: ATAPI: PLDS DVD-RW =
DU8A5SH, BU51, max UDMA/100
Dec 30 00:48:05 klaptop kernel: [    4.517574] ata1.00: NCQ Send/Recv Log n=
ot supported
Dec 30 00:48:05 klaptop kernel: [    4.517578] ata1.00: ATA-9: Samsung SSD =
850 EVO 1TB, EMT01B6Q, max UDMA/133
Dec 30 00:48:05 klaptop kernel: [    4.517582] ata1.00: 1953525168 sectors,=
 multi 1: LBA48 NCQ (depth 31/32), AA
Dec 30 00:48:05 klaptop kernel: [    4.517902] random: fast init done
Dec 30 00:48:05 klaptop kernel: [    4.519473] ata1.00: ACPI cmd ef/02:00:0=
0:00:00:a0 (SET FEATURES) succeeded
Dec 30 00:48:05 klaptop kernel: [    4.519478] ata1.00: ACPI cmd f5/00:00:0=
0:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Dec 30 00:48:05 klaptop kernel: [    4.519754] ata1.00: supports DRM functi=
ons and may not be fully accessible
Dec 30 00:48:05 klaptop kernel: [    4.523127] ata6.00: ACPI cmd e3/00:1f:0=
0:00:00:a0 (IDLE) succeeded
Dec 30 00:48:05 klaptop kernel: [    4.523880] ata6.00: ACPI cmd e3/00:02:0=
0:00:00:a0 (IDLE) succeeded
Dec 30 00:48:05 klaptop kernel: [    4.524169] ata6.00: configured for UDMA=
/100
Dec 30 00:48:05 klaptop kernel: [    4.526167] ata1.00: NCQ Send/Recv Log n=
ot supported
Dec 30 00:48:05 klaptop kernel: [    4.526262] ata1.00: configured for UDMA=
/133
Dec 30 00:48:05 klaptop kernel: [    4.526333] scsi host0: rpm_resume
Dec 30 00:48:05 klaptop kernel: [    4.526889] scsi 0:0:0:0: Direct-Access =
    ATA      Samsung SSD 850  1B6Q PQ: 0 ANSI: 5
Dec 30 00:48:05 klaptop kernel: [    4.532745] usb 1-1: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.532749] usb 1-1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.538511] microsoft 0003:045E:00DB.000=
1: input,hidraw0: USB HID v1.11 Keyboard [Microsoft Natural=C2=AE Ergonomic=
 Keyboard 4000] on usb-0000:00:14.0-1/input0
Dec 30 00:48:05 klaptop kernel: [    4.539775] input: Microsoft Natural=C2=
=AE Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:14.0/usb3/3-1/3-=
1:1.1/0003:045E:00DB.0002/input/input4
Dec 30 00:48:05 klaptop kernel: [    4.547582] usb 2-1: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.547586] usb 2-1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.558184] usb usb1: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.558187] usb usb1: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.566184] usb usb2: rpm_idle
Dec 30 00:48:05 klaptop kernel: [    4.566188] usb usb2: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    4.574194] usb 3-3: new full-speed USB =
device number 3 using xhci_hcd
Dec 30 00:48:05 klaptop kernel: [    4.578617] scsi host5: rpm_resume
Dec 30 00:48:05 klaptop kernel: [    4.582495] scsi 5:0:0:0: CD-ROM        =
    PLDS     DVD-RW DU8A5SH   BU51 PQ: 0 ANSI: 5
Dec 30 00:48:05 klaptop kernel: [    4.598318] microsoft 0003:045E:00DB.000=
2: input,hidraw1: USB HID v1.11 Device [Microsoft Natural=C2=AE Ergonomic K=
eyboard 4000] on usb-0000:00:14.0-1/input1
Dec 30 00:48:05 klaptop kernel: [    4.608089] sd 0:0:0:0: [sda] 1953525168=
 512-byte logical blocks: (1.00 TB/932 GiB)
Dec 30 00:48:05 klaptop kernel: [    4.608109] sd 0:0:0:0: [sda] Write Prot=
ect is off
Dec 30 00:48:05 klaptop kernel: [    4.608111] sd 0:0:0:0: [sda] Mode Sense=
: 00 3a 00 00
Dec 30 00:48:05 klaptop kernel: [    4.608141] sd 0:0:0:0: [sda] Write cach=
e: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 30 00:48:05 klaptop kernel: [    4.610618]  sda: sda1 sda2 sda3 sda4 < =
sda5 sda6 >
Dec 30 00:48:05 klaptop kernel: [    4.611296] sd 0:0:0:0: [sda] Attached S=
CSI disk
Dec 30 00:48:05 klaptop kernel: [    4.628295] sr 5:0:0:0: [sr0] scsi3-mmc =
drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Dec 30 00:48:05 klaptop kernel: [    4.628298] cdrom: Uniform CD-ROM driver=
 Revision: 3.20
Dec 30 00:48:05 klaptop kernel: [    4.628564] sr 5:0:0:0: Attached scsi CD=
-ROM sr0
Dec 30 00:48:05 klaptop kernel: [    4.716694] usb 3-3: New USB device foun=
d, idVendor=3D062a, idProduct=3D7223
Dec 30 00:48:05 klaptop kernel: [    4.716697] usb 3-3: New USB device stri=
ngs: Mfr=3D1, Product=3D2, SerialNumber=3D0
Dec 30 00:48:05 klaptop kernel: [    4.716699] usb 3-3: Product: Full-Speed=
 Mouse
Dec 30 00:48:05 klaptop kernel: [    4.716700] usb 3-3: Manufacturer: Full-=
Speed Mouse
Dec 30 00:48:05 klaptop kernel: [    4.722626] input: Full-Speed Mouse Full=
-Speed Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/0003:062A=
:7223.0003/input/input5
Dec 30 00:48:05 klaptop kernel: [    4.722734] hid-generic 0003:062A:7223.0=
003: input,hidraw2: USB HID v1.10 Mouse [Full-Speed Mouse Full-Speed Mouse]=
 on usb-0000:00:14.0-3/input0
Dec 30 00:48:05 klaptop kernel: [    4.722847] input: Full-Speed Mouse Full=
-Speed Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.1/0003:062A=
:7223.0004/input/input6
Dec 30 00:48:05 klaptop kernel: [    4.750174] psmouse serio1: synaptics: q=
ueried max coordinates: x [..5676], y [..4758]
Dec 30 00:48:05 klaptop kernel: [    4.783218] psmouse serio1: synaptics: q=
ueried min coordinates: x [1266..], y [1096..]
Dec 30 00:48:05 klaptop kernel: [    4.786447] hid-generic 0003:062A:7223.0=
004: input,hidraw3: USB HID v1.10 Keyboard [Full-Speed Mouse Full-Speed Mou=
se] on usb-0000:00:14.0-3/input1
Dec 30 00:48:05 klaptop kernel: [    4.838194] usb 3-7: new full-speed USB =
device number 4 using xhci_hcd
Dec 30 00:48:05 klaptop kernel: [    4.847940] psmouse serio1: synaptics: T=
ouchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xf003a3/0x943300/0x12e800/0x=
10000, board id: 3053, fw id: 2560
Dec 30 00:48:05 klaptop kernel: [    4.847955] psmouse serio1: synaptics: s=
erio: Synaptics pass-through port at isa0060/serio1/input0
Dec 30 00:48:05 klaptop kernel: [    4.889663] input: SynPS/2 Synaptics Tou=
chPad as /devices/platform/i8042/serio1/input/input2
Dec 30 00:48:05 klaptop kernel: [    4.916042] VMware vmxnet3 virtual NIC d=
river - version 1.4.a.0-k-NAPI
Dec 30 00:48:05 klaptop kernel: [    4.916827] VMware PVSCSI driver - versi=
on 1.0.7.0-k
Dec 30 00:48:05 klaptop kernel: [    4.986126] raid6: sse2x1   gen()  9919 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.054130] raid6: sse2x1   xor()  4853 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.122133] raid6: sse2x2   gen() 10571 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.190135] raid6: sse2x2   xor()  5995 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.258140] raid6: sse2x4   gen() 11260 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.326146] raid6: sse2x4   xor()  6655 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.394146] raid6: avx2x1   gen() 15285 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.462150] raid6: avx2x1   xor()  9592 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.530152] raid6: avx2x2   gen() 19419 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.598159] raid6: avx2x2   xor() 11276 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.666162] raid6: avx2x4   gen() 20378 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.734166] raid6: avx2x4   xor() 12890 =
MB/s
Dec 30 00:48:05 klaptop kernel: [    5.734166] raid6: using algorithm avx2x=
4 gen() 20378 MB/s
Dec 30 00:48:05 klaptop kernel: [    5.734167] raid6: .... xor() 12890 MB/s=
, rmw enabled
Dec 30 00:48:05 klaptop kernel: [    5.734167] raid6: using avx2x2 recovery=
 algorithm
Dec 30 00:48:05 klaptop kernel: [    5.734179] clocksource: Switched to clo=
cksource tsc
Dec 30 00:48:05 klaptop kernel: [    5.734435] xor: automatically using bes=
t checksumming function   avx      =20
Dec 30 00:48:05 klaptop kernel: [    5.736801] Btrfs loaded, crc32c=3Dcrc32=
c-intel
Dec 30 00:48:05 klaptop kernel: [    5.755286] usb 3-7: New USB device foun=
d, idVendor=3D138a, idProduct=3D0017
Dec 30 00:48:05 klaptop kernel: [    5.755287] usb 3-7: New USB device stri=
ngs: Mfr=3D0, Product=3D0, SerialNumber=3D1
Dec 30 00:48:05 klaptop kernel: [    5.755288] usb 3-7: SerialNumber: 82f9b=
467acb7
Dec 30 00:48:05 klaptop kernel: [    5.812491] BTRFS: device fsid f517ae30-=
e509-4bfb-9554-7fe60f091b0e devid 1 transid 220098 /dev/sda5
Dec 30 00:48:05 klaptop kernel: [    5.813964] PM: Starting manual resume f=
rom disk
Dec 30 00:48:05 klaptop kernel: [    5.813966] PM: Hibernation image partit=
ion 8:6 present
Dec 30 00:48:05 klaptop kernel: [    5.813966] PM: Looking for hibernation =
image.
Dec 30 00:48:05 klaptop kernel: [    5.814140] PM: Image not found (code -2=
2)
Dec 30 00:48:05 klaptop kernel: [    5.814141] PM: Hibernation image not pr=
esent or could not be loaded.
Dec 30 00:48:05 klaptop kernel: [    5.821080] BTRFS info (device sda5): di=
sk space caching is enabled
Dec 30 00:48:05 klaptop kernel: [    5.821081] BTRFS info (device sda5): ha=
s skinny extents
Dec 30 00:48:05 klaptop kernel: [    5.832058] BTRFS info (device sda5): de=
tected SSD devices, enabling SSD mode
Dec 30 00:48:05 klaptop kernel: [    5.878254] usb 3-11: new full-speed USB=
 device number 5 using xhci_hcd
Dec 30 00:48:05 klaptop kernel: [    5.975558] ip_tables: (C) 2000-2006 Net=
filter Core Team
Dec 30 00:48:05 klaptop kernel: [    6.023264] usb 3-11: New USB device fou=
nd, idVendor=3D8087, idProduct=3D07dc
Dec 30 00:48:05 klaptop kernel: [    6.023265] usb 3-11: New USB device str=
ings: Mfr=3D0, Product=3D0, SerialNumber=3D0
Dec 30 00:48:05 klaptop kernel: [    6.048338] BTRFS info (device sda5): di=
sk space caching is enabled
Dec 30 00:48:05 klaptop kernel: [    6.058759] RPC: Registered named UNIX s=
ocket transport module.
Dec 30 00:48:05 klaptop kernel: [    6.058761] RPC: Registered udp transpor=
t module.
Dec 30 00:48:05 klaptop kernel: [    6.058761] RPC: Registered tcp transpor=
t module.
Dec 30 00:48:05 klaptop kernel: [    6.058762] RPC: Registered tcp NFSv4.1 =
backchannel transport module.
Dec 30 00:48:05 klaptop kernel: [    6.065054] Installing knfsd (copyright =
(C) 1996 okir@monad.swb.de).
Dec 30 00:48:05 klaptop kernel: [    6.142203] usb 3-12: new high-speed USB=
 device number 6 using xhci_hcd
Dec 30 00:48:05 klaptop kernel: [    6.179734] EDAC MC: Ver: 3.0.0
Dec 30 00:48:05 klaptop kernel: [    6.179777] shpchp: Standard Hot Plug PC=
I Controller Driver version: 0.4
Dec 30 00:48:05 klaptop kernel: [    6.182575] ACPI Warning: SystemIO range=
 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000=
001800-0x000000000000187F (\_SB.PCI0.LPC.PMIO) (20160930/utaddress-247)
Dec 30 00:48:05 klaptop kernel: [    6.182581] ACPI: If an ACPI driver is a=
vailable for this device, you should use it instead of the native driver
Dec 30 00:48:05 klaptop kernel: [    6.182657] ACPI Warning: SystemIO range=
 0x0000000000000840-0x000000000000084F conflicts with OpRegion 0x0000000000=
000800-0x000000000000087F (\_SB.PCI0.LPC.LPIO) (20160930/utaddress-247)
Dec 30 00:48:05 klaptop kernel: [    6.182660] ACPI: If an ACPI driver is a=
vailable for this device, you should use it instead of the native driver
Dec 30 00:48:05 klaptop kernel: [    6.182660] ACPI Warning: SystemIO range=
 0x0000000000000830-0x000000000000083F conflicts with OpRegion 0x0000000000=
000800-0x000000000000087F (\_SB.PCI0.LPC.LPIO) (20160930/utaddress-247)
Dec 30 00:48:05 klaptop kernel: [    6.182662] ACPI: If an ACPI driver is a=
vailable for this device, you should use it instead of the native driver
Dec 30 00:48:05 klaptop kernel: [    6.182662] ACPI Warning: SystemIO range=
 0x0000000000000800-0x000000000000082F conflicts with OpRegion 0x0000000000=
000800-0x000000000000087F (\_SB.PCI0.LPC.LPIO) (20160930/utaddress-247)
Dec 30 00:48:05 klaptop kernel: [    6.182664] ACPI: If an ACPI driver is a=
vailable for this device, you should use it instead of the native driver
Dec 30 00:48:05 klaptop kernel: [    6.182664] lpc_ich: Resource conflict(s=
) found affecting gpio_ich
Dec 30 00:48:05 klaptop kernel: [    6.182711] input: Lid Switch as /device=
s/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input8
Dec 30 00:48:05 klaptop kernel: [    6.183106] ACPI: Lid Switch [LID]
Dec 30 00:48:05 klaptop kernel: [    6.183158] input: Sleep Button as /devi=
ces/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
Dec 30 00:48:05 klaptop kernel: [    6.183161] ACPI: Sleep Button [SLPB]
Dec 30 00:48:05 klaptop kernel: [    6.183223] input: Power Button as /devi=
ces/LNXSYSTM:00/LNXPWRBN:00/input/input10
Dec 30 00:48:05 klaptop kernel: [    6.183225] ACPI: Power Button [PWRF]
Dec 30 00:48:05 klaptop kernel: [    6.186274] EDAC ie31200: No ECC support
Dec 30 00:48:05 klaptop kernel: [    6.187649] [drm] Initialized
Dec 30 00:48:05 klaptop kernel: [    6.197452] Non-volatile memory driver v=
1.3
Dec 30 00:48:05 klaptop kernel: [    6.198264] tpm_tis 00:05: 1.2 TPM (devi=
ce-id 0x0, rev-id 78)
Dec 30 00:48:05 klaptop kernel: [    6.199581] thinkpad_acpi: ThinkPad ACPI=
 Extras v0.25
Dec 30 00:48:05 klaptop kernel: [    6.199581] thinkpad_acpi: http://ibm-ac=
pi.sf.net/
Dec 30 00:48:05 klaptop kernel: [    6.199582] thinkpad_acpi: ThinkPad BIOS=
 GNET80WW (2.28 ), EC unknown
Dec 30 00:48:05 klaptop kernel: [    6.199582] thinkpad_acpi: Lenovo ThinkP=
ad W541, model 20EG000BGB
Dec 30 00:48:05 klaptop kernel: [    6.200548] thinkpad_hwmon thinkpad_hwmo=
n: hwmon_device_register() is deprecated. Please convert the driver to use =
hwmon_device_register_with_info().
Dec 30 00:48:05 klaptop kernel: [    6.200989] thinkpad_acpi: radio switch =
found; radios are enabled
Dec 30 00:48:05 klaptop kernel: [    6.201138] thinkpad_acpi: This ThinkPad=
 has standard ACPI backlight brightness control, supported by the ACPI vide=
o driver
Dec 30 00:48:05 klaptop kernel: [    6.201139] thinkpad_acpi: Disabling thi=
nkpad-acpi brightness events by default...
Dec 30 00:48:05 klaptop kernel: [    6.202724] [drm] Memory usable by graph=
ics device =3D 2048M
Dec 30 00:48:05 klaptop kernel: [    6.202725] [drm] Replacing VGA console =
driver
Dec 30 00:48:05 klaptop kernel: [    6.203520] Console: switching to colour=
 dummy device 80x25
Dec 30 00:48:05 klaptop kernel: [    6.205807] wmi: Mapper loaded
Dec 30 00:48:05 klaptop kernel: [    6.206690] ACPI: Battery Slot [BAT0] (b=
attery present)
Dec 30 00:48:05 klaptop kernel: [    6.206873] ACPI: AC Adapter [AC] (on-li=
ne)
Dec 30 00:48:05 klaptop kernel: [    6.207676] thinkpad_acpi: rfkill switch=
 tpacpi_bluetooth_sw: radio is unblocked
Dec 30 00:48:05 klaptop kernel: [    6.211290] input: ThinkPad Extra Button=
s as /devices/platform/thinkpad_acpi/input/input11
Dec 30 00:48:05 klaptop kernel: [    6.211735] [drm] Supports vblank timest=
amp caching Rev 2 (21.10.2013).
Dec 30 00:48:05 klaptop kernel: [    6.211736] [drm] Driver supports precis=
e vblank timestamp query.
Dec 30 00:48:05 klaptop kernel: [    6.211906] snd_hda_codec_realtek hdaudi=
oC1D0: autoconfig for ALC3232: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:sp=
eaker
Dec 30 00:48:05 klaptop kernel: [    6.211907] snd_hda_codec_realtek hdaudi=
oC1D0:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Dec 30 00:48:05 klaptop kernel: [    6.211908] snd_hda_codec_realtek hdaudi=
oC1D0:    hp_outs=3D2 (0x16/0x15/0x0/0x0/0x0)
Dec 30 00:48:05 klaptop kernel: [    6.211909] snd_hda_codec_realtek hdaudi=
oC1D0:    mono: mono_out=3D0x0
Dec 30 00:48:05 klaptop kernel: [    6.211910] snd_hda_codec_realtek hdaudi=
oC1D0:    inputs:
Dec 30 00:48:05 klaptop kernel: [    6.211911] snd_hda_codec_realtek hdaudi=
oC1D0:      Dock Mic=3D0x19
Dec 30 00:48:05 klaptop kernel: [    6.211912] snd_hda_codec_realtek hdaudi=
oC1D0:      Mic=3D0x1a
Dec 30 00:48:05 klaptop kernel: [    6.211913] snd_hda_codec_realtek hdaudi=
oC1D0:      Internal Mic=3D0x12
Dec 30 00:48:05 klaptop kernel: [    6.212434] i915 0000:00:02.0: vgaarb: c=
hanged VGA decodes: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
Dec 30 00:48:05 klaptop kernel: [    6.232038] input: HDA Digital PCBeep as=
 /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
Dec 30 00:48:05 klaptop kernel: [    6.232061] snd_hda_codec_realtek hdaudi=
oC1D0: rpm_suspend
Dec 30 00:48:05 klaptop kernel: [    6.232150] input: HDA Intel PCH Dock Mi=
c as /devices/pci0000:00/0000:00:1b.0/sound/card1/input13
Dec 30 00:48:05 klaptop kernel: [    6.232179] input: HDA Intel PCH Mic as =
/devices/pci0000:00/0000:00:1b.0/sound/card1/input14
Dec 30 00:48:05 klaptop kernel: [    6.232206] input: HDA Intel PCH Dock He=
adphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input15
Dec 30 00:48:05 klaptop kernel: [    6.232233] input: HDA Intel PCH Headpho=
ne as /devices/pci0000:00/0000:00:1b.0/sound/card1/input16
Dec 30 00:48:05 klaptop kernel: [    6.250290] ACPI Warning: \_SB.PCI0.PEG.=
VID._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Packag=
e] (20160930/nsarguments-95)
Dec 30 00:48:05 klaptop kernel: [    6.250569] ACPI Warning: \_SB.PCI0.PEG.=
VID._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Packag=
e] (20160930/nsarguments-95)
Dec 30 00:48:05 klaptop kernel: [    6.250724] snd_hda_codec_realtek hdaudi=
oC1D0: rpm_resume
Dec 30 00:48:05 klaptop kernel: [    6.250838] pci 0000:01:00.0: optimus ca=
pabilities: enabled, status dynamic power, hda bios codec supported
Dec 30 00:48:05 klaptop kernel: [    6.250844] VGA switcheroo: detected Opt=
imus DSM method \_SB_.PCI0.PEG_.VID_ handle
Dec 30 00:48:05 klaptop kernel: [    6.250844] nouveau: detected PR support=
, will not use DSM
Dec 30 00:48:05 klaptop kernel: [    6.250873] nouveau 0000:01:00.0: enabli=
ng device (0000 -> 0003)
Dec 30 00:48:05 klaptop kernel: [    6.251018] nouveau 0000:01:00.0: NVIDIA=
 GK107 (0e7360a2)
Dec 30 00:48:05 klaptop kernel: [    6.253864] sd 0:0:0:0: Attached scsi ge=
neric sg0 type 0
Dec 30 00:48:05 klaptop kernel: [    6.253910] sr 5:0:0:0: Attached scsi ge=
neric sg1 type 5
Dec 30 00:48:05 klaptop kernel: [    6.254400] Intel(R) Wireless WiFi drive=
r for Linux
Dec 30 00:48:05 klaptop kernel: [    6.254400] Copyright(c) 2003- 2015 Inte=
l Corporation
Dec 30 00:48:05 klaptop kernel: [    6.258825] iwlwifi 0000:03:00.0: loaded=
 firmware version 17.352738.0 op_mode iwlmvm
Dec 30 00:48:05 klaptop kernel: [    6.266705] input: PC Speaker as /device=
s/platform/pcspkr/input/input17
Dec 30 00:48:05 klaptop kernel: [    6.267356] iwlwifi 0000:03:00.0: Detect=
ed Intel(R) Dual Band Wireless AC 7260, REV=3D0x144
Dec 30 00:48:05 klaptop kernel: [    6.267618] Error: Driver 'pcspkr' is al=
ready registered, aborting...
Dec 30 00:48:05 klaptop kernel: [    6.269505] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:05 klaptop kernel: [    6.270062] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:05 klaptop kernel: [    6.290659] AVX2 version of gcm_enc/dec =
engaged.
Dec 30 00:48:05 klaptop kernel: [    6.290659] AES CTR mode by8 optimizatio=
n enabled
Dec 30 00:48:05 klaptop kernel: [    6.298239] alg: No test for pcbc(aes) (=
pcbc-aes-aesni)
Dec 30 00:48:05 klaptop kernel: [    6.303593] psmouse serio2: trackpoint: =
IBM TrackPoint firmware: 0x0e, buttons: 3/3
Dec 30 00:48:05 klaptop kernel: [    6.321411] Adding 524284k swap on /dev/=
sda6.  Priority:-1 extents:1 across:524284k SSFS
Dec 30 00:48:05 klaptop kernel: [    6.358568] usb 3-12: New USB device fou=
nd, idVendor=3D04ca, idProduct=3D7035
Dec 30 00:48:05 klaptop kernel: [    6.358570] usb 3-12: New USB device str=
ings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Dec 30 00:48:05 klaptop kernel: [    6.358572] usb 3-12: Product: Integrate=
d Camera
Dec 30 00:48:05 klaptop kernel: [    6.358573] usb 3-12: Manufacturer: 8SSC=
20F26960L1GZ523029G
Dec 30 00:48:05 klaptop kernel: [    6.365611] nouveau 0000:01:00.0: bios: =
version 80.07.ac.00.20
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.0862] Net=
workManager (version 1.4.2) is starting...
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.0863] Rea=
d config: /etc/NetworkManager/NetworkManager.conf
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.0906] man=
ager[0x55b0228c90a0]: monitoring kernel firmware directory '/lib/firmware'.
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.0906] mon=
itoring ifupdown state file '/run/network/ifstate'.
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.0932] dns=
-mgr[0x55b0228c42a0]: init: dns=3Ddefault, rc-manager=3Dresolvconf
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.0938] man=
ager[0x55b0228c90a0]: WiFi hardware radio set enabled
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.0939] man=
ager[0x55b0228c90a0]: WWAN hardware radio set enabled
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1141] ini=
t!
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1143] man=
agement mode: unmanaged
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1146] dev=
ices added (path: /sys/devices/pci0000:00/0000:00:19.0/net/enp0s25, iface: =
enp0s25)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1146] dev=
ice added (path: /sys/devices/pci0000:00/0000:00:19.0/net/enp0s25, iface: e=
np0s25): no ifupdown configuration found.
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1146] dev=
ices added (path: /sys/devices/virtual/net/lo, iface: lo)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1146] dev=
ice added (path: /sys/devices/virtual/net/lo, iface: lo): no ifupdown confi=
guration found.
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1146] end=
 _init.
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1146] set=
tings: loaded plugin ifupdown: (C) 2008 Canonical Ltd.  To report bugs plea=
se use the NetworkManager mailing list. (/usr/lib/x86_64-linux-gnu/NetworkM=
anager/libnm-settings-plugin-ifupdown.so)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1147] set=
tings: loaded plugin keyfile: (c) 2007 - 2015 Red Hat, Inc.  To report bugs=
 please use the NetworkManager mailing list.
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1147] (57=
9818704) ... get_connections.
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1147] (57=
9818704) ... get_connections (managed=3Dfalse): return empty list.
Dec 30 00:48:06 klaptop kernel: [    6.506270] input: TPPS/2 IBM TrackPoint=
 as /devices/platform/i8042/serio1/serio2/input/input7
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1476] key=
file: new connection /etc/NetworkManager/system-connections/WB2 (84e0c20b-b=
085-4370-929b-8d754af80d8e,"WB2")
Dec 30 00:48:06 klaptop kernel: [    6.526660] iTCO_vendor_support: vendor-=
support=3D0
Dec 30 00:48:06 klaptop kernel: [    6.528125] Bluetooth: Core ver 2.22
Dec 30 00:48:06 klaptop kernel: [    6.528133] NET: Registered protocol fam=
ily 31
Dec 30 00:48:06 klaptop kernel: [    6.528133] Bluetooth: HCI device and co=
nnection manager initialized
Dec 30 00:48:06 klaptop kernel: [    6.528135] Bluetooth: HCI socket layer =
initialized
Dec 30 00:48:06 klaptop kernel: [    6.528137] Bluetooth: L2CAP socket laye=
r initialized
Dec 30 00:48:06 klaptop kernel: [    6.528140] Bluetooth: SCO socket layer =
initialized
Dec 30 00:48:06 klaptop kernel: [    6.529698] ieee80211 phy0: Selected rat=
e control algorithm 'iwl-mvm-rs'
Dec 30 00:48:06 klaptop kernel: [    6.531732] iTCO_wdt: Intel TCO WatchDog=
 Timer Driver v1.11
Dec 30 00:48:06 klaptop kernel: [    6.531795] iTCO_wdt: Found a Lynx Point=
 TCO device (Version=3D2, TCOBASE=3D0x1860)
Dec 30 00:48:06 klaptop kernel: [    6.531934] iTCO_wdt: initialized. heart=
beat=3D30 sec (nowayout=3D0)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1625] key=
file: new connection /etc/NetworkManager/system-connections/WBP 1 (7fc51fbc=
-eac7-4a50-bc93-193095df185e,"WBP 1")
Dec 30 00:48:06 klaptop kernel: [    6.540832] intel_rapl: Found RAPL domai=
n package
Dec 30 00:48:06 klaptop kernel: [    6.540834] intel_rapl: Found RAPL domai=
n dram
Dec 30 00:48:06 klaptop kernel: [    6.546465] usbcore: registered new inte=
rface driver btusb
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.1825] key=
file: new connection /etc/NetworkManager/system-connections/WLAN-810157 (d0=
d783b6-4e71-41ec-8454-6288455b5a9c,"WLAN-810157")
Dec 30 00:48:06 klaptop kernel: [    6.572225] Bluetooth: hci0: read Intel =
version: 3707100180012d0d00
Dec 30 00:48:06 klaptop kernel: [    6.573114] Bluetooth: hci0: Intel Bluet=
ooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2145] key=
file: new connection /etc/NetworkManager/system-connections/eduroam (f58856=
50-e54a-48c0-9fda-810c33a92c38,"eduroam")
Dec 30 00:48:06 klaptop kernel: [    6.588924] iwlwifi 0000:03:00.0 wlp3s0:=
 renamed from wlan0
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2412] key=
file: new connection /etc/NetworkManager/system-connections/H18+ (07870f15-=
63d2-4069-9b7b-7d9af7728479,"H18+")
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2499] key=
file: new connection /etc/NetworkManager/system-connections/Vodafone Hotspo=
t (60f7b168-b7db-4a8e-8a78-8d78f6d182f5,"Vodafone Hotspot")
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2609] key=
file: new connection /etc/NetworkManager/system-connections/Androidks (0fe0=
4bb6-7e72-46aa-950f-8b266d918691,"Androidks")
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2697] key=
file: new connection /etc/NetworkManager/system-connections/Wired connectio=
n 1 (69f85f23-0764-4afc-b23c-b1a5ce7ea215,"Wired connection 1")
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2782] key=
file: new connection /etc/NetworkManager/system-connections/Casablanca (e23=
9d612-895e-4fd9-9c86-2b49615fd1f5,"Casablanca")
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2901] key=
file: new connection /etc/NetworkManager/system-connections/casablanca (3bd=
cd57d-d3e6-44e5-bb8c-dbaae0803d26,"casablanca")
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.2998] key=
file: new connection /etc/NetworkManager/system-connections/WBP (d8910d0b-4=
a65-4b7e-a4f9-2a9dcc737e9e,"WBP")
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.3016] get=
 unmanaged devices count: 0
Dec 30 00:48:06 klaptop kernel: [    6.682894] Bluetooth: BNEP (Ethernet Em=
ulation) ver 1.3
Dec 30 00:48:06 klaptop kernel: [    6.682895] Bluetooth: BNEP filters: pro=
tocol multicast
Dec 30 00:48:06 klaptop kernel: [    6.682898] Bluetooth: BNEP socket layer=
 initialized
Dec 30 00:48:06 klaptop kernel: [    6.682899] media: Linux media interface=
: v0.10
Dec 30 00:48:06 klaptop kernel: [    6.686284] Linux video capture interfac=
e: v2.00
Dec 30 00:48:06 klaptop kernel: [    6.690577] uvcvideo: Found UVC 1.00 dev=
ice Integrated Camera (04ca:7035)
Dec 30 00:48:06 klaptop kernel: [    6.699125] uvcvideo 3-12:1.0: Entity ty=
pe for entity Extension 4 was not initialized!
Dec 30 00:48:06 klaptop kernel: [    6.699126] uvcvideo 3-12:1.0: Entity ty=
pe for entity Extension 3 was not initialized!
Dec 30 00:48:06 klaptop kernel: [    6.699127] uvcvideo 3-12:1.0: Entity ty=
pe for entity Processing 2 was not initialized!
Dec 30 00:48:06 klaptop kernel: [    6.699128] uvcvideo 3-12:1.0: Entity ty=
pe for entity Camera 1 was not initialized!
Dec 30 00:48:06 klaptop kernel: [    6.699183] input: Integrated Camera as =
/devices/pci0000:00/0000:00:14.0/usb3/3-12/3-12:1.0/input/input18
Dec 30 00:48:06 klaptop kernel: [    6.699231] usb 3-12: rpm_idle
Dec 30 00:48:06 klaptop kernel: [    6.699241] usbcore: registered new inte=
rface driver uvcvideo
Dec 30 00:48:06 klaptop kernel: [    6.699242] USB Video Class driver (1.1.=
1)
Dec 30 00:48:06 klaptop kernel: [    6.701468] usb 3-12: rpm_idle
Dec 30 00:48:06 klaptop kernel: [    6.719226] Bluetooth: hci0: Intel Bluet=
ooth firmware patch completed and activated
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5109] set=
tings: hostname: using hostnamed
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5110] set=
tings: hostname changed from (none) to "klaptop"
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5114] dhc=
p-init: Using DHCP client 'dhclient'
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5114] man=
ager: WiFi enabled by radio killswitch; enabled by state file
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5114] man=
ager: WWAN enabled by radio killswitch; enabled by state file
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5114] man=
ager: Networking is enabled by state file
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5115] Loa=
ded device plugin: NMVxlanFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5115] Loa=
ded device plugin: NMVlanFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5115] Loa=
ded device plugin: NMVethFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5115] Loa=
ded device plugin: NMTunFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5115] Loa=
ded device plugin: NMMacvlanFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5116] Loa=
ded device plugin: NMIPTunnelFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5116] Loa=
ded device plugin: NMInfinibandFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5116] Loa=
ded device plugin: NMEthernetFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5116] Loa=
ded device plugin: NMBridgeFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5116] Loa=
ded device plugin: NMBondFactory (internal)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5125] Loa=
ded device plugin: NMAtmManager (/usr/lib/x86_64-linux-gnu/NetworkManager/l=
ibnm-device-plugin-adsl.so)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5157] Loa=
ded device plugin: NMBluezManager (/usr/lib/x86_64-linux-gnu/NetworkManager=
/libnm-device-plugin-bluetooth.so)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5178] Loa=
ded device plugin: NMTeamFactory (/usr/lib/x86_64-linux-gnu/NetworkManager/=
libnm-device-plugin-team.so)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5186] Loa=
ded device plugin: NMWifiFactory (/usr/lib/x86_64-linux-gnu/NetworkManager/=
libnm-device-plugin-wifi.so)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5191] Loa=
ded device plugin: NMWwanFactory (/usr/lib/x86_64-linux-gnu/NetworkManager/=
libnm-device-plugin-wwan.so)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5198] dev=
ice (lo): link connected
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5207] man=
ager: (lo): new Generic device (/org/freedesktop/NetworkManager/Devices/0)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5222] man=
ager: (enp0s25): new Ethernet device (/org/freedesktop/NetworkManager/Devic=
es/1)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.5235] dev=
ice (enp0s25): state change: unmanaged -> unavailable (reason 'managed') [1=
0 20 2]
Dec 30 00:48:06 klaptop kernel: [    6.895239] IPv6: ADDRCONF(NETDEV_UP): e=
np0s25: link is not ready
Dec 30 00:48:06 klaptop kernel: [    7.146750] IPv6: ADDRCONF(NETDEV_UP): e=
np0s25: link is not ready
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.7772] rfk=
ill1: found WiFi radio killswitch (at /sys/devices/pci0000:00/0000:00:1c.1/=
0000:03:00.0/ieee80211/phy0/rfkill1) (driver iwlwifi)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.7776] dev=
ices added (path: /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/net/wlp=
3s0, iface: wlp3s0)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.7776] dev=
ice added (path: /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/net/wlp3=
s0, iface: wlp3s0): no ifupdown configuration found.
Dec 30 00:48:06 klaptop kernel: [    7.148434] ip6_tables: (C) 2000-2006 Ne=
tfilter Core Team
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.7806] (wl=
p3s0): using nl80211 for WiFi device control
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.7807] dev=
ice (wlp3s0): driver supports Access Point (AP) mode
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.7814] man=
ager: (wlp3s0): new 802.11 WiFi device (/org/freedesktop/NetworkManager/Dev=
ices/2)
Dec 30 00:48:06 klaptop NetworkManager[1918]: <info>  [1483055286.7820] dev=
ice (wlp3s0): state change: unmanaged -> unavailable (reason 'managed') [10=
 20 2]
Dec 30 00:48:06 klaptop kernel: [    7.153381] IPv6: ADDRCONF(NETDEV_UP): w=
lp3s0: link is not ready
Dec 30 00:48:06 klaptop kernel: [    7.155543] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:06 klaptop kernel: [    7.156063] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:06 klaptop kernel: [    7.159205] Ebtables v2.0 registered
Dec 30 00:48:06 klaptop kernel: [    7.351582] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:06 klaptop kernel: [    7.351837] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:07 klaptop kernel: [    7.372728] IPv6: ADDRCONF(NETDEV_UP): w=
lp3s0: link is not ready
Dec 30 00:48:07 klaptop kernel: [    7.444450] nouveau 0000:01:00.0: fb: 20=
48 MiB GDDR5
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.0794] dev=
ice (wlp3s0): set-hw-addr: set MAC address to 2A:65:07:A2:E5:F6 (scanning)
Dec 30 00:48:07 klaptop kernel: [    7.452958] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:07 klaptop kernel: [    7.453891] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:07 klaptop kernel: [    7.655344] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:07 klaptop kernel: [    7.656268] iwlwifi 0000:03:00.0: L1 Ena=
bled - LTR Enabled
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.3014] blu=
ez: use BlueZ version 5
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.3018] Mod=
emManager available in the bus
Dec 30 00:48:07 klaptop kernel: [    7.671864] IPv6: ADDRCONF(NETDEV_UP): w=
lp3s0: link is not ready
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.3147] sup=
plicant: wpa_supplicant running
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.3147] dev=
ice (wlp3s0): supplicant interface state: init -> starting
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.4803] sup=
-iface[0x55b02292d960,wlp3s0]: supports 5 scan SSIDs
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.4809] dev=
ice (wlp3s0): supplicant interface state: starting -> ready
Dec 30 00:48:07 klaptop NetworkManager[1918]: <info>  [1483055287.4810] dev=
ice (wlp3s0): state change: unavailable -> disconnected (reason 'supplicant=
-available') [20 30 42]
Dec 30 00:48:07 klaptop kernel: [    7.852392] IPv6: ADDRCONF(NETDEV_UP): w=
lp3s0: link is not ready
Dec 30 00:48:08 klaptop kernel: [    8.746563] vga_switcheroo: enabled
Dec 30 00:48:08 klaptop kernel: [    8.746819] [TTM] Zone  kernel: Availabl=
e graphics memory: 10092776 kiB
Dec 30 00:48:08 klaptop kernel: [    8.746819] [TTM] Zone   dma32: Availabl=
e graphics memory: 2097152 kiB
Dec 30 00:48:08 klaptop kernel: [    8.746820] [TTM] Initializing pool allo=
cator
Dec 30 00:48:08 klaptop kernel: [    8.746824] [TTM] Initializing DMA pool =
allocator
Dec 30 00:48:08 klaptop kernel: [    8.746852] nouveau 0000:01:00.0: DRM: V=
RAM: 2048 MiB
Dec 30 00:48:08 klaptop kernel: [    8.746853] nouveau 0000:01:00.0: DRM: G=
ART: 1048576 MiB
Dec 30 00:48:08 klaptop kernel: [    8.746855] nouveau 0000:01:00.0: DRM: T=
MDS table version 2.0
Dec 30 00:48:08 klaptop kernel: [    8.746856] nouveau 0000:01:00.0: DRM: D=
CB version 4.0
Dec 30 00:48:08 klaptop kernel: [    8.746857] nouveau 0000:01:00.0: DRM: D=
CB outp 00: 08800fc6 0f420010
Dec 30 00:48:08 klaptop kernel: [    8.746858] nouveau 0000:01:00.0: DRM: D=
CB outp 01: 08000f82 00020010
Dec 30 00:48:08 klaptop kernel: [    8.746859] nouveau 0000:01:00.0: DRM: D=
CB conn 00: 01000046
Dec 30 00:48:08 klaptop kernel: [    8.781822] [drm] Supports vblank timest=
amp caching Rev 2 (21.10.2013).
Dec 30 00:48:08 klaptop kernel: [    8.781823] [drm] Driver supports precis=
e vblank timestamp query.
Dec 30 00:48:08 klaptop kernel: [    8.781913] nouveau 0000:01:00.0: hwmon_=
device_register() is deprecated. Please convert the driver to use hwmon_dev=
ice_register_with_info().
Dec 30 00:48:08 klaptop kernel: [    8.949744] nouveau 0000:01:00.0: DRM: M=
M: using COPY for buffer copies
Dec 30 00:48:08 klaptop kernel: [    8.958369] usb 3-12: rpm_suspend
Dec 30 00:48:08 klaptop kernel: [    8.998373] usb usb3-port12: rpm_suspend
Dec 30 00:48:08 klaptop kernel: [    9.010375] [drm] Cannot find any crtc o=
r sizes - going 1024x768
Dec 30 00:48:08 klaptop kernel: [    9.064123] nouveau 0000:01:00.0: DRM: a=
llocated 1024x768 fb: 0x60000, bo ffff9bb72238bc00
Dec 30 00:48:08 klaptop kernel: [    9.064392] Console: switching to colour=
 frame buffer device 128x48
Dec 30 00:48:08 klaptop kernel: [    9.065116] nouveau 0000:01:00.0: fb0: n=
ouveaufb frame buffer device
Dec 30 00:48:08 klaptop kernel: [    9.082458] [drm] Initialized nouveau 1.=
3.1 20120801 for 0000:01:00.0 on minor 1
Dec 30 00:48:08 klaptop kernel: [    9.083512] ACPI: Video Device [VID] (mu=
lti-head: yes  rom: no  post: no)
Dec 30 00:48:08 klaptop kernel: [    9.083980] input: Video Bus as /devices=
/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input19
Dec 30 00:48:08 klaptop kernel: [    9.084137] ACPI: Video Device [VID1] (m=
ulti-head: yes  rom: yes  post: no)
Dec 30 00:48:08 klaptop kernel: [    9.084291] input: Video Bus as /devices=
/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:09/LNXVIDEO:01/input/input20
Dec 30 00:48:08 klaptop kernel: [    9.084406] snd_hda_intel 0000:00:03.0: =
bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
Dec 30 00:48:08 klaptop kernel: [    9.084413] [drm] Initialized i915 1.6.0=
 20161121 for 0000:00:02.0 on minor 0
Dec 30 00:48:10 klaptop kernel: [    9.459001] fbcon: inteldrmfb (fb1) is p=
rimary device
Dec 30 00:48:10 klaptop kernel: [    9.459002] fbcon: Remapping primary dev=
ice, fb1, to tty 1-63
Dec 30 00:48:10 klaptop kernel: [   10.799770] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:10 klaptop kernel: [   10.815681] i915 0000:00:02.0: fb1: inte=
ldrmfb frame buffer device
Dec 30 00:48:10 klaptop kernel: [   10.835266] snd_hda_codec_hdmi hdaudioC0=
D0: rpm_suspend
Dec 30 00:48:10 klaptop kernel: [   10.835434] input: HDA Intel HDMI HDMI/D=
P,pcm=3D3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input21
Dec 30 00:48:10 klaptop kernel: [   10.835480] input: HDA Intel HDMI HDMI/D=
P,pcm=3D7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input22
Dec 30 00:48:10 klaptop kernel: [   10.835523] input: HDA Intel HDMI HDMI/D=
P,pcm=3D8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input23
Dec 30 00:48:10 klaptop kernel: [   10.836029] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:10 klaptop kernel: [   10.859089] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:10 klaptop kernel: [   10.859150] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:10 klaptop NetworkManager[1918]: <info>  [1483055290.7948] dev=
ice (wlp3s0): supplicant interface state: ready -> inactive
Dec 30 00:48:11 klaptop NetworkManager[1918]: <info>  [1483055291.6638] man=
ager: startup complete
Dec 30 00:48:12 klaptop kernel: [   13.122178] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:12 klaptop kernel: [   13.122216] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:12 klaptop kernel: [   13.267619] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:12 klaptop kernel: [   13.267686] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:12 klaptop kernel: [   13.267814] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:12 klaptop kernel: [   13.267870] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:13 klaptop kernel: [   13.550640] nouveau 0000:01:00.0: rpm_id=
le
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9375] pol=
icy: auto-activating connection 'casablanca'
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9384] dev=
ice (wlp3s0): Activation: starting connection 'casablanca' (3bdcd57d-d3e6-4=
4e5-bb8c-dbaae0803d26)
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9385] dev=
ice (wlp3s0): state change: disconnected -> prepare (reason 'none') [30 40 =
0]
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9386] man=
ager: NetworkManager state is now CONNECTING
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9392] dev=
ice (wlp3s0): set-hw-addr: set-cloned MAC address to CC:3D:82:59:89:F4 (per=
manent)
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9410] dev=
ice (wlp3s0): state change: prepare -> config (reason 'none') [40 50 0]
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9411] dev=
ice (wlp3s0): Activation: (wifi) access point 'casablanca' has security, bu=
t secrets are required.
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9411] dev=
ice (wlp3s0): state change: config -> need-auth (reason 'none') [50 60 0]
Dec 30 00:48:17 klaptop kernel: [   18.312115] IPv6: ADDRCONF(NETDEV_UP): w=
lp3s0: link is not ready
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9434] dev=
ice (wlp3s0): state change: need-auth -> prepare (reason 'none') [60 40 0]
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9436] dev=
ice (wlp3s0): state change: prepare -> config (reason 'none') [40 50 0]
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9437] dev=
ice (wlp3s0): Activation: (wifi) connection 'casablanca' has security, and =
secrets exist.  No new secrets needed.
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9438] Con=
fig: added 'ssid' value 'casablanca'
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9438] Con=
fig: added 'scan_ssid' value '1'
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9438] Con=
fig: added 'key_mgmt' value 'WPA-PSK'
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9438] Con=
fig: added 'auth_alg' value 'OPEN'
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9438] Con=
fig: added 'psk' value '<omitted>'
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9874] dev=
ice (wlp3s0): supplicant interface state: inactive -> disconnected
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9875] sup=
-iface[0x55b02292d960,wlp3s0]: config: set interface ap_scan to 1
Dec 30 00:48:17 klaptop NetworkManager[1918]: <info>  [1483055297.9952] dev=
ice (wlp3s0): supplicant interface state: disconnected -> inactive
Dec 30 00:48:17 klaptop kernel: [   18.367411] wlp3s0: authenticate with d4=
:21:22:cb:cb:85
Dec 30 00:48:17 klaptop kernel: [   18.370259] wlp3s0: send auth to d4:21:2=
2:cb:cb:85 (try 1/3)
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0008] dev=
ice (wlp3s0): supplicant interface state: inactive -> associating
Dec 30 00:48:18 klaptop kernel: [   18.371146] wlp3s0: authenticated
Dec 30 00:48:18 klaptop kernel: [   18.374934] wlp3s0: associate with d4:21=
:22:cb:cb:85 (try 1/3)
Dec 30 00:48:18 klaptop kernel: [   18.379137] wlp3s0: RX AssocResp from d4=
:21:22:cb:cb:85 (capab=3D0x11 status=3D0 aid=3D1)
Dec 30 00:48:18 klaptop kernel: [   18.380611] wlp3s0: associated
Dec 30 00:48:18 klaptop kernel: [   18.380619] IPv6: ADDRCONF(NETDEV_CHANGE=
): wlp3s0: link becomes ready
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0144] dev=
ice (wlp3s0): supplicant interface state: associating -> associated
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0199] dev=
ice (wlp3s0): supplicant interface state: associated -> 4-way handshake
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0358] dev=
ice (wlp3s0): supplicant interface state: 4-way handshake -> completed
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0358] dev=
ice (wlp3s0): Activation: (wifi) Stage 2 of 5 (Device Configure) successful=
.  Connected to wireless network 'casablanca'.
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0359] dev=
ice (wlp3s0): state change: config -> ip-config (reason 'none') [50 70 0]
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0367] dhc=
p4 (wlp3s0): activation: beginning transaction (timeout in 45 seconds)
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0394] dhc=
p4 (wlp3s0): dhclient started with pid 3064
Dec 30 00:48:18 klaptop kernel: [   18.438644] wlp3s0: Limiting TX power to=
 30 (30 - 0) dBm as advertised by d4:21:22:cb:cb:85
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   address 192.168.2.104
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   plen 24 (255.255.255.0)
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   gateway 192.168.2.1
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   server identifier 192.168.2.1
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   lease time 1814400
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   nameserver '192.168.2.1'
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   nameserver '192.168.2.1'
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0):   domain name 'Speedport_W_724V_09011603_00_025'
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0886] dhc=
p4 (wlp3s0): state changed unknown -> bound
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0897] dev=
ice (wlp3s0): state change: ip-config -> ip-check (reason 'none') [70 80 0]
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0900] dev=
ice (wlp3s0): state change: ip-check -> secondaries (reason 'none') [80 90 =
0]
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0902] dev=
ice (wlp3s0): state change: secondaries -> activated (reason 'none') [90 10=
0 0]
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0902] man=
ager: NetworkManager state is now CONNECTED_LOCAL
Dec 30 00:48:18 klaptop at-spi-bus-laun[3085]: Failed to register client: G=
DBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.gnome.Se=
ssionManager was not provided by any .service files
Dec 30 00:48:18 klaptop at-spi-bus-laun[3085]: g_dbus_proxy_call_internal: =
assertion 'G_IS_DBUS_PROXY (proxy)' failed
Dec 30 00:48:18 klaptop at-spi-bus-laun[3085]: invalid unclassed pointer in=
 cast to 'GObject'
Dec 30 00:48:18 klaptop at-spi-bus-laun[3085]: instance with invalid (NULL)=
 class pointer
Dec 30 00:48:18 klaptop at-spi-bus-laun[3085]: g_signal_connect_data: asser=
tion 'G_TYPE_CHECK_INSTANCE (instance)' failed
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0913] man=
ager: NetworkManager state is now CONNECTED_GLOBAL
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0913] pol=
icy: set 'casablanca' (wlp3s0) as default for IPv4 routing and DNS
Dec 30 00:48:18 klaptop NetworkManager[1918]: <info>  [1483055298.0936] dev=
ice (wlp3s0): Activation: successful, device activated.
Dec 30 00:48:19 klaptop NetworkManager[1918]: <info>  [1483055299.6746] dhc=
p6 (wlp3s0): activation: beginning transaction (timeout in 45 seconds)
Dec 30 00:48:19 klaptop NetworkManager[1918]: <warn>  [1483055299.6746] dhc=
p6 (wlp3s0): hostname is not a FQDN, it will be ignored
Dec 30 00:48:19 klaptop NetworkManager[1918]: <info>  [1483055299.6762] dhc=
p6 (wlp3s0): dhclient started with pid 3220
Dec 30 00:48:19 klaptop NetworkManager[1918]: <info>  [1483055299.6771] pol=
icy: set 'casablanca' (wlp3s0) as default for IPv6 routing and DNS
Dec 30 00:48:20 klaptop kernel: [   20.583465] snd_hda_codec_hdmi hdaudioC0=
D0: rpm_resume
Dec 30 00:48:20 klaptop NetworkManager[1918]: <info>  [1483055300.3050] dhc=
p6 (wlp3s0):   nameserver 'fe80::1'
Dec 30 00:48:20 klaptop NetworkManager[1918]: <info>  [1483055300.3051] dhc=
p6 (wlp3s0): state changed unknown -> bound
Dec 30 00:48:20 klaptop NetworkManager[1918]: <info>  [1483055300.3070] dhc=
p6 (wlp3s0): client pid 3220 exited with status 0
Dec 30 00:48:20 klaptop NetworkManager[1918]: <info>  [1483055300.3071] dhc=
p6 (wlp3s0): state changed bound -> done
Dec 30 00:48:20 klaptop kernel: [   20.839240] snd_hda_intel 0000:00:1b.0: =
IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_ad=
j.
Dec 30 00:48:20 klaptop clock-applet[3304]: /build/glib2.0-m2w47E/glib2.0-2=
.50.2/./gobject/gsignal.c:2523: signal 'size_request' is invalid for instan=
ce '0x564aac92bd20' of type 'GtkLabel'
Dec 30 00:48:21 klaptop kernel: [   22.114185] random: crng init done
Dec 30 00:48:24 klaptop kernel: [   24.831417] nouveau 0000:01:00.0: rpm_su=
spend
Dec 30 00:48:24 klaptop kernel: [   24.831427] nouveau 0000:01:00.0: DRM: s=
uspending console...
Dec 30 00:48:24 klaptop kernel: [   24.831432] nouveau 0000:01:00.0: DRM: s=
uspending display...
Dec 30 00:48:24 klaptop kernel: [   24.831477] nouveau 0000:01:00.0: DRM: e=
victing buffers...
Dec 30 00:48:24 klaptop kernel: [   24.865243] nouveau 0000:01:00.0: DRM: w=
aiting for kernel channels to go idle...
Dec 30 00:48:24 klaptop kernel: [   24.865269] nouveau 0000:01:00.0: DRM: s=
uspending client object trees...
Dec 30 00:48:24 klaptop kernel: [   24.870724] nouveau 0000:01:00.0: DRM: s=
uspending kernel object tree...
Dec 30 00:48:25 klaptop kernel: [   26.080300] thinkpad_acpi: EC reports th=
at Thermal Table has changed
Dec 30 00:48:25 klaptop kernel: [   26.207691] pcieport 0000:00:01.0: rpm_i=
dle
Dec 30 00:48:25 klaptop kernel: [   26.207693] pcieport 0000:00:01.0: rpm_s=
uspend
Dec 30 00:48:28 klaptop kernel: [   28.927640] snd_hda_codec_hdmi hdaudioC0=
D0: rpm_suspend
SYSTEM IS NOW NOT RESPONSIVE


----- Original Message -----
From: "Lukas Wunner" <lukas@wunner.de>
To: "Kilian Singer" <kilian.singer@quantumtechnology.info>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "linux-pci" <linux-pci@vger.kerne=
l.org>, "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Rafael J. Wys=
ocki" <rafael.j.wysocki@intel.com>
Sent: Friday, December 30, 2016 1:07:31 AM
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"

On Fri, Dec 30, 2016 at 12:20:34AM +0100, Kilian Singer wrote:
> The echo on > /sys/bus/pci/devices/0000:00:01.0/power/control
>=20
> did not help.
>=20
> Also I noticed on each boot directly after initramfs I get
> mmc0: Unknown contrller version. You may experience problems.
>=20
> On all versions of the kernel.

Hm, that rings a bell.  The MMC controller is located below
root port 0000:00:1c.0, which has vendor/device ID 8086:8c10.

We're having trouble with the exact same root port on 2015
MacBook Pros where it mysteriously prevents them from powering off:
https://bugzilla.kernel.org/show_bug.cgi?id=3D103211
http://www.spinics.net/lists/linux-pci/msg53460.html

Does this help:
echo on > /sys/bus/pci/devices/0000:00:1c.0/power/control

Thanks,

Lukas
