Return-Path: <SRS0=1EYN=2T=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=1EYN=2T=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
Message-ID: <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
Date: Fri, 10 Mar 2017 18:49:13 +0100
MIME-Version: 1.0
In-Reply-To: <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 10/03/2017 17:45, Mason wrote:

> Time to clean up a million hacks to be able to discuss the finer points.

Here is my current boot log:

[    1.133895] OF: PCI: host bridge /soc/pcie@50000000 ranges:
[    1.139607] pci_add_resource_offset: res=[bus 00-0f] offset=0x0
[    1.145659] OF: PCI: Parsing ranges property...
[    1.150316] OF: PCI:   MEM 0x54000000..0x5fffffff -> 0x04000000
[    1.156364] pci_add_resource_offset: res=[mem 0x54000000-0x5fffffff] offset=0x50000000
[    1.164628] pci_tango 50000000.pcie: ECAM at [mem 0x50000000-0x50ffffff] for [bus 00-0f]
[    1.173033] pci_tango 50000000.pcie: PCI host bridge to bus 0000:00
[    1.179440] pci_bus 0000:00: root bus resource [bus 00-0f]
[    1.185056] pci_bus 0000:00: root bus resource [mem 0x54000000-0x5fffffff] (bus address [0x04000000-0x0fffffff])
[    1.195386] pci_bus 0000:00: scanning bus
[    1.199539] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
[    1.205691] pci 0000:00:00.0: calling tango_pcie_fixup_class+0x0/0x10
[    1.212277] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x3fffffff 64bit]
[    1.219220] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.225570] pci 0000:00:00.0: supports D1 D2
[    1.229957] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.236092] pci 0000:00:00.0: PME# disabled
[    1.240576] pci_bus 0000:00: fixups for bus
[    1.244886] PCI: bus0: Fast back to back transfers disabled
[    1.250587] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    1.257420] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.265567] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    1.272517] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-0f] (conflicts with (null) [bus 00-0f])
[    1.283462] pci_bus 0000:01: scanning bus
[    1.287623] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.293799] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.300799] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40
[    1.307223] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    1.313446] pci 0000:01:00.0: PME# disabled
[    1.318053] pci_bus 0000:01: fixups for bus
[    1.322362] PCI: bus1: Fast back to back transfers disabled
[    1.328060] pci_bus 0000:01: bus scan returning with max=01
[    1.333759] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.340506] pci_bus 0000:00: bus scan returning with max=01
[    1.346205] pci 0000:00:00.0: fixup irq: got 0
[    1.350765] pci 0000:00:00.0: assigning IRQ 00
[    1.355332] pci 0000:01:00.0: fixup irq: got 0
[    1.359892] pci 0000:01:00.0: assigning IRQ 00
[    1.364479] pci 0000:00:00.0: BAR 0: no space for [mem size 0x40000000 64bit]
[    1.371748] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x40000000 64bit]
[    1.379369] pci 0000:00:00.0: BAR 8: assigned [mem 0x54000000-0x540fffff]
[    1.386291] pci 0000:01:00.0: BAR 0: assigned [mem 0x54000000-0x54001fff 64bit]
[    1.393747] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.398833] pci 0000:00:00.0:   bridge window [mem 0x54000000-0x540fffff]
[    1.405767] pci 0000:00:00.0: calling tango_pcie_bar_quirk+0x0/0x40
[    1.412160] tango_pcie_bar_quirk: bus=0 devfn=0
[    1.416843] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    1.423074] pcieport 0000:00:00.0: enabling bus mastering
[    1.428652] altera_irq_domain_alloc: ENTER
[    1.432876] FOO-msi 2e080.msi: msi#0 address_hi 0x0 address_lo 0x9002e07c
[    1.440007] FOO-msi 2e080.msi: msi#0 address_hi 0x0 address_lo 0x9002e07c
[    1.446972] aer 0000:00:00.0:pcie002: service driver aer loaded
[    1.453157] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x7e0
[    1.459913] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    1.465709] quirk_usb_handoff_xhci: ioremap(0x54000000, 8192)
[    1.471589] xhci_find_next_ext_cap: offset=0x500
[    1.476325] val = 0x1000401
...
[    1.624093] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.630675] ehci-pci: EHCI PCI platform driver
[    1.635338] xhci_hcd 0000:01:00.0: enabling bus mastering
[    1.640789] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.646071] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.659065] xhci_find_next_ext_cap: offset=0x500
[    1.663714] val = 0x1000401
[    1.666526] xhci_find_next_ext_cap: offset=0x510
[    1.671171] val = 0x3000502
[    1.673984] xhci_find_next_ext_cap: offset=0x510
[    1.678632] val = 0x3000502
[    1.681433] xhci_find_next_ext_cap: offset=0x524
[    1.686079] val = 0x2000702
[    1.688888] xhci_find_next_ext_cap: offset=0x524
[    1.693533] val = 0x2000702
[    1.696343] xhci_find_next_ext_cap: offset=0x540
[    1.700987] val = 0x4c0
[    1.703446] xhci_find_next_ext_cap: offset=0x550
[    1.708091] val = 0xa
[    1.710382] xhci_find_next_ext_cap: offset=0x510
[    1.715028] val = 0x3000502
[    1.717837] xhci_find_next_ext_cap: offset=0x524
[    1.722482] val = 0x2000702
[    1.725304] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    1.733801] xhci_hcd 0000:01:00.0: enabling Mem-Wr-Inval
[    1.739222] altera_irq_domain_alloc: ENTER
[    1.743393] altera_irq_domain_alloc: ENTER
[    1.747543] altera_irq_domain_alloc: ENTER
[    1.751674] FOO-msi 2e080.msi: msi#1 address_hi 0x0 address_lo 0x9002e07c
[    1.758514] FOO-msi 2e080.msi: msi#2 address_hi 0x0 address_lo 0x9002e07c
[    1.765347] FOO-msi 2e080.msi: msi#3 address_hi 0x0 address_lo 0x9002e07c
[    1.772229] FOO-msi 2e080.msi: msi#1 address_hi 0x0 address_lo 0x9002e07c
[    1.779098] FOO-msi 2e080.msi: msi#2 address_hi 0x0 address_lo 0x9002e07c
[    1.785957] FOO-msi 2e080.msi: msi#3 address_hi 0x0 address_lo 0x9002e07c
[    1.792979] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.799817] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.807085] usb usb1: Product: xHCI Host Controller
[    1.811994] usb usb1: Manufacturer: Linux 4.9.7-1-rc2 xhci-hcd
[    1.817863] usb usb1: SerialNumber: 0000:01:00.0
[    1.823072] hub 1-0:1.0: USB hub found
[    1.826890] hub 1-0:1.0: 4 ports detected
[    1.831199] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.836473] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    1.843925] cmd=c8852020 status=c8852024
[    1.847946] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.856168] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.863004] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.870275] usb usb2: Product: xHCI Host Controller
[    1.875185] usb usb2: Manufacturer: Linux 4.9.7-1-rc2 xhci-hcd
[    1.881055] usb usb2: SerialNumber: 0000:01:00.0
[    1.886151] hub 2-0:1.0: USB hub found
[    1.889964] hub 2-0:1.0: 4 ports detected
[    1.894660] usbcore: registered new interface driver usb-storage


