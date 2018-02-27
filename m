Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45077 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeB0MVA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 07:21:00 -0500
Received: by mail-pf0-f193.google.com with SMTP id j24so7857700pff.12
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2018 04:21:00 -0800 (PST)
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marc.zyngier@arm.com
Cc: mingkai.hu@nxp.com, peter.newton@nxp.com, minghuan.lian@nxp.com,
        rajesh.raina@nxp.com, rajan.kapoor@nxp.com, prabhjot.singh@nxp.com,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH v6 3/3] PCI: mobiveil: Add MSI support for Mobiveil PCIe Host Bridge IP driver
Date: Tue, 27 Feb 2018 07:20:51 -0500
Message-Id: <1519734051-32298-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Adds MSI support for Mobiveil PCIe Host Bridge IP driver

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org
---
Fixes:
- used relaxed device access apis
- removed memory allocation of kernel buffer for MSI data, using the
  MSI register base instead.
- removed redundant CONFIG_PCI_MSI checks
---
 drivers/pci/host/pcie-mobiveil.c | 204 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/host/pcie-mobiveil.c
index 4270387..4b92dc0 100644
--- a/drivers/pci/host/pcie-mobiveil.c
+++ b/drivers/pci/host/pcie-mobiveil.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -56,6 +57,7 @@
 #define PAB_INTP_AMBA_MISC_ENB	0x0b0c
 #define PAB_INTP_AMBA_MISC_STAT	0x0b1c
 #define  PAB_INTP_INTX_MASK	0x1e0
+#define  PAB_INTP_MSI_MASK      0x8
 
 #define PAB_AXI_AMAP_CTRL(win)	PAB_REG_ADDR(0x0ba0, win)
 #define  WIN_ENABLE_SHIFT	0
@@ -85,8 +87,19 @@
 
 /* supported number of interrupts */
 #define PCI_NUM_INTX    4
+#define PCI_NUM_MSI		16
 #define PAB_INTA_POS    5
 
+/* MSI registers */
+#define MSI_BASE_LO_OFFSET	0x04
+#define MSI_BASE_HI_OFFSET	0x08
+#define MSI_SIZE_OFFSET		0x0c
+#define MSI_ENABLE_OFFSET	0x14
+#define MSI_STATUS_OFFSET	0x18
+#define MSI_DATA_OFFSET		0x20
+#define MSI_ADDR_L_OFFSET	0x24
+#define MSI_ADDR_H_OFFSET	0x28
+
 /* outbound and inbound window definitions */
 #define WIN_NUM_0		0
 #define WIN_NUM_1		1
@@ -101,11 +114,21 @@
 #define LINK_WAIT_MIN		90000
 #define LINK_WAIT_MAX		100000
 
+struct mobiveil_msi {			/* MSI information */
+	struct mutex lock;		/* protect bitmap variable */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	phys_addr_t msi_pages_phys;
+	int num_of_vectors;
+	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
+};
+
 struct mobiveil_pcie {
 	struct platform_device *pdev;
 	struct list_head resources;
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	void __iomem *csr_axi_slave_base;   /* root port config base */
+	void __iomem *apb_csr_base;     /* MSI register base */
 	void __iomem *pcie_reg_base;    /* Physical PCIe Controller Base */
 	struct irq_domain *intx_domain;
 	raw_spinlock_t intx_mask_lock;
@@ -116,6 +139,7 @@ struct mobiveil_pcie {
 	int ib_wins_configured;	/*  configured inbound windows */
 	struct resource *ob_io_res;
 	char root_bus_nr;
+	struct mobiveil_msi msi;
 };
 
 static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
@@ -204,6 +228,9 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
 	struct device *dev = &pcie->pdev->dev;
+	struct mobiveil_msi *msi = &pcie->msi;
+	u32 msi_data, msi_addr_lo, msi_addr_hi;
+	u32 intr_status, msi_status;
 	unsigned long shifted_status;
 	u32 bit, virq;
 	u32 val, mask;
@@ -222,8 +249,8 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
-		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
-			PAB_INTA_POS;
+		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT)
+			>> PAB_INTA_POS;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
 				virq = irq_find_mapping(pcie->intx_domain,
@@ -241,6 +268,39 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		} while ((shifted_status >>  PAB_INTA_POS) != 0);
 	}
 
