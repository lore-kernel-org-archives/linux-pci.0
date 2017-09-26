Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [RESEND PATCH v11 3/3] PCI: tango: Add MSI controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Marc Zyngier
 <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Mason <slash.tmp@free.fr>
References: <93a30f88-17e1-af14-0c50-54f829c1158b@free.fr>
Message-ID: <c47a6f46-d5da-d61a-fddd-983621f0f462@free.fr>
Date: Tue, 26 Sep 2017 12:27:39 +0200
MIME-Version: 1.0
In-Reply-To: <93a30f88-17e1-af14-0c50-54f829c1158b@free.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

The MSI controller in Tango supports 256 message-signaled interrupts
and a single doorbell address.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/pci/host/pcie-tango.c | 205 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
index 6bbb81f06a53..e23f7383ac33 100644
--- a/drivers/pci/host/pcie-tango.c
+++ b/drivers/pci/host/pcie-tango.c
@@ -1,12 +1,172 @@
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/pci-ecam.h>
 #include <linux/delay.h>
-#include <linux/of.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+
+#define MSI_MAX			256
 
 #define SMP8759_MUX		0x48
 #define SMP8759_TEST_OUT	0x74
+#define SMP8759_DOORBELL	0x7c
+#define SMP8759_STATUS		0x80
+#define SMP8759_ENABLE		0xa0
 
 struct tango_pcie {
-	void __iomem *base;
+	DECLARE_BITMAP(used_msi, MSI_MAX);
+	u64			msi_doorbell;
+	spinlock_t		used_msi_lock;
+	void __iomem		*base;
+	struct irq_domain	*dom;
+};
+
+static void tango_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct tango_pcie *pcie = irq_desc_get_handler_data(desc);
+	unsigned long status, base, virq, idx, pos = 0;
+
+	chained_irq_enter(chip, desc);
+	spin_lock(&pcie->used_msi_lock);
+
+	while ((pos = find_next_bit(pcie->used_msi, MSI_MAX, pos)) < MSI_MAX) {
+		base = round_down(pos, 32);
+		status = readl_relaxed(pcie->base + SMP8759_STATUS + base / 8);
+		for_each_set_bit(idx, &status, 32) {
+			virq = irq_find_mapping(pcie->dom, base + idx);
+			generic_handle_irq(virq);
+		}
+		pos = base + 32;
+	}
+
+	spin_unlock(&pcie->used_msi_lock);
+	chained_irq_exit(chip, desc);
+}
+
+static void tango_ack(struct irq_data *d)
+{
+	struct tango_pcie *pcie = d->chip_data;
+	u32 offset = (d->hwirq / 32) * 4;
+	u32 bit = BIT(d->hwirq % 32);
+
+	writel_relaxed(bit, pcie->base + SMP8759_STATUS + offset);
+}
+
+static void update_msi_enable(struct irq_data *d, bool unmask)
+{
+	unsigned long flags;
+	struct tango_pcie *pcie = d->chip_data;
+	u32 offset = (d->hwirq / 32) * 4;
+	u32 bit = BIT(d->hwirq % 32);
+	u32 val;
+
+	spin_lock_irqsave(&pcie->used_msi_lock, flags);
+	val = readl_relaxed(pcie->base + SMP8759_ENABLE + offset);
+	val = unmask ? val | bit : val & ~bit;
+	writel_relaxed(val, pcie->base + SMP8759_ENABLE + offset);
+	spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+}
+
+static void tango_mask(struct irq_data *d)
+{
+	update_msi_enable(d, false);
+}
+
+static void tango_unmask(struct irq_data *d)
+{
+	update_msi_enable(d, true);
+}
+
+static int tango_set_affinity(struct irq_data *d, const struct cpumask *mask,
+			      bool force)
+{
+	return -EINVAL;
+}
+
+static void tango_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct tango_pcie *pcie = d->chip_data;
+	msg->address_lo = lower_32_bits(pcie->msi_doorbell);
+	msg->address_hi = upper_32_bits(pcie->msi_doorbell);
+	msg->data = d->hwirq;
+}
+
+static struct irq_chip tango_chip = {
+	.irq_ack		= tango_ack,
+	.irq_mask		= tango_mask,
+	.irq_unmask		= tango_unmask,
+	.irq_set_affinity	= tango_set_affinity,
+	.irq_compose_msi_msg	= tango_compose_msi_msg,
+};
+
+static void msi_ack(struct irq_data *d)
+{
+	irq_chip_ack_parent(d);
+}
+
+static void msi_mask(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void msi_unmask(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip msi_chip = {
+	.name = "MSI",
+	.irq_ack = msi_ack,
+	.irq_mask = msi_mask,
+	.irq_unmask = msi_unmask,
+};
+
+static struct msi_domain_info msi_dom_info = {
+	.flags	= MSI_FLAG_PCI_MSIX
+		| MSI_FLAG_USE_DEF_DOM_OPS
+		| MSI_FLAG_USE_DEF_CHIP_OPS,
+	.chip	= &msi_chip,
+};
+
+static int tango_irq_domain_alloc(struct irq_domain *dom, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
+{
+	struct tango_pcie *pcie = dom->host_data;
+	unsigned long flags;
+	int pos;
+
+	spin_lock_irqsave(&pcie->used_msi_lock, flags);
+	pos = find_first_zero_bit(pcie->used_msi, MSI_MAX);
+	if (pos >= MSI_MAX) {
+		spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+		return -ENOSPC;
+	}
+	__set_bit(pos, pcie->used_msi);
+	spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+	irq_domain_set_info(dom, virq, pos, &tango_chip,
+			pcie, handle_edge_irq, NULL, NULL);
+
+	return 0;
+}
+
+static void tango_irq_domain_free(struct irq_domain *dom, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	unsigned long flags;
+	struct irq_data *d = irq_domain_get_irq_data(dom, virq);
+	struct tango_pcie *pcie = d->chip_data;
+
+	spin_lock_irqsave(&pcie->used_msi_lock, flags);
+	__clear_bit(d->hwirq, pcie->used_msi);
+	spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
+}
+
+static const struct irq_domain_ops dom_ops = {
+	.alloc	= tango_irq_domain_alloc,
+	.free	= tango_irq_domain_free,
 };
 
 static int smp8759_config_read(struct pci_bus *bus, unsigned int devfn,
@@ -76,7 +236,11 @@ static int tango_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct tango_pcie *pcie;
 	struct resource *res;
-	int ret;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct irq_domain *msi_dom, *irq_dom;
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+	int virq, offset;
 
 	dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data corruption\n");
 	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
@@ -95,6 +259,41 @@ static int tango_pcie_probe(struct platform_device *pdev)
 	if (!tango_pcie_link_up(pcie))
 		return -ENODEV;
 
+	if (of_pci_dma_range_parser_init(&parser, dev->of_node) < 0)
+		return -ENOENT;
+
+	if (of_pci_range_parser_one(&parser, &range) == NULL)
+		return -ENOENT;
+
+	range.pci_addr += range.size;
+	pcie->msi_doorbell = range.pci_addr + res->start + SMP8759_DOORBELL;
+
+	for (offset = 0; offset < MSI_MAX / 8; offset += 4)
+		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
+
+	virq = platform_get_irq(pdev, 1);
+	if (virq <= 0) {
+		dev_err(dev, "Failed to map IRQ\n");
+		return -ENXIO;
+	}
+
+	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
+	if (!irq_dom) {
+		dev_err(dev, "Failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi_dom = pci_msi_create_irq_domain(fwnode, &msi_dom_info, irq_dom);
+	if (!msi_dom) {
+		dev_err(dev, "Failed to create MSI domain\n");
+		irq_domain_remove(irq_dom);
+		return -ENOMEM;
+	}
+
+	pcie->dom = irq_dom;
+	spin_lock_init(&pcie->used_msi_lock);
+	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
+
 	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
 }
 
-- 
2.11.0
