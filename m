Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 24 Mar 2017 10:07:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4 v5] PCI: add driver for Faraday Technology Host Bridge
Message-ID: <20170324150753.GC25380@bhelgaas-glaptop.roam.corp.google.com>
References: <20170312222403.2473-1-linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170312222403.2473-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Feng-Hsin Chiang <john453@faraday-tech.com>, Arnd Bergmann <arnd@arndb.de>,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, Greentime Hu <green.hu@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 12, 2017 at 11:24:03PM +0100, Linus Walleij wrote:
> This adds a host bridge driver for the Faraday Technology
> FPPCI100 host bridge, used for Cortina Systems Gemini SoC
> (SL3516) PCI Host Bridge.
> 
> This code is inspired by the out-of-tree OpenWRT patch and
> then extensively rewritten for device tree and using the modern
> helpers to cut down and modernize the code to all new PCI
> frameworks. A driver exists in U-Boot as well.
> 
> Tested on the ITian Square One SQ201 NAS with the following
> result in the boot log (trimmed to relevant parts):
> 
> OF: PCI: host bridge /soc/pci@50000000 ranges:
> OF: PCI:    IO 0x50000000..0x500fffff -> 0x00000000
> OF: PCI:   MEM 0x58000000..0x5fffffff -> 0x58000000
> ftpci100 50000000.pci: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> pci_bus 0000:00: root bus resource [mem 0x58000000-0x5fffffff]
> ftpci100 50000000.pci:
>   DMA MEM1 BASE: 0x0000000000000000 -> 0x0000000007ffffff config 00070000
> ftpci100 50000000.pci:
>   DMA MEM2 BASE: 0x0000000000000000 -> 0x0000000003ffffff config 00060000
> ftpci100 50000000.pci:
>   DMA MEM3 BASE: 0x0000000000000000 -> 0x0000000003ffffff config 00060000
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
> pci 0000:00:0c.0: BAR 0: assigned [mem 0x58000000-0x58007fff]
> pci 0000:00:09.2: BAR 0: assigned [mem 0x58008000-0x580080ff]
> pci 0000:00:09.0: BAR 4: assigned [io  0x1000-0x101f]
> pci 0000:00:09.1: BAR 4: assigned [io  0x1020-0x103f]
> pci 0000:00:09.0: enabling device (0140 -> 0141)
> pci 0000:00:09.0: HCRESET not completed yet!
> pci 0000:00:09.1: enabling device (0140 -> 0141)
> pci 0000:00:09.1: HCRESET not completed yet!
> pci 0000:00:09.2: enabling device (0140 -> 0142)
> rt61pci 0000:00:0c.0: enabling device (0140 -> 0142)
> ieee80211 phy0: rt2x00_set_chip: Info - Chipset detected -
>    rt: 2561, rf: 0003, rev: 000c
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-pci: EHCI PCI platform driver
> ehci-pci 0000:00:09.2: EHCI Host Controller
> ehci-pci 0000:00:09.2: new USB bus registered, assigned bus number 1
> ehci-pci 0000:00:09.2: irq 125, io mem 0x58008000
> ehci-pci 0000:00:09.2: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 4 ports detected
> uhci_hcd: USB Universal Host Controller Interface driver
> uhci_hcd 0000:00:09.0: UHCI Host Controller
> uhci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:09.0: HCRESET not completed yet!
> uhci_hcd 0000:00:09.0: irq 123, io base 0x00001000
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
> uhci_hcd 0000:00:09.1: UHCI Host Controller
> uhci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:09.1: HCRESET not completed yet!
> uhci_hcd 0000:00:09.1: irq 124, io base 0x00001020
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: config failed, hub doesn't have any ports! (err -19)
> scsi 0:0:0:0: Direct-Access     USB      Flash Disk       1.00 PQ: 0 ANSI: 2
> sd 0:0:0:0: [sda] 7900336 512-byte logical blocks: (4.04 GB/3.77 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] No Caching mode page found
> sd 0:0:0:0: [sda] Assuming drive cache: write through
>  sda: sda1 sda2 sda3
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> ieee80211 phy0: rt2x00lib_request_firmware: Info -
>    Loading firmware file 'rt2561s.bin'
> ieee80211 phy0: rt2x00lib_request_firmware: Info -
>    Firmware detected - version: 0.8
> IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> 
> $ lspci
> 00:00.0 Class 0600: 159b:4321
> 00:09.2 Class 0c03: 1106:3104
> 00:09.0 Class 0c03: 1106:3038
> 00:09.1 Class 0c03: 1106:3038
> 00:0c.0 Class 0280: 1814:0301
> 
> cat /proc/interrupts
>            CPU0
> 123:          0       PCI   0 Edge      uhci_hcd:usb2
> 124:          0       PCI   1 Edge      uhci_hcd:usb3
> 125:        159       PCI   2 Edge      ehci_hcd:usb1
> 126:       1082       PCI   3 Edge      rt61pci
> 
> cat /proc/iomem
> 50000000-500000ff : /soc/pci@50000000
> 58000000-5fffffff : Gemini PCI MEM
>   58000000-58007fff : 0000:00:0c.0
>     58000000-58007fff : 0000:00:0c.0
>   58008000-580080ff : 0000:00:09.2
>     58008000-580080ff : ehci_hcd
> 
> The EHCI USB hub works fine, I can mount and manage
> files and the IRQs just keep ticking up. I can issue
> iwlist wlan0 scanning and see all the WLANs here, I don't have
> wpa_supplicant so have not tried connecting to them.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I don't know enough to review the DT patch, but you have Rob's ack
already.

Not sure how you want to merge these; if you want to feed the whole
thing via ARM SoC, that's fine with me.  Otherwise, let me know if
you'd like me to take anything.

Noticed one trivial typo below.

> + * Special configuration registers directly in the first few words
> + * in he I/O space.

s/he//

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