And when I insert/remove my Flash drive:

[  216.216744] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
[  216.250189] usb 2-1: New USB device found, idVendor=0951, idProduct=1666
[  216.256945] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  216.264130] usb 2-1: Product: DataTraveler 3.0
[  216.268607] usb 2-1: Manufacturer: Kingston
[  216.272821] usb 2-1: SerialNumber: 002618887865F0C0F8646BFA
[  216.283005] usb-storage 2-1:1.0: USB Mass Storage device detected
[  216.289492] scsi host0: usb-storage 2-1:1.0
[  217.299474] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[  217.309981] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[  217.320354] sd 0:0:0:0: [sda] Write Protect is off
[  217.325722] sd 0:0:0:0: [sda] Mode Sense: 4f 00 00 00
[  217.331333] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  217.343691]  sda: sda1
[  217.347819] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  217.371940] random: fast init done
[  217.547108] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.

[  244.509391] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: id=0000
[  244.517478] pcieport 0000:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0000(Requester ID)
[  244.529525] pcieport 0000:00:00.0:   device [1105:0024] error status/mask=00004000/00000000
[  244.538033] pcieport 0000:00:00.0:    [14] Completion Timeout     (First)
[  244.544940] pcieport 0000:00:00.0: broadcast error_detected message
[  244.551301] pcieport 0000:00:00.0: AER: Device recovery failed
[  244.828674] xhci_hcd 0000:01:00.0: Cannot set link state.
[  244.834177] usb usb2-port1: cannot disable (err = -32)
[  244.839359] usb 2-1: USB disconnect, device number 2

