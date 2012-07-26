Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57178 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab2GZTzb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 15:55:31 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 07/10] ARM: tegra: pcie: Add MSI support
Date: Thu, 26 Jul 2012 21:55:09 +0200
Message-Id: <1343332512-28762-8-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds support for message signaled interrupts to the Tegra
PCIe controller. Based on code by Krishna Kishore <kthota@nvidia.com>.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- clear interrupts before handling them
- free pages used as MSI region

Changes in v2:
- improve compile coverage by using the IS_ENABLED() macro
- move MSI-related fields to a separate structure
- free pages used for the AFI/FPCI region
- properly remove IRQ domain on module removal
- disable MSI interrupt on module removal
- use linear IRQ domain

 arch/arm/mach-tegra/Kconfig             |   1 +
 arch/arm/mach-tegra/devices.c           |   7 +
 arch/arm/mach-tegra/include/mach/irqs.h |   5 +-
 arch/arm/mach-tegra/pcie.c              | 277 +++++++++++++++++++++++++++++++-
 4 files changed, 288 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 3f6ea1e..dba0702 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -48,6 +48,7 @@ config ARCH_TEGRA_3x_SOC
 config TEGRA_PCI
 	bool "PCI Express support"
 	depends on ARCH_TEGRA_2x_SOC
+	select ARCH_SUPPORTS_MSI
 	select PCI
 
 config TEGRA_AHB
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 203af2e..308515a 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -767,6 +767,13 @@ static struct resource tegra_pcie_resources[] = {
 		.end = INT_PCIE_INTR,
 		.flags = IORESOURCE_IRQ,
 	},
