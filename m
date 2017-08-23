Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=i78b=7Z=free.fr=slash.tmp@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
From: Mason <slash.tmp@free.fr>
To: Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4dee5523-2d76-e731-6e81-f3027e88827f@free.fr>
 <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
Message-ID: <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
Date: Wed, 23 Aug 2017 16:30:03 +0200
MIME-Version: 1.0
In-Reply-To: <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 23/08/2017 14:41, Mason wrote:

> I compiled a minimal kernel, with lots of irrelevant drivers and
> frameworks left out, including power management. I still get the
> "xHCI host controller not responding, assume dead" issue.

The problem seems to have a timing-related aspect.

I added a bunch of logs (to a slow serial console) and the HC was
not killed. I was able to plug the Flash drive a second time.
(I am logging config space reads and writes.)

[    1.098314]   READ: bus=1 devfn=0 where=84 size=2 val=0x8
[    1.103779]   READ: bus=1 devfn=0 where=4 size=2 val=0x142
[    1.109315]   READ: bus=1 devfn=0 where=61 size=1 val=0x1
[    1.114746]   READ: bus=1 devfn=0 where=4 size=2 val=0x142
[    1.120311]   READ: bus=1 devfn=0 where=4 size=2 val=0x142
[    1.125841]  WRITE: bus=1 devfn=0 where=4 size=2 val=0x146

NB: I added msleep(2500) in usb_add_hcd()

[    3.681867] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    3.687154] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    3.694656]   READ: bus=1 devfn=0 where=96 size=1 val=0x30
[    3.705736] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    3.714233]   READ: bus=1 devfn=0 where=12 size=1 val=0x10
[    3.719752]   READ: bus=1 devfn=0 where=4 size=2 val=0x146
[    3.725269]  WRITE: bus=1 devfn=0 where=4 size=2 val=0x156
[    3.730794]   READ: bus=1 devfn=0 where=146 size=2 val=0x7
[    3.736314]   READ: bus=1 devfn=0 where=146 size=2 val=0x7
[    3.741835]  WRITE: bus=1 devfn=0 where=146 size=2 val=0x7
[    3.747354]   READ: bus=1 devfn=0 where=146 size=2 val=0x7
[    3.752871]   READ: bus=1 devfn=0 where=148 size=4 val=0x1000
[    3.758775]   READ: bus=1 devfn=0 where=146 size=2 val=0x7
[    3.764297]  WRITE: bus=1 devfn=0 where=146 size=2 val=0xc007
[    3.770108]   READ: bus=1 devfn=0 where=4 size=2 val=0x146
[    3.775626]  WRITE: bus=1 devfn=0 where=4 size=2 val=0x546
[    3.781146]   READ: bus=1 devfn=0 where=146 size=2 val=0xc007
[    3.786925]  WRITE: bus=1 devfn=0 where=146 size=2 val=0x8007
[    3.792919] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.799756] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.807021] usb usb1: Product: xHCI Host Controller
[    3.811933] usb usb1: Manufacturer: Linux 4.12.0-rc1 xhci-hcd
[    3.817713] usb usb1: SerialNumber: 0000:01:00.0
[    3.822773] hub 1-0:1.0: USB hub found
[    3.826598] hub 1-0:1.0: 4 ports detected

NB: I added msleep(2500) in usb_add_hcd()

