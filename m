Return-Path: <SRS0=v5Vi=2U=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=v5Vi=2U=free.fr=slash.tmp@kernel.org>
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
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
Message-ID: <c0a353cb-aa1f-25db-eccd-7a1618e655b3@free.fr>
Date: Sat, 11 Mar 2017 11:57:56 +0100
MIME-Version: 1.0
In-Reply-To: <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 10/03/2017 18:49, Mason wrote:

> And my current code, to work-around the silicon bugs:
> 
> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <linux/ioport.h>
> #include <linux/of_pci.h>
> #include <linux/of.h>
> #include <linux/pci-ecam.h>
> #include <linux/platform_device.h>
> 
> //#define DEBUG_CONFIG
> 
> static int tango_config_read(struct pci_bus *bus, unsigned int devfn,
> 				    int where, int size, u32 *val)
> {
> 	int ret;
> 	void __iomem *pci_conf = (void *)0xf002e048;
> 
> #ifdef DEBUG_CONFIG
> 	if (where == PCI_BASE_ADDRESS_0)
> 		dump_stack();
> #endif
> 
> 	writel(1, pci_conf);

This sets the config/mem mux to CONFIG SPACE.

> 	if (devfn != 0) {
> 		*val = ~0;
> 		return PCIBIOS_DEVICE_NOT_FOUND;
> 	}

This works around a silicon bug, where accesses to devices or
functions not 0 return garbage.

> 	ret = pci_generic_config_read(bus, devfn, where, size, val);
> 
> 	writel(0, pci_conf);

This resets the config/mem mux back to MEM SPACE.

If anything tries to access MEM in that time frame, we're toast.

> #ifdef DEBUG_CONFIG
> 	printk("%s: bus=%d where=%d size=%d val=0x%x\n",
> 			__func__, bus->number, where, size, *val);
> #endif
> 
> 	return ret;
> }
> 
> static int tango_config_write(struct pci_bus *bus, unsigned int devfn,
> 				     int where, int size, u32 val)
> {
> 	int ret;
> 	void __iomem *pci_conf = (void *)0xf002e048;
> 
> #ifdef DEBUG_CONFIG
> 	if (where == PCI_BASE_ADDRESS_0)
> 		dump_stack();
> #endif
> 
> #ifdef DEBUG_CONFIG
> 	printk("%s: bus=%d where=%d size=%d val=0x%x\n",
> 			__func__, bus->number, where, size, val);
> #endif
> 
> 	writel(1, pci_conf);
> 
> 	ret = pci_generic_config_write(bus, devfn, where, size, val);
> 
> 	writel(0, pci_conf);
> 
> 	return ret;
> }
> 
> static struct pci_ecam_ops tango_pci_ops = {
> 	.bus_shift	= 20,
> 	.pci_ops	= {
> 		.map_bus        = pci_ecam_map_bus,
> 		.read           = tango_config_read,
> 		.write          = tango_config_write,
> 	}
> };
> 
> static const struct of_device_id tango_pci_ids[] = {
> 	{ .compatible = "sigma,smp8759-pcie" },
> 	{ /* sentinel */ },
> };
> 
> static int tango_pci_probe(struct platform_device *pdev)
> {
> 	return pci_host_common_probe(pdev, &tango_pci_ops);
> }
> 
> static struct platform_driver tango_pci_driver = {
> 	.probe = tango_pci_probe,
> 	.driver = {
> 		.name = KBUILD_MODNAME,
> 		.of_match_table = tango_pci_ids,
> 	},
> };
> 
> builtin_platform_driver(tango_pci_driver);
> 
> #define RIESLING_B 0x24
> 
> /* Root complex reports incorrect device class */
> static void tango_pcie_fixup_class(struct pci_dev *dev)
> {
> 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> }
> DECLARE_PCI_FIXUP_EARLY(0x1105, RIESLING_B, tango_pcie_fixup_class);

This works around another silicon bug.

> static void tango_pcie_bar_quirk(struct pci_dev *dev)
> {
> 	struct pci_bus *bus = dev->bus;
> 
> 	printk("%s: bus=%d devfn=%d\n", __func__, bus->number, dev->devfn);
> 
>         pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000004);
> }
> DECLARE_PCI_FIXUP_FINAL(0x1105, PCI_ANY_ID, tango_pcie_bar_quirk);

And this is where the elusive "black magic" happens.

Is it "safe" to configure a BAR behind Linux's back?

Basically, there seems to be an identity map between RAM and PCI space.
(Is that, perhaps, some kind of default? I would think that the default
would have been defined by the "ranges" prop in the pci DT node.)

So PCI address 0x8000_0000 maps to CPU address 0x8000_0000, i.e. the
start of system RAM. And when dev 1 accesses RAM, the RC correctly
forwards the packet to the memory bus.

However, RC BAR0 is limited to 1 GB (split across 8 x 128 MB "region").

Thus, to properly set this up, I need to account for what memory
Linux is managing, i.e. the mem= command line argument.
(I don't know how to access that at run-time.)

For example, if we have 2 x 512 MB of RAM.
DRAM0 is at [0x8000_0000, 0xa000_0000[
DRAM1 is at [0xc000_0000, 0xe000_0000[

But a different situation is 1 x 1 GB of RAM.
DRAM0 is at [0x8000_0000, 0xc000_0000[

I need to program different region targets.
How to do that in a way that is acceptable upstream?

Regards.
