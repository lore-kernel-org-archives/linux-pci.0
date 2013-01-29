Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59475 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab3A2NWJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 08:22:09 -0500
Date: Tue, 29 Jan 2013 13:22:04 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129132204.GA23886@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
In-Reply-To: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 06:56:28PM +0000, Thomas Petazzoni wrote:
> This driver implements the support for the PCIe interfaces on the
> Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
> cover earlier families of Marvell SoCs, such as Dove, Orion and
> Kirkwood.
> 
> The driver implements the hw_pci operations needed by the core ARM PCI
> code to setup PCI devices and get their corresponding IRQs, and the
> pci_ops operations that are used by the PCI core to read/write the
> configuration space of PCI devices.
> 
> Since the PCIe interfaces of Marvell SoCs are completely separate and
> not linked together in a bus, this driver sets up an emulated PCI host
> bridge, with one PCI-to-PCI bridge as child for each hardware PCIe
> interface.
> 
> In addition, this driver enumerates the different PCIe slots, and for
> those having a device plugged in, it sets up the necessary address
> decoding windows, using the new armada_370_xp_alloc_pcie_window()
> function from mach-mvebu/addr-map.c.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

[snip]

> +static int __init mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{

[snip]

> +
> +       /*
> +        * Build an laddr array that describes the PCI device in a DT
> +        * way
> +        */
> +       laddr[0] = cpu_to_be32(port->devfn << 8);
> +       laddr[1] = laddr[2] = 0;
> +       intspec = cpu_to_be32(pin);
> +
> +       ret = of_irq_map_raw(port->dn, &intspec, 1, laddr, &oirq);
> +       if (ret) {
> +               dev_err(&pcie->pdev->dev,
> +                       "%s: of_irq_map_raw() failed, %d\n",
> +                       __func__, ret);
> +               return ret;
> +       }

Are you able to replace the above code with a call to of_irq_map_pci? I'm not
sure which approach is better. The of_irq_map_pci function doesn't require the
pin argument and instead uses the DT and/or performs its own pin swizzling. I
guess this means that if there are PCIe devices in the DT tree that does any
thing strange with pins then it would be reflected in the IRQ you get. I've
found that you will also need to provide an implementation of
pcibios_get_phb_of_node for this to work correctly (see my RFC bios32 patch).

> +
> +       return irq_create_of_mapping(oirq.controller, oirq.specifier,
> +                                    oirq.size);
> +}



> +static int mvebu_pcie_enable(struct mvebu_pcie *pcie)
> +{
> +       struct hw_pci hw;

[snip]

> +       pci_common_init(&hw);
> +
> +       return mvebu_pcie_window_config(pcie);
> +}
> +
> +static int __init mvebu_pcie_probe(struct platform_device *pdev)
> +{

[snip]

> +
> +       mvebu_pcie_enable(pcie);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mvebu_pcie_of_match_table[] = {
> +       { .compatible = "marvell,armada-370-xp-pcie", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
> +
> +static struct platform_driver mvebu_pcie_driver = {
> +       .driver = {
> +               .owner = THIS_MODULE,
> +               .name = "mvebu-pcie",
> +               .of_match_table =
> +                  of_match_ptr(mvebu_pcie_of_match_table),
> +       },
> +};
> +
> +static int mvebu_pcie_init(void)
> +{
> +       return platform_driver_probe(&mvebu_pcie_driver,
> +                                    mvebu_pcie_probe);
> +}

If you have multiple 'mvebu-pcie' in your DT then you will end up
with multiple calls to
mvebu_pcie_probe/mvebu_pcie_enable/pci_common_init.

However pci_common_init/pcibios_init_hw assumes it will only ever be called
once, and will thus result in trying to create multiple busses with the same
bus number. (The first root bus it creates is always zero provided you haven't
implemented hw->scan).

I noticed this in Thierry's patch set and posted an RFC patch which overcomes
this issue (patchwork.kernel.org/patch/2001171) and others. Perhaps you would
want to include this in your patchset?

Andrew Murray