[    6.455246] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    6.460520] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    6.468028] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.476236] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    6.483068] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.490334] usb usb2: Product: xHCI Host Controller
[    6.495240] usb usb2: Manufacturer: Linux 4.12.0-rc1 xhci-hcd
[    6.501020] usb usb2: SerialNumber: 0000:01:00.0
[    6.505994] hub 2-0:1.0: USB hub found
[    6.509806] hub 2-0:1.0: 4 ports detected
[    6.514215] usbcore: registered new interface driver usb-storage
[    6.520313] Registering SWP/SWPB emulation handler
[    6.525541]   READ: bus=0 devfn=0 where=132 size=4 val=0x8001
[    6.531334]   READ: bus=0 devfn=0 where=6 size=2 val=0x4010
[    6.536955]   READ: bus=0 devfn=0 where=52 size=1 val=0x50
[    6.542484]   READ: bus=0 devfn=0 where=80 size=2 val=0x7805
[    6.548180]   READ: bus=0 devfn=0 where=120 size=2 val=0x8001
[    6.553969]   READ: bus=0 devfn=0 where=128 size=2 val=0x10
[    6.559584]   READ: bus=0 devfn=0 where=124 size=2 val=0x6008
[    6.565387]   READ: bus=1 devfn=0 where=164 size=4 val=0x8fc0
[    6.571167]   READ: bus=1 devfn=0 where=6 size=2 val=0x10
[    6.576609]   READ: bus=1 devfn=0 where=52 size=1 val=0x50
[    6.582129]   READ: bus=1 devfn=0 where=80 size=2 val=0x7001
[    6.587821]   READ: bus=1 devfn=0 where=112 size=2 val=0x9005
[    6.593601]   READ: bus=1 devfn=0 where=144 size=2 val=0xa011
[    6.599381]   READ: bus=1 devfn=0 where=160 size=2 val=0x10
[    6.604985]   READ: bus=1 devfn=0 where=84 size=2 val=0x8
[    6.623665] Freeing unused kernel memory: 9216K


PLUG #1
[   66.783559] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[   66.816910] usb 2-2: New USB device found, idVendor=0951, idProduct=1666
[   66.823661] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   66.830909] usb 2-2: Product: DataTraveler 3.0
[   66.835417] usb 2-2: Manufacturer: Kingston
[   66.839660] usb 2-2: SerialNumber: 002618887865F0C0F8646BFA
[   66.848131] usb-storage 2-2:1.0: USB Mass Storage device detected
[   66.854584] scsi host0: usb-storage 2-2:1.0
[   67.869446] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   67.878270] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   67.886248] sd 0:0:0:0: [sda] Write Protect is off
[   67.891347] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   67.902708]  sda: sda1
[   67.906372] sd 0:0:0:0: [sda] Attached SCSI removable disk


UNPLUG #1
[   71.697358]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   71.703572]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[   71.709170]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   71.715569] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   71.723632]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[   71.729470]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   71.735373]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   71.741013]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   71.746914]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   71.752552]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   71.758194] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   71.770008] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   71.778494] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   71.785358]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   71.791259]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   71.796897]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   71.802524] pcieport 0000:00:00.0: AER: Device recovery failed
[   72.451908]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.458120]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[   72.463717]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.470012]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.476221]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[   72.481819]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.488109]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.494319]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[   72.499916]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.506205]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.512415]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[   72.518011]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[   72.524263] xhci_hcd 0000:01:00.0: Cannot set link state.
[   72.529711] usb usb2-port2: cannot disable (err = -32)
[   72.534883] usb 2-2: USB disconnect, device number 2
[   72.540042] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   72.548365]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[   72.554264]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.560157]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.565778]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.571654]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.577273]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.582891] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   72.594705] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   72.603122] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   72.609955]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.615833]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.621441]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.627061] pcieport 0000:00:00.0: AER: Device recovery failed
[   72.632931] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   72.640984]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[   72.646769]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.652636]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.658245]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.664114]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.669722]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.675330] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   72.687142] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   72.695545] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   72.702376]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.708244]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.713856]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.719473] pcieport 0000:00:00.0: AER: Device recovery failed
[   72.725342] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   72.733394]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[   72.739178]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.745044]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.750653]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.756520]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.762128]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.767734] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   72.779548] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   72.787950] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   72.794781]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.800649]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.806258]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.811873] pcieport 0000:00:00.0: AER: Device recovery failed
[   72.817741] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[   72.825793]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[   72.831574]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.837442]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.843054]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.848922]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.854529]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.860137] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[   72.871951] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[   72.880353] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[   72.887184]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[   72.893051]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[   72.898660]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[   72.904273] pcieport 0000:00:00.0: AER: Device recovery failed


PLUG #2
[  165.860193] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
[  165.893583] usb 2-2: New USB device found, idVendor=0951, idProduct=1666
[  165.900333] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  165.907515] usb 2-2: Product: DataTraveler 3.0
[  165.911989] usb 2-2: Manufacturer: Kingston
[  165.916198] usb 2-2: SerialNumber: 002618887865F0C0F8646BFA
[  165.924547] usb-storage 2-2:1.0: USB Mass Storage device detected
[  165.930970] scsi host0: usb-storage 2-2:1.0
[  166.962705] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[  166.971494] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[  166.979556] sd 0:0:0:0: [sda] Write Protect is off
[  166.984591] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  166.995847] random: fast init done
[  166.999430]  sda: sda1
[  167.003039] sd 0:0:0:0: [sda] Attached SCSI removable disk


