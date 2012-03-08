Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59196 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252Ab2CHOvt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 09:51:49 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 10/11] ARM: tegra: pcie: Add MSI support
Date: Thu,  8 Mar 2012 15:51:30 +0100
Message-Id: <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds support for message signaled interrupts to the Tegra
PCIe controller.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
This code is taken from the NVIDIA Vibrante kernel and therefore has no
appropriate Signed-off-by from the original author. Maybe someone at
NVIDIA can find out who wrote this code and maybe provide a proper
Signed-off-by that I can add?

 arch/arm/mach-tegra/Kconfig             |    1 +
 arch/arm/mach-tegra/devices.c           |    7 +
 arch/arm/mach-tegra/include/mach/irqs.h |    5 +-
 arch/arm/mach-tegra/pcie.c              |  239 +++++++++++++++++++++++++++++++
 4 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 1651119..7c596e6 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -48,6 +48,7 @@ config ARCH_TEGRA_3x_SOC
 config TEGRA_PCI
 	bool "PCI Express support"
 	depends on ARCH_TEGRA_2x_SOC
+	select ARCH_SUPPORTS_MSI
 	select PCI
 
 comment "Tegra board type"
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 09e24e1..195f165 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -721,6 +721,13 @@ static struct resource tegra_pcie_resources[] = {
 		.end = INT_PCIE_INTR,
 		.flags = IORESOURCE_IRQ,
 	},