Hmmm, that sounds fishy.


# cat /proc/interrupts 
           CPU0       CPU1       
 19:       1958       2212     GIC-0  29 Edge      twd
 20:        107          0      irq0   1 Level     serial
 25:          1          0  PCIe MSI   0 Edge      aerdrv
 27:        471          0  PCIe MSI 524288 Edge      xhci_hcd
 28:          0          0  PCIe MSI 524289 Edge      xhci_hcd
 29:          0          0  PCIe MSI 524290 Edge      xhci_hcd
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:       1094       2376  Rescheduling interrupts
IPI3:          0        132  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          1          0  IRQ work interrupts
IPI6:          0          0  completion interrupts
Err:          0

The MSI indices look fishy.
524288 = 0x80000
Not sure where that come from.


# /usr/sbin/lspci -v
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Memory at <ignored> (64-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 04000000-040fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [50] MSI: Enable+ Count=1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Flags: bus master, fast devsel, latency 0
        Memory at 54000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting
        Kernel driver in use: xhci_hcd


Still some weirdness here.
I might be using too old a version: lspci version 3.2.1


And my current code, to work-around the silicon bugs:

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/ioport.h>
#include <linux/of_pci.h>
#include <linux/of.h>
#include <linux/pci-ecam.h>
#include <linux/platform_device.h>

//#define DEBUG_CONFIG

static int tango_config_read(struct pci_bus *bus, unsigned int devfn,
				    int where, int size, u32 *val)
{
	int ret;
	void __iomem *pci_conf = (void *)0xf002e048;

#ifdef DEBUG_CONFIG
	if (where == PCI_BASE_ADDRESS_0)
		dump_stack();
#endif

	writel(1, pci_conf);

	if (devfn != 0) {
		*val = ~0;
		return PCIBIOS_DEVICE_NOT_FOUND;
	}

	ret = pci_generic_config_read(bus, devfn, where, size, val);

	writel(0, pci_conf);

#ifdef DEBUG_CONFIG
	printk("%s: bus=%d where=%d size=%d val=0x%x\n",
			__func__, bus->number, where, size, *val);
#endif

	return ret;
}

static int tango_config_write(struct pci_bus *bus, unsigned int devfn,
				     int where, int size, u32 val)
{
	int ret;
	void __iomem *pci_conf = (void *)0xf002e048;

#ifdef DEBUG_CONFIG
	if (where == PCI_BASE_ADDRESS_0)
		dump_stack();
#endif

#ifdef DEBUG_CONFIG
	printk("%s: bus=%d where=%d size=%d val=0x%x\n",
			__func__, bus->number, where, size, val);
#endif

	writel(1, pci_conf);

	ret = pci_generic_config_write(bus, devfn, where, size, val);

	writel(0, pci_conf);

	return ret;
}

static struct pci_ecam_ops tango_pci_ops = {
	.bus_shift	= 20,
	.pci_ops	= {
		.map_bus        = pci_ecam_map_bus,
		.read           = tango_config_read,
		.write          = tango_config_write,
	}
};

static const struct of_device_id tango_pci_ids[] = {
	{ .compatible = "sigma,smp8759-pcie" },
	{ /* sentinel */ },
};

static int tango_pci_probe(struct platform_device *pdev)
{
	return pci_host_common_probe(pdev, &tango_pci_ops);
}

static struct platform_driver tango_pci_driver = {
	.probe = tango_pci_probe,
	.driver = {
		.name = KBUILD_MODNAME,
		.of_match_table = tango_pci_ids,
	},
};

builtin_platform_driver(tango_pci_driver);

#define RIESLING_B 0x24

/* Root complex reports incorrect device class */
static void tango_pcie_fixup_class(struct pci_dev *dev)
{
	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
}
DECLARE_PCI_FIXUP_EARLY(0x1105, RIESLING_B, tango_pcie_fixup_class);

static void tango_pcie_bar_quirk(struct pci_dev *dev)
{
	struct pci_bus *bus = dev->bus;

	printk("%s: bus=%d devfn=%d\n", __func__, bus->number, dev->devfn);

        pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000004);
}
DECLARE_PCI_FIXUP_FINAL(0x1105, PCI_ANY_ID, tango_pcie_bar_quirk);


Regards.
