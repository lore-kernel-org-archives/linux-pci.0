Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH v10] PCI: tango: Add MSI controller support
Message-ID: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
Date: Tue, 22 Aug 2017 16:56:01 +0200
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Mason <slash.tmp@free.fr>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The MSI controller in Tango supports 256 message-signaled interrupts
and a single doorbell address.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Changes from v9 to v10
- Start from Bjorn's cleanup branch
- Clean up the MSI init and unused statements
- Based on top of v4.13-rc6

Hello Bjorn,

This patch is almost identical to the patch reviewed by Marc Zyngier
on June 14 (10 weeks ago). I'm not sure he could review this patch
again in time for 4.14 (given his work load these past few weeks).

The host bridge part landed in 4.13, but the driver is useless
without MSI support (legacy interrupts are not supported).
Can you take it for 4.14?

Regards.
---
 drivers/pci/host/pcie-tango.c | 191 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
index 6bbb81f06a53..d672271ad719 100644
--- a/drivers/pci/host/pcie-tango.c
+++ b/drivers/pci/host/pcie-tango.c
@@ -1,12 +1,170 @@
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/pci-ecam.h>
 #include <linux/delay.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 
+#define MSI_MAX			256
+
 #define SMP8759_MUX		0x48
 #define SMP8759_TEST_OUT	0x74
+#define SMP8759_STATUS		0x80
+#define SMP8759_ENABLE		0xa0
+#define SMP8759_DOORBELL	0xa002e07c
 
 struct tango_pcie {
-	void __iomem *base;
+	DECLARE_BITMAP(used_msi, MSI_MAX);
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
+	msg->address_lo = lower_32_bits(SMP8759_DOORBELL);
+	msg->address_hi = upper_32_bits(SMP8759_DOORBELL);
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
@@ -76,7 +234,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct tango_pcie *pcie;
 	struct resource *res;
-	int ret;
+	struct irq_domain *msi_dom, *irq_dom;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	int ret, reg, virq;
 
 	dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data corruption\n");
 	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
@@ -95,6 +255,33 @@ static int tango_pcie_probe(struct platform_device *pdev)
 	if (!tango_pcie_link_up(pcie))
 		return -ENODEV;
 
+	for (reg = 0; reg < MSI_MAX / 8; reg += 4)
+		writel_relaxed(0, pcie->base + SMP8759_ENABLE + reg);
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
+
+	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
+
 	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
 }
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
