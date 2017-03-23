Return-Path: <SRS0=7EXQ=3A=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=7EXQ=3A=free.fr=slash.tmp@kernel.org>
From: Mason <slash.tmp@free.fr>
Subject: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
Date: Thu, 23 Mar 2017 14:05:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

I think this version is ready for review.
It has all the required bits and pieces.
I still have a few questions, embedded as comments in the code.
(Missing are ancillary changes to Kconfig, Makefile)
---
 drivers/pci/host/pcie-tango.c | 350 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 350 insertions(+)
 create mode 100644 drivers/pci/host/pcie-tango.c

diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
new file mode 100644
index 000000000000..b2e6448aed2d
--- /dev/null
+++ b/drivers/pci/host/pcie-tango.c
@@ -0,0 +1,350 @@
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/pci-ecam.h>
+#include <linux/msi.h>
+
+#define MSI_COUNT 32
+
+struct tango_pcie {
+	void __iomem *mux;
+	void __iomem *msi_status;
+	void __iomem *msi_mask;
+	phys_addr_t msi_doorbell;
+	struct mutex lock; /* lock for updating msi_mask */
+	struct irq_domain *irq_domain;
+	struct irq_domain *msi_domain;
+	int irq;
+};
+
+/*** MSI CONTROLLER SUPPORT ***/
+
+static void tango_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct tango_pcie *pcie;
+	unsigned long status, virq;
+	int pos;
+
+	chained_irq_enter(chip, desc);
+	pcie = irq_desc_get_handler_data(desc);
+
+	status = readl_relaxed(pcie->msi_status);
+	writel_relaxed(status, pcie->msi_status); /* clear IRQs */
+
+	for_each_set_bit(pos, &status, MSI_COUNT) {
+		virq = irq_find_mapping(pcie->irq_domain, pos);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			pr_err("Unhandled MSI: %d\n", pos);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static struct irq_chip tango_msi_irq_chip = {
+	.name = "MSI",
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info msi_domain_info = {
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
+	.chip	= &tango_msi_irq_chip,
+};
+
+static void tango_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct tango_pcie *pcie = irq_data_get_irq_chip_data(data);
+
+	msg->address_lo = lower_32_bits(pcie->msi_doorbell);
+	msg->address_hi = upper_32_bits(pcie->msi_doorbell);
+	msg->data = data->hwirq;
+}
+
+static int tango_set_affinity(struct irq_data *irq_data,
+		const struct cpumask *mask, bool force)
+{
+	 return -EINVAL;
+}
+
+static struct irq_chip tango_msi_chip = {
+	.name			= "MSI",
+	.irq_compose_msi_msg	= tango_compose_msi_msg,
+	.irq_set_affinity	= tango_set_affinity,
+};
+
+static int tango_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+		unsigned int nr_irqs, void *args)
+{
+	struct tango_pcie *pcie = domain->host_data;
+	int pos, err = 0;
+	u32 mask;
+
+	if (nr_irqs != 1) /* When does that happen? */
+		return -EINVAL;
+
+	mutex_lock(&pcie->lock);
+
+	mask = readl_relaxed(pcie->msi_mask);
+	pos = find_first_zero_bit(&mask, MSI_COUNT);
+	if (pos < MSI_COUNT)
+		writel(mask | BIT(pos), pcie->msi_mask);
+	else
+		err = -ENOSPC;
+
+	mutex_unlock(&pcie->lock);
+
+	irq_domain_set_info(domain, virq, pos, &tango_msi_chip,
+			domain->host_data, handle_simple_irq, NULL, NULL);
+
+	return err;
+}
+
+static void tango_irq_domain_free(struct irq_domain *domain,
+				   unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct tango_pcie *pcie = irq_data_get_irq_chip_data(d);
+	int pos = d->hwirq;
+	u32 mask;
+
+	mutex_lock(&pcie->lock);
+
+	mask = readl(pcie->msi_mask);
+	writel(mask & ~BIT(pos), pcie->msi_mask);
+
+	mutex_unlock(&pcie->lock);
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= tango_irq_domain_alloc,
+	.free	= tango_irq_domain_free,
+};
+
+static int tango_msi_remove(struct platform_device *pdev)
+{
+	struct tango_pcie *msi = platform_get_drvdata(pdev);
+
+	irq_set_chained_handler(msi->irq, NULL);
+	irq_set_handler_data(msi->irq, NULL);
+	/* irq_set_chained_handler_and_data(msi->irq, NULL, NULL); instead? */
+
+	irq_domain_remove(msi->msi_domain);
+	irq_domain_remove(msi->irq_domain);
+
+	return 0;
+}
+
+static int tango_msi_probe(struct platform_device *pdev, struct tango_pcie *pcie)
+{
+	int virq;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
+	struct irq_domain *msi_dom, *irq_dom;
+
+	mutex_init(&pcie->lock);
+	writel(0, pcie->msi_mask);
+
+	/* Why is fwnode for this call? */
+	irq_dom = irq_domain_add_linear(NULL, MSI_COUNT, &msi_domain_ops, pcie);
+	if (!irq_dom) {
+		pr_err("Failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi_dom = pci_msi_create_irq_domain(fwnode, &msi_domain_info, irq_dom);
+	if (!msi_dom) {
+		pr_err("Failed to create MSI domain\n");
+		irq_domain_remove(irq_dom);
+		return -ENOMEM;
+	}
+
+	virq = platform_get_irq(pdev, 1);
+	if (virq <= 0) {
+		irq_domain_remove(msi_dom);
+		irq_domain_remove(irq_dom);
+		return -ENXIO;
+	}
+
+	pcie->irq_domain = irq_dom;
+	pcie->msi_domain = msi_dom;
+	pcie->irq = virq;
+	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
+
+	return 0;
+}
+
+/*** HOST BRIDGE SUPPORT ***/
+
+static int smp8759_config_read(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *val)
+{
+	int ret;
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
+
+	/*
+	 * QUIRK #1
+	 * Reads in configuration space outside devfn 0 return garbage.
+	 */
+	if (devfn != 0) {
+		*val = 0xffffffff; /* ~0 means "nothing here" right? */
+		return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
+	}
+
+	/*
+	 * QUIRK #2
+	 * The root complex advertizes a fake BAR, which is used to filter
+	 * bus-to-system requests. Hide it from Linux.
+	 */
+	if (where == PCI_BASE_ADDRESS_0 && bus->number == 0) {
+		*val = 0; /* 0 or ~0 to hide the BAR from Linux? */
+		return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
+	}
+
+	/*
+	 * QUIRK #3
+	 * Unfortunately, config and mem spaces are muxed.
+	 * Linux does not support such a setting, since drivers are free
+	 * to access mem space directly, at any time.
+	 * Therefore, we can only PRAY that config and mem space accesses
+	 * NEVER occur concurrently.
+	 */
+	writel(1, pcie->mux);
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
+	writel(0, pcie->mux);
+
+	return ret;
+}
+
+static int smp8759_config_write(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 val)
+{
+	int ret;
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
+
+	writel(1, pcie->mux);
+	ret = pci_generic_config_write(bus, devfn, where, size, val);
+	writel(0, pcie->mux);
+
+	return ret;
+}
+
+static struct pci_ecam_ops smp8759_ecam_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= smp8759_config_read,
+		.write		= smp8759_config_write,
+	}
+};
+
+static const struct of_device_id tango_pcie_ids[] = {
+	{ .compatible = "sigma,smp8759-pcie" },
+	{ .compatible = "sigma,rev2-pcie" },
+	{ /* sentinel */ },
+};
+
+static void smp8759_init(struct tango_pcie *pcie, void __iomem *base)
+{
+	pcie->mux		= base + 0x48;
+	pcie->msi_status	= base + 0x80;
+	pcie->msi_mask		= base + 0xa0;
+	pcie->msi_doorbell	= 0xa0000000 + 0x2e07c;
+}
+
+static void rev2_init(struct tango_pcie *pcie, void __iomem *base)
+{
+	void __iomem *misc_irq	= base + 0x40;
+	void __iomem *doorbell	= base + 0x8c;
+
+	pcie->mux		= base + 0x2c;
+	pcie->msi_status	= base + 0x4c;
+	pcie->msi_mask		= base + 0x6c;
+	pcie->msi_doorbell	= 0x80000000;
+
+	writel(lower_32_bits(pcie->msi_doorbell), doorbell + 0);
+	writel(upper_32_bits(pcie->msi_doorbell), doorbell + 4);
+
+	/* Enable legacy PCI interrupts */
+	writel(BIT(15), misc_irq);
+	writel(0xf << 4, misc_irq + 4);
+}
+
+static int tango_pcie_probe(struct platform_device *pdev)
+{
+	int ret;
+	void __iomem *base;
+	struct resource *res;
+	struct tango_pcie *pcie;
+	struct device *dev = &pdev->dev;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pcie);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (of_device_is_compatible(dev->of_node, "sigma,smp8759-pcie"))
+		smp8759_init(pcie, base);
+
+	if (of_device_is_compatible(dev->of_node, "sigma,rev2-pcie"))
+		rev2_init(pcie, base);
+
+	ret = tango_msi_probe(pdev, pcie);
+	if (ret)
+		return ret;
+
+	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
+}
+
+static int tango_pcie_remove(struct platform_device *pdev)
+{
+	return tango_msi_remove(pdev);
+}
+
+static struct platform_driver tango_pcie_driver = {
+	.probe	= tango_pcie_probe,
+	.remove	= tango_pcie_remove,
+	.driver	= {
+		.name = KBUILD_MODNAME,
+		.of_match_table = tango_pcie_ids,
+	},
+};
+
+/*
+ * This should probably be module_platform_driver ?
+ */
+builtin_platform_driver(tango_pcie_driver);
+
+#define VENDOR_SIGMA	0x1105
+
+/*
+ * QUIRK #4
+ * The root complex advertizes the wrong device class.
+ * Header Type 1 is for PCI-to-PCI bridges.
+ */
+static void tango_fixup_class(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_class);
+
+/*
+ * QUIRK #5
+ * Only transfers within the root complex BAR are forwarded to the host.
+ * By default, the DMA framework expects that
+ * PCI address 0x8000_0000 maps to system address 0x8000_0000
+ * which is where DRAM0 is mapped.
+ */
+static void tango_fixup_bar(struct pci_dev *dev)
+{
+        pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
+}
+DECLARE_PCI_FIXUP_FINAL(VENDOR_SIGMA, PCI_ANY_ID, tango_fixup_bar);
-- 
2.11.0