+#ifdef CONFIG_PCI_MSI
+	[5] = {
+		.start = INT_PCIE_MSI,
+		.end = INT_PCIE_MSI,
+		.flags = IORESOURCE_IRQ,
+	},
+#endif
 };
 
 static struct resource tegra_pcie_rp0_resources[] = {
diff --git a/arch/arm/mach-tegra/include/mach/irqs.h b/arch/arm/mach-tegra/include/mach/irqs.h
index 0a0dcac..a282524 100644
--- a/arch/arm/mach-tegra/include/mach/irqs.h
+++ b/arch/arm/mach-tegra/include/mach/irqs.h
@@ -172,7 +172,10 @@
 /* Tegra30 has 8 banks of 32 GPIOs */
 #define INT_GPIO_NR			(32 * 8)
 
-#define TEGRA_NR_IRQS			(INT_GPIO_BASE + INT_GPIO_NR)
+#define INT_PCI_MSI_BASE		(INT_GPIO_BASE + INT_GPIO_NR)
+#define INT_PCI_MSI_NR			(32 * 8)
+
+#define TEGRA_NR_IRQS			(INT_PCI_MSI_BASE + INT_PCI_MSI_NR)
 
 #define INT_BOARD_BASE			TEGRA_NR_IRQS
 #define NR_BOARD_IRQS			128
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 3e5fb66..dab3479 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -32,9 +32,11 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/msi.h>
 
 #include <asm/sizes.h>
 #include <asm/mach/irq.h>
@@ -79,6 +81,24 @@
 #define AFI_MSI_FPCI_BAR_ST	0x64
 #define AFI_MSI_AXI_BAR_ST	0x68
 
+#define AFI_MSI_VEC0		0x6c
+#define AFI_MSI_VEC1		0x70
+#define AFI_MSI_VEC2		0x74
+#define AFI_MSI_VEC3		0x78
+#define AFI_MSI_VEC4		0x7c
+#define AFI_MSI_VEC5		0x80
+#define AFI_MSI_VEC6		0x84
+#define AFI_MSI_VEC7		0x88
+
+#define AFI_MSI_EN_VEC0		0x8c
+#define AFI_MSI_EN_VEC1		0x90
+#define AFI_MSI_EN_VEC2		0x94
+#define AFI_MSI_EN_VEC3		0x98
+#define AFI_MSI_EN_VEC4		0x9c
+#define AFI_MSI_EN_VEC5		0xa0
+#define AFI_MSI_EN_VEC6		0xa4
+#define AFI_MSI_EN_VEC7		0xa8
+
 #define AFI_CONFIGURATION		0xac
 #define  AFI_CONFIGURATION_EN_FPCI	(1 << 0)
 
@@ -166,6 +186,14 @@
 #define PCIE_CONF_FUNC(f)	((f) << 8)
 #define PCIE_CONF_REG(r)	((((r) & 0xf00) << 16) | ((r) & ~3))
 
+struct tegra_pcie_msi {
+	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
+	struct irq_domain *domain;
+	unsigned long pages;
+	struct mutex lock;
+	int irq;
+};
+
 struct tegra_pcie {
 	struct device *dev;
 
@@ -190,6 +218,8 @@ struct tegra_pcie {
 
 	struct list_head ports;
 	unsigned int num_ports;
+
+	struct tegra_pcie_msi *msi;
 };
 
 struct tegra_pcie_port {
@@ -759,6 +789,233 @@ static inline void merge_range(struct resource *range, struct resource *new)
 		range->end = new->end;
 }
 
+static int tegra_pcie_msi_alloc(struct tegra_pcie *pcie)
+{
+	int msi;
+
+	mutex_lock(&pcie->msi->lock);
+
+	msi = find_first_zero_bit(pcie->msi->used, INT_PCI_MSI_NR);
+	if (msi < INT_PCI_MSI_NR)
+		set_bit(msi, pcie->msi->used);
+	else
+		msi = -ENOSPC;
+
+	mutex_unlock(&pcie->msi->lock);
+
+	return msi;
+}
+
+static void tegra_pcie_msi_free(struct tegra_pcie *pcie, unsigned long irq)
+{
+	mutex_lock(&pcie->msi->lock);
+
+	if (!test_bit(irq, pcie->msi->used))
+		dev_err(pcie->dev, "trying to free unused MSI#%lu\n", irq);
+	else
+		clear_bit(irq, pcie->msi->used);
+
+	mutex_unlock(&pcie->msi->lock);
+}
+
+static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
+{
+	struct tegra_pcie *pcie = data;
+	unsigned int i;
+
+	for (i = 0; i < 8; i++) {
+		unsigned long reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
+
+		while (reg) {
+			unsigned int offset = find_first_bit(&reg, 32);
+			unsigned int index = i * 32 + offset;
+			unsigned int irq;
+
+			/* clear the interrupt */
+			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
+
+			irq = irq_find_mapping(pcie->msi->domain, index);
+			if (irq) {
+				if (test_bit(index, pcie->msi->used))
+					generic_handle_irq(irq);
+				else
+					dev_info(pcie->dev, "unhandled MSI\n");
+			} else {
+				/*
+				 * that's weird who triggered this?
+				 * just clear it
+				 */
+				dev_info(pcie->dev, "unexpected MSI\n");
+			}
+
+			/* see if there's any more pending in this vector */
+			reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* called by arch_setup_msi_irqs in drivers/pci/msi.c */
+int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+{
+	struct tegra_pcie_port *port = sys_to_pcie(pdev->bus->sysdata);
+	struct tegra_pcie *pcie = port->pcie;
+	struct msi_msg msg;
+	unsigned int irq;
+	int hwirq;
+
+	hwirq = tegra_pcie_msi_alloc(pcie);
+	if (hwirq < 0)
+		return hwirq;
+
+	irq = irq_create_mapping(pcie->msi->domain, hwirq);
+	if (!irq)
+		return -EINVAL;
+
+	irq_set_msi_desc(irq, desc);
+
+	msg.address_lo = afi_readl(pcie, AFI_MSI_AXI_BAR_ST);
+	/* 32 bit address only */
+	msg.address_hi = 0;
+	msg.data = hwirq;
+
+	write_msi_msg(irq, &msg);
+
+	return 0;
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	struct tegra_pcie *pcie = irq_get_chip_data(irq);
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	tegra_pcie_msi_free(pcie, d->hwirq);
+}
+
+static struct irq_chip tegra_pcie_msi_irq_chip = {
+	.name = "Tegra PCIe MSI",
+	.irq_enable = unmask_msi_irq,
+	.irq_disable = mask_msi_irq,
+	.irq_mask = mask_msi_irq,
+	.irq_unmask = unmask_msi_irq,
+};
+
+static int tegra_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &tegra_pcie_msi_irq_chip,
+				 handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.map = tegra_pcie_msi_map,
+};
+
+static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
+{
+	struct platform_device *pdev = to_platform_device(pcie->dev);
+	unsigned long base;
+	int err;
+	u32 reg;
+
+	pcie->msi = devm_kzalloc(&pdev->dev, sizeof(*pcie->msi), GFP_KERNEL);
+	if (!pcie->msi)
+		return -ENOMEM;
+
+	mutex_init(&pcie->msi->lock);
+
+	pcie->msi->domain = irq_domain_add_linear(pcie->dev->of_node,
+						  INT_PCI_MSI_NR,
+						  &msi_domain_ops, pcie);
+	if (!pcie->msi->domain) {
+		dev_err(&pdev->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	err = platform_get_irq(pdev, 1);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+		goto err;
+	}
+
+	pcie->msi->irq = err;
+
+	err = devm_request_irq(&pdev->dev, pcie->msi->irq, tegra_pcie_msi_irq,
+			       0, tegra_pcie_msi_irq_chip.name, pcie);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
+		goto err;
+	}
+
+	/* setup AFI/FPCI range */
+	pcie->msi->pages = __get_free_pages(GFP_KERNEL, 3);
+	base = virt_to_phys((void *)pcie->msi->pages);
+
+	afi_writel(pcie, base, AFI_MSI_FPCI_BAR_ST);
+	afi_writel(pcie, base, AFI_MSI_AXI_BAR_ST);
+	/* this register is in 4K increments */
+	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
+
+	/* enable all MSI vectors */
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC0);
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC1);
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC2);
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC3);
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC4);
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC5);
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC6);
+	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC7);
+
+	/* and unmask the MSI interrupt */
+	reg = afi_readl(pcie, AFI_INTR_MASK);
+	reg |= AFI_INTR_MASK_MSI_MASK;
+	afi_writel(pcie, reg, AFI_INTR_MASK);
+
+	return 0;
+
+err:
+	irq_domain_remove(pcie->msi->domain);
+	return err;
+}
+
+static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
+{
+	unsigned int i, irq;
+	u32 value;
+
+	/* mask the MSI interrupt */
+	value = afi_readl(pcie, AFI_INTR_MASK);
+	value &= ~AFI_INTR_MASK_MSI_MASK;
+	afi_writel(pcie, value, AFI_INTR_MASK);
+
+	/* disable all MSI vectors */
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC0);
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC1);
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC2);
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC3);
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC4);
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC5);
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC6);
+	afi_writel(pcie, 0, AFI_MSI_EN_VEC7);
+
+	free_pages(pcie->msi->pages, 3);
+
+	for (i = 0; i < INT_PCI_MSI_NR; i++) {
+		irq = irq_find_mapping(pcie->msi->domain, i);
+		if (irq > 0)
+			irq_dispose_mapping(irq);
+	}
+
+	irq_domain_remove(pcie->msi->domain);
+
+	return 0;
+}
+
 static unsigned long tegra_pcie_port_get_pex_ctrl(struct tegra_pcie_port *port)
 {
 	unsigned long ret = 0;
@@ -973,14 +1230,26 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 	/* setup the AFI address translations */
 	tegra_pcie_setup_translations(pcie);
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = tegra_pcie_enable_msi(pcie);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to enable MSI support: %d\n",
+				err);
+			goto put_resources;
+		}
+	}
+
 	err = tegra_pcie_enable(pcie);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to enable PCIe ports: %d\n", err);
-		goto put_resources;
+		goto disable_msi;
 	}
 
 	return 0;
 
+disable_msi:
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_pcie_disable_msi(pcie);
 put_resources:
 	tegra_pcie_put_resources(pcie);
 	return err;
@@ -992,6 +1261,12 @@ static int __devexit tegra_pcie_remove(struct platform_device *pdev)
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
 	int err;
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = tegra_pcie_disable_msi(pcie);
+		if (err < 0)
+			return err;
+	}
+
 	err = tegra_pcie_put_resources(pcie);
 	if (err < 0)
 		return err;
-- 
1.7.11.2