UNPLUG #2
[  171.918834]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  171.925046]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[  171.930645]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  171.936941] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[  171.945000]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[  171.950784]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  171.956656]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  171.962263]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  171.968134]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  171.973741]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  171.979354] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[  171.991164] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[  171.999597] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[  172.006429]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.012300]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.017908]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  172.023529] pcieport 0000:00:00.0: AER: Device recovery failed
[  172.675221]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.681432]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[  172.687030]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.693325]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.699536]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[  172.705133]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.711424]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.717633]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[  172.723230]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.729517]   READ: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.735726]   READ: bus=0 devfn=0 where=2100 size=4 val=0x0
[  172.741322]  WRITE: bus=0 devfn=0 where=2096 size=4 val=0x10000024
[  172.747574] xhci_hcd 0000:01:00.0: Cannot set link state.
[  172.753021] usb usb2-port2: cannot disable (err = -32)
[  172.758193] usb 2-2: USB disconnect, device number 3
[  172.763340] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[  172.771627]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[  172.777515]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.783408]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.789030]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.794907]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.800526]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  172.806146] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[  172.817960] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[  172.826375] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[  172.833208]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.839078]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.844685]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  172.850305] pcieport 0000:00:00.0: AER: Device recovery failed
[  172.856183] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[  172.864236]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[  172.870020]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.875889]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.881497]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.887365]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.892974]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  172.898582] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[  172.910393] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[  172.918796] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[  172.925627]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.931494]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.937107]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  172.942724] pcieport 0000:00:00.0: AER: Device recovery failed
[  172.948593] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[  172.956644]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[  172.962428]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.968295]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.973903]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  172.979771]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  172.985379]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  172.990985] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[  173.002799] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[  173.011202] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[  173.018033]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  173.023901]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  173.029510]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  173.035123] pcieport 0000:00:00.0: AER: Device recovery failed
[  173.040990] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[  173.049042]   READ: bus=0 devfn=0 where=136 size=2 val=0x281f
[  173.054825]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  173.060693]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  173.066305]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  173.072173]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  173.077780]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  173.083388] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[  173.095202] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[  173.103605] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[  173.110435]   READ: bus=0 devfn=0 where=2052 size=4 val=0x4000
[  173.116303]   READ: bus=0 devfn=0 where=2056 size=4 val=0x0
[  173.121911]   READ: bus=0 devfn=0 where=2072 size=4 val=0xe
[  173.127524] pcieport 0000:00:00.0: AER: Device recovery failed




NOTE BENE: these issues do not occur at all with a USB2 Flash drive.

[ 2093.564771] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[ 2093.790646] usb 1-2: New USB device found, idVendor=058f, idProduct=6387
[ 2093.797397] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 2093.804583] usb 1-2: Product: Mass Storage
[ 2093.808707] usb 1-2: Manufacturer: Generic
[ 2093.812829] usb 1-2: SerialNumber: 31A69E70
[ 2093.819244] usb-storage 1-2:1.0: USB Mass Storage device detected
[ 2093.825624] scsi host0: usb-storage 1-2:1.0
[ 2094.856918] scsi 0:0:0:0: Direct-Access     Generic  Flash Disk       8.07 PQ: 0 ANSI: 2
[ 2094.866196] sd 0:0:0:0: [sda] 4106240 512-byte logical blocks: (2.10 GB/1.96 GiB)
[ 2094.874232] sd 0:0:0:0: [sda] Write Protect is off
[ 2094.879350] sd 0:0:0:0: [sda] No Caching mode page found
[ 2094.884816] sd 0:0:0:0: [sda] Assuming drive cache: write through
[ 2094.909111]  sda: sda1
[ 2094.912935] sd 0:0:0:0: [sda] Attached SCSI removable disk

[ 2100.516396] usb 1-2: USB disconnect, device number 2


Regards.