+#ifdef CONFIG_PCI_MSI
+	[3] = {
+		.start = INT_PCIE_MSI,
+		.end = INT_PCIE_MSI,
+		.flags = IORESOURCE_IRQ,
+	},
+#endif
 };
 
 struct platform_device tegra_pcie_device = {
diff --git a/arch/arm/mach-tegra/include/mach/irqs.h b/arch/arm/mach-tegra/include/mach/irqs.h
index aad1a2c..02e84bc 100644
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
 #define NR_BOARD_IRQS			32
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 8b20bc5..85db9fb 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -31,11 +31,14 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/msi.h>
 
 #include <asm/sizes.h>
+#include <asm/mach/irq.h>
 #include <asm/mach/pci.h>
 
 #include <mach/iomap.h>
@@ -81,6 +84,24 @@
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
 
@@ -211,6 +232,14 @@ struct tegra_pcie_info {
 	struct clk		*afi_clk;
 	struct clk		*pcie_xclk;
 	struct clk		*pll_e;
+
+#ifdef CONFIG_PCI_MSI
+	int msi_irq;
+	struct irq_chip msi_chip;
+	DECLARE_BITMAP(msi_in_use, INT_PCI_MSI_NR);
+	struct irq_domain *msi_domain;
+	struct mutex msi_lock;
+#endif
 };
 
 static inline struct tegra_pcie_info *sys_to_pcie(struct pci_sys_data *sys)
@@ -939,6 +968,208 @@ static void __devinit tegra_pcie_add_port(struct tegra_pcie_info *pcie,
 	memset(pp->res, 0, sizeof(pp->res));
 }
 
+#ifdef CONFIG_PCI_MSI
+static int tegra_pcie_msi_alloc(struct tegra_pcie_info *pcie)
+{
+	int msi;
+
+	mutex_lock(&pcie->msi_lock);
+
+	msi = find_first_zero_bit(pcie->msi_in_use, INT_PCI_MSI_NR);
+	if (msi < INT_PCI_MSI_NR)
+		set_bit(msi, pcie->msi_in_use);
+	else
+		msi = -ENOSPC;
+
+	mutex_unlock(&pcie->msi_lock);
+
+	return msi;
+}
+
+static void tegra_pcie_msi_free(struct tegra_pcie_info *pcie, unsigned long irq)
+{
+	mutex_lock(&pcie->msi_lock);
+
+	if (!test_bit(irq, pcie->msi_in_use))
+		dev_err(pcie->dev, "trying to free unused MSI#%lu\n", irq);
+	else
+		clear_bit(irq, pcie->msi_in_use);
+
+	mutex_unlock(&pcie->msi_lock);
+}
+
+static void tegra_pcie_msi_isr(unsigned int irq, struct irq_desc *desc)
+{
+	struct tegra_pcie_info *pcie = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int i;
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < 8; i++) {
+		unsigned long reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
+
+		while (reg) {
+			unsigned int offset = find_first_bit(&reg, 32);
+			unsigned int index = i * 32 + offset;
+			unsigned int irq;
+
+			irq = irq_find_mapping(pcie->msi_domain, index);
+			if (irq) {
+				if (test_bit(index, pcie->msi_in_use))
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
+			/* clear the interrupt */
+			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
+			/* see if there's any more pending in this vector */
+			reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+/* called by arch_setup_msi_irqs in drivers/pci/msi.c */
+int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+{
+	struct tegra_pcie_info *pcie = sys_to_pcie(pdev->bus->sysdata);
+	struct msi_msg msg;
+	unsigned int irq;
+	int hwirq;
+
+	hwirq = tegra_pcie_msi_alloc(pcie);
+	if (hwirq < 0)
+		return hwirq;
+
+	irq = irq_find_mapping(pcie->msi_domain, hwirq);
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
+	struct tegra_pcie_info *pcie = irq_get_chip_data(irq);
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	tegra_pcie_msi_free(pcie, d->hwirq);
+}
+
+static int tegra_pcie_enable_msi(struct platform_device *pdev)
+{
+	struct tegra_pcie_info *pcie = platform_get_drvdata(pdev);
+	volatile void *pages;
+	unsigned long base;
+	unsigned int msi;
+	int msi_base;
+	int err;
+	u32 reg;
+
+	mutex_init(&pcie->msi_lock);
+
+	msi_base = irq_alloc_descs(-1, 0, INT_PCI_MSI_NR, 0);
+	if (msi_base < 0) {
+		dev_err(&pdev->dev, "failed to allocate IRQs\n");
+		return msi_base;
+	}
+
+	pcie->msi_domain = irq_domain_add_legacy(pcie->dev->of_node,
+						 INT_PCI_MSI_NR, msi_base,
+						 0, &irq_domain_simple_ops,
+						 NULL);
+	if (!pcie->msi_domain) {
+		dev_err(&pdev->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	pcie->msi_chip.name = "PCIe-MSI";
+	pcie->msi_chip.irq_enable = unmask_msi_irq;
+	pcie->msi_chip.irq_disable = mask_msi_irq;
+	pcie->msi_chip.irq_mask = mask_msi_irq;
+	pcie->msi_chip.irq_unmask = unmask_msi_irq;
+
+	for (msi = 0; msi < INT_PCI_MSI_NR; msi++) {
+		unsigned int irq = irq_find_mapping(pcie->msi_domain, msi);
+
+		irq_set_chip_data(irq, pcie);
+		irq_set_chip_and_handler(irq, &pcie->msi_chip,
+					 handle_simple_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	err = platform_get_irq(pdev, 1);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+		return err;
+	}
+
+	pcie->msi_irq = err;
+
+	irq_set_chained_handler(pcie->msi_irq, tegra_pcie_msi_isr);
+	irq_set_handler_data(pcie->msi_irq, pcie);
+
+	/* setup AFI/FPCI range */
+	pages = (volatile void *)__get_free_pages(GFP_KERNEL, 3);
+	base = virt_to_phys(pages);
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
+}
+
+static int tegra_pcie_disable_msi(struct platform_device *pdev)
+{
+	return 0;
+}
+#else
+static int tegra_pcie_enable_msi(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int tegra_pcie_disable_msi(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 {
 	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
@@ -978,6 +1209,10 @@ static int __devinit tegra_pcie_probe(struct platform_device *pdev)
 	/* setup the AFI address translations */
 	tegra_pcie_setup_translations(pcie);
 
+	err = tegra_pcie_enable_msi(pdev);
+	if (err < 0)
+		dev_err(&pdev->dev, "failed to enable MSI support: %d\n", err);
+
 	if (pdata->enable_ports[0])
 		tegra_pcie_add_port(pcie, 0, RP0_OFFSET, AFI_PEX0_CTRL);
 
@@ -1000,6 +1235,10 @@ static int __devexit tegra_pcie_remove(struct platform_device *pdev)
 	struct tegra_pcie_pdata *pdata = pdev->dev.platform_data;
 	int err;
 
+	err = tegra_pcie_disable_msi(pdev);
+	if (err < 0)
+		return err;
+
 	err = tegra_pcie_put_resources(pdev);
 	if (err < 0)
 		return err;
-- 
1.7.9.3

