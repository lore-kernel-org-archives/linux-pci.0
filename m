Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Oct 2015 00:31:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, lftan.linux@gmail.com,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v11 3/6] pci:host: Add Altera PCIe host controller driver
Message-ID: <20151023053111.GK21237@localhost>
References: <1445506051-21688-1-git-send-email-lftan@altera.com>
 <1445506051-21688-4-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445506051-21688-4-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ley,

On Thu, Oct 22, 2015 at 05:27:28PM +0800, Ley Foon Tan wrote:
> This patch adds the Altera PCIe host controller driver.

> +static void altera_pcie_fixups(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		altera_pcie_retrain(dev);
> +		altera_pcie_fixup_res(dev);
> +	}
> +}

I'd really like to avoid this particular fixup because it's done
between pci_scan_root_bus() and pci_assign_unassigned_bus_resources()
and pci_bus_add_devices().  That path is almost 100% arch-independent,
and someday we should be able to pull all that out into one PCI core
interface.

You might be able to do the link retrain fixup as a header quirk.
That's not really ideal either, but I don't think we have a good
mechanism of inserting per-host bridge hooks in the enumeration path.
There are some pcibios_*() hooks, but those are per-arch, not per-host
bridge, so they're not really what you want here.

I think other host drivers have handled the "prevent enumeration of
root complex resources" problem by adding a similar check in the
config accessors.

> +static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
> +				 int where, int size, u32 value)

This needs a comment to the effect that this hardware can only generate
32-bit config accesses.  We also need a printk in the probe routine so
there's a note in dmesg so we have a clue that RW1C bits in config space
may be corrupted.

> +{
> +	struct altera_pcie *pcie = bus->sysdata;
> +	u32 data32;
> +	u32 shift = 8 * (where & 3);
> +	u8 byte_en;
> +
> +	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	switch (size) {
> +	case 1:
> +		data32 = (value & 0xff) << shift;
> +		byte_en = 1 << (where & 3);
> +		break;
> +	case 2:
> +		data32 = (value & 0xffff) << shift;
> +		byte_en = 3 << (where & 3);
> +		break;
> +	default:
> +		data32 = value;
> +		byte_en = 0xf;
> +		break;
> +	}
> +
> +	return tlp_cfg_dword_write(pcie, bus->number, devfn,
> +		(where & ~DWORD_MASK), byte_en, data32);
> +}

> +static void altera_pcie_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct altera_pcie *pcie;
> +	unsigned long status;
> +	u32 bit;
> +	u32 virq;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +
> +	while ((status = cra_readl(pcie, P2A_INT_STATUS)
> +		& P2A_INT_STS_ALL) != 0) {
> +		for_each_set_bit(bit, &status, INTX_NUM) {
> +			/* clear interrupts */
> +			cra_writel(pcie, 1 << bit, P2A_INT_STATUS);
> +
> +			virq = irq_find_mapping(pcie->irq_domain, bit + 1);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err(&pcie->pdev->dev, "unexpected IRQ\n");

Include the bit number here.  A printk string with no % substitutions
is rarely as useful as it could be.

> ...
> +	bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
> +				pcie, &pcie->resources);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	altera_pcie_fixups(bus);
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_assign_unassigned_bus_resources(bus);
> +	pci_bus_add_devices(bus);
> +
> +	/* Configure PCI Express setting. */
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);

This loop should be before pci_bus_add_devices().  When we call
pci_bus_add_devices(), drivers may claim devices immediately, and the
PCI core shouldn't be changing device configuration while a driver
owns the device.

Bjorn