+	/* read extra MSI status register */
+	msi_status = readl_relaxed(pcie->apb_csr_base + MSI_STATUS_OFFSET);
+
+	/* handle MSI interrupts */
+	if ((intr_status & PAB_INTP_MSI_MASK) || (msi_status & 1)) {
+		do {
+			msi_data = readl_relaxed(pcie->apb_csr_base
+					+ MSI_DATA_OFFSET);
+
+			/*
+			 * MSI_STATUS_OFFSET gets updated to zero once we have
+			 * popped not only the data but also address from MSI
+			 * hardware FIFO.so keeping these following two dummy
+			 * reads.
+			 */
+			msi_addr_lo = readl_relaxed(pcie->apb_csr_base +
+					MSI_ADDR_L_OFFSET);
+			msi_addr_hi = readl_relaxed(pcie->apb_csr_base +
+					MSI_ADDR_H_OFFSET);
+			dev_dbg(dev,
+				"MSI registers, data: %08x, addr: %08x:%08x\n",
+				msi_data, msi_addr_hi, msi_addr_lo);
+
+				virq = irq_find_mapping(msi->dev_domain,
+					msi_data);
+				if (virq)
+					generic_handle_irq(virq);
+
+			msi_status = readl_relaxed(pcie->apb_csr_base +
+					MSI_STATUS_OFFSET);
+		} while (msi_status & 1);
+	}
+
 	/* Clear the interrupt status */
 	csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
 	chained_irq_exit(chip, desc);
@@ -276,6 +336,12 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 		return PTR_ERR(pcie->csr_axi_slave_base);
 	pcie->pcie_reg_base = res->start;
 
+	/* map MSI config resource */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
+	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->apb_csr_base);
+
 	/* read the number of windows requested */
 	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
 		pcie->apio_wins = MAX_PIO_WINDOWS;
@@ -431,6 +497,22 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
+{
+	phys_addr_t msg_addr = pcie->pcie_reg_base;
+	struct mobiveil_msi *msi = &pcie->msi;
+
+	pcie->msi.num_of_vectors = PCI_NUM_MSI;
+	msi->msi_pages_phys = (phys_addr_t)msg_addr;
+
+	writel_relaxed(lower_32_bits(msg_addr),
+		pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
+	writel_relaxed(upper_32_bits(msg_addr),
+		pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
+	writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
+	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
+}
+
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
 	u32 value;
@@ -501,6 +583,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 		}
 	}
 
+	/* setup MSI hardware registers */
+	mobiveil_pcie_enable_msi(pcie);
+
 	return err;
 }
 
@@ -559,6 +644,116 @@ static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 	.xlate = pci_irqd_intx_xlate,
 };
 
+static struct irq_chip mobiveil_msi_irq_chip = {
+	.name = "Mobiveil PCIe MSI",
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info mobiveil_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			MSI_FLAG_PCI_MSIX),
+	.chip	= &mobiveil_msi_irq_chip,
+};
+
+static void mobiveil_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(data);
+	phys_addr_t addr = pcie->pcie_reg_base + (data->hwirq * sizeof(int));
+
+	msg->address_lo = lower_32_bits(addr);
+	msg->address_hi = upper_32_bits(addr);
+	msg->data = data->hwirq;
+
+	dev_dbg(&pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int mobiveil_msi_set_affinity(struct irq_data *irq_data,
+		const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip mobiveil_msi_bottom_irq_chip = {
+	.name			= "Mobiveil MSI",
+	.irq_compose_msi_msg	= mobiveil_compose_msi_msg,
+	.irq_set_affinity	= mobiveil_msi_set_affinity,
+};
+
+static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
+		unsigned int virq, unsigned int nr_irqs, void *args)
+{
+	struct mobiveil_pcie *pcie = domain->host_data;
+	struct mobiveil_msi *msi = &pcie->msi;
+	unsigned long bit;
+
+	WARN_ON(nr_irqs != 1);
+	mutex_lock(&msi->lock);
+
+	bit = find_first_zero_bit(msi->msi_irq_in_use, msi->num_of_vectors);
+	if (bit >= msi->num_of_vectors) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(bit, msi->msi_irq_in_use);
+
+	mutex_unlock(&msi->lock);
+
+	irq_domain_set_info(domain, virq, bit, &mobiveil_msi_bottom_irq_chip,
+				domain->host_data, handle_simple_irq,
+				NULL, NULL);
+	return 0;
+}
+
+static void mobiveil_irq_msi_domain_free(struct irq_domain *domain,
+		unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(d);
+	struct mobiveil_msi *msi = &pcie->msi;
+
+	mutex_lock(&msi->lock);
+
+	if (!test_bit(d->hwirq, msi->msi_irq_in_use)) {
+		dev_err(&pcie->pdev->dev, "trying to free unused MSI#%lu\n",
+			d->hwirq);
+	} else {
+		__clear_bit(d->hwirq, msi->msi_irq_in_use);
+	}
+
+	mutex_unlock(&msi->lock);
+}
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= mobiveil_irq_msi_domain_alloc,
+	.free	= mobiveil_irq_msi_domain_free,
+};
+
+static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct mobiveil_msi *msi = &pcie->msi;
+
+	mutex_init(&pcie->msi.lock);
+	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
+						&msi_domain_ops, pcie);
+	if (!msi->dev_domain) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+				&mobiveil_msi_domain_info, msi->dev_domain);
+	if (!msi->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->dev_domain);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -576,6 +771,11 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 
 	raw_spin_lock_init(&pcie->intx_mask_lock);
 
+	/* setup MSI */
+	ret = mobiveil_allocate_msi_domains(pcie);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
1.8.3.1
